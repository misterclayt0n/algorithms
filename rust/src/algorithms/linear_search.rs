pub fn linear_search(array: &[i32], x: i32) -> bool {
    for &item in array {
        if item == x {
            println!("true");
            return true;
        }
    }

    return false;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_linear_search_found() {
        let array = [1, 2, 3, 4, 5];
        assert!(linear_search(&array, 3));
    }

    #[test]
    fn test_linear_search_not_found() {
        let array = [1, 2, 3, 4, 5];
        assert!(!linear_search(&array, 6));
    }
}
