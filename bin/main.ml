open Unix
open Terminal_type.Check_input

type actions =
  | Backspace
  | AnythingElse

let ascii_codes = function
  | 127 -> Backspace 
  | _ -> AnythingElse

let enable_raw_mode () =
  let term_io = tcgetattr stdin in
  let raw_mode = { term_io with c_icanon = false; c_echo = false } in
  tcsetattr stdin TCSANOW raw_mode

let restore_mode old_mode =
  tcsetattr stdin TCSANOW old_mode

let rec handle_input (char_list) (position) =
  let letter = input_char (in_channel_of_descr stdin) in
  let test_letter = List.nth char_list position in
  match ((ascii_codes (int_of_char letter))) with
      | Backspace ->
          Printf.printf "\b \b%!";
          if position < 1 then
            handle_input char_list 0
          else
            handle_input char_list (position - 1)
            
      | AnythingElse ->
          let result = check ~input:letter ~text:test_letter in
          let colored_letter = color test_letter result in
          Printf.printf "%s%!" colored_letter;

          if (position + 1) <> (List.length char_list) then
            handle_input char_list (position + 1)

let explode_string input = 
  List.init (String.length input) (String.get input)

let () =
  let original_mode = tcgetattr stdin in
  try
    enable_raw_mode ();

    handle_input (explode_string "this is a test string") 0;

  with
  | End_of_file ->
    Printf.printf "\nExiting...\n";
    restore_mode original_mode
  | exn ->
    restore_mode original_mode;
    raise exn
