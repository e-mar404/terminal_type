type color =
  | Green
  | Red
  | LightGray
  | Reset

type status = 
  | Correct 
  | Incorrect
  | Backspace

let color_code = function
  | Green -> "\027[32m"
  | Red -> "\027[31m"
  | LightGray -> "\027[39;2m"
  | Reset -> "\027[0m"

let status_to_color = function
  | Correct -> Green
  | Incorrect -> Red
  | Backspace -> LightGray

let color char status =
  let ansi_color_start = color_code (status_to_color status) in
  let ansi_color_end = color_code Reset in
  Printf.sprintf "%s%c%s" ansi_color_start char ansi_color_end

let check ~(input:char) ~(text:char) =
  if input = text then Correct else Incorrect

