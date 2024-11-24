open Check_input

let typing_test ~read_input ~display ~test_text = 
  let user_input = read_input () in
  let result = check ~input:user_input ~text:(List.hd test_text) in
  let colored_result = color user_input result in
  display colored_result
