//
//
//
//                  Map Editor Loader File
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


// 2. Script Related constants
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
function Loader_onScriptLoad()
{
	
	// If you don't want to load any maps, remove this.
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
function Loader_onScriptUnload()
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
//  Description:  Saves a map to the Map/ directory
//  Params: mapName -> The name of the map
//  Returns: Nothing
//
function saveMap( mapName ) {

	local mapDocument = XmlDocument();
	mapDocument.LoadFile( FILE_DIRECTORY + mapName.tolower() + ".xml" );
	mapDocument.Clear();
	
	local root_Element = XmlElement( mapName );
	mapDocument.LinkChild( root_Element );
	
	for( local i = 0; i <= GetObjectCount(); i++ ) {
		local object = FindObject(i);
		
		if ( object ) {
			
			local x = object.Pos.x, y = object.Pos.y, z = object.Pos.z;
			local rx = object.Angle.x, ry = object.Angle.y, rz = object.Angle.z;
			local world = object.VirtualWorld;
			local model = object.Model;
			
			local object_Element = XmlElement( "Object" );
			
			// Set values
			object_Element.SetAttribute( "model", model );
			object_Element.SetAttribute( "x", x );
			object_Element.SetAttribute( "y", y );
			object_Element.SetAttribute( "z", z );
			object_Element.SetAttribute( "rx", rx );
			object_Element.SetAttribute( "ry", ry );
			object_Element.SetAttribute( "rz", rz );
			object_Element.SetAttribute( "world", world );
			
			// Link it to the document
			root_Element.LinkChild( object_Element );
			
		}
	}
	mapDocument.SaveFile();
	
	/*
	* Loader Document
	*/
	local loaderDocument = XmlDocument();
	loaderDocument.LoadFile( FILE_DIRECTORY + LOADER_NAME );
	
	local loader_Root = loaderDocument.FirstChild();
	
	if ( !attributeExists( "name", mapName.tolower(), loader_Root ) ) {
		local map_Element = XmlElement( "Map" );
		map_Element.SetAttribute( "name", mapName.tolower() );
		loader_Root.LinkChild( map_Element );
		loaderDocument.SaveFile();
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

///////////////////////////////////////
//
//  Type: XML function
//  Description: Checks is a value exists
//  Params: attritute -> xml attribute
//			value -> the value to compare
//		    root  -> the root element
//  Returns: true or false (boolean)
//
function attributeExists( attribute, value, root ) {
	local bool = false;
	local traverseElement = root.FirstChild();
	while ( traverseElement != null ) {
		if ( traverseElement.GetAttribute( attribute ) == value )
			bool = true;
		traverseElement = traverseElement.NextSibling();
	}
	return bool;
}

