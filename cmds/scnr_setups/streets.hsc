; HOST GLOBALS:

(global boolean game_ended false)

(global boolean timer_on false)
(global short wait 0)

(global boolean timer_on2 false)
(global short wait2 0)

(global boolean timer_on3 false)
(global short wait3 0)

(global boolean damage_enable false)
(global damage barrier_damage "objects\battle_royale\barrier_damage")

(global short random_player0 -1)
(global short random_player1 -1)
(global short random_player2 -1)
(global short random_player3 -1)
(global short random_player4 -1)
(global short random_player5 -1)
(global short random_player6 -1)
(global short random_player7 -1)
(global short random_player8 -1)
(global short random_player9 -1)
(global short random_player10 -1)
(global short random_player11 -1)
(global short random_player12 -1)
(global short random_player13 -1)
(global short random_player14 -1)
(global short random_player15 -1)
(global short random_number -1)
(global string random_selected "none")

(global vehicle pod0 none)
(global vehicle pod1 none)
(global vehicle pod2 none)
(global vehicle pod3 none)
(global vehicle pod4 none)
(global vehicle pod5 none)
(global vehicle pod6 none)
(global vehicle pod7 none)
(global vehicle pod8 none)
(global vehicle pod9 none)
(global vehicle pod10 none)
(global vehicle pod11 none)
(global vehicle pod12 none)
(global vehicle pod13 none)
(global vehicle pod14 none)
(global vehicle pod15 none)
(global stringid vehicle_seat "pod_d") 

; MODIFY FOR SET COUNT #1
(global short sets_count 3)
(global short current_set -1)
(global short previous_set -1)
(global string current_name "none")
(global folder current_events "none")
(global object current_barrier none)
(global triggervolume current_volume "none")

(global boolean event_call false)

(global boolean barrier_call false)
(global real barrier_scale 1)
(global short barrier_time 0)

(global boolean client_call false)
(global boolean players_ready false)
(global boolean round_ended false)
(global boolean break_loop false)

; CLIENT GLOBALS:

(global short local_player -1)
(global object current_client_barrier none)

(global short surviving_player -1)

(global boolean client_connected false)
(global boolean round_toggle false)
(global boolean event_toggle false)

; EXTERNAL SCRIPT OPCODES:

(script extern void (mp_sync_global (string global)))
(script extern short lobby_size)
(script extern short player_get_local_idx)
(script extern object (player_get_by_idx (short idx)))
(script extern void mp_hide_scoreboard)

; HOST FUNCTIONS:

(script startup host_start
	(sleep 10)
	(if (> (lobby_size) 1)
		(begin
			(wake host_loop)
			(wake continuous_client_sync)
			(wake timer)
			(wake timer2)
			(wake timer3)
			(wake damage_players)
		)
	)
)

(script dormant continuous_client_sync
	(sleep_until
		(begin
			(mp_sync_global current_set)
			(mp_sync_global client_call)
			(mp_sync_global players_ready)
			(mp_sync_global round_ended)
			(mp_sync_global event_call)
			(mp_sync_global barrier_call)
			(mp_sync_global barrier_scale)
			(mp_sync_global barrier_time)
			(mp_wake_script client_passthrough)
			(sleep 30)
			(= game_ended true)
		)
	5)
)

(script dormant client_passthrough
	(sleep_until (!= (player_get_local_idx) -1) 5)
	(wake client_loop)
)

(script dormant timer
	(sleep_until
		(begin
			(sleep_until (= timer_on true) 5)
			(sleep wait)
			(set timer_on false)
			(= game_ended true)
		)
	5)
)

(script dormant timer2
	(sleep_until
		(begin
			(sleep_until (= timer_on2 true) 5)
			(sleep wait2)
			(set timer_on2 false)
			(= game_ended true)
		)
	5)
)

(script dormant timer3
	(sleep_until
		(begin
			(sleep_until (= timer_on3 true) 5)
			(sleep wait3)
			(set timer_on3 false)
			(= game_ended true)
		)
	5)
)

