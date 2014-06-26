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
const FILE_DIRECTORY   = "Maps/";
const VERSION 		   = "0.1";

const LOADER_NAME = "LOADER.xml";

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
	print( "Loading Map Loader Script...\n" );
	print( "Map Loader Script v" + VERSION + " loaded!" );
	
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
	fileLoader();
	return 1;
}

///////////////////////////////////////
//
//  Type: Main Event
//  Description: When unloading all from
// 				 the server...
//  Params: None
//  Returns: 1
//
function onScriptUnload()
{
	return 1;
}



//************************************************** //
//
//                 Functions
//
//************************************************** //

///////////////////////////////////////
//
//  Type: Map loading function
//  Description: Loads all the maps
//				 in the loader xml file
//  Params:
//  Returns: Nothing
//
function fileLoader() {
	
	try {
		local loaderDocument = XmlDocument();
		loaderDocument.LoadFile( FILE_DIRECTORY + LOADER_NAME );
	
		local element = loaderDocument.FirstChild().FirstChild();
	
		local count = 0;
		while( element != null ) {
		
			local name = element.GetAttribute( "name" );
			
			loadMap( name );
			count++;
			
			element = element.NextSibling();
		}
		print(" -> Loaded all maps! Map count: " + count );
		
	} catch( e ) {
		print("ATTENTION: " + LOADER_NAME + " file didn't load successfully!");
		print("ATTENTION: Some maps might have not been loaded!");
	}
}

///////////////////////////////////////
//
//  Type: Map function
//  Description:  Loads a map from the Map/ directory
//  Params: mapName -> The name of the map
//  Returns: Nothing
//
function loadMap( mapName ) {
	
	// XML document
	local mapDocument = XmlDocument();
	mapDocument.LoadFile( FILE_DIRECTORY + mapName.tolower() + ".xml" );
	
	// Root element
	local root_Element = mapDocument.FirstChild();
	
	// First element
	local element = root_Element.FirstChild();
	
	local count = 0;
	
	// Traverse the file
	while( element != null ) {
	
		local model = element.GetAttribute( "model" ).tointeger();
		local world = element.GetAttribute( "world" ).tointeger();
		local x = element.GetAttribute( "x" ).tofloat(),
			  y = element.GetAttribute( "y" ).tofloat(),
			  z = element.GetAttribute( "z" ).tofloat();
		local rx = element.GetAttribute( "rx" ).tofloat(),
			  ry = element.GetAttribute( "ry" ).tofloat(),
			  rz = element.GetAttribute( "rz" ).tofloat();
			
		local ob = CreateObject( model, Vector( x, y, z ) );
		ob.Angle = Vector( rx, ry, rz );
		ob.VirtualWorld = world;
		
		count++;
		element = element.NextSibling();
	}
	print( " -> Loaded " + mapName + " successfully! Object count: " + count );
}