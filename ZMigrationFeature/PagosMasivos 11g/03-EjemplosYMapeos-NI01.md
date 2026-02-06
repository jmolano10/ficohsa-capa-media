# Ejemplos y Mapeos - NI01 (Nicaragua)

## Características Únicas

NI01 tiene la implementación más simple:
- **Sin validación de acceso previa**
- **Sin bitácora de base de datos**
- Implementado como pipeline dentro de PagosMasivosInterno.proxy (no proxy separado)
- Usa servicio MTR cargadorArchivoLote

## Request OSB (Ejemplo SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_NI_001</UserName>
            <Password>P@ssw0rd123</Password>
         </Authentication>
         <Region>
            <SourceBank>NI01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>TXN-NI-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>CORPNI12345</CUSTOMER_ID>
         <USERNAME>usuario.nicaragua</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>LOTE-NI-2024-001</CUSTOMER_BATCH_ID>
               <TYPE>1</TYPE>
               <CONCEPT_BATCH>Pago de Servicios Nicaragua</CONCEPT_BATCH>
               <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
               <DATA_STRUCTURE>
                  <VALIDATIONS>
                     <DEBIT_ACCT_BALANCE>YES</DEBIT_ACCT_BALANCE>
                     <DEBIT_ACCT_STATUS>YES</DEBIT_ACCT_STATUS>
                     <NUMBER_OF_TRANSACTIONS>2</NUMBER_OF_TRANSACTIONS>
                     <TOTAL_AMOUNT>20000.00</TOTAL_AMOUNT>
                  </VALIDATIONS>
                  <FIELDS>
                     <FIELD>DEBIT_ACCOUNT</FIELD>
                     <FIELD>CREDIT_ACCOUNT</FIELD>
                     <FIELD>AMOUNT</FIELD>
                     <FIELD>BENEFICIARY</FIELD>
                  </FIELDS>
                  <DELIMITER>|</DELIMITER>
               </DATA_STRUCTURE>
               <TRANSACTIONS>
                  <TRANSACTION>NI1234567890|NI9876543210|12000.00|Proveedor NI 1</TRANSACTION>
                  <TRANSACTION>NI1234567890|NI9876543211|8000.00|Proveedor NI 2</TRANSACTION>
               </TRANSACTIONS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivos>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Lote procesado</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivosResponse>
         <GLOBAL_ID>TXN-NI-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>CORPNI12345</CUSTOMER_ID>
         <BATCHES>
            <BATCH>
               <BANK_BATCH_ID>NI987654</BANK_BATCH_ID>
               <CUSTOMER_BATCH_ID>LOTE-NI-2024-001</CUSTOMER_BATCH_ID>
               <STATUS>LOADED</STATUS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivosResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Servicios y Conexiones

### Servicio Web - Cargador de Lotes (ÚNICO)

**Servicio:** cargadorArchivoLote (MTR)  
**Ruta:** `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote`  
**Tipo:** Web Service SOAP  
**Operación:** cargarLotes  
**Namespace:** http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/  

### Servicios NO Implementados

- ❌ **Bitácora:** No registra en base de datos
- ❌ **Validación de Acceso:** No valida permisos
- ✅ **Mapeo de Errores:** Sí usa MapeoErrores.proxy (heredado)

## Transformaciones XQuery

### Archivos Específicos NI01

- `pagosMasivosInternoNIIn.xq`: Mapeo OSB → MTR
- `pagosMasivosInternoNIOut.xq`: Mapeo MTR → OSB
- `pagosMasivosInternoNIHeaderOut.xq`: Construcción de header

### Mapeo de Entrada - OSB a MTR

Similar a GT01/PA01, mapea estructura OSB a estructura MTR con país="NI" y empresa="01".

### Mapeo de Salida - MTR a OSB

| Campo Origen (MTR) | Campo Destino (OSB) | Notas |
|--------------------|---------------------|-------|
| respuestaHostToHost/cabeceraRespuesta/codigo | successIndicator | Código directo |
| respuestaHostToHost/cabeceraRespuesta/mensaje | messages | Mensaje directo |
| respuestaHostToHost/cuerpoRespuesta/idLoteBanco | BANK_BATCH_ID | ID asignado |
| respuestaHostToHost/cuerpoRespuesta/idLoteCliente | CUSTOMER_BATCH_ID | ID cliente |
| respuestaHostToHost/cuerpoRespuesta/estado | STATUS | Estado del lote |

