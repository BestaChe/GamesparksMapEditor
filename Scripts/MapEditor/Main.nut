//
//
//
//                  Map Editor Main File
//                                Created by: Knucis
//
//
//____________________________________________________________________________________


//************************************************** //
//
//                 Constants
//
//************************************************** //

// 1. Colour Stuff
Col_PM  	<- Colour( 162, 205, 90 );
Col_Editor  <- Colour( 216, 168, 36 );

// 2. Script Related constants
const SCRIPT_DIRECTORY = "Scripts/MapEditor/Server/";
const CLIENT_DIRECTORY = "Scripts/MapEditor/Client/";
const FILE_DIRECTORY   = "Maps/";
const VERSION 		   = "0.1";


// 3. Server Related constants

//************************************************** //
//
//                 Events
//
//************************************************** //

///////////////////////////////////////
//
//  Type: Main Event
//  Description: When loading all the 
//               Scripts to the server..
//  Params: None
//  Returns: 1
//
function onScriptLoad()
{	
	print( "------------------------------------------" );
	print( "Loading Map Editor Script...\n" );

	loadScript( "Object" ); // Everything related to objects
	loadScript( "Loader" ); // Map loader
	
	print( "Map Editor Script v" + VERSION + " loaded!" );
	
	return 1;
}

///////////////////////////////////////
//
//  Type: Main Event
//  Description: When the server's up..
//  Params: None
//  Returns: 1
//
function onServerStart()
{
	return 1;
}

///////////////////////////////////////
//
//  Type: Main Event
//  Description: When unloading all scripts from
// 				 the server...
//  Params: None
//  Returns: 1
//
function onScriptUnload()
{
	unloadScript( "Object" );
	unloadScript( "Loader" );
	return 1;
}



//************************************************** //
//
//                 Functions
//
//************************************************** //

///////////////////////////////////////
//
//  Type: Loading Function
//  Description: Loads a script from the
// 				 server's directory!
//  Params: String -> Name of the script
//  Returns: None
//
function loadScript( scriptName ) 
{
	local error = false;
	// Checks if the file exists...
	try {
		print( ">> Trying to load " + SCRIPT_DIRECTORY + scriptName + ".nut" );
		dofile( SCRIPT_DIRECTORY + scriptName + ".nut" );
	} catch( e ) {
		error = true;
		print("[FAILURE] Failed to load script " + scriptName + ".nut!" );
	}
	// Checks if you can load the main scriptLoad from the file...
	try {
		local a = compilestring( scriptName + "_onScriptLoad();" );
		a();
	} catch( e ) {
		error = true;
		print( e );
	}
	// Everything went ok.
	if ( !error ) {
		print( ">> " + scriptName + ".nut has been loaded successfully!\n\n" );
	}
}

///////////////////////////////////////
//
//  Type: Loading Function
//  Description: Unloads a script from the
// 				 server's directory!
//  Params: String -> Name of the script
//  Returns: None
//
function unloadScript( scriptName ) {

	local error = false;
	print( ">> Unloading " + SCRIPT_DIRECTORY + scriptName + ".nut" );
	try {
		local a = compilestring( scriptName + "_onScriptUnload();" );
		a();
	} catch( e ) {
		error = true;
		print( e );
	}
	// Everything went ok.
	if ( !error ) {
		print( ">> " + scriptName + ".nut has been unloaded successfully!" );
	}

}
///////////////////////////////////////
//
//  Type: Position function
//  Description: Returns the vector pos
//				 in front of the player
//  Params: player -> the player
//			range -> the range			
//  Returns: Vector
//	Credits: aXXo (VU forums)
//
function GetPlayer2DLookAtPos( player, range )
{
	local angle = player.Angle + 90; //To point North at 90 degrees (It is at 0 degree by default)
	
	if ( angle > 360 ) 
		angle -= 360;
		
	local slope = tan( angle * ( PI/180 ) );
	
	local x2 = null, y2 = null;
	
	if ( angle >= 135 && angle <= 225 )
		x2 = player.Pos.x - range;
	else if ( angle > 225 && angle <= 315 )
		y2 = player.Pos.y - range;
	else if ( angle > 315 || angle <= 45 )
		x2 = player.Pos.x + range;
	else if ( angle >= 45 && angle < 135 )
		y2 = player.Pos.y + range;
	
	if ( !y2 ) 
		y2 = ( ( x2 - player.Pos.x ) * slope ) + player.Pos.y;
	
	else if ( !x2 )
		x2 = (( y2 - player.Pos.y )/slope) + player.Pos.x;
		
	return Vector( x2, y2, player.Pos.z);
}

///////////////////////////////////////
//
//  Type: Game message function
//  Description: Game message, yay!
//  Params: text   -> the text to print
//			player -> the player to print to
//			color  -> the colour
//  Returns: None
//
function editorMessage( text, player, color ) {
	MessagePlayer("[#009999] >>[#d] " + text, player, color );
}