# Ejemplos de Request/Response y Mapeo de Datos - HN01

## Request OSB (Ejemplo SOAP/XML)

### SOAP Header
```xml
<soapenv:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
        <Authentication>
            <UserName>USUARIO_CB</UserName>
            <Password>PASSWORD_CB</Password>
        </Authentication>
        <Region>
            <SourceBank>HN01</SourceBank>
        </Region>
        <BankingCorrespondent>
            <Id>001</Id>
        </BankingCorrespondent>
    </aut:RequestHeader>
</soapenv:Header>
```

### SOAP Body
```xml
<soapenv:Body>
    <ret:retiroEfectivo xmlns:ret="http://www.ficohsa.com.hn/middleware.services/retiroEfectivoCBTypes">
        <ACCOUNT_NUMBER>1234567890</ACCOUNT_NUMBER>
        <CURRENCY>HNL</CURRENCY>
        <AMOUNT>1000.00</AMOUNT>
        <TOKEN_ID>TKN123456789</TOKEN_ID>
        <TRANSACTION_ID_CB>CB20231201001</TRANSACTION_ID_CB>
    </ret:retiroEfectivo>
</soapenv:Body>
```

## Response OSB (Ejemplo SOAP/XML)

### SOAP Header - Exitoso
```xml
<soapenv:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
        <successIndicator>SUCCESS</successIndicator>
        <messages>Transacción procesada exitosamente</messages>
        <transactionId>FT231201001</transactionId>
    </aut:ResponseHeader>
</soapenv:Header>
```

### SOAP Body - Exitoso
```xml
<soapenv:Body>
    <ret:retiroEfectivoResponse xmlns:ret="http://www.ficohsa.com.hn/middleware.services/retiroEfectivoCBTypes">
        <ACCOUNT_NUMBER>1234567890</ACCOUNT_NUMBER>
        <AMOUNT>1000.00</AMOUNT>
        <CURRENCY>HNL</CURRENCY>
        <ACCOUNT_NAME>JUAN CARLOS PEREZ LOPEZ</ACCOUNT_NAME>
        <TOKEN_ID>TKN123456789</TOKEN_ID>
        <COMMISION_AMOUNT>25.00</COMMISION_AMOUNT>
    </ret:retiroEfectivoResponse>
</soapenv:Body>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta de Comisiones (MW_P_CON_COMISION_CORBAN)

#### Request a Base de Datos
```xml
<ns1:InputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionesCB">
    <ns1:PV_MONTO>1000.00</ns1:PV_MONTO>
    <ns1:PV_MONEDA>HNL</ns1:PV_MONEDA>
    <ns1:PV_CODIGO_TRANSACCION>4</ns1:PV_CODIGO_TRANSACCION>
    <ns1:PV_USUARIO_TRANSACCION>USUARIO_CB</ns1:PV_USUARIO_TRANSACCION>
</ns1:InputParameters>
```

#### Response de Base de Datos
```xml
<ns1:OutputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionesCB">
    <ns1:PV_CODIGO_ERROR>SUCCESS</ns1:PV_CODIGO_ERROR>
    <ns1:PV_MENSAJE_ERROR>Consulta exitosa</ns1:PV_MENSAJE_ERROR>
    <ns1:PV_MONTO_COMISION>25.00</ns1:PV_MONTO_COMISION>
</ns1:OutputParameters>
```

### 2. Transferencia T24 (RetiroEfectivoTengo)

#### Request a T24
```xml
<ns1:RetiroEfectivoTengo xmlns:ns1="T24WebServicesImpl">
    <WebRequestCommon>
        <userName>T24_USER</userName>
        <password>T24_PASS</password>
    </WebRequestCommon>
    <OfsFunction>
        <noOfAuth>0</noOfAuth>
    </OfsFunction>
    <FUNDSTRANSFERRETAILINTSALEWSType>
        <TransactionType>AC</TransactionType>
        <DebitAccount>1234567890</DebitAccount>
        <DebitCurrency>HNL</DebitCurrency>
        <DebitAmount>1000.00</DebitAmount>
        <CreditAccount>9876543210</CreditAccount>
        <LRREFTENGO>CB20231201001</LRREFTENGO>
    </FUNDSTRANSFERRETAILINTSALEWSType>