## Flujo de Datos NI01 (Simplificado)

```
Cliente → PagosMasivos.proxy
  ↓
  Enrutamiento → NI01
  ↓
PagosMasivosInterno.proxy (Pipeline NI01)
  ↓
  Validación XSD (heredada)
  ↓
  Validación Servicio Regional (heredada)
  ↓
  ❌ SIN Bitácora Request
  ↓
  ❌ SIN Validación de Acceso
  ↓
  Transformación Request (XQuery)
  ↓
  Validación WSDL
  ↓
  Invocación cargadorArchivoLote (MTR)
  ↓
  Transformación Response Header
  ↓
  if (successIndicator = SUCCESS)
    → Transformación Response Body
  else
    → Response vacío
  ↓
  ❌ SIN Bitácora Response
  ↓
Cliente ← Response SOAP
```

## Reglas de Negocio NI01

### 1. Sin Validación de Acceso

**Implicación:** Cualquier cliente con credenciales válidas puede procesar lotes sin verificación de permisos específicos.

**Riesgo:** Menor control de seguridad comparado con otras regiones.

### 2. Sin Auditoría

**Implicación:** No hay registro en base de datos de:
- Requests recibidos
- Responses enviados
- Errores ocurridos

**Riesgo:** Pérdida de trazabilidad y auditoría.

### 3. Validación de Response

**Ubicación:** Pipeline `NI01_PagosMasivosInterno_response`, Stage `FlujoSalida`

**Lógica:**
```xquery
if (upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text())) = 'SUCCESS') then
  -- Mapear response body completo
else
  -- Retornar response vacío
```

**Regla:** Solo se construye response body si el código es SUCCESS.

### 4. Construcción de Header

**Transformación:** pagosMasivosInternoNIHeaderOut.xq

**Lógica:**
```xquery
<aut:ResponseHeader>
  <successIndicator>
    {string($cargarLotesResponse/respuestaHostToHost/cabeceraRespuesta/codigo/text())}
  </successIndicator>
  <messages>
    {string($cargarLotesResponse/respuestaHostToHost/cabeceraRespuesta/mensaje/text())}
  </messages>
</aut:ResponseHeader>
```

**Regla:** El header se construye directamente de la respuesta MTR sin mapeo adicional.

## Diferencias Clave vs Otras Regiones

| Aspecto | HN01 | GT01 | PA01 | NI01 |
|---------|------|------|------|------|
| Validación Acceso | ✅ SP | ✅ WS | ✅ WS | ❌ No |
| Bitácora Request | ✅ Sí | ✅ Sí | ✅ Sí | ❌ No |
| Bitácora Response | ✅ Sí | ✅ Sí | ✅ Sí | ❌ No |
| Bitácora Error | ✅ Sí | ✅ Sí | ✅ Sí | ❌ No |
| Proxy Dedicado | ✅ Sí | ✅ Sí | ✅ Sí | ❌ No (pipeline) |
| Backend | SJS | MTR | MTR | MTR |

## Riesgos Identificados

### Críticos

1. **Sin Auditoría:** Imposible rastrear transacciones procesadas
2. **Sin Control de Acceso:** Cualquier usuario puede procesar lotes
3. **Sin Bitácora de Errores:** Errores no se registran para análisis

### Altos

4. **Implementación Incompleta:** Falta funcionalidad básica presente en otras regiones
5. **Inconsistencia:** Comportamiento diferente puede confundir a usuarios

### Medios

6. **Mantenimiento:** Al estar en pipeline compartido, cambios pueden afectar otras regiones

## Recomendaciones

### Prioridad Crítica

1. **Implementar Bitácora:** Agregar registro en BD para auditoría
2. **Implementar Validación de Acceso:** Verificar permisos antes de procesar

### Prioridad Alta

3. **Crear Proxy Dedicado:** Separar NI01 en proxy propio como GT01/PA01
4. **Estandarizar Flujo:** Alinear con otras regiones

### Prioridad Media

5. **Documentar Razón:** Si la simplificación es intencional, documentar por qué
6. **Agregar Métricas:** Monitorear uso y errores

## Consideraciones para Migración

- NI01 requiere **mayor trabajo** que otras regiones para alcanzar paridad funcional
- Evaluar si la simplificación es requerimiento de negocio o deuda técnica
- Considerar impacto en compliance y auditoría
- Validar con stakeholders de Nicaragua antes de migrar
