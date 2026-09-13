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

## Pipeline

1. Carga CSV → `stg_transactions`
2. Limpieza → `stg_transactions_clean`
3. Data Quality → `dq_results`
4. Quality Gate → `ALLOW` / `BLOCK`
5. Carga de dimensiones y hechos
6. `MERGE` → upsert en `fact_transacciones`

## Modelo de datos

- **Dimensiones:** `dim_cliente`, `dim_producto`, `dim_riesgo`, `dim_fecha`
- **Hechos:** `fact_transacciones` (particionada por fecha, clave hash SHA256)

## Calidad de datos

10 reglas DQ (CRITICAL y WARNING). Si falla una regla crítica, el Quality Gate bloquea la carga.

## Orquestación

`CONTROL_M_MAIN.bat` ejecuta 4 jobs con 3 reintentos: valida input, ejecuta DataStage, valida output y archiva el input.

```bat
cd Parte 4\control-m-datastage\scripts
CONTROL_M_MAIN.bat
```

## CI/CD

`WorkFlow.yaml` automatiza carga → limpieza → calidad → gate → DWH, con auditoría en `audit_pipeline`.

## Configuración

- Proyecto BigQuery: `dwh-bdb` · Dataset: `bdb_dwh`
- Bucket GCS: `dwh-reto-dbd` · Fuente: `raw/transactions/datos_transacciones.csv`
- DataStage: proyecto `prueba-datastage-bdb`, flujo `DS_CLIENTES_TRANS`
