package data_structures

import "fmt"

const (
	RED   = true
	BLACK = false
)

type RedBlackNode struct {
	Value  int
	Left   *RedBlackNode
	Right  *RedBlackNode
	Parent *RedBlackNode
	Color  bool
}

type RedBlackTree struct {
	Root *RedBlackNode
	NIL  *RedBlackNode
}

func NewRedBlackNode(value int, color bool, nilNode *RedBlackNode) *RedBlackNode {
	return &RedBlackNode{
		Value:  value,
		Color:  color,
		Left:   nilNode,
		Right:  nilNode,
		Parent: nilNode,
	}
}

func NewRedBlackTree() *RedBlackTree {
	nilNode := &RedBlackNode{Color: BLACK}
	return &RedBlackTree{NIL: nilNode, Root: nilNode}
}

func (t *RedBlackTree) leftRotate(x *RedBlackNode) {
	y := x.Right
    x.Right = y.Left

    if y.Left != t.NIL {
        y.Left.Parent = x
    }

    y.Parent = x.Parent
    if x.Parent == t.NIL {
        t.Root = y
    } else if x == x.Parent.Left {
        x.Parent.Left = y
    } else {
        x.Parent.Right = y
    }
    y.Left = x
    x.Parent = y
}

func (t *RedBlackTree) rightRotate(x *RedBlackNode) {
    y := x.Left
    x.Left = y.Right
    if y.Right != t.NIL {
        y.Right.Parent = x
    }

    y.Parent = x.Parent

    if x.Parent == t.NIL {
        t.Root = y
    } else if x == x.Parent.Right {
        x.Parent.Right = y
    } else {
        x.Parent.Left = y
    }

    y.Right = x
    y.Parent = y
}

func (t *RedBlackTree) Insert(value int) {
    newNode := NewRedBlackNode(value, RED, t.NIL)
    y := t.NIL
    x := t.Root

    for x != t.NIL {
        y = x
        if newNode.Value < x.Value {
            x = x.Left
        } else {
            x = x.Right
        }
    }

    newNode.Parent = y

    if y == t.NIL {
        t.Root = newNode
    } else if newNode.Value < y.Value {
        y.Left = newNode
    } else {
        y.Right = newNode
    }

    newNode.Left = t.NIL
    newNode.Right = t.NIL
    newNode.Color = RED
    t.insertFixup(newNode)
}

func (t *RedBlackTree) insertFixup(z *RedBlackNode) {
    for z.Parent.Color == RED {
        if z.Parent == z.Parent.Parent.Left {
            y := z.Parent.Parent.Right
            if y.Color == RED {
                z.Parent.Color = BLACK
                y.Color = BLACK
                z.Parent.Parent.Color = RED
                z = z.Parent.Parent
            } else {
                if z == z.Parent.Right {
                    z = z.Parent
                    t.leftRotate(z)
                }
                z.Parent.Color = BLACK
                z.Parent.Parent.Color = RED
                t.rightRotate(z.Parent.Parent)
            }
        } else {
            y := z.Parent.Parent.Left
            if y.Color == RED {
                z.Parent.Color = BLACK
                y.Color = BLACK
                z.Parent.Parent.Color = RED
                z = z.Parent.Parent
            } else {
                if z == z.Parent.Left {
                    z = z.Parent
                    t.rightRotate(z)
                }
                z.Parent.Color = BLACK
                z.Parent.Parent.Color = RED
                t.leftRotate(z.Parent.Parent)
            }
        }
    }
    t.Root.Color = BLACK
}

func (t *RedBlackTree) PreOrder(node *RedBlackNode) {
    if node != t.NIL {
        fmt.Printf("%d ", node.Value)
        t.PreOrder(node.Left)
        t.PreOrder(node.Right)
    }
}
