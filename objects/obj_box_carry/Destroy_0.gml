if (carried_by != noone && instance_exists(carried_by)) {
    carried_by.carrying = noone;
    carried_by.carry_side = undefined;
}