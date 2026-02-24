# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua)

## 1. Request OSB (Ejemplo)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_OSB_NI</UserName>
            <Password>PASSWORD_OSB_NI</Password>
         </Authentication>
         <Region>
            <SourceBank>NI01</SourceBank>
            <DestinationBank>NI01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamo>
         <LOAN_NUMBER>NI1234567890</LOAN_NUMBER>
         <PAYMENT_AMOUNT>3000.00</PAYMENT_AMOUNT>
         <PAYMENT_TYPE>ACCOUNT_DEBIT</PAYMENT_TYPE>
         <DEBIT_ACCOUNT>NI1001234567</DEBIT_ACCOUNT>
         <INTERFACE_REFERENCE_NO>REFNI20240101001</INTERFACE_REFERENCE_NO>
      </pag:pagoPrestamo>
   </soapenv:Body>
</soapenv:Envelope>
```

## 2. Response OSB (Ejemplo - Exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Pago procesado exitosamente</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse>
         <DATE_TIME>20240101</DATE_TIME>
         <LOAN_NUMBER>NI1234567890</LOAN_NUMBER>
         <DUE_ID></DUE_ID>
         <PAYMENT_AMOUNT>3000.00</PAYMENT_AMOUNT>
      </pag:pagoPrestamoResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## 3. Cadenas de Conexión y Credenciales

### 3.1. Servicio COBIS

- **Endpoint:** http://10.235.53.145:9080/GerenciaProductoPrestamo/SrvAplCobisPrestamoService
- **Operación:** OpPagarPrestamo
- **Protocolo:** SOAP 1.2
- **WSDL:** COBISCorp.eCOBIS.SrvAplCobisPrestamo.Service.wsdl
- **Namespace:** http://impl.service.srvaplcobisprestamo.ecobis.cobiscorp/

## 4. Request Interno a COBIS

```xml
<opPagarPrestamoSolicitud xmlns="http://service.srvaplcobisprestamo.ecobis.cobiscorp"
                          xmlns:dto="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
    <dto:contextoTransaccional>
        <dto:identificadorTransaccional>REFNI20240101001</dto:identificadorTransaccional>
        <dto:codCanalOriginador>1</dto:codCanalOriginador>
        <dto:ipConsumidor>OMNICANAL</dto:ipConsumidor>
    </dto:contextoTransaccional>
    <dto:transaccion>
        <dto:valMonto>3000.00</dto:valMonto>
    </dto:transaccion>
    <dto:prestamo>
        <dto:producto>
            <dto:valNumeroProducto>NI1234567890</dto:valNumeroProducto>
        </dto:producto>
    </dto:prestamo>
    <dto:cuenta>
        <dto:codCuentaHabiente>NI1001234567</dto:codCuentaHabiente>
    </dto:cuenta>
    <dto:oficina>
        <dto:codOficina>1</dto:codOficina>
    </dto:oficina>
    <dto:moneda>
        <dto:multimoneda>N</dto:multimoneda>
    </dto:moneda>
    <dto:canal>
        <dto:servicio>10</dto:servicio>
    </dto:canal>
</opPagarPrestamoSolicitud>
```

## 5. Response Interno de COBIS

```xml
<opPagarPrestamoRespuesta xmlns="http://service.srvaplcobisprestamo.ecobis.cobiscorp"
                          xmlns:dto="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
    <dto:pagoPrestamo>
        <dto:transaccion>
            <dto:valMonto>3000.00</dto:valMonto>
            <dto:fecAplicacion>2024-01-01</dto:fecAplicacion>
        </dto:transaccion>
        <dto:prestamo>
            <dto:producto>
                <dto:valNumeroProducto>NI1234567890</dto:valNumeroProducto>
            </dto:producto>
        </dto:prestamo>
    </dto:pagoPrestamo>
