if (!instance_exists(target)) {
    exit;
}

var target_x = target.x;
var target_y = target.y;

cam_x = target_x;
cam_y = target_y;

var final_cam_x = clamp(cam_x - view_w / 2, 0, room_width - view_w);
var final_cam_y = clamp(cam_y - view_h / 2, 0, room_height - view_h);

camera_set_view_pos(camera, final_cam_x, final_cam_y);