(script dormant damage_players
	(sleep_until
		(begin
			(sleep_until (= damage_enable true) 5)
			(if (!= (volume_test_object current_volume (list_get (players) 0)) true) (damage_object_effect barrier_damage (list_get (players) 0)) )
			(if (!= (volume_test_object current_volume (list_get (players) 1)) true) (damage_object_effect barrier_damage (list_get (players) 1)) )
			(if (!= (volume_test_object current_volume (list_get (players) 2)) true) (damage_object_effect barrier_damage (list_get (players) 2)) )
			(if (!= (volume_test_object current_volume (list_get (players) 3)) true) (damage_object_effect barrier_damage (list_get (players) 3)) )
			(if (!= (volume_test_object current_volume (list_get (players) 4)) true) (damage_object_effect barrier_damage (list_get (players) 4)) )
			(if (!= (volume_test_object current_volume (list_get (players) 5)) true) (damage_object_effect barrier_damage (list_get (players) 5)) )
			(if (!= (volume_test_object current_volume (list_get (players) 6)) true) (damage_object_effect barrier_damage (list_get (players) 6)) )
			(if (!= (volume_test_object current_volume (list_get (players) 7)) true) (damage_object_effect barrier_damage (list_get (players) 7)) )
			(if (!= (volume_test_object current_volume (list_get (players) 8)) true) (damage_object_effect barrier_damage (list_get (players) 8)) )
			(if (!= (volume_test_object current_volume (list_get (players) 9)) true) (damage_object_effect barrier_damage (list_get (players) 9)) )
			(if (!= (volume_test_object current_volume (list_get (players) 10)) true) (damage_object_effect barrier_damage (list_get (players) 10)) )
			(if (!= (volume_test_object current_volume (list_get (players) 11)) true) (damage_object_effect barrier_damage (list_get (players) 11)) )
			(if (!= (volume_test_object current_volume (list_get (players) 12)) true) (damage_object_effect barrier_damage (list_get (players) 12)) )
			(if (!= (volume_test_object current_volume (list_get (players) 13)) true) (damage_object_effect barrier_damage (list_get (players) 13)) )
			(if (!= (volume_test_object current_volume (list_get (players) 14)) true) (damage_object_effect barrier_damage (list_get (players) 14)) )
			(if (!= (volume_test_object current_volume (list_get (players) 15)) true) (damage_object_effect barrier_damage (list_get (players) 15)) )
			(sleep 8)
			(= game_ended true)
		)
	5)
)

