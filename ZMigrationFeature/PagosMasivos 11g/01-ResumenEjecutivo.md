# Resumen Ejecutivo - PagosMasivos

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. Ejemplos y Mapeos por Región:
   - [HN01 - Honduras](03-EjemplosYMapeos-HN01.md)
   - [GT01 - Guatemala](03-EjemplosYMapeos-GT01.md)
   - [PA01 - Panamá](03-EjemplosYMapeos-PA01.md)
   - [NI01 - Nicaragua](03-EjemplosYMapeos-NI01.md)
4. Diagramas de Secuencia por Región:
   - [HN01 - Honduras](04-Secuencia-HN01.mmd)
   - [GT01 - Guatemala](04-Secuencia-GT01.mmd)
   - [PA01 - Panamá](04-Secuencia-PA01.mmd)
   - [NI01 - Nicaragua](04-Secuencia-NI01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**PagosMasivos** es un servicio OSB (Oracle Service Bus) que permite a clientes corporativos realizar operaciones de pagos masivos (batch payments) a través de múltiples canales. El servicio actúa como orquestador principal que:

- Recibe solicitudes de carga de lotes de pagos desde aplicaciones cliente
- Valida la estructura y permisos de acceso del cliente
- Enruta las solicitudes según la región (país/empresa)
- Procesa lotes de transacciones de forma masiva
- Gestiona proveedores de pagos
- Consulta estados y detalles de lotes procesados
- Autoriza y cancela lotes de pagos

## 2. Entradas y Salidas Principales

### Entradas Principales

**Header SOAP (RequestHeader):**
- `Authentication/UserName`: Usuario autenticado
- `Authentication/Password`: Contraseña del usuario
- `Region/SourceBank`: Código de región (HN01, GT01, PA01, NI01)

**Body SOAP - Operación pagosMasivos:**
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
        <VALIDATIONS>...</VALIDATIONS>
        <FIELDS>...</FIELDS>
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

**Header SOAP (ResponseHeader):**
- `successIndicator`: SUCCESS | ERROR
- `messages`: Mensajes de respuesta o error

**Body SOAP - Respuesta pagosMasivos:**
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

### Proxy Services (Orquestadores)
- **PagosMasivos.proxy**: Proxy principal que expone 13 operaciones
- **PagosMasivosInterno.proxy**: Orquestador interno con lógica regional (HN01, NI01)
- **PagosMasivosInternoGT.proxy**: Orquestador específico para Guatemala
- **PagosMasivosInternoPA.proxy**: Orquestador específico para Panamá

### Proxy Services Delegados (por operación)
- **CargaProveedores.proxy**: Gestión de proveedores
- **AutorizarProveedores.proxy**: Autorización de proveedores
- **EliminarProveedores.proxy**: Eliminación de proveedores
- **ConsultaProveedores.proxy**: Consulta de proveedores
- **ConsultaDetalleLote.proxy**: Detalle de lotes
- **ConsultaTransaccionLote.proxy**: Consulta de transacciones
- **ConsultaEstadoLote.proxy**: Estado de lotes
- **CancelarLote.proxy**: Cancelación de lotes
- **EditarEstadoRegistroLote.proxy**: Edición de estados
- **AutorizarLotePagosMasivos.proxy**: Autorización de lotes
- **CargarArchivoLote.proxy**: Carga de archivos
- **ConsultaLotesCliente.proxy**: Consulta de lotes por cliente

### Business Services

#### Base de Datos (PMSV)
- **registraBitacoraPagosMasivos_db**: Bitácora de transacciones (HN01)
- **registraBitacoraPagosMasivosRG_db**: Bitácora regional (GT01, PA01)
- **validaAccesoPMS_db**: Validación de acceso (HN01)
- **procesaLotePagoMasivo_db**: Procesamiento de lotes

#### Servicios Java (SJS)
- **sjPagosMasivosInterno**: Servicio Java para procesamiento interno (HN01)

#### Servicios Externos (MTR)
- **cargadorArchivoLote**: Servicio de carga de lotes (GT01, PA01, NI01)
- **validaAccesoPMS**: Validación de acceso regional (GT01, PA01)

#### Servicios OSB
- **achTransfer**: Transferencias ACH
- **MapeoErrores**: Mapeo de códigos de error

### Servicios de Validación
- **ValidaServicioRegional_db**: Valida que el servicio esté habilitado para la región

## 4. Riesgos/Limitaciones Conocidas

### Riesgos Identificados

1. **Regionalización Compleja**
   - Cada región (HN01, GT01, PA01, NI01) tiene implementaciones diferentes
   - HN01 usa servicios Java internos (SJS)
   - GT01, PA01, NI01 usan servicios externos MTR (cargadorArchivoLote)
   - Riesgo de inconsistencias en comportamiento entre regiones

2. **Manejo de Errores**
   - Dependencia del servicio MapeoErrores para traducción de códigos
   - Errores pueden perderse si el servicio de mapeo falla
   - Código de servicio: FICBCO0231

3. **Bitácora Dual**
   - HN01 usa `registraBitacoraPagosMasivos_db`
   - GT01/PA01 usan `registraBitacoraPagosMasivosRG_db`
   - Riesgo de inconsistencia en auditoría

4. **Validación de Acceso**
   - HN01 usa stored procedure en base de datos
   - GT01/PA01 usan servicio web MTR
   - Diferentes criterios de validación por región

5. **Procesamiento Asíncrono**
   - Los lotes se procesan de forma asíncrona
   - No hay garantía de procesamiento inmediato
   - Requiere consultas posteriores para verificar estado

### Limitaciones Conocidas

1. **Regiones No Implementadas**
   - El flujo por defecto retorna error: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
   - Solo HN01, GT01, PA01, NI01 están implementadas

2. **Autenticación Custom**
   - Usa autenticación custom-token con usuario/password en header
   - No usa estándares como OAuth2 o JWT

3. **Formato de Datos**
   - Las transacciones se envían como strings delimitados
   - Requiere parsing manual en el backend
   - Propenso a errores de formato

4. **Sin Retry Automático**
   - No se detectó lógica de retry en caso de fallo
   - Responsabilidad del cliente reintentar

5. **Límites de Transacciones**
   - No se especifican límites máximos de transacciones por lote
   - Puede causar problemas de performance

## 5. Métricas o SLAs

### Métricas Configuradas

**Monitoring:**
- `isEnabled`: false (deshabilitado)
- `aggregationInterval`: 10 segundos
- `pipelineMonitoringLevel`: Pipeline

**Logging:**
- `isEnabled`: true
- `logLevel`: debug

**Alerting:**
- `sla-alerting`: enabled (normal)
- `pipeline-alerting`: enabled (normal)

**Reporting:**
- `reporting`: true

### SLAs Implícitos

No se encontraron SLAs explícitos en la configuración. Se recomienda establecer:

1. **Tiempo de Respuesta**
   - Carga de lote: < 30 segundos
   - Consultas: < 5 segundos
   - Autorización: < 15 segundos

2. **Disponibilidad**
   - Objetivo: 99.5% uptime
   - Ventana de mantenimiento: Domingos 2-6 AM

3. **Capacidad**
   - Transacciones concurrentes: 100
   - Tamaño máximo de lote: 10,000 transacciones
   - Throughput: 1,000 transacciones/minuto

4. **Retención de Datos**
   - Bitácora: 90 días
   - Estados de lotes: 1 año

## 6. Endpoint Principal

**URI:** `/Middleware/OperationsAndExecution/Payments/PagosMasivos`

**Protocolo:** SOAP 1.1 over HTTP

**WSDL:** `Middleware/v2/Resources/PagosMasivos/wsdl/pagosMasivosPS.wsdl`

**Operaciones Disponibles:**
1. pagosMasivos
2. consultaLotesCliente
3. consultaDetalleLote
4. consultaTransaccionLote
5. cargarArchivoLote
6. autorizarLote
7. cancelarLote
8. editarEstadoRegistroLote
9. consultaEstadoLote
10. cargarProveedores
11. consultarProveedores
12. autorizarProveedores
13. eliminarProveedores

## 7. Regiones Detectadas

| Código | País | Implementación | Servicios Backend |
|--------|------|----------------|-------------------|
| **HN01** | Honduras | PagosMasivosInterno.proxy | SJS (sjPagosMasivosInterno) + DB (PMSV) |
| **GT01** | Guatemala | PagosMasivosInternoGT.proxy | MTR (cargadorArchivoLote) + DB (PMSV) |
| **PA01** | Panamá | PagosMasivosInternoPA.proxy | MTR (cargadorArchivoLote) + DB (PMSV) |
| **NI01** | Nicaragua | PagosMasivosInterno.proxy | MTR (cargadorArchivoLote) |

## 8. Flujo General de Procesamiento

1. **Recepción**: Cliente envía request SOAP al proxy PagosMasivos
2. **Autenticación**: Validación de credenciales en header
3. **Validación Regional**: Verifica que el servicio esté habilitado para la región
4. **Enrutamiento**: Según SourceBank, enruta a proxy regional específico
5. **Bitácora Request**: Registra solicitud en base de datos
6. **Validación de Acceso**: Verifica permisos del cliente
7. **Procesamiento**: Invoca servicio backend (SJS o MTR)
8. **Bitácora Response**: Registra respuesta en base de datos
9. **Mapeo de Errores**: Traduce códigos de error si aplica
10. **Respuesta**: Retorna resultado al cliente

## 9. Consideraciones para Migración

### Puntos Críticos

1. **Diferencias Regionales**: Cada región tiene implementación distinta
2. **Dependencias Externas**: MTR para GT01, PA01, NI01
3. **Base de Datos**: Múltiples stored procedures y esquemas
4. **Bitácora**: Sistema de auditoría completo a migrar
5. **Mapeo de Errores**: Servicio centralizado de traducción

### Recomendaciones

1. Migrar región por región, comenzando con HN01
2. Unificar implementaciones donde sea posible
3. Considerar arquitectura basada en eventos
4. Implementar circuit breakers y retry policies
5. Modernizar autenticación (OAuth2/JWT)
6. Agregar métricas y observabilidad
7. Documentar SLAs explícitos
