module Point exposing (Point, add, sub, x, y)


type alias Point =
    ( Float, Float )


add : Point -> Point -> Point
add a b =
    let
        x =
            Tuple.first a + Tuple.first b

        y =
            Tuple.second a + Tuple.second b
    in
    ( x, y )


sub : Point -> Point -> Point
sub a b =
    let
        x =
            Tuple.first a - Tuple.first b

        y =
            Tuple.second a - Tuple.second b
    in
    ( x, y )


x : Point -> Float
x a =
    Tuple.first a


y : Point -> Float
y a =
    Tuple.second a
