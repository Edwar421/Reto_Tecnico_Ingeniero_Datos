SELECT
  c.id_cliente,
  c.numero_identificacion,
  c.nombres,
  c.ciudad,
  p.tipo_producto,
  f.tipo_transaccion,
  f.monto_transaccion,
  f.fecha_hora,
  r.reporte_riesgo
FROM `dwh-bdb.bdb_dwh.fact_transacciones` AS f
INNER JOIN `dwh-bdb.bdb_dwh.dim_cliente` AS c
  ON f.id_cliente = c.id_cliente
INNER JOIN `dwh-bdb.bdb_dwh.dim_producto` AS p
  ON f.id_producto = p.id_producto
INNER JOIN `dwh-bdb.bdb_dwh.dim_riesgo` AS r
  ON f.id_riesgo = r.id_riesgo
WHERE DATE(f.fecha_hora) = '2024-02-28'
  AND r.reporte_riesgo = 'No'
ORDER BY f.monto_transaccion DESC
LIMIT 10;