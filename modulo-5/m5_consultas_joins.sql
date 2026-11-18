-- Motor utilizado: SQL Server 2025
-- M5: Consultas con JOINs - Ventas_Tech_DB

USE Ventas_Tech_DB;

-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: tener cada venta con los datos del cliente, el producto y la categoría en una sola fila,
-- para usarla como fuente principal en Power BI (ciudad sirve para filtrar y categoría para agrupar).
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
-- Hallazgo: las 10 ventas cruzan bien con sus clientes y productos. Computación es la categoría
-- que más vende: $4.950 de los $6.444 totales (77%).

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: detectar clientes registrados que nunca compraron, para que CRM los contacte.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
-- Hallazgo: no aparece ningún cliente (0 filas). Los 5 clientes registrados compraron al menos
-- una vez, así que CRM no tiene clientes inactivos para contactar.

-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: encontrar productos del catálogo sin movimiento, para que el área de producto
-- decida si los promociona o los saca.
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
-- Hallazgo: no aparece ningún producto (0 filas). Los 6 productos del catálogo se vendieron,
-- así que por ahora el área de producto no tiene artículos parados.

-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: comparar cuánto se vendió en la primera y en la segunda quincena de marzo.
-- La columna canal no existe en la tabla: la creo en cada SELECT.
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
-- Hallazgo: en la primera quincena se facturó más ($3.620) que en la segunda ($2.824),
-- o sea que las ventas bajaron en la segunda mitad del mes.