; Doom style man!
(script static void randomize_players
   (if (= random_number 0) (begin (set random_selected "rng0") (set random_player0 7) (set random_player1 9) (set random_player2 5) (set random_player3 6) (set random_player4 14) (set random_player5 10) (set random_player6 12) (set random_player7 8) (set random_player8 1) (set random_player9 2) (set random_player10 13) (set random_player11 15) (set random_player12 4) (set random_player13 11) (set random_player14 0) (set random_player15 3)))
   (if (= random_number 1) (begin (set random_selected "rng1") (set random_player0 5) (set random_player1 1) (set random_player2 13) (set random_player3 12) (set random_player4 2) (set random_player5 4) (set random_player6 15) (set random_player7 10) (set random_player8 6) (set random_player9 11) (set random_player10 3) (set random_player11 14) (set random_player12 0) (set random_player13 9) (set random_player14 8) (set random_player15 7)))
   (if (= random_number 2) (begin (set random_selected "rng2") (set random_player0 12) (set random_player1 7) (set random_player2 0) (set random_player3 11) (set random_player4 14) (set random_player5 8) (set random_player6 13) (set random_player7 9) (set random_player8 6) (set random_player9 15) (set random_player10 1) (set random_player11 5) (set random_player12 3) (set random_player13 2) (set random_player14 4) (set random_player15 10)))
   (if (= random_number 3) (begin (set random_selected "rng3") (set random_player0 2) (set random_player1 10) (set random_player2 7) (set random_player3 12) (set random_player4 13) (set random_player5 0) (set random_player6 11) (set random_player7 15) (set random_player8 5) (set random_player9 9) (set random_player10 4) (set random_player11 8) (set random_player12 1) (set random_player13 6) (set random_player14 14) (set random_player15 3)))
   (if (= random_number 4) (begin (set random_selected "rng4") (set random_player0 10) (set random_player1 3) (set random_player2 11) (set random_player3 0) (set random_player4 12) (set random_player5 14) (set random_player6 8) (set random_player7 9) (set random_player8 2) (set random_player9 5) (set random_player10 15) (set random_player11 4) (set random_player12 6) (set random_player13 1) (set random_player14 13) (set random_player15 7)))
   (if (= random_number 5) (begin (set random_selected "rng5") (set random_player0 9) (set random_player1 14) (set random_player2 11) (set random_player3 13) (set random_player4 1) (set random_player5 0) (set random_player6 12) (set random_player7 5) (set random_player8 3) (set random_player9 8) (set random_player10 10) (set random_player11 4) (set random_player12 6) (set random_player13 15) (set random_player14 2) (set random_player15 7)))
   (if (= random_number 6) (begin (set random_selected "rng6") (set random_player0 4) (set random_player1 15) (set random_player2 0) (set random_player3 2) (set random_player4 14) (set random_player5 12) (set random_player6 10) (set random_player7 6) (set random_player8 7) (set random_player9 13) (set random_player10 5) (set random_player11 11) (set random_player12 9) (set random_player13 3) (set random_player14 1) (set random_player15 8)))
   (if (= random_number 7) (begin (set random_selected "rng7") (set random_player0 1) (set random_player1 7) (set random_player2 14) (set random_player3 10) (set random_player4 0) (set random_player5 15) (set random_player6 4) (set random_player7 2) (set random_player8 3) (set random_player9 5) (set random_player10 12) (set random_player11 13) (set random_player12 6) (set random_player13 9) (set random_player14 11) (set random_player15 8)))
   (if (= random_number 8) (begin (set random_selected "rng8") (set random_player0 13) (set random_player1 3) (set random_player2 15) (set random_player3 0) (set random_player4 8) (set random_player5 2) (set random_player6 4) (set random_player7 7) (set random_player8 11) (set random_player9 14) (set random_player10 1) (set random_player11 9) (set random_player12 6) (set random_player13 10) (set random_player14 12) (set random_player15 5)))
   (if (= random_number 9) (begin (set random_selected "rng9") (set random_player0 3) (set random_player1 9) (set random_player2 13) (set random_player3 11) (set random_player4 15) (set random_player5 14) (set random_player6 0) (set random_player7 7) (set random_player8 2) (set random_player9 6) (set random_player10 4) (set random_player11 1) (set random_player12 5) (set random_player13 10) (set random_player14 12) (set random_player15 8)))
   (if (= random_number 10) (begin (set random_selected "rng10") (set random_player0 14) (set random_player1 12) (set random_player2 1) (set random_player3 7) (set random_player4 0) (set random_player5 6) (set random_player6 4) (set random_player7 11) (set random_player8 5) (set random_player9 2) (set random_player10 3) (set random_player11 15) (set random_player12 8) (set random_player13 10) (set random_player14 13) (set random_player15 9)))
   (if (= random_number 11) (begin (set random_selected "rng11") (set random_player0 7) (set random_player1 11) (set random_player2 2) (set random_player3 6) (set random_player4 8) (set random_player5 13) (set random_player6 9) (set random_player7 1) (set random_player8 10) (set random_player9 0) (set random_player10 15) (set random_player11 4) (set random_player12 12) (set random_player13 5) (set random_player14 14) (set random_player15 3)))
   (if (= random_number 12) (begin (set random_selected "rng12") (set random_player0 0) (set random_player1 13) (set random_player2 9) (set random_player3 11) (set random_player4 1) (set random_player5 5) (set random_player6 14) (set random_player7 3) (set random_player8 6) (set random_player9 12) (set random_player10 15) (set random_player11 2) (set random_player12 8) (set random_player13 7) (set random_player14 10) (set random_player15 4)))
   (if (= random_number 13) (begin (set random_selected "rng13") (set random_player0 9) (set random_player1 6) (set random_player2 2) (set random_player3 13) (set random_player4 12) (set random_player5 4) (set random_player6 0) (set random_player7 5) (set random_player8 11) (set random_player9 10) (set random_player10 3) (set random_player11 1) (set random_player12 7) (set random_player13 8) (set random_player14 15) (set random_player15 14)))
   (if (= random_number 14) (begin (set random_selected "rng14") (set random_player0 6) (set random_player1 7) (set random_player2 12) (set random_player3 2) (set random_player4 9) (set random_player5 4) (set random_player6 8) (set random_player7 5) (set random_player8 13) (set random_player9 14) (set random_player10 3) (set random_player11 15) (set random_player12 10) (set random_player13 11) (set random_player14 1) (set random_player15 0)))
   (if (= random_number 15) (begin (set random_selected "rng15") (set random_player0 13) (set random_player1 4) (set random_player2 5) (set random_player3 0) (set random_player4 1) (set random_player5 14) (set random_player6 15) (set random_player7 10) (set random_player8 3) (set random_player9 7) (set random_player10 12) (set random_player11 9) (set random_player12 11) (set random_player13 2) (set random_player14 8) (set random_player15 6)))
)

