package algorithms

func QuickSort(arr []int) []int {
	if len(arr) < 2 {
		return arr
	}

	low, high := 0, len(arr)-1

	pivot := arr[len(arr)/2]

	for low <= high {
		for arr[low] < pivot {
			low++
		}

		for arr[high] > pivot {
			high--
		}

		if low <= high {
			arr[low], arr[high] = arr[high], arr[low]
			low++
			high--
		}
	}

	if 0 < high {
		QuickSort(arr[:high+1])
	}

	if low < len(arr) {
		QuickSort(arr[low:])
	}

	return arr
}
