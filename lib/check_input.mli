type color =
  | Green
  | Red
  | LightGray
  | Reset

type status = 
  | Correct 
  | Incorrect
  | Backspace

val color : char -> status -> string
val check : input:char -> text:char -> status