</ns1:RetiroEfectivoTengo>
```

#### Response de T24
```xml
<ns1:RetiroEfectivoTengoResponse xmlns:ns1="T24WebServicesImpl">
    <Status>
        <successIndicator>SUCCESS</successIndicator>
        <messages>Transaction completed successfully</messages>
        <transactionId>FT231201001</transactionId>
    </Status>
</ns1:RetiroEfectivoTengoResponse>
```

### 3. Consulta de Saldo de Cuenta

#### Request
```xml
<ConsultadesaldodecuentaRequest>
    <Header>
        <Region>
            <SourceBank>HN01</SourceBank>
        </Region>
    </Header>
    <Body>
        <ACCOUNT_NUMBER>1234567890</ACCOUNT_NUMBER>
    </Body>
</ConsultadesaldodecuentaRequest>
```

#### Response
```xml
<ConsultadesaldodecuentaResponse>
    <WSFICOACCTBASICDETAILSType>
        <gWSFICOACCTBASICDETAILSDetailType>
            <mWSFICOACCTBASICDETAILSDetailType>
                <AVAILBALANCE>5000.00</AVAILBALANCE>
                <ACCOUNTTITLE>JUAN CARLOS PEREZ LOPEZ</ACCOUNTTITLE>
            </mWSFICOACCTBASICDETAILSDetailType>
        </gWSFICOACCTBASICDETAILSDetailType>
    </WSFICOACCTBASICDETAILSType>
</ConsultadesaldodecuentaResponse>
```

## Cadenas de Conexión y Credenciales

### Base de Datos
- **Nombre de Conexión**: eis/DB/ConnectionMiddleware
- **Stored Procedure**: MW_P_CON_COMISION_CORBAN
- **Esquema**: No especificado (usa conexión por defecto)
- **Tipo**: Oracle Database Adapter

### Servicio T24
- **Endpoint WSDL**: http://10.242.104.55:7005/svcRegistraTransaccionTengo/services
- **Operación**: RetiroEfectivoTengo
- **Protocolo**: SOAP/HTTP
- **Autenticación**: Usuario/contraseña en WebRequestCommon

### Servicios OSB Internos
- **ConsultaCuentas**: Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS
- **Transferencias**: Middleware/Business_Resources/Transferencias/Resources/transferenciasBS
- **ValidaServicioRegional**: Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db

## Tablas de Mapeo de Entrada

### Mapeo OSB → Consulta Comisiones
| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| retiroEfectivo/AMOUNT | data($retiroEfectivo/AMOUNT) | PV_MONTO |
| retiroEfectivo/CURRENCY | data($retiroEfectivo/CURRENCY) | PV_MONEDA |
| Constante '4' | '4' | PV_CODIGO_TRANSACCION |
| header/Authentication/UserName | upper-case($usuarioTransaccion) | PV_USUARIO_TRANSACCION |

### Mapeo OSB → T24 Transferencia
| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| header/Authentication/UserName | getUsername() o valor directo | userName |
| header/Authentication/Password | getPassword() o valor directo | password |
| $tipoTrxT24 | Variable externa | TransactionType |
| retiroEfectivo/ACCOUNT_NUMBER | data($retiroEfectivoREQ/ACCOUNT_NUMBER) | DebitAccount |
| retiroEfectivo/CURRENCY | data($retiroEfectivoREQ/CURRENCY) | DebitCurrency |
| retiroEfectivo/AMOUNT | data($retiroEfectivoREQ/AMOUNT) | DebitAmount |
| $cuentaCreditoT24 | Variable externa | CreditAccount |
| retiroEfectivo/TRANSACTION_ID_CB | data($retiroEfectivoREQ/TRANSACTION_ID_CB) | LRREFTENGO |

## Tablas de Mapeo de Salida

### Mapeo Consulta Saldo → OSB
| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| AVAILBALANCE | $RSPConsultadesaldodecuenta/.../AVAILBALANCE/text() | $disponible |
| ACCOUNTTITLE | data($ACCOUNTTITLE) | ACCOUNT_NAME |

### Mapeo T24 Response → OSB
| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| Status/successIndicator | fn:string($RSPRegistraTransaccionT24/Status/successIndicator/text()) | $successIndicator |
| Status/messages | fn:string-join($RSPRegistraTransaccionT24/Status/messages/text()," ") | $validateMessage |
| Status/transactionId | fn:string($RSPRegistraTransaccionT24/Status/transactionId/text()) | $transactionId |

### Mapeo Final OSB Response
| Campo Origen | Transformación/Script | Campo Destino (Response) |
|-------------|----------------------|------------------------|
| retiroEfectivo/ACCOUNT_NUMBER | data($retiroEfectivo/ACCOUNT_NUMBER) | ACCOUNT_NUMBER |
| retiroEfectivo/AMOUNT | data($retiroEfectivo/AMOUNT) | AMOUNT |
| retiroEfectivo/CURRENCY | data($retiroEfectivo/CURRENCY) | CURRENCY |
| consultadesaldodecuentaResponse/ACCOUNTTITLE | data($ACCOUNTTITLE) | ACCOUNT_NAME |
| retiroEfectivo/TOKEN_ID | data($retiroEfectivo/TOKEN_ID) | TOKEN_ID |
| $montocomision | $comision | COMMISION_AMOUNT |

## Reglas de Negocio Detectadas

### 1. Validación de Fondos Suficientes
- **Ubicación**: HN01_request pipeline, stage "Request"
- **Regla**: `xs:double($disponible) - xs:double($total) >= 0.0`
- **Descripción**: El saldo disponible debe ser mayor o igual al monto solicitado más la comisión
- **Fragmento de Código**:
```xquery
<con3:assign varName="total">
    <con3:expr>
        <con2:xqueryText>xs:double($body/ret:retiroEfectivo/AMOUNT/text()) + 
        xs:double($RSPconsultaComisionesCB/con1:PV_MONTO_COMISION/text())</con2:xqueryText>
    </con3:expr>