(script static void load_player_pods
	(unit_enter_vehicle (unit (list_get (players) random_player0)) pod0 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player1)) pod1 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player2)) pod2 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player3)) pod3 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player4)) pod4 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player5)) pod5 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player6)) pod6 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player7)) pod7 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player8)) pod8 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player9)) pod9 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player10)) pod10 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player11)) pod11 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player12)) pod12 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player13)) pod13 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player14)) pod14 vehicle_seat)
	(unit_enter_vehicle (unit (list_get (players) random_player15)) pod15 vehicle_seat)
)

(script static void wake_pod_physics 
	(object_wake_physics pod0)
	(object_wake_physics pod1)
	(object_wake_physics pod2)
	(object_wake_physics pod3)
	(object_wake_physics pod4)
	(object_wake_physics pod5)
	(object_wake_physics pod6)
	(object_wake_physics pod7)
	(object_wake_physics pod8)
	(object_wake_physics pod9)
	(object_wake_physics pod10)
	(object_wake_physics pod11)
	(object_wake_physics pod12)
	(object_wake_physics pod13)
	(object_wake_physics pod14)
	(object_wake_physics pod15)
)

(script dormant players_safely_on_ground
	(sleep_until 
		(or
			(and (> (object_get_health (list_get (players) 0)) 0) (< (object_get_health (object_get_parent (list_get (players) 0))) 0) )
			(and (> (object_get_health (list_get (players) 1)) 0) (< (object_get_health (object_get_parent (list_get (players) 1))) 0) )
			(and (> (object_get_health (list_get (players) 2)) 0) (< (object_get_health (object_get_parent (list_get (players) 2))) 0) )
			(and (> (object_get_health (list_get (players) 3)) 0) (< (object_get_health (object_get_parent (list_get (players) 3))) 0) )
			(and (> (object_get_health (list_get (players) 4)) 0) (< (object_get_health (object_get_parent (list_get (players) 4))) 0) )
			(and (> (object_get_health (list_get (players) 5)) 0) (< (object_get_health (object_get_parent (list_get (players) 5))) 0) )
			(and (> (object_get_health (list_get (players) 6)) 0) (< (object_get_health (object_get_parent (list_get (players) 6))) 0) )
			(and (> (object_get_health (list_get (players) 7)) 0) (< (object_get_health (object_get_parent (list_get (players) 7))) 0) )
			(and (> (object_get_health (list_get (players) 8)) 0) (< (object_get_health (object_get_parent (list_get (players) 8))) 0) )
			(and (> (object_get_health (list_get (players) 9)) 0) (< (object_get_health (object_get_parent (list_get (players) 9))) 0) )
			(and (> (object_get_health (list_get (players) 10)) 0) (< (object_get_health (object_get_parent (list_get (players) 10))) 0) )
			(and (> (object_get_health (list_get (players) 11)) 0) (< (object_get_health (object_get_parent (list_get (players) 11))) 0) )
			(and (> (object_get_health (list_get (players) 12)) 0) (< (object_get_health (object_get_parent (list_get (players) 12))) 0) )
			(and (> (object_get_health (list_get (players) 13)) 0) (< (object_get_health (object_get_parent (list_get (players) 13))) 0) )
			(and (> (object_get_health (list_get (players) 14)) 0) (< (object_get_health (object_get_parent (list_get (players) 14))) 0) )
			(and (> (object_get_health (list_get (players) 15)) 0) (< (object_get_health (object_get_parent (list_get (players) 15))) 0) )
		)
	5)
	(sleep 60)
	(object_can_take_damage (players))
)

