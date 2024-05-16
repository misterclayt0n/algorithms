package algorithms

type TreeNode struct {
	Value int
	Left  *TreeNode
	Right *TreeNode
}

func CompareTrees(p *TreeNode, q *TreeNode) bool {
	// structure check
	if p == nil && q == nil {
		return true
	}

	// structure check
	if p == nil && q != nil || p != nil && q == nil {
		return false
	}

	// value check
	if p.Value != q.Value {
		return false
	}

	return CompareTrees(p.Left, q.Left) && CompareTrees(p.Right, q.Right)
}
