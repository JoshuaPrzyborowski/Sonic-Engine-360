// This script makes the powerup for the box occur, argument0 is the box_type

  //Box Types
  /*
      0 - Life
      1 - Eggman
      2 - Ring
      3 - Shield Basic
      4 - Shield Fire
      5 - Shield Electricity
      6 - Shield Water
      7 - Invincibility
      8 - Sneekers
  */

sound_play(SndBoxHit);

switch (argument0)
{
    
    case 0:     // Life
        player_lifeup();
        break;

    case 1:     // Eggman
        if (invincibility == -1)
            player_hurt();
        break;

    case 2:     // 10 Rings
        player_ring(10);
        break;

    case 3:     // Shield Basic
        shield = 1;
        shield_action = -1;
        sound_play(SndShieldBasicGet);
        break;

    case 4:     // Shield Fire
        shield = 2;
        shield_action = -1;
        sound_play(SndShieldFireGet);
        break;

    case 5:     // Shield Electricity
        shield = 3;
        shield_action = -1;
        sound_play(SndShieldElectricityGet);
        break;

    case 6:     // Shield Water
        shield = 4;
        shield_action = -1;
        sound_play(SndShieldWaterGet);
        break;

    case 7:     // Invincibility box
        invincibility = inv_box;          // Start invincibility box counter
        inv_sparks = 0;                   // Number of invincibility effect sparks
//        player_music(SndInvincible);
        break;

    case 8:     // Speed Sneekers
        sneekers = 0;                    // Start sneeker counter by setting to 0
        acc = 0.2;
        max_runspeed = 15;
//        player_music(SndSneekers);
        break;
}