; MODIFY FOR SET COUNT #2
(script static void setup_round
	(object_destroy_containing "set_")
	(set current_set (random_range 0 sets_count))
	; (if (= previous_set current_set) )
	; (set previous_set current_set)
	(set random_number (random_range 0 16))
	(randomize_players)
	(print random_selected)
	(if (= current_set 0)
		(begin
			(object_create_folder "set_0_spawns") (set current_events "set_0_events") (set current_name "set_0") (set current_barrier "set_0_barrier") (set current_volume "set_0_barrier")
			(set pod0 "set_0_spawn_0") (set pod1 "set_0_spawn_1") (set pod2 "set_0_spawn_2") (set pod3 "set_0_spawn_3") (set pod4 "set_0_spawn_4") (set pod5 "set_0_spawn_5") (set pod6 "set_0_spawn_6") (set pod7 "set_0_spawn_7") (set pod8 "set_0_spawn_8") (set pod9 "set_0_spawn_9") (set pod10 "set_0_spawn_10") (set pod11 "set_0_spawn_11") (set pod12 "set_0_spawn_12") (set pod13 "set_0_spawn_13") (set pod14 "set_0_spawn_14") (set pod15 "set_0_spawn_15")
		)
	)
	(if (= current_set 1) 
		(begin
			(object_create_folder "set_1_spawns") (set current_events "set_1_events") (set current_name "set_1") (set current_barrier "set_1_barrier") (set current_volume "set_1_barrier")
			(set pod0 "set_1_spawn_0") (set pod1 "set_1_spawn_1") (set pod2 "set_1_spawn_2") (set pod3 "set_1_spawn_3") (set pod4 "set_1_spawn_4") (set pod5 "set_1_spawn_5") (set pod6 "set_1_spawn_6") (set pod7 "set_1_spawn_7") (set pod8 "set_1_spawn_8") (set pod9 "set_1_spawn_9") (set pod10 "set_1_spawn_10") (set pod11 "set_1_spawn_11") (set pod12 "set_1_spawn_12") (set pod13 "set_1_spawn_13") (set pod14 "set_1_spawn_14") (set pod15 "set_1_spawn_15")
		)
	)
	(if (= current_set 2) 
		(begin 
			(object_create_folder "set_2_spawns") (set current_events "set_2_events") (set current_name "set_2") (set current_barrier "set_2_barrier") (set current_volume "set_2_barrier")
			(set pod0 "set_2_spawn_0") (set pod1 "set_2_spawn_1") (set pod2 "set_2_spawn_2") (set pod3 "set_2_spawn_3") (set pod4 "set_2_spawn_4") (set pod5 "set_2_spawn_5") (set pod6 "set_2_spawn_6") (set pod7 "set_2_spawn_7") (set pod8 "set_2_spawn_8") (set pod9 "set_2_spawn_9") (set pod10 "set_2_spawn_10") (set pod11 "set_2_spawn_11") (set pod12 "set_2_spawn_12") (set pod13 "set_2_spawn_13") (set pod14 "set_2_spawn_14") (set pod15 "set_2_spawn_15")
		)
	)
	(print current_name)
)

