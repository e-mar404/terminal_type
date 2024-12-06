open OUnit2
open Unix
open Terminal_type.Display

let show_test_text () = print_endline "\033[39;2mt\033[0m\033[39;2me\033[0m\033[39;2ms\033[0m\033[39;2mt\033[0m"

let correct_letter _ =
  let colored_letter = "\033[32mt\033[0m" in
  let expected = "\033[32mt\033[0m\033[39;2me\033[0m\033[39;2ms\033[0m\033[39;2mt\033[0m" in
  let buffer = Buffer.create 4 in
  
  let stdout_copy = Unix.dup Unix.stdout in
  let (read_fd, write_fd) = Unix.pipe () in
  Unix.dup2 write_fd Unix.stdout;
  Unix.close write_fd;

  show_test_text ();

  display colored_letter 0;

  flush (out_channel_of_descr stdout);
  Unix.dup2 stdout_copy Unix.stdout;
  Unix.close stdout_copy;

  let channel = Unix.in_channel_of_descr read_fd in
  Buffer.add_channel buffer channel 1024;
  close_in channel;

  assert_equal ~printer:(fun x -> x) (Buffer.contents buffer) expected

let suite =
  "suite" >::: [
    "correct_letter" >:: correct_letter;
  ]

let () =
  run_test_tt_main suite
