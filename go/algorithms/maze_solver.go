package algorithms

type Point struct {
	X, Y int
}

func MazeSolver(maze []string, wall string, current, end Point, visited map[Point]bool) ([]Point, bool) {
	// check if current position is out of bounds or if it's a wall
	if current.X < 0 || current.X >= len(maze[0]) || current.Y < 0 || current.Y >= len(maze) || maze[current.Y][current.X] == wall[0] {
		return nil, false
	}

	// check if we found the end
	if current == end {
		return []Point{end}, true
	}

	// check if we've visited this point before
	if visited[current] {
		return nil, false
	}

	visited[current] = true

	directions := []Point{{0, -1}, {1, 0}, {0, 1}, {-1, 0}}

	for _, direction := range directions {
		next := Point{current.X + direction.X, current.Y + direction.Y}
		if path, ok := MazeSolver(maze, wall, next, end, visited); ok {
			return append([]Point{current}, path...), true
		}
	}

	visited[current] = false
	return nil, false
}
