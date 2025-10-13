ds_list_destroy(solution_list);

if (owns_solution_maps && ds_exists(solution_list, ds_type_list)) {
    var n = ds_list_size(solution_list);
    for (var i = 0; i < n; ++i) {
        var m = ds_list_find_value(solution_list, i);
        if (ds_exists(m, ds_type_map)) ds_map_destroy(m);
    }
}
if (ds_exists(solution_list, ds_type_list)) ds_list_destroy(solution_list);
