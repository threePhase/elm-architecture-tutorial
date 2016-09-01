module Tree exposing
  ( Tree
  , depth
  , empty
  , flatten
  , foldl
  , fromList
  , insert
  , isElement
  , map
  , singleton
  , sum
  )


type Tree a
  = Empty
  | Node a (Tree a) (Tree a)

depth : Tree a -> Int
depth tree =
  case tree of
    Empty ->
      0

    Node v left right ->
      1 + max (depth left) (depth right)

empty : Tree a
empty =
  Empty

flatten : Tree a -> List a
flatten tree =
  case tree of
    Empty -> []

    Node v left right ->
      v :: flatten left ++ flatten right

foldl : (a -> b -> b) -> b -> Tree a -> b
foldl func i tree =
  case tree of
    Empty -> i

    Node v left right ->
      foldl func (foldl func (func v i) right) left

fromList : List comparable -> Tree comparable
fromList xs =
  List.foldl insert empty xs

insert : comparable -> Tree comparable -> Tree comparable
insert x tree =
  case tree of
    Empty ->
      singleton x

    Node y left right ->
      if x > y then
        Node y left (insert x right)

      else if x < y then
        Node y (insert x left) right

      else
        tree

isElement : comparable -> Tree comparable -> Bool
isElement x tree =
  case tree of
    Empty -> False

    Node y left right ->
      if x > y then
        isElement x right

      else if y < x then
        isElement x left

      else
        True

map : (a -> b) -> Tree a -> Tree b
map f tree =
  case tree of
    Empty -> Empty

    Node v left right ->
      Node (f v) (map f left) (map f right)

singleton : a -> Tree a
singleton v =
  Node v Empty Empty


sum : Tree number -> number
sum tree =
  case tree of
    Empty -> 0

    Node v left right ->
      v + sum left + sum right
