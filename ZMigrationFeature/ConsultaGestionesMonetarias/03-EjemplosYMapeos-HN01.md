# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <Authentication>
                <UserName>usuario_honduras</UserName>
                <Password>password123</Password>
            </Authentication>
            <Region>
                <SourceBank>HN01</SourceBank>
            </Region>
            <messageId>12345</messageId>
            <timestamp>2024-01-15T10:30:00</timestamp>
        </aut:RequestHeader>
    </soap:Header>
    <soap:Body>
        <con:consultaGestionesMonetarias xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaGestionesMonetariasTypes">
            <NUMUSU>1234567</NUMUSU>
            <DETALLE_GESTION>PRESTAMO_PERSONAL</DETALLE_GESTION>
            <PAIS>HN</PAIS>
        </con:consultaGestionesMonetarias>
    </soap:Body>
</soap:Envelope>
```

## Response OSB (Ejemplo SOAP/XML)

### SOAP Response Exitoso
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>SUCCESS</successIndicator>
            <messages>Consulta ejecutada exitosamente</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <con:consultaGestionesMonetariasResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaGestionesMonetariasTypes">
            <GestionesMonetariasResponseRecord>
                <NUMUSU>1234567</NUMUSU>
                <DETALLE>PRESTAMO_PERSONAL</DETALLE>
                <IMP_M_LOCAL>50000.00</IMP_M_LOCAL>
                <IMP_M_USD>2000.00</IMP_M_USD>
                <FECHA_ORIGEN>2024-01-01</FECHA_ORIGEN>
                <FECHA_LIQ>2024-01-15</FECHA_LIQ>
                <FECHA_VENCIMIENTO>2026-01-01</FECHA_VENCIMIENTO>
                <FECHA_LIQ_PROX>2024-02-15</FECHA_LIQ_PROX>
                <FECHA_PAGO>2024-01-15</FECHA_PAGO>
                <PORCENTAJE>15</PORCENTAJE>
                <CATEGORIA>CREDITO</CATEGORIA>
                <SUB_CATEGORIA>PERSONAL</SUB_CATEGORIA>
                <OPERACION>DESEMBOLSO</OPERACION>
                <PAGO_MLOCAL>2500.00</PAGO_MLOCAL>
                <PAGO_USD>100.00</PAGO_USD>
                <SALDO_ACT_MLOCAL>47500.00</SALDO_ACT_MLOCAL>
                <SALDO_ACT_USD>1900.00</SALDO_ACT_USD>
            </GestionesMonetariasResponseRecord>
            <GestionesMonetariasResponseRecord>
                <NUMUSU>1234567</NUMUSU>
                <DETALLE>PRESTAMO_PERSONAL</DETALLE>
                <IMP_M_LOCAL>2500.00</IMP_M_LOCAL>
                <IMP_M_USD>100.00</IMP_M_USD>
                <FECHA_ORIGEN>2024-01-15</FECHA_ORIGEN>
                <FECHA_LIQ>2024-01-15</FECHA_LIQ>
                <FECHA_VENCIMIENTO>2024-02-15</FECHA_VENCIMIENTO>
                <FECHA_LIQ_PROX>2024-02-15</FECHA_LIQ_PROX>
                <FECHA_PAGO>2024-01-15</FECHA_PAGO>
                <PORCENTAJE>15</PORCENTAJE>
                <CATEGORIA>CREDITO</CATEGORIA>
                <SUB_CATEGORIA>PERSONAL</SUB_CATEGORIA>
                <OPERACION>PAGO_CUOTA</OPERACION>
                <PAGO_MLOCAL>2500.00</PAGO_MLOCAL>
                <PAGO_USD>100.00</PAGO_USD>
                <SALDO_ACT_MLOCAL>47500.00</SALDO_ACT_MLOCAL>
                <SALDO_ACT_USD>1900.00</SALDO_ACT_USD>
            </GestionesMonetariasResponseRecord>
        </con:consultaGestionesMonetariasResponse>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Validación de Servicio Regional

#### Request a ValidaServicioRegional
```xml
<val:InputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
    <val:PV_SERVICIO_ID>FICBCO0287</val:PV_SERVICIO_ID>
    <val:PV_REGION>HN01</val:PV_REGION>
    <val:PV_USUARIO>usuario_honduras</val:PV_USUARIO>
