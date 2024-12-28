use std::collections::HashSet;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
    x: isize,
    y: isize,
}

fn maze_solver(
    maze: &[&str],
    wall: char,
    current: Point,
    end: Point,
    visited: &mut HashSet<Point>,
) -> Option<Vec<Point>> {
    // Check if current position is out of bounds or if it's a wall.
    if current.x < 0
        || current.y < 0
        || current.y >= maze.len() as isize
        || current.x >= maze[current.y as usize].len() as isize
        || maze[current.y as usize]
            .chars()
            .nth(current.x as usize)
            .unwrap()
            == wall
    {
        return None;
    }

    if current == end {
        return None;
    }

    if visited.contains(&current) {
        return None;
    }

    visited.insert(current);

    let directions = [
        Point { x: 0, y: -1 }, // Up.
        Point { x: 1, y: 0 },  // Right.
        Point { x: 0, y: 1 },  // Down.
        Point { x: -1, y: 0 }, // Left.
    ];

    for direction in directions {
        let next = Point {
            x: current.x + direction.x,
            y: current.y + direction.y,
        };

        if let Some(mut path) = maze_solver(maze, wall, next, end, visited) {
            path.insert(0, current);
            return Some(path);
        }
    }

    visited.remove(&current);
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_maze_solver_success() {
        let maze = [
            "....",
            ".##.",
            "....",
            "....",
        ];
        let start = Point { x: 0, y: 0 };
        let end = Point { x: 3, y: 3 };
        let mut visited = HashSet::new();

        let result = maze_solver(&maze, '#', start, end, &mut visited);
        assert!(result.is_some());
        let path = result.unwrap();

        assert_eq!(path.first(), Some(&start));
        assert_eq!(path.last(), Some(&end));
    }

    #[test]
    fn test_maze_solver_wall_blocked() {
        let maze = [
            "....",
            ".##.",
            "....",
            "....",
        ];
        let start = Point { x: 0, y: 0 };
        let end = Point { x: 3, y: 1 }; // Bloqueado por paredes
        let mut visited = HashSet::new();

        let result = maze_solver(&maze, '#', start, end, &mut visited);
        assert!(result.is_none());
    }

    #[test]
    fn test_maze_solver_no_path() {
        let maze = [
            "....",
            "####",
            "....",
            "....",
        ];
        let start = Point { x: 0, y: 0 };
        let end = Point { x: 3, y: 3 }; // Sem caminho disponível
        let mut visited = HashSet::new();

        let result = maze_solver(&maze, '#', start, end, &mut visited);
        assert!(result.is_none());
    }
}
