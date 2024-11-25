open Check_input

let typing_test ~read_input ~display ~test_text = 
  List.iteri
    (fun index expected_char ->
      match read_input () with
      | None -> failwith "error with input" 
      | Some user_input ->
          match user_input with
          | '\b' -> 
              let prev_index = if index > 0 then index - 1 else 0 in 
              let prev_color = color (List.nth test_text prev_index) Backspace in
              display prev_color prev_index;
          | _ ->
              let result = check ~input:user_input ~text:expected_char in
              let colored_result = color expected_char result in
              display colored_result index)
    test_text
