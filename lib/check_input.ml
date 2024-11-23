type color =
  | Green
  | Red
  | Reset

type status = Correct | Incorrect

let color_code = function
  | Green -> "\033[32m"
  | Red -> "\033[31m"
  | Reset -> "\033[0m"

let status_to_color = function
  | Correct -> Green
  | Incorrect -> Red

let color char status =
  let ansi_color_start = color_code (status_to_color status) in
  let ansi_color_end = color_code Reset in
  Printf.sprintf "%s%c%s" ansi_color_start char ansi_color_end

let check ~(input:char) ~(text:char) =
  if input = text then Correct else Incorrect

