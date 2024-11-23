type color =
  | Green
  | Red
  | Reset

type status = Correct | Incorrect

val color : char -> status -> string
val check : input:char -> text:char -> status
