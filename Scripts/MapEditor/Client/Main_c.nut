//
//
//
//                  Map Editor Main Client File
//                                Created by: Knucis
//
//
//____________________________________________________________________________________


//************************************************** //
//
//                 Constants
//
//************************************************** //

// 1. Colour stuff
Col_PM  	<- Colour( 162, 205, 90 );
Col_Editor  <- Colour( 216, 168, 36 );

// 2. General constants
pPlayer		<- FindLocalPlayer();
const FONT  = "Lucida Console";

// 3. Control variables
controlSensitivity <- 1;
controlMode 	   <- 0;
currentObject	   <- null;

cameraAngle	   	   <- 0.0;
cameraZoom		   <- 10.0;


// 3. Bind constants


//************************************************** //
//
//                 Events
//
//************************************************** //

function onScriptLoad() {
	
	// --> Control Window
	middleWindow <- gx_GUIWindow( 750, 800, 400, 150, "Control Information" );
	middleWindow.Colour( Colour( 75, 75, 75 ) );
	middleWindow.Alpha( 175 );
	middleWindow.Moveable( true );
	middleWindow.Visible( false );
	
		// --> Labels
		labelMode <- GUILabel( parseVectorScreen( 20, 25 ), parseScreenSize( 100, 25 ), "Mode: --- " );
		labelMode.TextColour = Colour( 255, 255, 255 );
		labelMode.FontSize = 16;
		labelMode.FontName = FONT;
		
		labelControls <- GUILabel( parseVectorScreen( 40, 50 ), parseScreenSize( 100, 25 ), "Controls:" );
		labelControls.TextColour = Colour( 255, 255, 255 );
		labelControls.FontName = FONT;
		
		labelControls1 <- GUILabel( parseVectorScreen( 60, 75 ), parseScreenSize( 100, 25 ), "---" );
		labelControls1.TextColour = Colour( 255, 255, 255 );
		labelControls1.FontName = FONT;
		
		labelControls2 <- GUILabel( parseVectorScreen( 60, 100 ), parseScreenSize( 100, 25 ), "---" );
		labelControls2.TextColour = Colour( 255, 255, 255 );
		labelControls2.FontName = FONT;
		
		labelSensitivity <- GUILabel( parseVectorScreen( 20, 125 ), parseScreenSize( 100, 25 ), "Sensitivity: " + controlSensitivity + "x " );
		labelSensitivity.TextColour = Colour( 100, 100, 255 );
		labelSensitivity.FontName = FONT;
	
	middleWindow.addChild( labelMode );
	middleWindow.addChild( labelControls );
	middleWindow.addChild( labelControls1 );
	middleWindow.addChild( labelControls2 );
	middleWindow.addChild( labelSensitivity );
	// <-- Control Window
	
	// --> Position Window
	posWindow <- gx_GUIWindow( 1050, 800, 150, 150, "Object Position" );
	posWindow.Colour( Colour( 75, 75, 75 ) );
	posWindow.Alpha( 175 );
	posWindow.Moveable( true );
	posWindow.Visible( false );
	
		// --> Labels		
		labelObjectX <- GUILabel( parseVectorScreen( 20, 50 ), parseScreenSize( 100, 25 ), "X: " );
		labelObjectX.TextColour = Colour( 255, 175, 175 );
		labelObjectX.FontName = FONT;
		
		
		labelObjectY <- GUILabel( parseVectorScreen( 20, 75 ), parseScreenSize( 100, 25 ), "Y: " );
		labelObjectY.TextColour = Colour( 175, 255, 175 );
		labelObjectY.FontName = FONT;
		
		
		labelObjectZ <- GUILabel( parseVectorScreen( 20, 100 ), parseScreenSize( 100, 25 ), "Z: " );
		labelObjectZ.TextColour = Colour( 175, 175, 255 );
		labelObjectZ.FontName = FONT;
		
	
	posWindow.addChild( labelObjectX );
	posWindow.addChild( labelObjectY );
	posWindow.addChild( labelObjectZ );
	// <-- Position Window
	
	// --> Rotation Window
	rotWindow <- gx_GUIWindow( 1225, 800, 150, 150, "Object Rotation" );
	rotWindow.Colour( Colour( 75, 75, 75 ) );
	rotWindow.Alpha( 175 );
	rotWindow.Moveable( true );
	rotWindow.Visible( false );
	
		// --> Labels
		labelObjectXr <- GUILabel( parseVectorScreen( 20, 50 ), parseScreenSize( 100, 25 ), "rX: " );
		labelObjectXr.TextColour = Colour( 255, 175, 175 );
		labelObjectXr.FontName = FONT;
		
		
		labelObjectYr <- GUILabel( parseVectorScreen( 20, 75 ), parseScreenSize( 100, 25 ), "rY: " );
		labelObjectYr.TextColour = Colour( 175, 255, 175 );
		labelObjectYr.FontName = FONT;
		
		
		labelObjectZr <- GUILabel( parseVectorScreen( 20, 100 ), parseScreenSize( 100, 25 ), "rZ: " );
		labelObjectZr.TextColour = Colour( 175, 175, 255 );
		labelObjectZr.FontName = FONT;
		
	
	rotWindow.addChild( labelObjectXr );
	rotWindow.addChild( labelObjectYr );
	rotWindow.addChild( labelObjectZr );
	// <-- Rotation Window
	
	// --> Detail Window
	detailWindow <- gx_GUIWindow( 450, 800, 150, 150, "Object Details" );
	detailWindow.Colour( Colour( 75, 75, 75 ) );
	detailWindow.Alpha( 175 );
	detailWindow.Moveable( true );
	detailWindow.Visible( false );
	
		// --> Labels
		labelObjectID <- GUILabel( parseVectorScreen( 20, 50 ), parseScreenSize( 100, 25 ), "ID: " );
		labelObjectID.TextColour = Colour( 255, 255, 255 );
		labelObjectID.FontName = FONT;
		
		
		labelObjectModel <- GUILabel( parseVectorScreen( 20, 75 ), parseScreenSize( 100, 25 ), "Model: " );
		labelObjectModel.TextColour = Colour( 255, 255, 255 );
		labelObjectModel.FontName = FONT;
		
		
		labelObjectWorld <- GUILabel( parseVectorScreen( 20, 100 ), parseScreenSize( 100, 25 ), "World: " );
		labelObjectWorld.TextColour = Colour( 255, 255, 255 );
		labelObjectWorld.FontName = FONT;
		
	
	detailWindow.addChild( labelObjectID );
	detailWindow.addChild( labelObjectModel );
	detailWindow.addChild( labelObjectWorld );
	// <-- Detail Window
	
	// Screen Layers
	AddGUILayer( middleWindow.Window );
	AddGUILayer( posWindow.Window );
	AddGUILayer( rotWindow.Window );
	AddGUILayer( detailWindow.Window );
	
}

