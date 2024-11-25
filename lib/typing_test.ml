open Check_input

let typing_test ~read_input ~display ~test_text = 
  List.iteri
    (fun index expected_char ->
      match read_input () with
      | None -> failwith "error with input" 
      | Some user_input ->
        let result = check ~input:user_input ~text:expected_char in
        let colored_result = color expected_char result in
        display colored_result index)
    test_text
