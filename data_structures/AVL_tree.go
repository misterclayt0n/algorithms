package data_structures

import "fmt"

// AVLNode represents a node in the AVL tree.
type AVLNode struct {
	Value  int
	Left   *AVLNode
	Right  *AVLNode
	Height int
}

// AVLTree represents the AVL tree.
type AVLTree struct {
	Root *AVLNode
}

// NewAVLNode creates a new AVL node.
func NewAVLNode(value int) *AVLNode {
	return &AVLNode{
		Value:  value,
		Height: 1,
	}
}

// NewAVLTree creates a new AVL tree.
func NewAVLTree() *AVLTree {
	return &AVLTree{}
}

// height returns the height of a node.
func (t *AVLTree) height(n *AVLNode) int {
	if n == nil {
		return 0
	}
	return n.Height
}

// max returns the maximum of two integers.
func (t *AVLTree) max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

// rightRotate performs a right rotation on the subtree with root y.
func (t *AVLTree) rightRotate(y *AVLNode) *AVLNode {
	x := y.Left
	T2 := x.Right

	// perform rotation
	x.Right = y
	y.Left = T2

	// update heights
	y.Height = t.max(t.height(y.Left), t.height(y.Right)) + 1
	x.Height = t.max(t.height(x.Left), t.height(x.Right)) + 1

	// return new root
	return x
}

// leftRotate performs a left rotation on the subtree with root x.
func (t *AVLTree) leftRotate(x *AVLNode) *AVLNode {
	y := x.Right
	T2 := y.Left

	// perform rotation
	y.Left = x
	x.Right = T2

	// update heights
	x.Height = t.max(t.height(x.Left), t.height(x.Right)) + 1
	y.Height = t.max(t.height(y.Left), t.height(y.Right)) + 1

	// return new root
	return y
}

// getBalance calculates and returns the balance factor of a node.
func (t *AVLTree) getBalance(n *AVLNode) int {
	if n == nil {
		return 0
	}
	return t.height(n.Left) - t.height(n.Right)
}

// Insert inserts a new value into the AVL tree and returns the new root of the subtree.
func (t *AVLTree) Insert(value int) {
	t.Root = t.insertNode(t.Root, value)
}

func (t *AVLTree) insertNode(node *AVLNode, value int) *AVLNode {
	// step 1: perform the normal BST insertion
	if node == nil {
		return NewAVLNode(value)
	}
	if value < node.Value {
		node.Left = t.insertNode(node.Left, value)
	} else if value > node.Value {
		node.Right = t.insertNode(node.Right, value)
	} else {
		// duplicate values are not allowed in the AVL tree
		return node
	}

	// step 2: update the height of this ancestor node
	node.Height = 1 + t.max(t.height(node.Left), t.height(node.Right))

	// step 3: get the balance factor of this ancestor node to check whether this node became unbalanced
	balance := t.getBalance(node)

	// if this node becomes unbalanced, then there are 4 cases

	// case 1: left left
	if balance > 1 && value < node.Left.Value {
		return t.rightRotate(node)
	}

	// case 2: right right
	if balance < -1 && value > node.Right.Value {
		return t.leftRotate(node)
	}

	// case 3: left right
	if balance > 1 && value > node.Left.Value {
		node.Left = t.leftRotate(node.Left)
		return t.rightRotate(node)
	}

	// case 4: right left
	if balance < -1 && value < node.Right.Value {
		node.Right = t.rightRotate(node.Right)
		return t.leftRotate(node)
	}

	// return the (unchanged) node pointer
	return node
}

// PreOrder performs a pre-order traversal of the tree and prints the values of the nodes.
func (t *AVLTree) PreOrder(node *AVLNode) {
	if node != nil {
		fmt.Printf("%d ", node.Value)
		t.PreOrder(node.Left)
		t.PreOrder(node.Right)
	}
}
