// Initialise the global array that allows the lookup of the depth of a given object
// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
// NOTE: MacroExpansion is used to insert the array initialisation at import time
gml_pragma( "global", "__global_object_depths()");

// insert the generated arrays here
global.__objectDepths[0] = 0; // SolidParent
global.__objectDepths[1] = 0; // WallParent
global.__objectDepths[2] = 0; // DepthLayerParent
global.__objectDepths[3] = 0; // DepthSetLow
global.__objectDepths[4] = 0; // LevelBaker
global.__objectDepths[5] = 0; // DepthChange
global.__objectDepths[6] = 0; // DepthSetHigh
global.__objectDepths[7] = -3; // Player
global.__objectDepths[8] = -10; // DisplayCamera
global.__objectDepths[9] = 0; // Plat_SC1
global.__objectDepths[10] = 3; // SpringUp
global.__objectDepths[11] = 0; // Plat_C3
global.__objectDepths[12] = 0; // Plat_C2
global.__objectDepths[13] = 3; // SpringLeft
global.__objectDepths[14] = 2; // BoxParent
global.__objectDepths[15] = 0; // Plat_4x4
global.__objectDepths[16] = 3; // SpringRight
global.__objectDepths[17] = 0; // Plat_C1
global.__objectDepths[18] = 0; // Plat_4x1
global.__objectDepths[19] = 2; // Plat_JumpThrough
global.__objectDepths[20] = 0; // Plat_Loop1
global.__objectDepths[21] = 5; // Plat_LR
global.__objectDepths[22] = 0; // Plat_1x4
global.__objectDepths[23] = -5; // Plat_HR
global.__objectDepths[24] = 1; // Ring
global.__objectDepths[25] = 0; // Plat_1x1
global.__objectDepths[26] = 2; // EndPost
global.__objectDepths[27] = 0; // Plat_TC0
global.__objectDepths[28] = 2; // SpikeUp_x1
global.__objectDepths[29] = 2; // Plat_Moving
global.__objectDepths[30] = 0; // Plat_C0
global.__objectDepths[31] = 3; // SpringUpRight
global.__objectDepths[32] = 3; // SpringParent


global.__objectNames[0] = "SolidParent";
global.__objectNames[1] = "WallParent";
global.__objectNames[2] = "DepthLayerParent";
global.__objectNames[3] = "DepthSetLow";
global.__objectNames[4] = "LevelBaker";
global.__objectNames[5] = "DepthChange";
global.__objectNames[6] = "DepthSetHigh";
global.__objectNames[7] = "Player";
global.__objectNames[8] = "DisplayCamera";
global.__objectNames[9] = "Plat_SC1";
global.__objectNames[10] = "SpringUp";
global.__objectNames[11] = "Plat_C3";
global.__objectNames[12] = "Plat_C2";
global.__objectNames[13] = "SpringLeft";
global.__objectNames[14] = "BoxParent";
global.__objectNames[15] = "Plat_4x4";
global.__objectNames[16] = "SpringRight";
global.__objectNames[17] = "Plat_C1";
global.__objectNames[18] = "Plat_4x1";
global.__objectNames[19] = "Plat_JumpThrough";
global.__objectNames[20] = "Plat_Loop1";
global.__objectNames[21] = "Plat_LR";
global.__objectNames[22] = "Plat_1x4";
global.__objectNames[23] = "Plat_HR";
global.__objectNames[24] = "Ring";
global.__objectNames[25] = "Plat_1x1";
global.__objectNames[26] = "EndPost";
global.__objectNames[27] = "Plat_TC0";
global.__objectNames[28] = "SpikeUp_x1";
global.__objectNames[29] = "Plat_Moving";
global.__objectNames[30] = "Plat_C0";
global.__objectNames[31] = "SpringUpRight";
global.__objectNames[32] = "SpringParent";


// create another array that has the correct entries
var len = array_length_1d(global.__objectDepths);
global.__objectID2Depth = [];
for( var i=0; i<len; ++i ) {
	var objID = asset_get_index( global.__objectNames[i] );
	global.__objectID2Depth[ objID ] = global.__objectDepths[i];
} // end for