</val:InputParameters>
```

#### Response de ValidaServicioRegional
```xml
<val:OutputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
    <val:PV_CODIGO_ERROR>SUCCESS</val:PV_CODIGO_ERROR>
    <val:PV_MENSAJE_ERROR>Servicio válido para la región</val:PV_MENSAJE_ERROR>
</val:OutputParameters>
```

### 2. Consulta a Base de Datos

#### Request al Stored Procedure
```xml
<ns1:InputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGestionesMonetarias">
    <ns1:PN_NUMUSU>1234567</ns1:PN_NUMUSU>
    <ns1:PV_PAIS>HN</ns1:PV_PAIS>
    <ns1:PV_DETALLE>PRESTAMO_PERSONAL</ns1:PV_DETALLE>
</ns1:InputParameters>
```

#### Response del Stored Procedure
```xml
<ns1:OutputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGestionesMonetarias">
    <ns1:PT_CAMPOS_RESULTADO>
        <ns1:PT_CAMPOS_RESULTADO_ITEM>
            <ns1:NUMUSU>1234567</ns1:NUMUSU>
            <ns1:DETALLE>PRESTAMO_PERSONAL</ns1:DETALLE>
            <ns1:OPERACION>DESEMBOLSO</ns1:OPERACION>
            <ns1:IMP_M_LOCAL>50000.00</ns1:IMP_M_LOCAL>
            <ns1:IMP_M_USD>2000.00</ns1:IMP_M_USD>
            <ns1:FECHA_ORIGEN>2024-01-01</ns1:FECHA_ORIGEN>
            <ns1:FECHA_LIQ>2024-01-15</ns1:FECHA_LIQ>
            <ns1:FECHA_VENCIMIENTO>2026-01-01</ns1:FECHA_VENCIMIENTO>
            <ns1:FECHA_LIQ_PROX>2024-02-15</ns1:FECHA_LIQ_PROX>
            <ns1:FECHA_PAGO>2024-01-15</ns1:FECHA_PAGO>
            <ns1:PORCENTAJE>15</ns1:PORCENTAJE>
            <ns1:CATEGORIA>CREDITO</ns1:CATEGORIA>
            <ns1:SUB_CATEGORIA>PERSONAL</ns1:SUB_CATEGORIA>
            <ns1:PAGO_MLOCAL>2500.00</ns1:PAGO_MLOCAL>
            <ns1:PAGO_USD>100.00</ns1:PAGO_USD>
            <ns1:SALDO_ACT_USD>1900.00</ns1:SALDO_ACT_USD>
            <ns1:SALDO_ACT_MLOCAL>47500.00</ns1:SALDO_ACT_MLOCAL>
        </ns1:PT_CAMPOS_RESULTADO_ITEM>
        <ns1:PT_CAMPOS_RESULTADO_ITEM>
            <ns1:NUMUSU>1234567</ns1:NUMUSU>
            <ns1:DETALLE>PRESTAMO_PERSONAL</ns1:DETALLE>
            <ns1:OPERACION>PAGO_CUOTA</ns1:OPERACION>
            <ns1:IMP_M_LOCAL>2500.00</ns1:IMP_M_LOCAL>
            <ns1:IMP_M_USD>100.00</ns1:IMP_M_USD>
            <ns1:FECHA_ORIGEN>2024-01-15</ns1:FECHA_ORIGEN>
            <ns1:FECHA_LIQ>2024-01-15</ns1:FECHA_LIQ>
            <ns1:FECHA_VENCIMIENTO>2024-02-15</ns1:FECHA_VENCIMIENTO>
            <ns1:FECHA_LIQ_PROX>2024-02-15</ns1:FECHA_LIQ_PROX>
            <ns1:FECHA_PAGO>2024-01-15</ns1:FECHA_PAGO>
            <ns1:PORCENTAJE>15</ns1:PORCENTAJE>
            <ns1:CATEGORIA>CREDITO</ns1:CATEGORIA>
            <ns1:SUB_CATEGORIA>PERSONAL</ns1:SUB_CATEGORIA>
            <ns1:PAGO_MLOCAL>2500.00</ns1:PAGO_MLOCAL>
            <ns1:PAGO_USD>100.00</ns1:PAGO_USD>
            <ns1:SALDO_ACT_USD>1900.00</ns1:SALDO_ACT_USD>
            <ns1:SALDO_ACT_MLOCAL>47500.00</ns1:SALDO_ACT_MLOCAL>
        </ns1:PT_CAMPOS_RESULTADO_ITEM>
    </ns1:PT_CAMPOS_RESULTADO>
    <ns1:PV_CODIGOMENSAJE>SUCCESS</ns1:PV_CODIGOMENSAJE>
    <ns1:PV_DESCRIPCIONMENSAJE>Consulta ejecutada exitosamente</ns1:PV_DESCRIPCIONMENSAJE>
