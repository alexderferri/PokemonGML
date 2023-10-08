
// ================================ GAMEPLAY ==============================================
enum Alliance {
	PLAYER,
	FOE
}



// ================================ POKE STRUCTS =========================================

// Pokemon Type 
enum Type {
	
	NORMAL,
	FIRE,
	WATER,
	GRASS,
	ELECTRIC,
	PSYCHIC,
	ICE,
	DRAGON,
	DARK,
	FAIRY,
	FIGHTING,
	FLYING,
	POISON,
	GROUND,
	ROCK,
	BUG,
	GHOST,
	STEEL

}
	
// Pokemon Leveling Rate
enum LevelingRate {
	ERRATIC,
	FAST,
	MEDIUM_FAST,
	MEDIUM_SLOW,
	SLOW,
	FLUCTUATING
}


// Struct (or class) that stores the Base Stats and Data of each Pokemon
function PokemonBase(_front, _back, _name, _type, _ability, _levelingRate, _ev, _stats, _moveset) constructor {
	
	spriteFront  = _front;
	spriteBack   = _back;
	name		 = _name;
	type		 = _type;
	ability	     = _ability;
	levelingRate = _levelingRate;
	ev           = _ev;
	stats        = _stats;
	
	moveset      = _moveset;
}

// Struct (or class) that stores the Actual Pokemon Data that are affected by its level. It also stores the base data.
// It also contains some helper methods such as creating a new Pokemon instance.
function Pokemon(_pokemonBase, _level = 5) constructor {

	
	base         = _pokemonBase;
	level        = _level;
	ability	     = -1;
	iv			 = -1;
	stats        = -1;
	
	moveset      = ds_list_create();

	
	// Init the Pokemon Stats and Data
	static Init = function(){
		
	
		// Get Random IV
		iv = GetRandomIV();
		
		// Calculate Stats Based on Pokemon's Level
		stats = new Stats(
		
			// HP
			CalculateHP  (base.stats.hp,    base.ev,       level),
			// ATK  
			CalculateStat(base.stats.atk,   base.ev.atk,   level),
			// DEF
			CalculateStat(base.stats.def,   base.ev.def,   level),
			// SPECIAL ATTACK
			CalculateStat(base.stats.spAtk, base.ev.spAtk, level),
			// SPECIAL DEFENCE
			CalculateStat(base.stats.spDef, base.ev.spDef, level),
			// SPEED
			CalculateStat(base.stats.spd,   base.ev.spd,   level)
		);
		
		moveset = GetMoveSetFromLevel(level);
		
		return self;
	}
	
	// Create a new Pokemon instance in the game
	static CreateInstance = function(_alliance) {
		
		var _pokemonInst      = instance_create_depth(room_width/2, room_height/2, -2000, oPokemon);
		_pokemonInst.data     = self;
		_pokemonInst.alliance = _alliance;
		
		return self;
	}
	
	
	// Get the moveset from the Moveset DB filtered by its level
	static GetMoveSetFromLevel = function(_level) {
		
		var _moveset = [];
		
		for (var i = 0; i < array_length(base.moveset.level); i++) {
			
			if (base.moveset.level[i] <= _level) {
				array_push(_moveset, base.moveset.move[i]);
			}
		
		}
		
		return _moveset;
	
	}
	
}

// Struct (or class) that stores the Stats of a Pokemon
function Stats(_hp, _atk, _def, _spAtk, _spDef, _spd) constructor {
	
	hp    = _hp;
	atk   = _atk;
	def   = _def;
	spAtk = _spAtk;
	spDef = _spDef;
	spd   = _spd;

}

// Struct (or class) that stores the IV Stats of a Pokemon. It inherits from the Stats struct
function IV(_hp, _atk, _def, _spAtk, _spDef, _spd) : Stats(_hp, _atk, _def, _spAtk, _spDef, _spd) constructor {
	
	hp    = _hp;
	atk   = _atk;
	def   = _def;
	spAtk = _spAtk;
	spDef = _spDef;
	spd   = _spd;

}

