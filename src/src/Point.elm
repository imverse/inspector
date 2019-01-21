module Point exposing (Point, add, sub, xCoordinate, yCoordinate)


type alias Point =
    { x : Float, y : Float }


add : Point -> Point -> Point
add a b =
    let
        x =
            a.x + b.x

        y =
            a.y + b.y
    in
    { x = x, y = y }


sub : Point -> Point -> Point
sub a b =
    let
        x =
            a.x - b.x

        y =
            a.y - b.y
    in
    { x = x, y = y }


xCoordinate : Point -> Float
xCoordinate a =
    a.x


yCoordinate : Point -> Float
yCoordinate a =
    a.y