function onScriptUnload() {


}

function onClientCommand( cmd, text ) {
	
	try {

	// Creates an Object
	if ( cmd == "addob" ) {
		if ( !text ) Message( "Error - You must specify a model ID", Colour( 255, 100, 100 ) );
		else if ( !IsNum( text ) ) MessagePlayer( "Error - Model ID must be a number", pPlayer, Colour( 255, 100, 100 ) );
		else if ( middleWindow.Window.Visible ) Message( "Error - Exit the editor first.", Colour( 255, 100, 100 ) );
		else {
			CallServerFunc( "MapEditor/Main.nut", "createMapObject", text.tointeger(), pPlayer );
			editorMessage( "Added object model: [ " + text + " ]." , Col_PM );
			editorMessage( "You can edit its position with [#FF0000]/moveob <object id>[#d]" , Col_PM );
		}
	}
	
	else if ( cmd == "removeob" ) {
		if ( !text ) Message( "Error - You must specify a model ID", Colour( 255, 100, 100 ) );
		else if ( !IsNum( text ) ) MessagePlayer( "Error - Model ID must be a number", pPlayer, Colour( 255, 100, 100 ) );
		else if ( !FindObject( text.tointeger() ) ) Message( "Error - Cannot find that object.", Colour( 255, 100, 100 ) );
		else if ( middleWindow.Window.Visible ) Message( "Error - Exit the editor first.", Colour( 255, 100, 100 ) );
		else {
			CallServerFunc( "MapEditor/Main.nut", "removeMapObject", text.tointeger() );
			editorMessage( "Removed object ID: [ " + text + " ]." , Col_PM );
		}
	}
	
	else if ( cmd == "moveob" ) {
		if ( !text ) Message( "Error - You must specify an ID", Colour( 255, 100, 100 ) );
		else {
			if ( text == "exit" ) {
				if ( !middleWindow.Window.Visible ) Message( "Error - You are not in the editor.", Colour( 255, 100, 100 ) );
				else {
					currentObject = null;
					endEditingObject();
					editorMessage("Exited the editor successfully!", Col_Editor );
				}
			}
			else {
				if ( !IsNum( text ) ) MessagePlayer( "Error - Model ID must be a number", pPlayer, Colour( 255, 100, 100 ) );
				else if ( !FindObject( text.tointeger() ) ) Message( "Error - Cannot find that object.", Colour( 255, 100, 100 ) );
				else if ( middleWindow.Window.Visible ) Message( "Error - Exit your current editor session first.", Colour( 255, 100, 100 ) );
				else {
					currentObject = text.tointeger();
					startEditingObject( currentObject );
					editorMessage("Welcome to the object position editor!", Col_Editor );
					editorMessage("You can change modes by pressing: [#FF0000]1, 2, 3, 4[#d] or [#FF0000]5[#d]!", Col_Editor );
					editorMessage("You can also change your sensitivity with: [#FF0000]Q[#d] and [#FF0000]E[#d]!", Col_Editor );
					editorMessage("If you wish to exit the editor, type: [#FF0000]/moveob exit[#d]", Col_Editor );
				}
			}
		}
	}
	
	else if ( cmd == "nearob" ) {
		if ( !text ) Message( "Error - You must specify a range", Colour( 255, 100, 100 ) );
		else if ( !IsNum( text ) ) MessagePlayer( "Error - range must be a number", pPlayer, Colour( 255, 100, 100 ) );
		else if ( middleWindow.Window.Visible ) Message( "Error - Exit the editor first.", Colour( 255, 100, 100 ) );
		else if ( text.tointeger() > 999 ) Message( "Error - Number's too big.", Colour( 255, 100, 100 ) );
		else {
			CallServerFunc( "MapEditor/Main.nut", "nearMapObject", pPlayer, text.tointeger() );
		}
	}
	
	else if ( cmd == "savemap" ) {
		if ( !text ) Message( "Error - You must specify a name for the map (one word only)", Colour( 255, 100, 100 ) );
		else if ( middleWindow.Window.Visible ) Message( "Error - Exit the editor first.", Colour( 255, 100, 100 ) );
		else {
			CallServerFunc( "MapEditor/Main.nut", "saveMap", text );
			editorMessage("Map: [" + text + "] saved successfully!", Col_PM );
		}
	}
	
	} catch( e ) { 
		Message( e ) 
	};
	
}

