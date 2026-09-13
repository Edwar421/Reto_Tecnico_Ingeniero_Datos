DECLARE fecha_inicio DATE DEFAULT '2026-01-01';
DECLARE fecha_fin DATE DEFAULT '2026-12-31';

SELECT
  c.id_cliente,
  c.numero_identificacion,
  c.nombres,
  c.ciudad,

  COUNT(*) AS cantidad_transacciones,
  SUM(f.monto_transaccion) AS monto_total,
  AVG(f.monto_transaccion) AS monto_promedio,
  MAX(f.monto_transaccion) AS transaccion_maxima,
  MAX(f.fecha_hora) AS ultima_transaccion,

  r.reporte_riesgo

FROM `dwh-bdb.bdb_dwh.fact_transacciones` AS f

INNER JOIN `dwh-bdb.bdb_dwh.dim_cliente` AS c
  ON f.id_cliente = c.id_cliente

INNER JOIN `dwh-bdb.bdb_dwh.dim_riesgo` AS r
  ON f.id_riesgo = r.id_riesgo

WHERE DATE(f.fecha_hora) BETWEEN fecha_inicio AND fecha_fin
  AND r.reporte_riesgo = 'No'

GROUP BY
  c.id_cliente,
  c.numero_identificacion,
  c.nombres,
  c.ciudad,
  r.reporte_riesgo

ORDER BY monto_total DESC
LIMIT 10;