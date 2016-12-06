// Initialise the global array that allows the lookup of the depth of a given object
// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
// NOTE: MacroExpansion is used to insert the array initialisation at import time
gml_pragma( "global", "__global_object_depths()");

// insert the generated arrays here
global.__objectDepths[0] = -10; // DisplayCamera
global.__objectDepths[1] = 1; // Ring
global.__objectDepths[2] = 0; // WallParent
global.__objectDepths[3] = 0; // SolidParent
global.__objectDepths[4] = 0; // DepthLayerParent
global.__objectDepths[5] = 2; // EndPost
global.__objectDepths[6] = 0; // DepthSetHigh
global.__objectDepths[7] = 0; // DepthSetLow
global.__objectDepths[8] = 0; // DepthChange
global.__objectDepths[9] = 0; // LevelBaker
global.__objectDepths[10] = -3; // Player
global.__objectDepths[11] = 0; // Plat_SC1
global.__objectDepths[12] = 0; // Plat_4x4
global.__objectDepths[13] = 0; // Plat_C2
global.__objectDepths[14] = 0; // Plat_TC0
global.__objectDepths[15] = 0; // Plat_C1
global.__objectDepths[16] = 0; // Plat_C0
global.__objectDepths[17] = 2; // SpikeUp_x1
global.__objectDepths[18] = 3; // SpringUp
global.__objectDepths[19] = 3; // SpringRight
global.__objectDepths[20] = 3; // SpringLeft
global.__objectDepths[21] = 3; // SpringUpRight
global.__objectDepths[22] = 0; // Plat_4x1
global.__objectDepths[23] = 0; // Plat_1x4
global.__objectDepths[24] = 3; // SpringParent
global.__objectDepths[25] = 2; // BoxParent
global.__objectDepths[26] = 0; // Plat_C3
global.__objectDepths[27] = 0; // Plat_1x1
global.__objectDepths[28] = 5; // Plat_LR
global.__objectDepths[29] = -5; // Plat_HR
global.__objectDepths[30] = 0; // Plat_Loop1
global.__objectDepths[31] = 2; // Plat_JumpThrough
global.__objectDepths[32] = 2; // Plat_Moving


global.__objectNames[0] = "DisplayCamera";
global.__objectNames[1] = "Ring";
global.__objectNames[2] = "WallParent";
global.__objectNames[3] = "SolidParent";
global.__objectNames[4] = "DepthLayerParent";
global.__objectNames[5] = "EndPost";
global.__objectNames[6] = "DepthSetHigh";
global.__objectNames[7] = "DepthSetLow";
global.__objectNames[8] = "DepthChange";
global.__objectNames[9] = "LevelBaker";
global.__objectNames[10] = "Player";
global.__objectNames[11] = "Plat_SC1";
global.__objectNames[12] = "Plat_4x4";
global.__objectNames[13] = "Plat_C2";
global.__objectNames[14] = "Plat_TC0";
global.__objectNames[15] = "Plat_C1";
global.__objectNames[16] = "Plat_C0";
global.__objectNames[17] = "SpikeUp_x1";
global.__objectNames[18] = "SpringUp";
global.__objectNames[19] = "SpringRight";
global.__objectNames[20] = "SpringLeft";
global.__objectNames[21] = "SpringUpRight";
global.__objectNames[22] = "Plat_4x1";
global.__objectNames[23] = "Plat_1x4";
global.__objectNames[24] = "SpringParent";
global.__objectNames[25] = "BoxParent";
global.__objectNames[26] = "Plat_C3";
global.__objectNames[27] = "Plat_1x1";
global.__objectNames[28] = "Plat_LR";
global.__objectNames[29] = "Plat_HR";
global.__objectNames[30] = "Plat_Loop1";
global.__objectNames[31] = "Plat_JumpThrough";
global.__objectNames[32] = "Plat_Moving";


// create another array that has the correct entries
var len = array_length_1d(global.__objectDepths);
global.__objectID2Depth = [];
for( var i=0; i<len; ++i ) {
	var objID = asset_get_index( global.__objectNames[i] );
	global.__objectID2Depth[ objID ] = global.__objectDepths[i];
} // end for