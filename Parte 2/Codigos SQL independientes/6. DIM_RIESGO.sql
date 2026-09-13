CREATE OR REPLACE TABLE `dwh-bdb.bdb_dwh.dim_riesgo` AS
SELECT
  FARM_FINGERPRINT(
    CONCAT(
      COALESCE(reporte_riesgo, ''),
      '|',
      CAST(COALESCE(monto_riesgo, -1) AS STRING),
      '|',
      CAST(COALESCE(tiempo_mora_dias, -1) AS STRING)
    )
  ) AS id_riesgo,
  reporte_riesgo,
  monto_riesgo,
  tiempo_mora_dias

FROM (
  SELECT DISTINCT
    reporte_riesgo,
    monto_riesgo,
    tiempo_mora_dias

  FROM `dwh-bdb.bdb_dwh.stg_transactions_clean`

  WHERE reporte_riesgo IS NOT NULL
);