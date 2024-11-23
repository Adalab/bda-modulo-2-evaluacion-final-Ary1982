USE sakila;

-- Ejercicios
-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT
DISTINCT f.title AS titulos_peliculas
FROM film AS f;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT
DISTINCT f.title AS titulos_peliculas,
f.rating AS clasificación
FROM film AS f
WHERE f.rating = 'PG-13';