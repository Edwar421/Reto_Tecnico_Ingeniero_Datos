# Reto Técnico — Ingeniero de Datos (DWH)

Data Warehouse de transacciones con modelado dimensional (esquema estrella), ETL en BigQuery, calidad de datos, orquestación y CI/CD.

## Stack

- **DWH:** Google BigQuery (GoogleSQL)
- **ETL:** IBM DataStage (Cloud Pak for Data)
- **Orquestación:** Control-M (simulado con `.bat`)
- **CI/CD:** Google Cloud Workflows
- **Fuente:** CSV en Google Cloud Storage

## Estructura

| Carpeta | Contenido |
|---|---|
| `Parte 1/` | Modelo dimensional Estrella (diagrama) |
| `Parte 2/` | 9 scripts SQL del ETL y capa DWH |
| `Parte 3/` | Consultas analíticas de negocio |
| `Parte 4/` | Orquestación Control-M + DataStage (`.bat`) |
| `Parte 5/` | CI/CD (`WorkFlow.yaml`) |


## Modelo de datos

- **Dimensiones:** `dim_cliente`, `dim_producto`, `dim_riesgo`, `dim_fecha`
- **Hechos:** `fact_transacciones` (particionada por fecha, clave hash SHA256)

## Calidad de datos

10 reglas DQ (CRITICAL y WARNING). Si falla una regla crítica, el Quality Gate bloquea la carga.


## CI/CD

`WorkFlow.yaml` automatiza carga → limpieza → calidad → gate → DWH, con auditoría en `audit_pipeline`.
