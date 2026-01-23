# Ejemplos y Mapeos - Panamá (PA01)

## Características Principales
- Arquitectura idéntica a Guatemala
- Mismo package y stored procedure para préstamos
- Diferencias en transformaciones de salida de tarjetas

## Cadenas de Conexión

### Base de Datos - Préstamos
- **Conexión**: `eis/DB/ConnectionProxyAbanksPA`
- **Package**: `OSB_K_CONLISTAPRESTAMOS`
- **Stored Procedure**: `TOPLEVEL$OSB_P_CON_LISTA_PRES`
- **Operación**: `consultaListaPrestamos`

### Base de Datos - Tarjetas
- **Conexión**: `eis/DB/ConnectionProxyMasterDataPA`
- **Stored Procedure**: `conDatosTarjetaCliente`

## Mapeo de Entrada - Préstamos
Idéntico a Guatemala (GT01)

## Mapeo de Salida - Préstamos
Idéntico a Guatemala, con `LIABILITY_SOURCE_BANK` = "PA01"

## Mapeo de Salida - Tarjetas (Diferencias con GT)

| Aspecto | Guatemala | Panamá |
|---------|-----------|--------|
| Agrupación | Sí (distinct-values) | No (iteración directa) |
| Moneda ALT | Búsqueda explícita | No soportada explícitamente |
| Validaciones | Básicas | Condicionales por campo |
| Formato Fecha | yyyy-MM-dd | YYY-MM-dd (typo en código) |

**Reglas de Negocio**:
- **RN-PA-TC-OUT-001**: Cada fila del RowSet es un registro independiente
- **RN-PA-TC-OUT-002**: Validación condicional: solo incluye campo si no está vacío
- **RN-PA-TC-OUT-003**: Variable `validationMessagess` (doble 's') para errores
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClientePAOut.xq`

## Retry y Timeout
- **Retry Count**: 1
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true
