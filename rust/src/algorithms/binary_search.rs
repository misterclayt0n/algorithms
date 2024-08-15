pub fn binary_search(array: &[i32], x: i32) -> bool {
    let mut low = 0;
    let mut high = array.len();

    while low < high {
        let middle = low + (high - low) / 2;

        if array[middle] == x {
            return true;
        } else if array[middle] < x {
            low = middle + 1;
        } else {
            high = middle;
        }
    }

    false
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_binary_search() {
        let array = [1, 2, 3, 4, 5];
        assert!(binary_search(&array, 3));
    }

    #[test]
    fn test_binary_search_not_found() {
        let array = [1, 2, 3, 4, 5];
        assert!(!binary_search(&array, 6));
    }
}