</ns1:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos Oracle
- **Nombre de Conexión**: `eis/DB/ConnectionInterfazSFC`
- **Esquema**: `SALESFORCE`
- **Stored Procedure**: `SFC_P_CON_GESTIONES_MONETARIAS`
- **Tipo de Conexión**: JCA Database Adapter
- **Modo de Conexión**: Managed

### Parámetros del Stored Procedure
- **Parámetro 1**: `PN_NUMUSU` (NUMBER, índice 1)
- **Parámetro 2**: `PV_PAIS` (VARCHAR2, índice 2)  
- **Parámetro 3**: `PV_DETALLE` (VARCHAR2, índice 3)
- **Parámetro 4**: `PT_CAMPOS_RESULTADO` (Array, índice 4) - OUTPUT
- **Parámetro 5**: `PV_CODIGOMENSAJE` (VARCHAR2, índice 5) - OUTPUT
- **Parámetro 6**: `PV_DESCRIPCIONMENSAJE` (VARCHAR2, índice 6) - OUTPUT

## Tablas de Mapeo de Entrada

### Mapeo OSB → Stored Procedure (consultaGestionesMonetariasIn.xq)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| `NUMUSU` | `data($consultaGestionesMonetarias/NUMUSU)` | `PN_NUMUSU` |
| `PAIS` | `data($consultaGestionesMonetarias/PAIS)` | `PV_PAIS` |
| `DETALLE_GESTION` | `data($consultaGestionesMonetarias/DETALLE_GESTION)` | `PV_DETALLE` |

### Mapeo Header OSB → Validación Regional

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Validación) |
|-------------------|----------------------|---------------------------|
| `RequestHeader/Authentication/UserName` | XPath extraction | `PV_USUARIO` |
| `RequestHeader/Region/SourceBank` | XPath extraction | `PV_REGION` |
| Constante | `"FICBCO0287"` | `PV_SERVICIO_ID` |

## Tablas de Mapeo de Salida

### Mapeo Stored Procedure → OSB Response (consultaGestionesMonetariasOut.xq)

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| `PT_CAMPOS_RESULTADO_ITEM/NUMUSU` | `data($Registro/ns1:NUMUSU)` | `NUMUSU` |
| `PT_CAMPOS_RESULTADO_ITEM/DETALLE` | `data($Registro/ns1:DETALLE)` | `DETALLE` |
| `PT_CAMPOS_RESULTADO_ITEM/IMP_M_LOCAL` | `data($Registro/ns1:IMP_M_LOCAL)` | `IMP_M_LOCAL` |
| `PT_CAMPOS_RESULTADO_ITEM/IMP_M_USD` | `data($Registro/ns1:IMP_M_USD)` | `IMP_M_USD` |
| `PT_CAMPOS_RESULTADO_ITEM/FECHA_ORIGEN` | `data($Registro/ns1:FECHA_ORIGEN)` | `FECHA_ORIGEN` |
| `PT_CAMPOS_RESULTADO_ITEM/FECHA_LIQ` | `data($Registro/ns1:FECHA_LIQ)` | `FECHA_LIQ` |
| `PT_CAMPOS_RESULTADO_ITEM/FECHA_VENCIMIENTO` | `data($Registro/ns1:FECHA_VENCIMIENTO)` | `FECHA_VENCIMIENTO` |
| `PT_CAMPOS_RESULTADO_ITEM/FECHA_LIQ_PROX` | `data($Registro/ns1:FECHA_LIQ_PROX)` | `FECHA_LIQ_PROX` |
| `PT_CAMPOS_RESULTADO_ITEM/FECHA_PAGO` | `data($Registro/ns1:FECHA_PAGO)` | `FECHA_PAGO` |
| `PT_CAMPOS_RESULTADO_ITEM/PORCENTAJE` | `data($Registro/ns1:PORCENTAJE)` | `PORCENTAJE` |
| `PT_CAMPOS_RESULTADO_ITEM/CATEGORIA` | `data($Registro/ns1:CATEGORIA)` | `CATEGORIA` |
| `PT_CAMPOS_RESULTADO_ITEM/SUB_CATEGORIA` | `data($Registro/ns1:SUB_CATEGORIA)` | `SUB_CATEGORIA` |
| `PT_CAMPOS_RESULTADO_ITEM/OPERACION` | `data($Registro/ns1:OPERACION)` | `OPERACION` |
| `PT_CAMPOS_RESULTADO_ITEM/PAGO_MLOCAL` | `data($Registro/ns1:PAGO_MLOCAL)` | `PAGO_MLOCAL` |
| `PT_CAMPOS_RESULTADO_ITEM/PAGO_USD` | `data($Registro/ns1:PAGO_USD)` | `PAGO_USD` |
| `PT_CAMPOS_RESULTADO_ITEM/SALDO_ACT_MLOCAL` | `data($Registro/ns1:SALDO_ACT_MLOCAL)` | `SALDO_ACT_MLOCAL` |
| `PT_CAMPOS_RESULTADO_ITEM/SALDO_ACT_USD` | `data($Registro/ns1:SALDO_ACT_USD)` | `SALDO_ACT_USD` |

