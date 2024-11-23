type color =
  | Green
  | Red
  | Reset

type status =
  | Correct
  | Incorrect
  | End

val color : char -> status -> string
