
-- M5: Consultas con JOINs - Ventas_Tech_DB

USE Ventas_Tech_DB;

/* CONSULTA 1: Vista base del proyecto (INNER JOIN) */
-- Cada venta con los datos del cliente, el producto y la categoría en una sola fila
SELECT
    v.fecha_venta AS fecha,
    c.nombre AS cliente,
    c.ciudad,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

/* CONSULTA 2: Clientes sin ventas (LEFT JOIN) */
-- Clientes registrados que nunca compraron
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

/* CONSULTA 3: Productos sin ventas (LEFT JOIN) */
-- Productos del catálogo que no tienen ninguna venta
SELECT
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

/* CONSULTA 4: Consolidado por canal (UNION ALL) */
-- La columna canal se crea en cada SELECT: primera y segunda quincena de marzo
SELECT
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT fecha_venta AS fecha, cantidad * precio_unitario AS total, 'Primera quincena' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

    SELECT fecha_venta AS fecha, cantidad * precio_unitario AS total, 'Segunda quincena' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS ventas_por_canal
GROUP BY canal;

/* HALLAZGOS
-- 1. Cada cliente registrado realizó como mínimo una compra (la consulta 2 no retorna filas),
-- por lo que no existen clientes inactivos.
-- 2. Se vendieron todos los productos del catálogo (la consulta 3 no retorna filas),
-- de modo que no hay productos sin movimiento.
-- 3. La facturación de la primera quincena de marzo fue superior ($3.620) a la de la segunda ($2.824),
-- es decir, las ventas disminuyeron durante la segunda mitad del mes. */
