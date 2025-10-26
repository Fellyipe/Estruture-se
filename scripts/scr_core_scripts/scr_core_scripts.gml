function is_descendant(obj, base) {
    var p = object_get_parent(obj);
    while (p != noone) {
        if (p == base) return true;
        p = object_get_parent(p);
    }
    return false;
}


