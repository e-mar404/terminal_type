open OUnit2
open Terminal_type.Typing_test

let typing_test_one_correct_input _ =
  let read_input () = 't' in
  let test_text = ['t'] in

  let output_buffer = Buffer.create 16 in
  let display colored_input =
    Buffer.add_string output_buffer colored_input;
  in
  
  let _ = typing_test ~read_input ~display ~test_text in
  let expected_output = "\033[32mt\033[0m" in

  assert_equal expected_output (Buffer.contents output_buffer)

let typing_test_one_incorrect_input _ =
  let read_input () = 't' in
  let test_text = ['h'] in

  let output_buffer = Buffer.create 16 in
  let display colored_input =
    Buffer.add_string output_buffer colored_input;
  in

  let _ = typing_test ~read_input ~display ~test_text in
  let expected_output = "\033[31mt\033[0m" in

  assert_equal expected_output (Buffer.contents output_buffer)

let suite =
  "suite" >::: [
    "typing_test_one_correct_input" >:: typing_test_one_correct_input;
    "typing_test_one_incorrect_input" >:: typing_test_one_incorrect_input;
  ]

let () =
  run_test_tt_main suite