(script static void create_events
	(object_create_folder current_events)
	(set event_call true)
	(sleep 45)
	(set event_call false)
)

(script static void update_barrier
	(object_set_scale current_barrier barrier_scale barrier_time)
	(set barrier_call true)
	(sleep 45)
	(set barrier_call false)
)

(script static void fallthrough_check
	(if
		(or
			(= (mp_round_started) false)
			(< (list_count_not_dead (players)) 2)
		)
		(set break_loop true)
	)
)

(script static void wait_check
	(sleep_until
		(or
			(= break_loop true)
			(= (mp_round_started) false)
			(< (list_count_not_dead (players)) 2)
			(= timer_on false)
		)
	5)
)

(script static void host_loop_reset
	(set timer_on false)
	(set timer_on2 false)
	(set timer_on3 false)
	(set wait 0)
	(set wait2 0)
	(set wait3 0)
	(mp_scripts_reset)
)

(script dormant host_loop
	; \\\\\\\\\\\
	; ROUND START
	; ///////////
	(setup_round)
	
	(set client_call true)
	(sleep 45)
	(set client_call false)
	
	(sleep_until (= (mp_round_started) true) 5)
	
	; \\\\\\\\\
	; LOAD PODS
	; /////////
	(set wait2 450)
	(set timer_on2 true)
	(sleep_until
		(or
			(= (mp_round_started) false)
			(= (list_count_not_dead (players)) (lobby_size) )
			(= timer_on2 false)
		)
	5)
	(fallthrough_check)
	(if (= break_loop false) (begin (load_player_pods) (wake_pod_physics) (object_cannot_take_damage (players)) ))
	(set players_ready true)
	(wake players_safely_on_ground)
	
	; \\\\\\\\\\\\\\\\\\\\\
	; ENABLE BARRIER DAMAGE
	; /////////////////////
	(set wait3 300)
	(set timer_on3 true)
	(sleep_until
		(or
			(= (mp_round_started) false)
			(= (volume_test_players_all current_volume) true)
			(= timer_on3 false)
		)
	5)
	(fallthrough_check)
	(if (= break_loop false) (set damage_enable true) )
	
	; \\\\\\\\\\
	; SHRINK 0.7
	; //////////
	(set wait 1200)
	(set timer_on true)
	(wait_check)
	(fallthrough_check)
	(if (= break_loop false) (begin (set barrier_scale 0.7) (set barrier_time 425) (update_barrier) ))
	
	; \\\\\\\\\\
	; SHRINK 0.5
	; //////////
	(set wait 1200)
	(set timer_on true)
	(wait_check)
	(fallthrough_check)
	(if (= break_loop false) (begin (set barrier_scale 0.5) (set barrier_time 425) (update_barrier) ))
	
	; \\\\\\\\\\\\
	; SUPPLY EVENT
	; ////////////
	(set wait 600)
	(set timer_on true)
	(wait_check)
	(fallthrough_check)
	(if (= break_loop false) (create_events) )
		
	; \\\\\\\\\\
	; SHRINK 0.3
	; //////////
	(set wait 600)
	(set timer_on true)
	(wait_check)
	(fallthrough_check)
	(if (= break_loop false) (begin (set barrier_scale 0.3) (set barrier_time 425) (update_barrier) ))

	; \\\\\\\\\\
	; SHRINK 0.1
	; //////////
	(set wait 1200)
	(set timer_on true)
	(wait_check)
	(fallthrough_check)
	(if (= break_loop false) (begin (set barrier_scale 0.1) (set barrier_time 425) (update_barrier) ))
	
	; \\\\\\\\\\\
	; SHRINK 0.04
	; ///////////
	(set wait 300)
	(set timer_on true)
	(wait_check)
	(fallthrough_check)
	(if (= break_loop false) (begin (set barrier_scale 0.04) (set barrier_time 100) (update_barrier) ))
	
	; \\\\\\\\\
	; ROUND END
	; /////////
	(sleep_until
		(or
			(= break_loop true)
			(= (mp_round_started) false)
			(< (list_count_not_dead (players)) 2)
		)
	5)
	
	(set damage_enable false)
	(set break_loop false)
	(set round_ended true)
	
	(sleep_until (= (mp_round_started) false) 5)
	(sleep_until (= (list_count_not_dead (players)) 0) 5)
	
	(set round_ended false)
	(set players_ready false)
	
	(sleep_until (= (mp_round_started) true) 5)
	
	(host_loop_reset)
)

