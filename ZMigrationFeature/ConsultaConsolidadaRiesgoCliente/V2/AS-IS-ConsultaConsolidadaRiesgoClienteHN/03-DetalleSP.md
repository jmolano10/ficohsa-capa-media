# Detalle del Stored Procedure – p_consulta_ONBASE_V2

## Información General

| Campo | Valor |
|-------|-------|
| **Nombre** | `p_consulta_ONBASE_V2` |
| **Schema** | `CREDITOS_RIESGOS` |
| **Package** | `dbo` |
| **Servidor BD** | SQL Server (via JNDI `eis/DB/ConnectionCustomerCreditRisk`) |
| **Linked Server** | `[svrpruebas]` → BD `BURO_EXTERNO` |

## Parámetro de Entrada

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `@IDENTIDAD` | NVARCHAR(20) | Número de identidad del cliente hondureño |

## Parámetro de Salida

Retorna un `SELECT @XML_CLIENTE CLIENTE` — un XML tipo `FOR XML RAW/ROOT` con toda la información consolidada.

## Tablas Consultadas

### Base de Datos Local: `CREDITOS_RIESGOS.HN_ONBASE`

| # | Tabla | Descripción | Clave de Búsqueda |
|---|-------|-------------|-------------------|
| 1 | `MA_CLIENTES` | Datos maestros del cliente (demográficos, score, salary) | `Numero_Identidad = @IDENTIDAD` |
| 2 | `MA_PASIVOS` | Cuentas de ahorro/corriente | `Numero_Identidad = @IDENTIDAD` |
| 3 | `MA_TRANSACCIONESPASIVOS` | Transacciones de cuentas pasivas | JOIN con MA_PASIVOS por `Cuenta = Numero_Cuenta` |
| 4 | `MA_TARJETAS` | Tarjetas de crédito (estado, límites, saldos, bloqueos) | `Identidad = @IDENTIDAD` (ltrim/rtrim) |
| 5 | `MA_TRANSACCIONESTARJETA` | Historial 12 meses por tarjeta (cortes, pagos, consumos, mora) | `IDENTIDAD = @IDENTIDAD` |
| 6 | `EXTRAFIN` | Financiamientos extra vigentes en tarjetas | JOIN con `MA_TARJETAS` por `NUMUSU = Numero_Cuenta` |
| 7 | `Ma_Prestamos` | Cartera de préstamos (monto, tasa, plazo, mora) | `Numero_Identidad = @IDENTIDAD` |
| 8 | `MA_TRANSACCIONESPRESTAMO` | Historial de transacciones por préstamo | JOIN con `Ma_Prestamos` por agencia+subApp+nroPrestamo |
| 9 | `MA_OFERTA_PREAPROBADA` | Ofertas pre-aprobadas (Ficocrédito, Ficoya, OPI, Retanqueo) | `IDENTIDAD = @IDENTIDAD` |

### Linked Server: `[svrpruebas].BURO_EXTERNO.DBO`

