package data_structures

type RingBuffer struct {
	Buffer []int
	Head   int
	Tail   int
	Size   int
}

func NewRingBuffer(Size int) *RingBuffer {
	return &RingBuffer{
		Buffer: make([]int, Size),
		Head:   0,
		Tail:   0,
		Size:   Size,
	}
}

func (rb *RingBuffer) Push(value int) {
	rb.Buffer[rb.Head] = value
	rb.Head = (rb.Head + 1) % rb.Size
	if rb.Head == rb.Tail {
		rb.Tail = (rb.Tail + 1) % rb.Size
	}
}

func (rb *RingBuffer) Pop() (int, bool) {
	if rb.Tail == rb.Head {
		return 0, false
	}

	val := rb.Buffer[rb.Tail]
	rb.Tail = (rb.Tail + 1) % rb.Size
	return val, true
}