</opPagarPrestamoRespuesta>
```

## 6. Mapeo de Entrada - Request a COBIS

### Tabla de Mapeo

| Campo Origen (OSB) | Transformación/Script | Campo Destino (COBIS) |
|--------------------|----------------------|----------------------|
| pagoPrestamo/INTERFACE_REFERENCE_NO | data() | contextoTransaccional/identificadorTransaccional |
| Constante: "1" | Valor fijo | contextoTransaccional/codCanalOriginador |
| Constante: "OMNICANAL" | Valor fijo | contextoTransaccional/ipConsumidor |
| pagoPrestamo/PAYMENT_AMOUNT | data() | transaccion/valMonto |
| pagoPrestamo/LOAN_NUMBER | data() | prestamo/producto/valNumeroProducto |
| pagoPrestamo/DEBIT_ACCOUNT | data() | cuenta/codCuentaHabiente |
| Constante: "1" | Valor fijo | oficina/codOficina |
| Constante: "N" | Valor fijo | moneda/multimoneda |
| Constante: "10" | Valor fijo | canal/servicio |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIIn.xq`

**Regla de Negocio:** Mapeo de estructura OSB a estructura COBIS con valores fijos para contexto

## 7. Mapeo de Salida - Response de COBIS

### Tabla de Mapeo

| Campo Origen (COBIS) | Transformación/Script | Campo Destino (OSB) |
|---------------------|----------------------|-------------------|
| pagoPrestamo/transaccion/fecAplicacion | convertirFecha(yyyy-MM-dd → yyyyMMdd) | pagoPrestamoResponse/DATE_TIME |
| pagoPrestamo/prestamo/producto/valNumeroProducto | data() | pagoPrestamoResponse/LOAN_NUMBER |
| Constante: "" | Valor vacío | pagoPrestamoResponse/DUE_ID |
| pagoPrestamo/transaccion/valMonto | data() | pagoPrestamoResponse/PAYMENT_AMOUNT |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIOut.xq`

**Función de Conversión de Fecha:**
```xquery
declare function convertirFecha($date as xs:string) as xs:string {
    fn-bea:date-to-string-with-format("yyyyMMdd", 
        fn-bea:date-from-string-with-format("yyyy-MM-dd", $date))
};
```

## 8. Mapeo de Salida - Response Header

### Tabla de Mapeo

| Campo Origen (COBIS) | Transformación/Script | Campo Destino (OSB) |
|---------------------|----------------------|-------------------|
| Respuesta exitosa | "SUCCESS" | ResponseHeader/successIndicator |
| Respuesta con error | "Error" | ResponseHeader/successIndicator |
| Mensaje de error | data() | ResponseHeader/messages |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIHeaderOut.xq`

## 9. Reglas de Negocio Detectadas

### RN-NI-001: Validación de Región
- **Ubicación:** Pipeline ValidacionesGenerales_request, Stage ValidacionServicioRegional
- **Descripción:** Valida que el servicio FICBCO0076 esté habilitado para la región NI01
- **Código:** `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`

### RN-NI-002: Validación de Tipo de Pago
- **Ubicación:** Pipeline NI01_PagoPrestamo_request, Stage FlujoEntrada
- **Descripción:** Solo acepta PAYMENT_TYPE = "ACCOUNT_DEBIT"
- **Código:** Lógica en PagoPrestamo.proxy, condición `fn:upper-case(fn:string($body/pag:pagoPrestamo/PAYMENT_TYPE/text())) = "ACCOUNT_DEBIT"`

### RN-NI-003: Contexto Transaccional COBIS
- **Ubicación:** Transformación pagoPrestamoNIIn.xq
- **Descripción:** Establece contexto transaccional con valores fijos:
  - codCanalOriginador: 1
  - ipConsumidor: OMNICANAL
  - codOficina: 1
  - multimoneda: N
  - servicio: 10
