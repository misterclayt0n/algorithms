use algorithms_and_DSA::algorithms::linear_search;

#[test]
fn test_linear_search() {
    let array = [1, 2, 3, 4, 5];
    assert!(linear_search(&array, 3)); // Teste para valor existente
    assert!(!linear_search(&array, 6)); // Teste para valor inexistente
}
