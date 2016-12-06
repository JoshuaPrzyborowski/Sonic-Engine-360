/// Switch depth layers depending on direction, this then sets all walls at this depth to non-solid
// -> Note depth for layered objects can be set in their room instance creation code as well as the object itself!

var layer_deact;
with (Player)
{
    if (place_meeting(x, y, other))  //standard collision
    {
        // Get layer to deactivate depending on Player hspeed direction, the layer values are set in the layer objects creation events
        if (hsp > 0)
            layer_deact = other.L1;
        else
            layer_deact = other.L2;

        // Deactivate walls with depth set at the layer_deact value
        if (depth_layer != layer_deact)
        {
            depth_layer = layer_deact;
            with (WallParent)
            {
                solid = (depth != layer_deact);
            }
        }
    }
}

