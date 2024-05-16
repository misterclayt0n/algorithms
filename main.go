package main

import (
	"fmt"

	al "github.com/misterclayt0n/go-algorithms/algorithms"
	// ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	tree1 := &al.TreeNode{Value: 2, Left: &al.TreeNode{Value: 1}, Right: &al.TreeNode{Value: 3}}
	tree2 := &al.TreeNode{Value: 1, Left: &al.TreeNode{Value: 2}, Right: &al.TreeNode{Value: 3}}

	fmt.Println(al.CompareTrees(tree1, tree2))
}
