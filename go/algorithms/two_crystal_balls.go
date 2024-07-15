package algorithms

import (
	"math"
)

func TwoCrystalBall(breaks []bool) int {
	jmpAmount := math.Floor(math.Sqrt(float64(len(breaks))))

	i := jmpAmount

	// Primeira bola: identifica o intervalo onde poderia quebrar.
	for ; i < float64(len(breaks)); i += jmpAmount {
		if breaks[int(i)] {
			break
		}
	}

	i -= jmpAmount

	// Segunda bola: busca linear no intervalo para encontrar o ponto exato.
	for j := 0; j < int(jmpAmount) && i < float64(len(breaks)); j, i = j+1, i+1 {
		if breaks[int(i)] {
			return int(i) // Encontrou o ponto exato onde a bola quebra.
		}
	}

	return -1 // Se a bola não quebra em nenhum ponto, retorna -1.
}
