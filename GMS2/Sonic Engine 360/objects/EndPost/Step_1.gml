/// Endpost collision checks

with (Player)       // Note with all items, the code is used in the items but it runs through inside the Player
{
    if (action == act_death) continue;  // Don't run through code if Player is dead

    // Only execute collect action if a collision is going to occur
    if (other.action == 0 && x > other.x)
    {
        other.action = 1;
        scores += 2500;
        other.alarm[0] = 160;
        sound_play(SndEndPost);
    }
}

