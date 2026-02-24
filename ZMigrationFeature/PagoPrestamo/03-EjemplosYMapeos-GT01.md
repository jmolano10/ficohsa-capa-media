# Ejemplos de Request/Response y Mapeo de Datos - GT01 (Guatemala)

## 1. Request OSB (Ejemplo)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_OSB_GT</UserName>
            <Password>PASSWORD_OSB_GT</Password>
         </Authentication>
         <Region>
            <SourceBank>GT01</SourceBank>
            <DestinationBank>GT01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamo>
         <LOAN_NUMBER>GT1234567890</LOAN_NUMBER>
         <PAYMENT_AMOUNT>10000.00</PAYMENT_AMOUNT>
         <PAYMENT_TYPE>ACCOUNT_DEBIT</PAYMENT_TYPE>
         <DEBIT_ACCOUNT>GT1001234567</DEBIT_ACCOUNT>
         <INTERFACE_REFERENCE_NO>REFGT20240101001</INTERFACE_REFERENCE_NO>
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
         <DATE_TIME>20240101120000</DATE_TIME>
         <LOAN_NUMBER>GT1234567890</LOAN_NUMBER>
         <DUE_ID>001</DUE_ID>
         <PAYMENT_AMOUNT>10000.00</PAYMENT_AMOUNT>
      </pag:pagoPrestamoResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## 3. Cadenas de Conexión y Credenciales

### 3.1. Base de Datos ABANKS GT

- **Nombre de Conexión:** eis/DB/ConnectionProxyAbanksGT
- **Stored Procedure:** OSB_P_PAGO_PRESTAMO
- **Esquema:** No especificado explícitamente
- **Package:** OSB_P_PAGO_PRESTAMO

## 4. Mapeo de Entrada - Stored Procedure

### Request a OSB_P_PAGO_PRESTAMO

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|--------------------|----------------------|-------------------|
| pagoPrestamo/LOAN_NUMBER | data() | LOAN_NUMBER |
| pagoPrestamo/PAYMENT_AMOUNT | data() | PAYMENT_AMOUNT |
| pagoPrestamo/DEBIT_ACCOUNT | data() | DEBIT_ACCOUNT |
| pagoPrestamo/INTERFACE_REFERENCE_NO | data() | INTERFACE_REFERENCE_NO |
| RequestHeader/Authentication/UserName | data() | USERNAME |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoGTIn.xq`

**Regla de Negocio:** Mapeo directo de campos OSB a parámetros del stored procedure

### Response de OSB_P_PAGO_PRESTAMO

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| LOAN_NUMBER | data() | pagoPrestamoResponse/LOAN_NUMBER |
| PAYMENT_AMOUNT | data() | PAYMENT_AMOUNT |
| DATE_TIME | data() | DATE_TIME |
| DUE_ID | data() | DUE_ID |
| TRANSACCION_ID | data() | (No mapeado en response) |
| VALUEDATE | data() | (No mapeado en response) |
| ERROR_CODE | data() | ResponseHeader/successIndicator |
| ERROR_MESSAGE | data() | ResponseHeader/messages |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoGTOut.xq`

## 5. Mapeo de Salida - Response Header

### Response Header

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| ERROR_CODE | fn:string() | ResponseHeader/successIndicator |
| ERROR_MESSAGE | fn:string() | ResponseHeader/messages |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoGTHeaderOut.xq`

**Regla de Negocio:** Si ERROR_CODE != "SUCCESS", se mapea como error

## 6. Reglas de Negocio Detectadas

### RN-GT-001: Validación de Región
- **Ubicación:** Pipeline ValidacionesGenerales_request, Stage ValidacionServicioRegional
- **Descripción:** Valida que el servicio FICBCO0076 esté habilitado para la región GT01
- **Código:** `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`

### RN-GT-002: Validación de Tipo de Pago
- **Ubicación:** Pipeline GT01_PagoPrestamo_request, Stage FlujoEntrada
- **Descripción:** Solo acepta PAYMENT_TYPE = "ACCOUNT_DEBIT"
- **Código:** Lógica en PagoPrestamo.proxy, condición `fn:upper-case(fn:string($PaymentType)) = "ACCOUNT_DEBIT"`

### RN-GT-003: Validación de Campos Requeridos
- **Ubicación:** Pipeline GT01_PagoPrestamo_request, Stage FlujoEntrada
- **Descripción:** Valida que PAYMENT_TYPE, LOAN_NUMBER y PAYMENT_AMOUNT no estén vacíos
- **Código:** Lógica en PagoPrestamo.proxy, condición de validación

### RN-GT-004: Mapeo de Errores
- **Ubicación:** Pipeline ValidacionesGenerales_response, Stage MapeoError
- **Descripción:** Mapea códigos de error del SP a mensajes estándar
- **Código:** `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`

### RN-GT-005: Procesamiento en Stored Procedure
- **Ubicación:** Stored Procedure OSB_P_PAGO_PRESTAMO
- **Descripción:** Toda la lógica de negocio está encapsulada en el SP
- **Código:** Base de datos ABANKS GT

## 7. Resumen de Dependencias

### Servicios de Base de Datos
1. ValidaServicioRegional (eis/DB/ConnectionInterbanca)
2. PagoPrestamo_db (eis/DB/ConnectionProxyAbanksGT)

### Proxy Services
1. MapeoErrores

### Archivos XQuery
1. validaServicioRegionalIn.xq
2. aplicarValoresPorDefectoRegion.xq
3. validarCrucePaisEmpresa.xq
4. pagoPtmoGTIn.xq
5. pagoPtmoGTOut.xq
6. pagoPtmoGTHeaderOut.xq
7. mapeoErroresUsageIn.xq
8. mapeoErroresUsageOut.xq

## 8. Diferencias con HN01

1. **Simplicidad:** No requiere validación de tipo de préstamo
2. **Sin UUID:** No genera identificador único de transacción
3. **Sin Reversión:** No implementa reversión automática
4. **Un Solo Tipo de Pago:** Solo soporta ACCOUNT_DEBIT
5. **Stored Procedure:** Toda la lógica está en el SP, no en OSB
6. **Sin Parametrización:** No consulta parámetros de configuración
7. **Sin Validación de Productos:** No valida cuenta y préstamo antes de procesar