(script static void client_start
	(fade_in 0 0 0 10000)
	(mp_hide_scoreboard)
	(cinematic_set_title event_dropping)
	(sound_looping_start "objects\levels\ui\mainmenu\menu_pelican\sounds\menu_pelican_loop_3" "none" 2)
	(pod_rumble)
	(client_intro)
	(client_setup_round)
	(sleep_until (= players_ready true) 5)
	(sleep 15)
	(fade_in 0 0 0 50)
	(sleep_until
		(or 
			(= (mp_round_started) false)
			(< (object_get_health (object_get_parent (player_get_by_idx local_player))) 1)
		)
	5)
	(sound_looping_stop "objects\levels\ui\mainmenu\menu_pelican\sounds\menu_pelican_loop_3")
	(player_effect_stop 0)
	(sleep 120)
	(client_outro)
)

; CLIENT FUNCTIONS:

; MODIFY FOR SET COUNT #3
(script static void client_setup_round
	(set round_toggle false)
	(set event_toggle false)
	(set surviving_player -1)
	(set local_player (player_get_local_idx))
	(mp_object_destroy current_client_barrier)
	(if (= current_set 0) (begin (mp_object_create "set_0_visual") (set current_client_barrier "set_0_visual") ))
	(if (= current_set 1) (begin (mp_object_create "set_1_visual") (set current_client_barrier "set_1_visual") ))
	(if (= current_set 2) (begin (mp_object_create "set_2_visual") (set current_client_barrier "set_2_visual") )) 
)

(script static void pod_rumble
	(player_effect_set_max_translation 0.005 0.005 0.005)
	(player_effect_set_max_rotation 0.005 0.005 0.005)
	(player_effect_set_max_rumble 0.01 0.01)
	(player_effect_start 0.5 2)
)

(script static void client_intro
	(chud_cinematic_fade 0 0)
	(chud_show_messages false)
	(cinematic_show_letterbox true)
	(sound_class_set_gain "ui" 0 0)
	(sound_class_set_gain "game_event" 0 0)
	(sound_class_set_gain "ambient_nature" 0 10)
	(player_enable_input false)
)

(script static void client_outro
	(chud_cinematic_fade 1 1.5)
	(chud_show_messages true)
	(cinematic_show_letterbox false)
	(sound_class_set_gain "ui" 1 0)
	(sound_class_set_gain "game_event" 1 0)
	(sound_class_set_gain "ambient_nature" 1 30)
	(player_enable_input true)
)

(script static void update_client_barrier
	(object_set_scale current_client_barrier barrier_scale barrier_time)
)

(script static void update_client_barrier_quick
	(object_set_scale current_client_barrier barrier_scale 0)
)

(script static void get_surviving_player
	(if (> (object_get_health (player_get_by_idx 0)) 0) (set surviving_player 0) )
	(if (> (object_get_health (player_get_by_idx 1)) 0) (set surviving_player 1) )
	(if (> (object_get_health (player_get_by_idx 2)) 0) (set surviving_player 2) )
	(if (> (object_get_health (player_get_by_idx 3)) 0) (set surviving_player 3) )
	(if (> (object_get_health (player_get_by_idx 4)) 0) (set surviving_player 4) )
	(if (> (object_get_health (player_get_by_idx 5)) 0) (set surviving_player 5) )
	(if (> (object_get_health (player_get_by_idx 6)) 0) (set surviving_player 6) )
	(if (> (object_get_health (player_get_by_idx 7)) 0) (set surviving_player 7) )
	(if (> (object_get_health (player_get_by_idx 8)) 0) (set surviving_player 8) )
	(if (> (object_get_health (player_get_by_idx 9)) 0) (set surviving_player 9) )
	(if (> (object_get_health (player_get_by_idx 10)) 0) (set surviving_player 10) )
	(if (> (object_get_health (player_get_by_idx 11)) 0) (set surviving_player 11) )
	(if (> (object_get_health (player_get_by_idx 12)) 0) (set surviving_player 12) )
	(if (> (object_get_health (player_get_by_idx 13)) 0) (set surviving_player 13) )
	(if (> (object_get_health (player_get_by_idx 14)) 0) (set surviving_player 14) )
	(if (> (object_get_health (player_get_by_idx 15)) 0) (set surviving_player 15) )
)

