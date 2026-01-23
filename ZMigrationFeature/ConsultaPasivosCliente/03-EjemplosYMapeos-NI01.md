# Ejemplos y Mapeos - Nicaragua (NI01)

## Características Principales
- Única región con servicio SOAP externo (COBIS)
- Soporte de producto PTC (Préstamos con Tarjeta de Crédito)
- Filtrado avanzado por BINes y códigos de bloqueo
- Obtención de parámetros desde configuración

## Cadenas de Conexión

### Servicio SOAP - COBIS
- **Endpoint**: `http://10.235.53.149:9082/GerenciaProductoPasivos/SrvAplCobisPasivosService`
- **Protocolo**: SOAP 1.2
- **Namespace**: `http://impl.service.srvaplcobispasivos.ecobis.cobiscorp/`
- **Operación**: `OpConsultaPasivosCliente`
- **Timeout**: 0 (sin timeout configurado)
- **Retry**: 0 (sin retry)

### Servicio de Configuración
- **Business Service**: `ObtenerParametrizacion`
- **Parámetros**:
  - `FICBCO0044.CODIGOSBLOQUEO`: Lista de códigos de bloqueo separados por ||
  - `FICBCO0044.BINES.PTC`: Lista de BINes de tarjetas PTC separados por ||

## Mapeo de Entrada - COBIS

| Campo Origen (OSB) | Transformación | Campo Destino (COBIS) |
|--------------------|---------------|----------------------|
| Constante "1" | Hardcoded | `codCanalOriginador` |
| `CUSTOMER_ID` | Directo | `codCliente` |
| `UserName` (header) | Directo | `valIdCliente` |
| `LIABILITY_TYPE` | `if 'PTC' then 'TRC' else directo` | `codTipoProducto` |

**Reglas de Negocio**:
- **RN-NI-IN-001**: PTC se convierte a TRC en el request a COBIS
- **RN-NI-IN-002**: valIdCliente se toma del username de autenticación
- **Ubicación**: `consultaPasivosClienteNIIn.xq`

## Mapeo de Salida - COBIS

### Préstamos (PTM)
- **Filtro**: `codTipoProducto = 'CCA'`
- **Campos**: Mapeo directo con redondeo a 2 decimales
- **Fecha**: Formato `yyyyMMdd`

### Tarjetas de Crédito (TRC)
- **Filtro**: `codTipoProducto = 'TCR'` AND NOT IN (lista BINes PTC)
- **Exclusión**: Tarjetas con códigos de bloqueo en lista
- **Validación**: Si ambos códigos de bloqueo están en lista, excluir

### Préstamos con Tarjeta (PTC)
- **Filtro**: `codTipoProducto = 'TCR'` AND IN (lista BINes PTC)
- **Inclusión**: Solo si ambos códigos de bloqueo están en lista
- **Validación Especial**: Si código "A" y saldo <= 0, excluir
- **Monedas**: Solo incluir moneda si monto > 0

**Reglas de Negocio**:
- **RN-NI-OUT-001**: Redondeo con `fn:round-half-to-even(xs:decimal(...), 2)`
- **RN-NI-OUT-002**: Filtrado por BINes usando `substring(..., 1, 6)`
- **RN-NI-OUT-003**: Tokenización de parámetros con `fn:tokenize($param, '\\|\\|')`
- **RN-NI-OUT-004**: Lógica compleja para PTC con validación de bloqueos y saldos
- **Ubicación**: `consultaPasivosClienteNIOut.xq`

## Dependencias Críticas
1. Disponibilidad del servicio COBIS
2. Configuración correcta de parámetros CODIGOSBLOQUEO y BINES.PTC
3. Sin retry ni timeout configurado (riesgo de disponibilidad)

## Recomendaciones
- Implementar timeout apropiado (ej: 30 segundos)
- Configurar retry con backoff exponencial
- Implementar circuit breaker para servicio COBIS
- Monitorear disponibilidad del servicio externo
