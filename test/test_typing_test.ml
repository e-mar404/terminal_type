open OUnit2
open Terminal_type.Typing_test

let one_correct_input _ =
  let read_input () = Some 't' in
  let test_text = ['t'] in

  let output_buffer = Buffer.create 16 in
  let display colored_input _ =
    Buffer.add_string output_buffer colored_input;
  in
  
  let _ = typing_test ~read_input ~display ~test_text in
  let expected_output = "\033[32mt\033[0m" in

  assert_equal expected_output (Buffer.contents output_buffer)

let one_incorrect_input _ =
  let read_input () = Some 't' in
  let test_text = ['h'] in

  let output_buffer = Buffer.create 16 in
  let display colored_input _ =
    Buffer.add_string output_buffer colored_input;
  in

  let _ = typing_test ~read_input ~display ~test_text in
  let expected_output = "\033[31mh\033[0m" in

  assert_equal expected_output (Buffer.contents output_buffer)

let two_correct_input _ = 
  let input = ref ['t'; 'e'] in
  let read_input () = 
    match !input with 
    | [] -> None
    | letter :: rest ->
        input := rest;
        Some letter
  in

  let test_text = ['t'; 'e'] in

  let output_buffer = Buffer.create 16 in
  let display colored_input _ =
    Buffer.add_string output_buffer colored_input;
  in

  let _ = typing_test ~read_input ~display ~test_text in
  let expected_output = "\033[32mt\033[0m\033[32me\033[0m" in

  assert_equal expected_output (Buffer.contents output_buffer)

let two_incorrect_input _ = 
  let input = ref ['a'; 'b'] in
  let read_input () = 
    match !input with 
    | [] -> None
    | letter :: rest ->
        input := rest;
        Some letter
  in

  let test_text = ['t'; 'e'] in

  let output_buffer = Buffer.create 16 in
  let display colored_input _ =
    Buffer.add_string output_buffer colored_input;
  in

  let _ = typing_test ~read_input ~display ~test_text in
  let expected_output = "\033[31mt\033[0m\033[31me\033[0m" in

  assert_equal expected_output (Buffer.contents output_buffer)

let suite =
  "suite" >::: [
    "one_correct_input" >:: one_correct_input;
    "one_incorrect_input" >:: one_incorrect_input;
    "two_correct_input" >:: two_correct_input;
    "two_incorrect_input" >:: two_incorrect_input;
  ]

let () =
  run_test_tt_main suite