</con3:assign>
```

### 2. Validación de Moneda por Corresponsal
- **Ubicación**: Validaciones_request pipeline, stage "ValidarCorresponsal"
- **Regla**: `$body/ret:retiroEfectivo/CURRENCY/text() != $monedaValida`
- **Descripción**: La moneda de la transacción debe coincidir con la moneda permitida del corresponsal
- **Fragmento de Código**:
```xquery
<con5:condition>
    <con6:xqueryText>$body/ret:retiroEfectivo/CURRENCY/text() != $monedaValida</con6:xqueryText>
</con5:condition>
```

### 3. Cobro de Comisión Condicional
- **Ubicación**: HN01_request pipeline, stage "Request"
- **Regla**: `xs:double($montocomision) > 0`
- **Descripción**: Solo se cobra comisión si el monto es mayor a cero
- **Fragmento de Código**:
```xquery
<con3:condition>
    <con2:xqueryText>xs:double($montocomision) > 0</con2:xqueryText>
</con3:condition>
```

### 4. Reversión Automática en Error de Comisión
- **Ubicación**: HN01_request pipeline, stage "Request"
- **Regla**: Si falla el cobro de comisión, se reversa la transacción principal
- **Descripción**: Garantiza atomicidad de la operación
- **Servicio**: ReversarTransaccion proxy service

### 5. Validación de Cuenta Existente
- **Ubicación**: HN01_request pipeline, stage "Request"
- **Regla**: `fn:string($count) = "0"`
- **Descripción**: La cuenta debe existir y retornar al menos un registro
- **Error**: "R03-Número de Cuenta Inexistente"

### 6. Estados de Transacción Tengo
- **Ubicación**: Múltiples stages
- **Regla**: Seguimiento de estados para trazabilidad
- **Estados**:
  - REGISTRADO
  - VALIDANDO_RUTA_REGIONAL
  - OBTENIENDO_COMISION
  - CONSULTANDO_CUENTA
  - REALIZANDO_TRANSFERENCIA
  - TRANSACCION_EXITOSA