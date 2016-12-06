/// Loop object initialization

/*
This object creates a set of other object instances upon the room start
in this case it is used to created a set of instances that make up a loop
consisting of the platform instances as well as the depth layering instances

Other objects like this can be manually made for common level features doing so
can make level design a lot easier
*/

var high_depth_layer, low_depth_layer;

high_depth_layer = +5;
low_depth_layer = -5;

// Low Depth Layer
with (instance_create(x, y, Plat_1x4))
    {depth = low_depth_layer;}

with (instance_create(x, y + 128, Plat_1x4))
    {depth = low_depth_layer;}

with (instance_create(x + 32, y, Plat_C1))
    {depth = low_depth_layer;}

with (instance_create(x + 32, y + 128, Plat_C2))
    {depth = low_depth_layer;}

with (instance_create(x - 32, y, DepthLayerParent))
    {L1 = low_depth_layer; L2 = low_depth_layer; image_yscale = 8;}


// High Depth Layer
with (instance_create(x + 288, y, Plat_1x4))
    {depth = high_depth_layer;}

with (instance_create(x + 288, y + 128, Plat_1x4))
    {depth = high_depth_layer;}

with (instance_create(x + 160, y, Plat_C0))
    {depth = high_depth_layer;}

with (instance_create(x + 160, y + 128, Plat_C3))
    {depth = high_depth_layer;}

with (instance_create(x + 320, y, DepthLayerParent))
    {L1 = high_depth_layer; L2 = high_depth_layer; image_yscale = 8;}


// Depth Switcher
with (instance_create(x + 144, y, DepthLayerParent))
    {L1 = high_depth_layer; L2 = low_depth_layer; image_yscale = 1;}


// Destroy thsi loop instance as no longer needed
instance_destroy();

/* */
/*  */
