fn bubble_sort(array: &mut [i32]) {
    for i in 0..array.len() {
        for j in 0..array.len() - 1 - i {
            if array[j] > array[j + 1] {
                array.swap(j, j + 1);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;


    #[test]
    fn test_bubble_sort_1() {
        let mut array = [5, 2, 9, 1, 5, 6];
        bubble_sort(&mut array);
        assert!(array.is_sorted());
    }

    #[test]
    fn test_bubble_sort_2() {
        let mut array = [10, 6, 90, 2, 43, 56, 9];
        bubble_sort(&mut array);
        assert!(array.is_sorted());
    }
}