- **Código:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIIn.xq`

### RN-NI-004: Conversión de Fecha
- **Ubicación:** Transformación pagoPrestamoNIOut.xq
- **Descripción:** Convierte fecha de formato COBIS (yyyy-MM-dd) a formato OSB (yyyyMMdd)
- **Código:** Función convertirFecha en `pagoPrestamoNIOut.xq`

### RN-NI-005: Validación de Esquema COBIS
- **Ubicación:** Pipeline NI01_PagoPrestamo_request, Stage FlujoEntrada
- **Descripción:** Valida el request contra el esquema COBIS antes de enviar
- **Código:** Validación con esquema `Middleware/v2/BusinessServices/CTS/prestamo/xsd/services.xsd`

### RN-NI-006: Mapeo de Errores
- **Ubicación:** Pipeline ValidacionesGenerales_response, Stage MapeoError
- **Descripción:** Mapea códigos de error de COBIS a mensajes estándar
- **Código:** `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`

### RN-NI-007: DUE_ID Vacío
- **Ubicación:** Transformación pagoPrestamoNIOut.xq
- **Descripción:** COBIS no retorna DUE_ID, se deja vacío en la respuesta
- **Código:** `<DUE_ID></DUE_ID>` en pagoPrestamoNIOut.xq

## 10. Resumen de Dependencias

### Servicios SOAP Externos
1. prestamo (COBIS) - http://10.235.53.145:9080/GerenciaProductoPrestamo/SrvAplCobisPrestamoService

### Servicios de Base de Datos
1. ValidaServicioRegional (eis/DB/ConnectionInterbanca)

### Proxy Services
1. MapeoErrores

### Archivos XQuery
1. validaServicioRegionalIn.xq
2. aplicarValoresPorDefectoRegion.xq
3. validarCrucePaisEmpresa.xq
4. pagoPrestamoNIIn.xq
5. pagoPrestamoNIOut.xq
6. pagoPrestamoNIHeaderOut.xq
7. mapeoErroresUsageIn.xq
8. mapeoErroresUsageOut.xq

### Archivos XSD
1. services.xsd (COBIS)
2. cobiscorp.ecobis.srvaplcobisentidades.dto.xsd
3. commonDTO1.xsd
4. commonDTO2.xsd

## 11. Diferencias con Otras Regiones

### vs HN01
1. **Protocolo:** SOAP 1.2 vs DB Adapter
2. **Sistema Core:** COBIS vs T24/ABANKS
3. **Complejidad:** Media vs Alta
4. **Tipos de Pago:** Solo ACCOUNT_DEBIT vs Múltiples
5. **Conversión de Fecha:** Sí vs No
6. **Contexto Transaccional:** Requerido vs No aplica
7. **DUE_ID:** Vacío vs Poblado

### vs GT01/PA01
1. **Protocolo:** SOAP 1.2 vs DB Adapter
2. **Sistema Core:** COBIS vs ABANKS
3. **Estructura de Datos:** Compleja (DTO) vs Simple (SP)
4. **Validación de Esquema:** Sí vs No
5. **Conversión de Fecha:** Sí vs No
6. **Valores Fijos:** Múltiples vs Ninguno

## 12. Campos Específicos de COBIS

| Campo | Valor | Descripción |
|-------|-------|-------------|
| codCanalOriginador | 1 | Código del canal que origina la transacción |
| ipConsumidor | OMNICANAL | IP o identificador del consumidor |
| codOficina | 1 | Código de la oficina |
| multimoneda | N | Indicador de multimoneda (N = No) |
| servicio | 10 | Código del servicio |

## 13. Consideraciones Especiales

1. **SOAP 1.2:** Requiere configuración específica del binding
2. **Timeout:** Configurado en 0 (sin límite)
3. **Retry:** No configurado
4. **Connection Timeout:** 0 (sin límite)
5. **Follow Redirects:** false
6. **Chunked Streaming Mode:** true
7. **Validación de Esquema:** Obligatoria antes de enviar a COBIS
8. **Formato de Fecha:** Conversión obligatoria en respuesta
9. **DUE_ID:** Siempre vacío en respuesta
10. **Contexto Transaccional:** Obligatorio con valores específicos
