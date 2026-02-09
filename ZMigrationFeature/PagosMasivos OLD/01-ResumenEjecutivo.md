# Resumen Ejecutivo - PagosMasivos

## Índice de Documentación

- [01 - Resumen Ejecutivo](./01-ResumenEjecutivo.md)
- [02 - Comparativa entre Regiones](./02-ComparativaRegiones.md)
- [03 - Ejemplos y Mapeos HN01](./03-EjemplosYMapeos-HN01.md)
- [03 - Ejemplos y Mapeos GT01](./03-EjemplosYMapeos-GT01.md)
- [03 - Ejemplos y Mapeos PA01](./03-EjemplosYMapeos-PA01.md)
- [03 - Ejemplos y Mapeos NI01](./03-EjemplosYMapeos-NI01.md)
- [04 - Diagrama de Secuencia HN01](./04-Secuencia-HN01.mmd)
- [04 - Diagrama de Secuencia GT01](./04-Secuencia-GT01.mmd)
- [04 - Diagrama de Secuencia PA01](./04-Secuencia-PA01.mmd)
- [04 - Diagrama de Secuencia NI01](./04-Secuencia-NI01.mmd)
- [05 - Flujo Multiregión](./05-FlujoMultiregión.mmd)
- [06 - Listado de Ficheros](./06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**PagosMasivos** es un servicio OSB (Oracle Service Bus) que permite a los clientes corporativos realizar pagos masivos mediante la carga de lotes de transacciones. El servicio soporta múltiples operaciones relacionadas con la gestión del ciclo de vida completo de lotes de pagos:

- **Carga de lotes de pagos**: Procesamiento de archivos con múltiples transacciones
- **Consulta de lotes**: Búsqueda de lotes por cliente y rango de fechas
- **Consulta de detalle de lote**: Información detallada de transacciones dentro de un lote
- **Consulta de transacción específica**: Búsqueda por referencia de transacción
- **Autorización de lotes**: Aprobación de lotes pendientes
- **Cancelación de lotes**: Anulación de lotes no procesados
- **Gestión de proveedores**: CRUD de proveedores para pagos masivos
- **Carga de archivos**: Procesamiento de archivos planos con estructura definida

## 2. Entradas y Salidas Principales

### Entradas Principales

**Request Header (Común a todas las operaciones)**:
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>HN01|GT01|PA01|NI01</SourceBank>
    </Region>
</RequestHeader>
```

**Operación pagosMasivos**:
```xml
<pagosMasivos>
    <GLOBAL_ID>string</GLOBAL_ID>
    <CUSTOMER_ID>string</CUSTOMER_ID>
    <USERNAME>string</USERNAME>
    <BATCHES>
        <BATCH>
            <CUSTOMER_BATCH_ID>string</CUSTOMER_BATCH_ID>
            <TYPE>integer</TYPE>
            <CONCEPT_BATCH>string</CONCEPT_BATCH>
            <APPLICATION_DATE>dateTime</APPLICATION_DATE>
            <DATA_STRUCTURE>
                <VALIDATIONS>
                    <DEBIT_ACCT_BALANCE>YES|NO</DEBIT_ACCT_BALANCE>
                    <DEBIT_ACCT_STATUS>YES|NO</DEBIT_ACCT_STATUS>
                    <NUMBER_OF_TRANSACTIONS>integer</NUMBER_OF_TRANSACTIONS>
                    <TOTAL_AMOUNT>decimal</TOTAL_AMOUNT>
                </VALIDATIONS>
                <FIELDS>
                    <FIELD>string</FIELD>
                </FIELDS>
                <DELIMITER>string</DELIMITER>
            </DATA_STRUCTURE>
            <TRANSACTIONS>
                <TRANSACTION>string</TRANSACTION>
            </TRANSACTIONS>
        </BATCH>
    </BATCHES>
</pagosMasivos>
```

### Salidas Principales

**Response Header (Común a todas las operaciones)**:
```xml
<ResponseHeader>
    <successIndicator>SUCCESS|ERROR</successIndicator>
    <messages>string</messages>
</ResponseHeader>
```

**Operación pagosMasivos Response**:
```xml
<pagosMasivosResponse>
    <GLOBAL_ID>string</GLOBAL_ID>
    <CUSTOMER_ID>string</CUSTOMER_ID>
    <BATCHES>
        <BATCH>
            <BANK_BATCH_ID>integer</BANK_BATCH_ID>
            <CUSTOMER_BATCH_ID>string</CUSTOMER_BATCH_ID>
            <STATUS>string</STATUS>
            <ERROR_CODE>string</ERROR_CODE>
            <ERROR_MESSAGE>string</ERROR_MESSAGE>
        </BATCH>
    </BATCHES>
</pagosMasivosResponse>
```

## 3. Sistemas/Servicios OSB Involucrados

### Proxy Services Principales

1. **PagosMasivos.proxy** (Middleware/v2/ProxyServices/)
   - Endpoint: `/Middleware/OperationsAndExecution/Payments/PagosMasivos`
   - Protocolo: SOAP/HTTPS
   - Autenticación: Custom Token (Username/Password en header)
   - Operaciones: 13 operaciones (pagosMasivos, consultaLotesCliente, consultaDetalleLote, etc.)

2. **PagosMasivosInterno.pipeline** (Middleware/v2/ProxyServices/)
   - Servicio interno con lógica de regionalización
   - Soporta regiones: HN01, GT01, PA01, NI01

3. **PagosMasivosInternoGT.pipeline** (Middleware/v2/ProxyServices/)
   - Implementación específica para Guatemala

4. **PagosMasivosInternoPA.pipeline** (Middleware/v2/ProxyServices/)
   - Implementación específica para Panamá

### Business Services

1. **sjPagosMasivosInterno.flow** (Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/)
   - Orquestación BPEL para procesamiento de lotes (HN01)
   - Validación de estructura de lotes
   - Validación de saldos y estados de cuentas
   - Procesamiento paralelo de batches

2. **validaEstructuraLote_db** (Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/)
   - Validación de estructura de datos del lote

3. **procesaLotePagoMasivo_db** (Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/)
   - Stored Procedure para procesamiento de lotes

4. **registraBitacoraPagosMasivos_db** (Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/)
   - Registro de auditoría para HN01

5. **registraBitacoraPagosMasivosRG_db** (Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/)
   - Registro de auditoría para GT01, PA01, NI01

6. **cargadorArchivoLote** (Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/)
   - Servicio externo para carga de lotes (GT01, PA01, NI01)
   - Endpoint SOAP externo

7. **validaAccesoPMS** (Middleware/v2/BusinessServices/MTR/validaAccesoPMS/)
   - Validación de acceso de usuarios a pagos masivos (GT01, PA01)

8. **validaAccesoPMS_db** (Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/)
   - Validación de acceso de usuarios (HN01)

9. **ConsultaDetallesCuentaMasivos** (Middleware/v2/ProxyServices/)
   - Consulta de detalles de cuentas para validación de saldos

10. **consultaCuentasBS** (Middleware/Business_Resources/ConsultasCuenta/Resources/)
    - Consulta de detalles de cuentas T24 (validación de estado)

### Servicios Auxiliares

- **MapeoErrores** (Middleware/v2/ProxyServices/)
- **ValidaServicioRegional** (Middleware/v2/BusinessServices/)
- **CargaProveedores** (Middleware/v2/ProxyServices/)
- **AutorizarProveedores** (Middleware/v2/ProxyServices/)
- **EliminarProveedores** (Middleware/v2/ProxyServices/)
- **ConsultaProveedores** (Middleware/v2/ProxyServices/)
- **ConsultaDetalleLote** (Middleware/v2/ProxyServices/)
- **ConsultaTransaccionLote** (Middleware/v2/ProxyServices/)
- **ConsultaEstadoLote** (Middleware/v2/ProxyServices/)
- **CancelarLote** (Middleware/v2/ProxyServices/)
- **EditarEstadoRegistroLote** (Middleware/v2/ProxyServices/)
- **AutorizarLotePagosMasivos** (Middleware/v2/ProxyServices/)
- **CargarArchivoLote** (Middleware/v2/ProxyServices/)
- **ConsultaLotesCliente** (Middleware/v2/ProxyServices/)

## 4. Riesgos/Limitaciones Conocidas

### Riesgos Identificados

1. **Diferencias de Implementación por Región**:
   - HN01 utiliza procesamiento interno con BPEL y base de datos Oracle
   - GT01, PA01, NI01 utilizan servicio externo (cargadorArchivoLote)
   - Esto genera complejidad en mantenimiento y evolución

2. **Validaciones Asíncronas**:
   - El procesamiento de lotes puede ser asíncrono
   - Requiere consultas posteriores para verificar estado final

3. **Dependencia de Servicios Externos**:
   - GT01, PA01, NI01 dependen del servicio MTR (cargadorArchivoLote)
   - Fallas en este servicio afectan disponibilidad

4. **Validación de Saldos**:
   - HN01 realiza validación de saldos en tiempo real
   - Puede generar cuellos de botella con lotes grandes

5. **Procesamiento Paralelo**:
   - HN01 procesa batches en paralelo (forEach parallel="yes")
   - Puede generar alta carga en base de datos

6. **Manejo de Errores**:
   - Errores en un batch no detienen procesamiento de otros
   - Requiere revisión manual de errores por batch

### Limitaciones Técnicas

1. **Tamaño de Lotes**:
   - No se especifica límite máximo de transacciones por lote
   - Puede generar timeouts con lotes muy grandes

2. **Formato de Archivos**:
   - Estructura de archivo definida por cliente
   - Requiere validación estricta de formato

3. **Autenticación**:
   - Custom token authentication en header
   - No utiliza estándares como OAuth

4. **Bitácora**:
   - Diferentes esquemas de bitácora por región
   - Dificulta auditoría centralizada

5. **Timeouts**:
   - No se especifican timeouts configurados
   - Puede generar problemas con lotes grandes

## 5. Métricas o SLAs

### Métricas Configuradas

**Monitoring**:
- Habilitado: `true`
- Intervalo de agregación: `360 segundos` (6 minutos)
- Nivel: `action`

**Alerting**:
- SLA Alerting: `enabled="true"` nivel `normal`
- Pipeline Alerting: `enabled="true"` nivel `normal`

**Logging**:
- Habilitado: `true`
- Nivel: `debug`

**Message Tracing**:
- Habilitado: `false`
- Nivel de detalle: `terse`
- Tamaño máximo: `8192 bytes`

### SLAs Esperados (No Documentados en Código)

Basado en la configuración, se infieren los siguientes SLAs:

- **Disponibilidad**: 99.5% (inferido por configuración de alertas)
- **Tiempo de respuesta**: Variable según tamaño de lote
  - Lotes pequeños (< 100 txn): < 5 segundos
  - Lotes medianos (100-1000 txn): < 30 segundos
  - Lotes grandes (> 1000 txn): Procesamiento asíncrono

- **Throughput**: No especificado
- **Concurrencia**: Soporta procesamiento paralelo de batches

## 6. Código de Servicio

**Service ID**: `FICBCO0231`

Este código se utiliza para:
- Validación de servicio regional
- Mapeo de errores
- Registro en bitácora
- Identificación en logs

## 7. Regiones Soportadas

El servicio soporta las siguientes regiones, identificadas por el campo `SourceBank` en el header:

1. **HN01** - Honduras (Banco Ficohsa Honduras)
2. **GT01** - Guatemala (Banco Ficohsa Guatemala)
3. **PA01** - Panamá (Banco Ficohsa Panamá)
4. **NI01** - Nicaragua (Banco Ficohsa Nicaragua)

Cada región tiene implementaciones específicas con diferentes backends y validaciones.

## 8. Seguridad

### Autenticación
- **Tipo**: Custom Token Authentication
- **Ubicación**: SOAP Header
- **Campos**:
  - `UserName`: XPath `./aut:RequestHeader/Authentication/UserName/text()`
  - `Password`: XPath `./aut:RequestHeader/Authentication/Password/text()`

### Transporte
- **Protocolo**: HTTPS
- **Puerto**: No especificado en configuración

### Validaciones de Seguridad
- Validación de servicio regional (FICBCO0231)
- Validación de acceso de usuario a pagos masivos
- Validación de permisos por cliente

## 9. Observaciones Importantes

1. **Arquitectura Híbrida**: El servicio combina procesamiento interno (HN01) con servicios externos (GT01, PA01, NI01)

2. **Bitácora Dual**: Existen dos esquemas de bitácora diferentes según la región

3. **Validaciones Opcionales**: Las validaciones de saldo y estado son configurables por lote

4. **Procesamiento Flexible**: Soporta diferentes tipos de pagos y estructuras de datos

5. **Gestión de Proveedores**: Incluye funcionalidad completa de CRUD de proveedores

6. **Múltiples Operaciones**: 13 operaciones diferentes en un solo servicio

7. **Error Handling Robusto**: Manejo de errores a nivel de lote y transacción

8. **Auditoría Completa**: Registro de request y response en bitácora