### Mapeo Header Response (consultaGestionesMonetariasHeaderOut.xq)

| Campo Origen (SP) | Transformación/Script | Campo Destino (Header) |
|------------------|----------------------|----------------------|
| `PV_CODIGOMENSAJE` | `data($PV_CODIGOMENSAJE)` | `successIndicator` |
| `PV_DESCRIPCIONMENSAJE` | `data($PV_DESCRIPCIONMENSAJE)` | `messages` |

## Reglas de Negocio Detectadas

### 1. Validación Regional
- **Ubicación**: Pipeline `ValidacionServicioRegional`
- **Regla**: Solo se permite procesamiento para regiones válidas registradas en base de datos
- **Implementación**: Llamada a stored procedure `ValidaServicioRegional`
- **Condición**: `$respValidaServicioRegional/val:PV_CODIGO_ERROR/text() != 'SUCCESS'`

### 2. Validación de Esquema
- **Ubicación**: Stage `ValidacionXSD`
- **Regla**: El request debe cumplir con el esquema XSD definido
- **Implementación**: Validación XSD contra `consultaGestionesMonetariasTypes.xsd`
- **Campos Obligatorios**: `NUMUSU`, `DETALLE_GESTION`, `PAIS`

### 3. Enrutamiento Regional
- **Ubicación**: Branch node `RegionalizacionPaisEmpresa`
- **Regla**: Enrutamiento basado en `SourceBank` del header
- **Implementación**: XPath `./aut:RequestHeader/Region/SourceBank`
- **Valores Válidos**: 'HN01', 'GT01', 'PA01'

### 4. Manejo de Respuesta Exitosa
- **Ubicación**: Pipeline response de cada región
- **Regla**: Solo construir response body si `successIndicator = "SUCCESS"`
- **Implementación**: Condicional XQuery `$successIndicator = "SUCCESS"`

### 5. Iteración de Resultados
- **Ubicación**: Transformaciones de salida (XQuery)
- **Regla**: Procesar todos los elementos del array `PT_CAMPOS_RESULTADO`
- **Implementación**: `for $Registro in $outputParameters/ns1:PT_CAMPOS_RESULTADO/ns1:PT_CAMPOS_RESULTADO_ITEM`

### 6. Mapeo de Errores
- **Ubicación**: Error handler pipeline
- **Regla**: Mapear errores técnicos a códigos de negocio
- **Implementación**: Llamada a proxy `MapeoErrores` con código `FICBCO0287`
- **Parámetros**: `$errorMessage` y `$errorCode`

### 7. Autenticación Personalizada
- **Ubicación**: Configuración del proxy service
- **Regla**: Extraer credenciales del header SOAP
- **Implementación**: XPath para `UserName` y `Password`
- **Namespaces**: `http://www.ficohsa.com.hn/middleware.services/autType`