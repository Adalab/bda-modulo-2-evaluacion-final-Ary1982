USE sakila;

-- Ejercicios
-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT
DISTINCT f.title AS titulos_peliculas
FROM film AS f;



-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT
f.title AS titulos_peliculas,
f.rating AS clasificación
FROM film AS f
WHERE f.rating = 'PG-13';



-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT
f.title AS titulos_peliculas,
f.description 
FROM film AS f
WHERE f.description LIKE "%AMAZING%";



-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT
f.title AS titulos_peliculas,
f.length
FROM film AS f
WHERE f.length > 120;


-- 5. Recupera los nombres de todos los actores.

SELECT
a.first_name,
a.last_name
FROM actor AS a;


-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.


SELECT
a.first_name,
a.last_name
FROM actor AS a
WHERE a.last_name LIKE '%GIBSON%';


-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- la primera manera de resolverlo que se me ocurre es esta:

SELECT
a.actor_id ,
a.first_name,
a.last_name
FROM actor AS a
WHERE a.actor_id BETWEEN 10 AND 20;

-- Otra forma alternativa posdría ser esta:

SELECT
a.actor_id ,
a.first_name,
a.last_name
FROM actor AS a
WHERE a.actor_id >= 10 AND a.actor_id <= 20;
  

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

-- Tabla a consultar: film
-- Columnas (o atributos) que nos interesan en esta consulta: title, rating

 
SELECT
f.title AS TituloPelicula,
f.rating AS Clasificación
FROM film AS f
WHERE f.rating <> 'R'
AND f.rating <> 'PG-13';



-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

-- COUNT(film_id) AS CantidadPeliculas: Utilizo la función de agregación COUNT(film_id) para contar cuántas películas existen en cada clasificación. 
-- El resultado se renombra como CantidadPeliculas.
-- GROUP BY rating: Agrupo los resultados por la columna rating para obtener el conteo de películas para cada clasificación distinta.

SELECT
f.rating AS Clasificación,
COUNT(film_id) AS CantidadPeliculas
FROM film AS f
GROUP BY rating;




-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido 
-- junto con la cantidad de películas alquiladas.
-- tablas a consultar: customer, rental
-- columnas que nos interesan de customer: first_name, last_name (customer_id cruza con la tabla rental)
-- columnas de la tabla rental: customer_id, rental_id
-- Hago un INNER JOIN entre la tabla customer y rental, se cruzan en customer_id. Esto sirve para asociar los alquileres con los daros de los clientes.
-- Agrupo los resultados usando las columnas customer_id, first_name y last_name, para que aparezca cada cliente con el numenro total de peliculas alquiladas.

SELECT
c.customer_id AS Id_cliente,
c.first_name AS NombreCliente,
c.last_name AS ApellidoCliente,
COUNT(r.rental_id) AS PeliculasAlquiladas
FROM customer AS c
INNER JOIN rental as r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;




-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

-- tablas a consultar: rental, inventory, film_category y category
-- columnas de la tabla rental que nos interesan: rental_id, inventory_id
-- columnas de la tabla inventory que nos interesan: inventory_id, film_id
-- columnas de la tabla film_category que nos interesan: film_id, category_id
-- columnas de la tabla category que nos interesan: category_id, name

-- uso el LEFT JOIN para unir las tablas a través de las columnas que tienen en común, pero "guardando" todas las categorias 
-- (por ejemplo, si no ha sido alquilada ninguna pelicula en esa categoria, me devuelve uno 0 en esa fila, no voy a perder esa categoria por el camino)
-- agrupo los resultados por el nombre de la categoria.


SELECT
c.name AS Categoria,
COUNT(r.rental_id) AS AlquileresPorCategoria
FROM category AS c
LEFT JOIN film_category AS fc 
ON c.category_id = fc.category_id
LEFT JOIN inventory AS i
ON i.film_id = fc.film_id
LEFT JOIN rental AS r
ON r.inventory_id = i.inventory_id
GROUP BY c.name;


-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.


SELECT 
AVG(f.length) AS DuraciónMedia,
f.rating AS Clasificación
FROM film AS f
GROUP BY f.rating;


-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

-- Tablas que necesito: film, film_actor, actor
-- Columnas de la tabla film que necesito: title, film_id
-- Columnas de la tabla film_actor que necesito: film_id, actor_id
-- Columnas de la tabla actor que necesito: actor_id, first_name, last_name

SELECT
a.first_name AS Nombre,
a.last_name AS Apellido
FROM actor AS a
INNER JOIN film_actor fa
ON fa.actor_id = a.actor_id
INNER JOIN film AS f
ON f.film_id = fa.film_id
WHERE f.title = 'INDIAN LOVE';