function onClientRender() {
	if ( middleWindow.Window.Visible ) {
		updateMovement( currentObject );
	}
}

//************************************************** //
//
//                 Functions
//
//************************************************** //

///////////////////////////////////////
//
//  Type: GUI update function
//  Description: Updates the X,Y,Z labels
//  Params: x -> coord x
//			y -> coord y
//			z -> coord z
//  Returns: Nothing
//
function updateObjectPos( x, y, z ) {
	
	labelObjectX.Text = "X: " + x;
	labelObjectY.Text = "Y: " + y;
	labelObjectZ.Text = "Z: " + z;

}

///////////////////////////////////////
//
//  Type: GUI update function
//  Description: Updates the rX,rY,rZ labels
//  Params: xr -> rotation x
//			yr -> rotation y
//			zr -> rotation z
//  Returns: Nothing
//
function updateObjectRot( xr, yr, zr ) {
	
	labelObjectXr.Text = "rX: " + xr;
	labelObjectYr.Text = "rY: " + yr;
	labelObjectZr.Text = "rZ: " + zr;

}

///////////////////////////////////////
//
//  Type: GUI update function
//  Description: Updates the object details
//  Params: id 	  -> object id
//			model -> object model
//			world -> object virtual world
//  Returns: Nothing
//
function updateObjectDetails( id, model, world ) {
	
	labelObjectID.Text = "ID: " + id;
	labelObjectModel.Text = "Model: " + model;
	labelObjectWorld.Text = "World: " + world;

}

///////////////////////////////////////
//
//  Type: GUI update function
//  Description: Updates the mode information
//  Params: mode -> mode id
//  Returns: Nothing
//
function updateControlDetails( mode ) {
	
	labelMode.Text = "Mode: " + getModeName( mode );
	updateControls( mode );
	
}

