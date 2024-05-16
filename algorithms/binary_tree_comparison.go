package algorithms

type TreeNode struct {
	Value int
	Left  *TreeNode
	Right *TreeNode
}

func CompareTrees(p *TreeNode, q *TreeNode) bool {
	if p == nil && q == nil {
		return true
	}

	if p == nil && q != nil || p != nil && q == nil {
		return false
	}

	if p.Value != q.Value {
		return false
	}

	return CompareTrees(p.Left, q.Left) && CompareTrees(p.Right, q.Right)
}