| # | Tabla | Descripción | Clave de Búsqueda |
|---|-------|-------------|-------------------|
| 10 | `EQX_CONTROL` | Control de estudios Equifax (Id, Fecha consulta) | `identidad = @IDENTIDAD` |
| 11 | `RecordScore` | Score crediticio del estudio | `IdEstudio` |
| 12 | `RecordB` | Referencias bancarias vigentes | `IdEstudio = @id_estudio` |
| 13 | `RecordD` | Referencias comerciales vigentes | `IdEstudio = @id_estudio` |
| 14 | `RecordT` | Referencias tarjeta vigentes | `IdEstudio = @id_estudio` |
| 15 | `RECORDPRB` | Referencias bancarias históricas (pasadas) | `IdEstudio = @id_estudio` |
| 16 | `RECORDPRD` | Referencias comerciales históricas | `IdEstudio = @id_estudio` |
| 17 | `RECORDPRT` | Referencias tarjeta históricas | `IdEstudio = @id_estudio` |
| 18 | `recordhB` | Historial de mora bancaria (categoría, conteo) | `idEstudio + acreedor + operationNumber` |
| 19 | `recordhD` | Historial de mora comercial | `idEstudio + infoSource + referencia` |
| 20 | `recordhT` | Historial de mora tarjeta (vectorCategorias, conteoLoc/Dol) | `idEstudio + infoSource + referencia` |
| 21 | `RECORDA` | Direcciones reportadas al buró | `IdEstudio = @id_estudio` |
| 22 | `RECORDTEL` | Teléfonos reportados al buró | `IdEstudio = @id_estudio` |
| 23 | `RECORDH` | Registros de alto riesgo (cargos administrativos) | `IdEstudio = @id_estudio` |
| 24 | `RECORDS` | SICOM (mora judicial/sistémica) | `IdEstudio = @id_estudio` |
| 25 | `RECORDC` | Consultas realizadas al buró | `IdEstudio = @id_estudio` |
| 26 | `RECORDEVALUACION` | Evaluación consolidada del buró | `IdEstudio = @id_estudio` |

## Campos Principales por Sección

### MA_CLIENTES (Datos del Cliente)
- Numero_Identidad, Target, Fecha_Nacimiento, Edad, Tipo_Persona
- Salario, Salario_Planilla, Meses_Crediticios, Flag_Blaze, Flag_Hit

### MA_TARJETAS (Tarjetas de Crédito) – v2
- Numero_Cuenta, BehaviorScore, Calificacion_Score, Estado, Producto
- Fecha_Apertura, Mora_Actual, Limite_Actual, Saldo_Actual, Saldo_Corte
- Saldo_Extra, Saldo_Intra, CuotasExtraVigentes
- **Campos v2 (rmt151):** MorosidadHistorica_LOC/USD, Flag_Castigo, FecBloque1/2, CodBloque1/2, Fecha_Aprobacion_Extra/Intra/PIL, Limite_Previo, Saldo_Autorizacion

### MA_TRANSACCIONESTARJETA (12 meses de historia)
- Fecha_Corte, Saldo_Corte, Pago_Minimo, Pagos, Consumos, Retiros
- Limite, Otras_Transacciones, Intereses, Total_Cargos, Otros_Debitos, Mora
- Saldo_Total, Saldo_Extra/Intra, Cuota_Extra/Intra, Intereses_Extra/Intra, Cargos_Extra/Intra
- **Campos v2:** Total_Compras, Disponible (por cada uno de los 12 meses)

### Ma_Prestamos (Préstamos)
- Numero_Contrato, Numero_Prestamo, Codigo_Agencia, Codigo_Sub_Aplicacion
- Fecha_Apertura, Fecha_Cancelacion, Monto_Inicial, Saldo_Actual, Valor_Cuota
- Tasa, Plazo, Numero_Cuotas, Fecha_Primer_Pago, Fecha_Ultimo_Pago
- Cargos, Interes, Seguros, Otros_Cargos, Mora_Actual, Tipo_Deudor

## Observaciones Técnicas

1. **XML Assembly Pattern**: El SP usa el patrón de construir un XML raíz y luego insertar fragmentos con `.modify('insert ...')` — esto es específico de SQL Server.

2. **Linked Server**: Las consultas al buró usan un linked server `[svrpruebas]` que apunta a la BD `BURO_EXTERNO`. En producción, el nombre del linked server podría ser diferente.

3. **Filtro de calidad de datos**: Para MA_TARJETAS se usa `ltrim(rtrim(Identidad))` debido a problemas conocidos de calidad en la data.

4. **Variable `@id_estudio`**: Se obtiene del `EQX_CONTROL` como el estudio más reciente del cliente (MAX o TOP 1 por fecha).

5. **Manejo de error**: Retorna un XML simple con `IDENTIDAD` + `ERROR_MESSAGE()` en caso de excepción.