///////////////////////////////////////
//
//  Type: Mode function
//  Description: Returns the mode's name
//  Params: mode -> mode id
//  Returns: String mode's name
//
function getModeName( mode ) {
	switch( mode ) {
	case 0:
		return "Object X/Y position.";
	case 1:
		return "Object Z position.";
	case 2:
		return "Object X/Y rotation.";
	case 3:
		return "Object Z rotation.";
	case 4:
		return "Camera distance.";
	}
}

///////////////////////////////////////
//
//  Type: GUI update function
//  Description: Updates the control information
//  Params: mode -> mode id
//  Returns: Nothing
//
function updateControls( mode ) {
	switch( mode ) {
	case 0:
		labelControls1.Text = "A/D - X movement";
		labelControls2.Text = "W/S - Y movement";
		break;
	case 1:
		labelControls1.Text = "W/S - Z movement";
		labelControls2.Text = "";
		break;
	case 2:
		labelControls1.Text = "A/D - X rotation";
		labelControls2.Text = "W/S - Y rotation";
		break;
	case 3:
		labelControls1.Text = "A/D - Z rotation";
		labelControls2.Text = "";
		break;
	case 4:
		labelControls1.Text = "A/D - left-right movement";
		labelControls2.Text = "W/S - zoom";
		break;
	}
}

///////////////////////////////////////
//
//  Type: Mode function
//  Description: Sets a mode
//  Params: mode -> mode id
//  Returns: Nothing
//
function setMode( mode ) {
	controlMode = mode;
	updateControlDetails( controlMode );
}

///////////////////////////////////////
//
//  Type: Camera update function
//  Description: Updates the camera pos
//  Params: objectID -> id of the object
//  Returns: Nothing
//
function updateCameraPos( objectID ) {
	local object = FindObject( objectID );
	local behindPos = Vector( Get2DLookAtPos( object.Pos, cameraAngle, -cameraZoom ).x, 
							  Get2DLookAtPos( object.Pos, cameraAngle, -cameraZoom ).y, 
							  object.Pos.z + 10.0 );
	SetCameraMatrix( behindPos, object.Pos );
}

///////////////////////////////////////
//
//  Type: GUI update function
//  Description: Updates the sensitivity
//  Params: down -> either true or false (1, 0)
//  Returns: Nothing
//
function updateSensitivity( down ) {

	if ( down ) {
		if ( controlSensitivity > 0.01 )
			controlSensitivity = ( controlSensitivity / 2.0 );
	}
	else {
		if ( controlSensitivity < 8 )
			controlSensitivity = ( controlSensitivity * 2.0 );
	}
	labelSensitivity.Text = "Sensitivity: " + round( controlSensitivity.tofloat(), 2 ) + "x";

}

///////////////////////////////////////
//
//  Type: Map Editor function
//  Description: Starts editing the map
//  Params: id -> object id
//  Returns: Nothing
//
function startEditingObject( id ) {

	BindKey( '1', BINDTYPE_DOWN, "setMode", 0 );
	BindKey( '2', BINDTYPE_DOWN, "setMode", 1 );
	BindKey( '3', BINDTYPE_DOWN, "setMode", 2 );
	BindKey( '4', BINDTYPE_DOWN, "setMode", 3 );
	BindKey( '5', BINDTYPE_DOWN, "setMode", 4 );
	
	BindKey( 'E', BINDTYPE_UP, "updateSensitivity", 1 );
	BindKey( 'Q', BINDTYPE_UP, "updateSensitivity", 0 );
	
	BindKey( 'W', BINDTYPE_DOWN, "bindButton_W" );
	BindKey( 'A', BINDTYPE_DOWN, "bindButton_A" );
	BindKey( 'S', BINDTYPE_DOWN, "bindButton_S" );
	BindKey( 'D', BINDTYPE_DOWN, "bindButton_D" );

	
	
	updateMovement( currentObject );
	updateObjectDetails( id, FindObject( id ).Model, 0 );
	updateControlDetails( controlMode );
	
	pPlayer.Frozen = true;
	
	middleWindow.Visible( true );
	posWindow.Visible( true );
	rotWindow.Visible( true );
	detailWindow.Visible( true );
	
}