// Struct (or class) that stores the EV Stats of a Pokemon. It inherits from the Stats struct
function EV(_hp, _atk, _def, _spAtk, _spDef, _spd) : Stats(_hp, _atk, _def, _spAtk, _spDef, _spd) constructor {
	
	hp    = _hp;
	atk   = _atk;
	def   = _def;
	spAtk = _spAtk;
	spDef = _spDef;
	spd   = _spd;

}

// Struct (or class) that stores the Pokemon's moveset based on the level. 
// It has an array of levels and a relative array of move for each level.
function MoveSet(_level = [], _move = []) constructor {
	
	level = _level;
	move  = _move;
	

}
	
	
	
	
	
	
// ============================= POKE MOVES ==================================================

// Move Category
enum MoveCategory {
	
	PHYSICAL,
	SPECIAL,
	STATUS

}

// Struct (or class) that stores each individual Move.
function Move(_name, _category, _type, _pp, _power, _accuracy) constructor {
	
	name	 = _name;
	category = _category;
	type     = _type;
	pp       = _pp;
	pwer     = _power;
	accuracy = _accuracy;
};










// ============================= POKE FUNCTIONS ===========================================

// Creates a new Pokemon Data at the given index in the Pokemon DB and at a given level.
// It returns the newly created Pokemon struct 
function CreatePokemon(_ID = 0, _level = 5) {
	
	var _pokeIsFound = ds_list_find_value(global.PokeDB, _ID);
	
	if (_pokeIsFound == -1) {
		show_message("Cannot create a new Pokemon! No Pokemon found at database index: " + string(_ID));
		return -1;
	}

	return new Pokemon(global.PokeDB[| _ID], _level);
}


// Returns a new IV struct with random stats
function GetRandomIV() {
	
	return new IV(0, 0, 0, 0, 0, 0);
}








// =========================== STATS FORMULA CALCULATION ==============================
// Pokemon has two formulas for calculating HP and all other stats based on the EVs and Base Stats.


// Calculates the HP based on the Pokemon base HP and EVs
function CalculateHP(_baseHp, _ev, _level) {
	
	var _n = ( (_baseHp + 7) * 2 + (sqrt(_ev.hp) / 4) ) * _level;
	
	return round((_n / 100) + _level + 10);
	
}

// Calculates the stat based on the Pokemon base stat and EVs
function CalculateStat(_baseStat, _evStat, _level) {
	
	var _n = ( (_baseStat + 7) * 2 + (sqrt(_evStat) / 4) ) * _level;
	
	return round((_n / 100) + 5);
}
	
	
	
	
	
	
	
	
	
	
// ============================ DATABASE ================================
// Pokemon and Moveset Database

// Create a new DB (Dictionary) for the Moveset
global.MovesetDB = ds_map_create();

// Add Moves to the Moveset Database
ds_map_add(global.MovesetDB, "Tackle",     new Move("Tackle",      MoveCategory.PHYSICAL, Type.NORMAL, 35, 40, 1.0) );
ds_map_add(global.MovesetDB, "Growl",      new Move("Growl",       MoveCategory.STATUS,   Type.NORMAL, 40, 0,  1.0) );
ds_map_add(global.MovesetDB, "Vine Whip",  new Move("Vine Whip",   MoveCategory.PHYSICAL, Type.GRASS,  25, 45, 1.0) );
ds_map_add(global.MovesetDB, "Growth",     new Move("Growth",      MoveCategory.STATUS,   Type.NORMAL, 20, 0,  1.0) );



// Create a new DB (List) for the Pokemons
global.PokeDB = ds_list_create();

// Add new Pokemons to the Database
ds_list_add(global.PokeDB, 

	// Bulbasaur
	new PokemonBase(
		sBulbasaurFront,
		sBulbasaurBack,
		"Bulbasaur", 
		[Type.GRASS, Type.POISON],
		-1, 
		LevelingRate.MEDIUM_SLOW, 
		new EV(0, 0, 0, 1, 0, 0),
		new Stats(45, 49, 49, 65, 65, 45),
		new MoveSet(
			[1, 1, 3, 6],
			[global.MovesetDB[? "Tackle"], global.MovesetDB[? "Growl"], global.MovesetDB[? "Vine Whip"], global.MovesetDB[? "Growth"]]
		)
	)

);




