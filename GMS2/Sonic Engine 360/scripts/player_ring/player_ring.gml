rings += argument0;
sound_play(SndRingCollect);

if (rings div 100 > ring_life_counter)
{
    player_lifeup();
    ring_life_counter += 1;
}
