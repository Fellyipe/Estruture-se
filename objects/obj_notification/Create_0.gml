// obj_concept_notify - Create
sprite_to_draw = spr_notification;
spawn_room = room_get_name(room);

// visual state
draw_set_alpha(1);
alpha = 1;
pulse_timer = 0;
pulse_speed = 0.09;
pulse_scale = 1.06;
base_y_offset = -80; // posição relativa do GUI (ajuste se quiser mais alto/baixo)
visible = true;

// optional auto-mark if concept doesn't exist in data (defensive)
audio_play_sound(snd_notification, 0, false, 1, 0, 1);
