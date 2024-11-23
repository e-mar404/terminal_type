open OUnit2
open Check_input

let correct_color_char _ =
  assert_equal "\033[32ma\033[0m" (color 'a' Correct)

let incorrect_color_char _ =
  assert_equal "\033[31ma\033[0m" (color 'a' Incorrect)

let suite =
  "suite" >::: [
    "correct_color_char" >:: correct_color_char;
    "incorrect_color_char" >:: incorrect_color_char;
  ]

let () =
  run_test_tt_main suite
