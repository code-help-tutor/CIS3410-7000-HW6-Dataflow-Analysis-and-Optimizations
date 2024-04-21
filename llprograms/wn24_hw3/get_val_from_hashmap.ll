@key = global i64 483
@table_sz = global i64 15
%arr = type [15 x i64]
@hashmap_glob = global %arr [i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0]

define i64 @get_modulo_value(i64 %sz_of_hashmap) {
    %index_pointer = alloca i64
    store i64 0, i64* %index_pointer
    br label %mod_loop

mod_loop:
    %indx = load i64, i64* %index_pointer
    %upper_bound = mul i64 %indx, %sz_of_hashmap
    %new_index = add i64 %indx, 1
    store i64 %new_index, i64* %index_pointer
    %hashkey = load i64, i64* @key
    %cmp_eq = icmp eq i64 %upper_bound, %hashkey
    br i1 %cmp_eq, label %equal, label %cont
equal:
    ret i64 0
cont:
    %cmp_sgt = icmp sgt i64 %upper_bound, %hashkey
    br i1 %cmp_sgt, label %overshot, label %mod_loop

overshot:
    %lower_bound = sub i64 %upper_bound, %sz_of_hashmap
    %return_val = sub i64 %hashkey, %lower_bound
    ret i64 %return_val
}

define i64 @get_val_from_hash_map_using_global_key() {
    %n = load i64, i64* @table_sz
    %index_ptr = alloca i64
    store i64 0, i64* %index_ptr
    br label %fill_custom_vals

fill_custom_vals:
    %index = load i64, i64* %index_ptr
    %ptr_in_hashmap_one = getelementptr %arr, %arr* @hashmap_glob, i64 0, i64 0 
    store i64 1, i64* %ptr_in_hashmap_one
    %ptr_in_hashmap_two = getelementptr %arr, %arr* @hashmap_glob, i64 0, i64 1 
    store i64 6, i64* %ptr_in_hashmap_two
    %ptr_in_hashmap_tres = getelementptr %arr, %arr* @hashmap_glob, i64 0, i64 3 
    store i64 9, i64* %ptr_in_hashmap_tres
    %ptr_in_hashmap_quatro = getelementptr %arr, %arr* @hashmap_glob, i64 0, i64 4 
    store i64 5, i64* %ptr_in_hashmap_quatro
    br label %get_keys_value

get_keys_value:
    %modulo_value = call i64 @get_modulo_value(i64 %n)
    %ptr_with_retval = getelementptr %arr, %arr* @hashmap_glob, i64 0, i64 %modulo_value
    %retval = load i64, i64* %ptr_with_retval
    ret i64 %retval
}

define i64 @main(i64 %argc, i8** %argv) {
  %1 = call i64 @get_val_from_hash_map_using_global_key()
  ret i64 %1
}