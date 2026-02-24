# Ejemplos de Request/Response y Mapeo de Datos - PA01 (Panamá)

## 1. Request OSB (Ejemplo)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_OSB_PA</UserName>
            <Password>PASSWORD_OSB_PA</Password>
         </Authentication>
         <Region>
            <SourceBank>PA01</SourceBank>
            <DestinationBank>PA01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamo>
         <LOAN_NUMBER>PA1234567890</LOAN_NUMBER>
         <PAYMENT_AMOUNT>2500.00</PAYMENT_AMOUNT>
         <PAYMENT_TYPE>ACCOUNT_DEBIT</PAYMENT_TYPE>
         <DEBIT_ACCOUNT>PA1001234567</DEBIT_ACCOUNT>
         <INTERFACE_REFERENCE_NO>REFPA20240101001</INTERFACE_REFERENCE_NO>
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
         <LOAN_NUMBER>PA1234567890</LOAN_NUMBER>
         <DUE_ID>001</DUE_ID>
         <PAYMENT_AMOUNT>2500.00</PAYMENT_AMOUNT>
      </pag:pagoPrestamoResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## 3. Cadenas de Conexión y Credenciales

### 3.1. Base de Datos ABANKS PA

- **Nombre de Conexión:** eis/DB/ConnectionProxyAbanksPA
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

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoPAIn.xq`

**Nota:** Idéntico a GT01, solo cambia el namespace

### Response de OSB_P_PAGO_PRESTAMO

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| LOAN_NUMBER | data() | pagoPrestamoResponse/LOAN_NUMBER |
| PAYMENT_AMOUNT | data() | PAYMENT_AMOUNT |
| DATE_TIME | data() | DATE_TIME |
| DUE_ID | data() | DUE_ID |
| ERROR_CODE | data() | ResponseHeader/successIndicator |
| ERROR_MESSAGE | data() | ResponseHeader/messages |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoPAOut.xq`

## 5. Reglas de Negocio Detectadas

### RN-PA-001: Validación de Región
- **Ubicación:** Pipeline ValidacionesGenerales_request, Stage ValidacionServicioRegional
- **Descripción:** Valida que el servicio FICBCO0076 esté habilitado para la región PA01
- **Código:** `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`

### RN-PA-002: Validación de Tipo de Pago
- **Ubicación:** Pipeline PA01_PagoPrestamo_request, Stage FlujoEntrada
- **Descripción:** Solo acepta PAYMENT_TYPE = "ACCOUNT_DEBIT"
- **Código:** Lógica en PagoPrestamo.proxy

### RN-PA-003: Validación de Campos Requeridos
- **Ubicación:** Pipeline PA01_PagoPrestamo_request, Stage FlujoEntrada
- **Descripción:** Valida que PAYMENT_TYPE, LOAN_NUMBER y PAYMENT_AMOUNT no estén vacíos
- **Código:** Lógica en PagoPrestamo.proxy

### RN-PA-004: Mapeo de Errores
- **Ubicación:** Pipeline ValidacionesGenerales_response, Stage MapeoError
- **Descripción:** Mapea códigos de error del SP a mensajes estándar
- **Código:** `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`

### RN-PA-005: Procesamiento en Stored Procedure
- **Ubicación:** Stored Procedure OSB_P_PAGO_PRESTAMO
- **Descripción:** Toda la lógica de negocio está encapsulada en el SP
- **Código:** Base de datos ABANKS PA

## 6. Resumen de Dependencias

### Servicios de Base de Datos
1. ValidaServicioRegional (eis/DB/ConnectionInterbanca)
2. pagoPrestamo_db (eis/DB/ConnectionProxyAbanksPA)

### Proxy Services
1. MapeoErrores

### Archivos XQuery
1. validaServicioRegionalIn.xq
2. aplicarValoresPorDefectoRegion.xq
3. validarCrucePaisEmpresa.xq
4. pagoPtmoPAIn.xq
5. pagoPtmoPAOut.xq
6. pagoPtmoPAHeaderOut.xq
7. mapeoErroresUsageIn.xq
8. mapeoErroresUsageOut.xq

## 7. Diferencias con GT01

**Ninguna diferencia significativa en la lógica.** Solo cambia:
- Conexión de base de datos (ConnectionProxyAbanksPA vs ConnectionProxyAbanksGT)
- Namespace en archivos XQuery
- Región en validaciones (PA01 vs GT01)

## 8. Diferencias con HN01

Idénticas a las diferencias de GT01 con HN01:
1. Simplicidad en implementación
2. Sin UUID
3. Sin reversión automática
4. Un solo tipo de pago
5. Lógica en stored procedure
6. Sin parametrización
7. Sin validación de productos
