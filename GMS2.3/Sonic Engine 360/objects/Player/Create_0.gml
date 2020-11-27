/*==============================================================================//
                        Setup settings for Sonic
//==============================================================================*/
    /* Changable settings */

    hspl                = 20;                    /* Horizontal Speed Limit */
    vspl                = 20;                    /* Vertical Speed Limit */

    acc                 = 0.11;                  /* Acceleration */
    max_runspeed        = 12;                    /* Maximum run speed */
    vfr                 = 0.3;                   /* Vertical Force (gravity) */
    rol_minsp           = 0.4;                   /* Minimum speed needed to roll */
    fric_nat            = 0.10;                  /* Natural Friction Value */
    fric_mov            = 0.005;                 /* Moving Friction Value */
    fric_rol            = 0.04;                  /* Rolling Friction Value (for slopes and the ground) */
    fric_gnd            = 0.21;                  /* Ground Friction Value (for slopes and the ground) */
    jmp                 = -6.8;                  /* Jump strength */
    spind               = 15;                    /* Spin dash strength */

    mask_radius         = 12;                    /* Radius of the player mask */
    character           = Sonic;                 /* Character sprite used */

//==============================================================================
    /* Key action mapping variables */
    KEY_LEFT        = false;
    KEY_RIGHT       = false;
    KEY_UP          = false;
    KEY_DOWN        = false;
    KEY_A_PRESS     = false;

//==============================================================================
    /* Variable initializations */  

    life                = 3;                     /* Number Of Lifes (should be set outside of the Player) */
    scores              = 0;                     /* The player score (should be set outside of the Player) */

    angle               = 0;                     /* Angle of the player*/
    dcos_val            = 1;                     /* Angle cos component */
    dsin_val            = 0;                     /* Amgle sin component */
    ground              = 1;                     /* Check if the player is on the ground */
    action              = 0;                     /* Action the player is currently doing */
    pushing             = 0;                     /* Whether pushing */
    jumping             = 0;                     /* Whether jumping */
    jump_factor         = -1;                    /* Used for variable jump height */
    balancing           = 0;                     /* Balancing direction (0 = not balancing) */
    xdir                = 1;                     /* Direction */
    fric                = 0;                     /* Friction */
    hsp                 = 0;                     /* Horizontal Speed */
    vsp                 = 0;                     /* Vertical Speed */
    full_hspeed         = 0;                     /* The full horizontal amount moving */
    full_vspeed         = 0;                     /* The full vertical amount moving */
    full_direction      = 0;                     /* The full direction moving in (in radians) */
    shield              = 0;                     /* Type of shield used (0 = none, 1 = basic, 2 = fire, 3 = electricity, 4 = water) */
    shield_action       = -1;                    /* Shield action (0 = not using, greater is counter for time used) */
    rings               = 0;                     /* Amount of rings */
    ring_life_counter   = 0;                     /* Amount of lifes taken from 100 rings */
    invincibility       = -1;                    /* Counter used in invinciblity timing and type (-1 = none, 0 = hit, 10000 = shield */
    sneekers            = -1;                    /* Counter for speed sneekers */
    invisible           = 0;                     /* Whether invisible or not */
    current_music       = -1;                    /* Current music playing */
    wait_time           = 0;                     /* Counter used in wait timing */
    time_count          = 0;                     /* Game time counter */
    current_step        = 0;                     /* Monitors the current step in the game */
    depth_layer         = -5;                    /* The current depth layer deactivated */
 
//==============================================================================
    /* Constants */
    act_none            = 0;
    act_roll            = 1;
    act_lookdown        = 2;
    act_lookup          = 3;
    act_spindash        = 4;
    act_spring          = 5;
    act_hit             = 6;
    act_death           = 7;

    inv_hit             = 0;
    inv_box             = 10000;
    inv_action          = 20000;