-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT
f.title AS titulos_peliculas
FROM film AS f
WHERE f.description LIKE "%DOG%" 
OR f.description LIKE "%CAT%";


-- 15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT
f.title,
f.release_year
FROM film AS f
WHERE f.release_year BETWEEN 2005 AND 2010;


-- 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".

-- Tabla film, tabla film_category y tabla category
-- De la tabla film necesito title y film_id
-- De la tabla film_category necesito film_id y category_id
-- De la tabla category necesito category_id y name

SELECT
f.title AS Pelicula,
c.name AS Categoria
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category as c
ON fc.category_id = c.category_id
WHERE c.name = 'FAMILY';



-- 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

-- uso la tabla film
-- uso las columnas: title, rating y length


SELECT
f.title AS Pelicula,
f.rating AS Clasificacion,
f.length AS Duracion
FROM film AS f
WHERE f.rating = 'R' 
AND f.length > 120;


---------------------------------------------------------

-- BONUS

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

-- Tablas involucradas: actor, film actor
-- De la tabla actor necesito las columnas first_name, last,name y actor_id (en común con la tabla film_actor)
-- De la tabla film_actor necesito las columnas: actor_id y film_id


SELECT
a.first_name AS Nombre,
a.last_name AS Apellido,
COUNT(fa.film_id) AS CantidadPeliculas
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 10;



-- 19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

-- Tablas involucradas: actor, film actor
-- De la tabla actor necesito las columnas first_name, last,name y actor_id (en común con la tabla film_actor)
-- De la tabla film_actor necesito las columnas: actor_id y film_id


SELECT
a.first_name AS Nombre,
a.last_name AS Apellido
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) = 0;



-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría 
-- junto con el promedio de duración.

-- Tablas que me interesan: film, film_category, category
-- Columnas de la tabla film: length, film_id
-- Columnas de la tabla film_category: film_id, category_id
-- Columnas de la tabla category: category_id, name


SELECT
c.name Categoria,
AVG(f.length) AS PromedioDuración
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
INNER JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 120;




-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

-- Tablas que necesito: actor, film_actor
-- Columnas de la tabla actor: first_name, last_name, actor_id
-- Columnas de la tabla film_actor: actor_id, film_id

SELECT
a.first_name AS NombreActor,
a.last_name AS ApellidoActor,
COUNT(fa.film_id) AS CantidadPeliculas
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 5;


-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
-- Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

-- Tablas que necesito: rental, inventory y film
-- Columnas de rental: inventory_id, rental_id, rental_date y return_date
-- Columnas de inventory: film_id, inventory_id
-- Columnas de film: film_id, title


SELECT
f.title AS Titulo
FROM 
film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
WHERE i.inventory_id IN (
	SELECT
	r.inventory_id
	FROM rental AS r
	WHERE DATEDIFF(r.return_date, r.rental_date) > 5
);



-- OPCIÓN 2 (SIN SUBCONSULTA) pero con la columna de los días:

SELECT
f.title AS Titulo,
DATEDIFF(r.return_date, r.rental_date) AS DiasAlquiler
FROM film AS f
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
WHERE DATEDIFF(r.return_date, r.rental_date) > 5;




-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.


-- Tablas que necesito: actor, film_actor, film_category y category

-- Columnas que necesito de category: name, category_id
-- Columnas que necesito de film_category: category_id, film_id
-- Columnas que necesito de film_actor: film_id, actor_id
-- Columnas que necesito de actor: actor_id, first_name y last_name

SELECT
a.first_name AS Nombre,
a.last_name AS Apellido
FROM actor AS a
WHERE a.actor_id NOT IN (
	SELECT 
	a.actor_id
	FROM actor 
	LEFT JOIN film_actor AS fa
	ON a.actor_id = fa.actor_id
	LEFT JOIN film_category AS fc
	ON fc.film_id = fa.film_id
	LEFT JOIN category AS c
	ON c.category_id = fc.category_id
	WHERE c.name = 'HORROR'
    );



-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.

-- Tablas que necesito: film, film_category, category

-- De la tabla category necesito las columnas name y category_id;
-- De la tabla film_category necesito las columnas category_id y film_id
-- De la tabla film necesito las columnas film_id, title y length


SELECT
f.title,
f.length
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = 'COMEDY'
AND f.length > 180;



-- 25. Encuentra todos los actores que han actuado juntos en al menos una película. 
-- La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.

-- Necesito las tablas: actor y film_actor

-- De la tabla actor necesito las columnas: actor_id, first_name y last_name
-- De la tabla film_actor necesito las columnas: actor_id y film_id

SELECT
a.first_name AS NombreActor,
a.last_name AS ApellidoActor,
COUNT(film_id) AS PeliculasEnComún
FROM actor AS a
WHERE film_id 