///////////////////////////////////////
//
//  Type: Map Editor function
//  Description: Exits the editor
//  Params: 
//  Returns: Nothing
//
function endEditingObject() {
	UnbindKey( '1' );
	UnbindKey( '2' );
	UnbindKey( '3' );
	UnbindKey( '4' );
	UnbindKey( '5' );
	
	UnbindKey( 'E' );
	UnbindKey( 'Q' );
	
	UnbindKey( 'W' );
	UnbindKey( 'A' );
	UnbindKey( 'S' );
	UnbindKey( 'D' );
	
	pPlayer.Frozen = false;
	RestoreCamera();
	
	middleWindow.Visible( false );
	posWindow.Visible( false );
	rotWindow.Visible( false );
	detailWindow.Visible( false );
}

///////////////////////////////////////
//
//  Type: Bind function
//  Description: Button A
//  Params: 
//  Returns: Nothing
//
function bindButton_A() {
	
	switch( controlMode ) {
	// X movement
	case 0:
		moveObject( currentObject, -controlSensitivity, 0, 0 );
		break;
	// Z movement
	case 1:
		break;
	// X rotation
	case 2:
		rotateObject( currentObject, -controlSensitivity, 0, 0 );
		break;
	// Z rotation
	case 3:
		rotateObject( currentObject, 0, 0, -controlSensitivity );
		break;
	// Camera left
	case 4:
		if ( cameraAngle - controlSensitivity < 0 )
			cameraAngle = 360;
		else
			cameraAngle = cameraAngle - controlSensitivity;
		break;
	}

}

///////////////////////////////////////
//
//  Type: Bind function
//  Description: Button D
//  Params: 
//  Returns: Nothing
//
function bindButton_D() {
	
	switch( controlMode ) {
	// X movement
	case 0:
		moveObject( currentObject, controlSensitivity, 0, 0 );
		break;
	// Z movement
	case 1:
		break;
	// X rotation
	case 2:
		rotateObject( currentObject, controlSensitivity, 0, 0 );
		break;
	// Z rotation
	case 3:
		rotateObject( currentObject, 0, 0, controlSensitivity );
		break;
	// Camera left
	case 4:
		if ( cameraAngle + controlSensitivity > 360 )
			cameraAngle = 0;
		else
			cameraAngle = cameraAngle + controlSensitivity;
		break;
	}

}

///////////////////////////////////////
//
//  Type: Bind function
//  Description: Button W
//  Params: 
//  Returns: Nothing
//
function bindButton_W() {
	
	switch( controlMode ) {
	// Y movement
	case 0:
		moveObject( currentObject, 0, controlSensitivity, 0 );
		break;
	// Z movement
	case 1:
		moveObject( currentObject, 0, 0, controlSensitivity );
		break;
	// Y rotation
	case 2:
		rotateObject( currentObject, 0, controlSensitivity, 0 );
		break;
	// Z rotation
	case 3:
		//--
		break;
	// Camera left
	case 4:
		cameraZoom = cameraZoom + controlSensitivity;
		break;
	}
}

///////////////////////////////////////
//
//  Type: Bind function
//  Description: Button S
//  Params: 
//  Returns: Nothing
//
function bindButton_S() {
	
	switch( controlMode ) {
	// Y movement
	case 0:
		moveObject( currentObject, 0, -controlSensitivity, 0 );
		break;
	// Z movement
	case 1:
		moveObject( currentObject, 0, 0, -controlSensitivity );
		break;
	// Y rotation
	case 2:
		rotateObject( currentObject, 0, -controlSensitivity, 0 );
		break;
	// Z rotation
	case 3:
		//--
		break;
	// Camera left
	case 4:
		cameraZoom = cameraZoom - controlSensitivity;
		break;
	}
}

function moveObject( id, ax, ay, az ) {
	CallServerFunc( "MapEditor/Main.nut", "moveMapObject", id, ax, ay, az );
}

function rotateObject( id, ax, ay, az ) {
	CallServerFunc( "MapEditor/Main.nut", "rotateMapObject", id, ax, ay, az );
}

function editorMessage( text, color ) {
	Message("[#009999] >>[#d] " + text, color );
}

///////////////////////////////////////
//
//  Type: GUI update function
//  Description: Updates everything
//  Params: id -> object ID
//  Returns: Nothing
//
function updateMovement( id ) {
	local object = FindObject( id );
	updateObjectPos( object.Pos.x, object.Pos.y, object.Pos.z );
	updateObjectRot( object.Angle.x, object.Angle.y, object.Angle.z );
	updateCameraPos( id );
}

///////////////////////////////////////
//
//  			CLASS
//
//  Type: GUI stuff
//  Description: Handles Window's position,
//				 size, etc etc...
//
class gx_GUIWindow {