(script dormant client_loop
	(sleep_until
		(begin
		
			(if (= client_connected false)
				(begin
					(sleep_until
						(begin
							(if 
								(and 
									(= client_connected false) 
									(= client_call true) 
								) 
								(begin 
									(set client_connected true) 
									(client_start) 
								)
							)
							(if 
								(and 
									(= client_connected false) 
									(= (mp_round_started) true) 
									(> (list_count_not_dead (players)) 1) 
								) 
								(begin 
									(set client_connected true) 
									(client_setup_round) 
									(update_client_barrier_quick) 
								)
							)
							(= client_connected true)
						)
					5)
				)
			)
		
			(if (= client_call true) (client_start) )
			
			(if (= barrier_call true)
				(begin
					(cinematic_set_title event_zone_shrinking)
					(update_client_barrier)
					(sleep 45)
				)
			)
			
			(if 
				(and 
					(= event_call true)
					(= event_toggle false)
				)
				(begin
					(cinematic_set_title event_supply_drop)
					(set event_toggle true)
				)
			)

			(if 
				(and 
					(= round_ended true) 
					(= round_toggle false) 
				)
				(begin
					(if 
						(and
							(= round_toggle false)
							(= (list_count_not_dead (players)) 1)
							(> (object_get_health (player_get_by_idx local_player)) 0)
						)
						(begin
							(set round_toggle true)
							(cinematic_set_title event_winner)
							(sound_impulse_start "battle_royale\ui\winning" "none" 1)
							(camera_control true)
							(set_camera_third_person 0 true)
							(sleep 30)
							(effect_new_on_object_marker "objects\characters\grunt\fx\grunt_birthday_party" (player_get_by_idx local_player) "head")
							(sleep 30)
							(effect_new_on_object_marker "objects\characters\grunt\fx\grunt_birthday_party" (player_get_by_idx local_player) "head")
							(sleep 30)
							(effect_new_on_object_marker "objects\characters\grunt\fx\grunt_birthday_party" (player_get_by_idx local_player) "head")
							(sleep 45)
							(set_camera_third_person 0 false)
							(camera_control false)
						)
					)
					(if 
						(and	
							(= round_toggle false)
							(= (list_count_not_dead (players)) 1) 
							(<= (object_get_health (player_get_by_idx local_player)) 0)
						)
						(begin
							(set round_toggle true)
							(cinematic_set_title event_loser)
							(sound_impulse_start "battle_royale\ui\losing" "none" 1)
							(get_surviving_player)
							(sleep 30)
							(effect_new_on_object_marker "objects\characters\grunt\fx\grunt_birthday_party" (player_get_by_idx surviving_player) "head")
							(sleep 30)
							(effect_new_on_object_marker "objects\characters\grunt\fx\grunt_birthday_party" (player_get_by_idx surviving_player) "head")
							(sleep 30)
							(effect_new_on_object_marker "objects\characters\grunt\fx\grunt_birthday_party" (player_get_by_idx surviving_player) "head")
							(sleep 45)
						)
					)
					(if 
						(and
							(= round_toggle false)
							(= (list_count_not_dead (players)) 0)
						)
						(begin
							(set round_toggle true)
							(cinematic_set_title event_tie)
							(sound_impulse_start "battle_royale\ui\tie" "none" 1)
						)
					)				
					(set round_toggle true)
				)
			)
					
			(= game_ended true)
		)
	5)
)
