
USE Ventas_Tech_DB;

/* CONSULTA 1: Resumen ejecutivo mensual */
-- Total facturado, cantidad de pedidos y ticket promedio por mes
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

/* CONSULTA 2: Ranking de productos */
-- Top 5 productos por total facturado
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

/* CONSULTA 3: Clientes recurrentes */
-- Clientes con más de un pedido
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

/* CONSULTA 4: Meses por encima o por debajo del promedio */
-- Compara el total de cada mes con el promedio mensual general
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) >= 
             (SELECT SUM(cantidad * precio_unitario) / COUNT(DISTINCT MONTH(fecha_venta)) FROM ventas)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

/* HALLAZGOS
-- 1. La laptop (producto 1) es la que genera más ingresos: $3.600 de los $6.444,
-- más de la mitad de las ventas, aunque solo se vendieron 3 unidades.
-- 2. El mouse (producto 2) es el producto más vendido (13 unidades),
-- pero su bajo precio hace que aporte poco dinero: $364.
-- 3. Todos los clientes realizaron 2 compras. El cliente 1 fue quien más gastó, con $2.640. */