	constructor( posx, posy, sizex, sizey, titletext ) {
	
		x = posx;
		y = posy;
		sizeX = sizex;
		sizeY = sizey;
		title = titletext;
		Window = ::GUIWindow( ::parseVectorScreen( posx - (sizex/2), posy - (sizey/2) ), ::parseScreenSize( sizex, sizey ), title );
		
	}
	
	function addChild( child ) {
		Window.AddChild( child );
	}
	
	function Visible( boolean ) {
		Window.Visible = boolean;
	}
	
	function Pos() {
		return ::VectorScreen( x, y );
	}
	
	function Titlebar( boolean ) {
		Window.Titlebar = boolean;
	}
	
	function Colour( colour ) {
		Window.Colour = colour;
	}
	
	function Alpha( alpha ) {
		if ( alpha < 255 ) {
			Window.Transparent = true;
			Window.Alpha = alpha;
		}
		else {
			Window.Transparent = false;
			Window.Alpha = 255;
		}
	}
	
	function Moveable( boolean ) {
		Window.Moveable = boolean;
	}
	
	function Remove() {
		Window.Remove();
		x = 0;
		y = 0;
		sizeX = 0;
		sizeY = 0;
		title = null;
	}
	
	Window = null;
	x = 0;
	y = 0;
	sizeX = 0;
	sizeY = 0;
	title = null;

}

///////////////////////////////////////
//
//  Type: GUI Function
//  Description: Parses the real vector position
//				 depending on a screen (Knucis' one)
//  Params: x -> position x (integer)
//			y -> position y (integer)
//  Returns: VectorScreen(x,y);
//
function parseVectorScreen( x, y ) {

	local screenX = ( x * ScreenWidth ) / 1440; // I am using 1440 because it's my width resolution...
	local screenY = ( y * ScreenHeight ) / 900; // I am using 900 because it's my height resolution...
	
	return VectorScreen( screenX, screenY );
}

///////////////////////////////////////
//
//  Type: GUI Function
//  Description: Parses the real size
//				 depending on a screen (Knucis' one)
//  Params: sizex -> size x (integer)
//			sizey -> size y (integer)
//  Returns: ScreenSize(x,y);
//
function parseScreenSize( sizex, sizey ) {

	local screenX = ( sizex * ScreenWidth ) / 1440; // I am using 1440 because it's my width resolution...
	local screenY = ( sizey * ScreenHeight ) / 900; // I am using 900 because it's my height resolution...
	
	return ScreenSize( screenX, screenY );

}

///////////////////////////////////////
//
//  Type: Control Function
//  Description: Toggles the mouse cursor
//				 and camera movement!
//  Params: toggle -> boolean
//  Returns: None
//
function toggleControls( toggle ) {
	
	ShowMouseCursor( !toggle );
	ToggleCameraMovement( toggle );
}

///////////////////////////////////////
//
//  Type: Position function
//  Description: Returns the vector pos
//				 in front of the player
//  Params: range -> the range
//  Returns: Vector
//	Credits: aXXo (VU forums)
//
function Get2DLookAtPos( pos, a, range )
{
	local player = pos;
	local angle = a + 90; //To point North at 90 degrees (It is at 0 degree by default)
	
	if ( angle > 360 ) 
		angle -= 360;
		
	local slope = tan( angle * ( PI/180 ) );
	
	local x2 = null, y2 = null;
	
	if ( angle >= 135 && angle <= 225 )
		x2 = pos.x - range;
	else if ( angle > 225 && angle <= 315 )
		y2 = pos.y - range;
	else if ( angle > 315 || angle <= 45 )
		x2 = pos.x + range;
	else if ( angle >= 45 && angle < 135 )
		y2 = pos.y + range;
	
	if ( !y2 ) 
		y2 = ( ( x2 - pos.x ) * slope ) + pos.y;
	
	else if ( !x2 )
		x2 = (( y2 - pos.y )/slope) + pos.x;
		
	return Vector( x2, y2, pos.z);
}

///////////////////////////////////////
//
//  Type: Round function
//  Description: Returns a rounded
//				 value
//  Params: val -> value to round
//			idx -> number of zeros
//  Returns: float new value
//	Credits: interwebz
//
function round( val, idx ) {
    local f = pow( 10 , idx ) * 1.0;
    local newVal = val * f;
    newVal = floor(newVal + 0.5)
    newVal = ( newVal * 1.0 ) / f;
 
   return newVal;
}