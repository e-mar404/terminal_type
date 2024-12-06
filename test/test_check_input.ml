open OUnit2
open Terminal_type.Check_input

let check_correct_char _ =
  assert_equal Correct (check ~input:'a' ~text:'a')

let check_incorrect_char _ =
  assert_equal Incorrect (check ~input:'b' ~text:'a')

let correct_color_char _ =
  assert_equal "\033[32ma\033[0m" (color 'a' Correct)

let incorrect_color_char _ =
  assert_equal "\033[31ma\033[0m" (color 'a' Incorrect)

let suite =
  "suite" >::: [
    "check_correct_char" >:: check_correct_char;
    "check_incorrect_char" >:: check_incorrect_char; 
    "correct_color_char" >:: correct_color_char;
    "incorrect_color_char" >:: incorrect_color_char;
  ]

let () =
  run_test_tt_main suite
