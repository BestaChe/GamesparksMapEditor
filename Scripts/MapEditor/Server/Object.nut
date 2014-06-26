//
//
//
//                  Map Editor Object File
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
function Object_onScriptLoad()
{

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
function Object_onScriptUnload()
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
//  Type: Object function
//  Description: Creates an object
//  Params: id -> object's id
//  Returns: Nothing
//
function createMapObject( model, player ) {
	local ob = CreateObject( model.tointeger(), GetPlayer2DLookAtPos( player, 10 ) );
}

///////////////////////////////////////
//
//  Type: Object function
//  Description: Removes an object
//  Params: id -> object's id
//  Returns: Nothing
//
function removeMapObject( id ) {
	local ob = FindObject( id );
	ob.Remove();
}

///////////////////////////////////////
//
//  Type: Object function
//  Description: Moves the object
//  Params: id -> object's id
//			x  -> x movement
//			y  -> y movement
//			z  -> z movement
//  Returns: Nothing
//
function moveMapObject( id, x, y, z ) {
	local ob = FindObject( id );
	ob.Pos = Vector( ob.Pos.x + x, ob.Pos.y + y, ob.Pos.z + z );
}

///////////////////////////////////////
//
//  Type: Object function
//  Description: Rotates the object
//  Params: id -> object's id
//			x  -> x movement
//			y  -> y movement
//			z  -> z movement
//  Returns: Nothing
//
function rotateMapObject( id, x, y, z ) {
	local ob = FindObject( id );
	ob.Angle = Vector( ob.Angle.x + x, ob.Angle.y + y, ob.Angle.z + z );
}

///////////////////////////////////////
//
//  Type: Object function
//  Description: Prints the nearby objects
//  Params: player    -> the player
//			distance  -> minimum distance
//  Returns: Nothing
//
function nearMapObject( player, distance ) {
	
	local count = 0;
	local mem = array( GetObjectCount(), null );
	
	for( local i = 0; i <= GetObjectCount() - 1; i++ ) {
	
		local ob = FindObject( i );
		if ( ob ) {
			if ( GetDistance( ob.Pos, player.Pos ) <= distance ) {
				mem[count] = "[#DDDDFF]ID: [" + i + "] Model: [" + ob.Model + "][#d]";
				count++;
			}
		}
	}
	
	if ( count == 0 )
		editorMessage( "No objects near you.", player, Col_PM );
	else {
		editorMessage( "Nearby objects:", player, Col_PM );
		for( local j = 0; j <= count - 1; j++ ) {
			editorMessage( "    - " + mem[j], player, Col_PM );
		}
		editorMessage( "Count: " + count + "/" + GetObjectCount(), player, Col_PM );
	}
}