//==============================================================================
    /* Animation variables used in draw */
    animation           = -1;
    animations_old      = -1;
    animations_frame    = 0;
    animations_framemin = 0;
    animations_framemax = 0;
    animations_speed    = 0;
    animations_timer    = 0;
    animations_return   = 0;

    /* Animation constants */
    ani_stand               = 0;
    ani_wait_start          = 1;
    ani_wait_tap            = 2;
    ani_walk                = 3;
    ani_run                 = 4;
    ani_roll                = 5;
    ani_lookdown            = 6;
    ani_lookup              = 7;
    ani_spindash            = 8;
    ani_spring              = 9;
    ani_hit                 = 10;
    ani_death               = 11;
    ani_push                = 12;
    ani_brake               = 13;
    ani_balance_forwards    = 14;
    ani_balance_backwards   = 15;

    /* Animation settings */

    ani_framemin[ani_push]                  = 45;
    ani_framemax[ani_push]                  = 48;
    ani_return[ani_push]                    = 45;
    ani_speed[ani_push]                     = 10;

    ani_framemin[ani_balance_forwards]      = 51;
    ani_framemax[ani_balance_forwards]      = 52;
    ani_return[ani_balance_forwards]        = 51;
    ani_speed[ani_balance_forwards]         = 10;

    ani_framemin[ani_balance_backwards]     = 53;
    ani_framemax[ani_balance_backwards]     = 55;
    ani_return[ani_balance_backwards]       = 53;
    ani_speed[ani_balance_backwards]        = 10;

    ani_framemin[ani_stand]                 = 0;
    ani_framemax[ani_stand]                 = 0;
    ani_return[ani_stand]                   = 0;
    ani_speed[ani_stand]                    = 0;                  

    ani_framemin[ani_wait_start]            = 1;
    ani_framemax[ani_wait_start]            = 2;
    ani_return[ani_wait_start]              = 3;
    ani_speed[ani_wait_start]               = 5;

    ani_framemin[ani_wait_tap]              = 3;
    ani_framemax[ani_wait_tap]              = 4;
    ani_return[ani_wait_tap]                = 3;
    ani_speed[ani_wait_tap]                 = 10;

    ani_framemin[ani_brake]                 = 49;
    ani_framemax[ani_brake]                 = 50;
    ani_return[ani_brake]                   = 49;
    ani_speed[ani_brake]                    = 12;

    ani_framemin[ani_walk]                  = 5;
    ani_framemax[ani_walk]                  = 16;
    ani_return[ani_walk]                    = 5;
    ani_speed[ani_walk]                     = 12;

    ani_framemin[ani_run]                   = 17;
    ani_framemax[ani_run]                   = 23;
    ani_return[ani_run]                     = 17;
    ani_speed[ani_run]                      = 14;

    ani_framemin[ani_roll]                  = 24;
    ani_framemax[ani_roll]                  = 31;
    ani_return[ani_roll]                    = 24;
    ani_speed[ani_roll]                     = 14;

    ani_framemin[ani_lookdown]              = 32;
    ani_framemax[ani_lookdown]              = 33;
    ani_return[ani_lookdown]                = 33;
    ani_speed[ani_lookdown]                 = 20;
 
    ani_framemin[ani_lookup]                = 34;
    ani_framemax[ani_lookup]                = 35;
    ani_return[ani_lookup]                  = 35;
    ani_speed[ani_lookup]                   = 20;

    ani_framemin[ani_spindash]              = 36;
    ani_framemax[ani_spindash]              = 41;
    ani_return[ani_spindash]                = 36;
    ani_speed[ani_spindash]                 = 25;

    ani_framemin[ani_spring]                = 42;
    ani_framemax[ani_spring]                = 42;
    ani_return[ani_spring]                  = 42;
    ani_speed[ani_spring]                   = 0;

    ani_framemin[ani_hit]                   = 43;
    ani_framemax[ani_hit]                   = 43;
    ani_return[ani_hit]                     = 43;
    ani_speed[ani_hit]                      = 0;

    ani_framemin[ani_death]                 = 44;
    ani_framemax[ani_death]                 = 44;
    ani_return[ani_death]                   = 44;
    ani_speed[ani_death]                    = 0;

//==============================================================================
    /* Code execution */
    camera = instance_create(x, y, DisplayCamera);
    camera.xpan = 0;
    camera.ypan = 0;
    __view_set( e__VW.Object, 0, camera );

/* */
/*  */
