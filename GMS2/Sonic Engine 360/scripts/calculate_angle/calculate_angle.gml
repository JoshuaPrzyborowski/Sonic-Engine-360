// ==== Prototype ======
// calculate_angle( angle, horizontal_space )
// ===============================================
// Returns the angle of the surface below the mask depending on actual angle.
// Basically, two points search for the surface and when they found it, calculates the angle
// between them and that's the angle surface.

var done1, done2, sensor_radius, sensor_angle, sensor_dcos, sensor_dsin, x1, y1, x2, y2;

sensor_radius = 8;
sensor_angle = argument0;
sensor_dcos = cos(degtorad(sensor_angle));
sensor_dsin = sin(degtorad(sensor_angle));

x1 = x - (sensor_dcos * sensor_radius);
y1 = y + (sensor_dsin * sensor_radius);
x2 = x + (sensor_dcos * sensor_radius);
y2 = y - (sensor_dsin * sensor_radius);

mask_index = MaskSmall;
done1 = 0; done2 = 0;
for (i = 0; i < 28; i += 1)
{
    if (!done1)
    {
        done1 = (!place_free(x1,y1));
        x1 += sensor_dsin;
        y1 += sensor_dcos;
    }
    if (!done2)
    {
        done2 = (!place_free(x2,y2));
        x2 += sensor_dsin;
        y2 += sensor_dcos;
    }

    if (done1 && done2)
        break;
}

if ((done1 && done2) || !ground)
    return point_direction(x1, y1, x2, y2);
else
    return sensor_angle;
