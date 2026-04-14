# Ejemplos de Request/Response y Mapeo de Datos - HN01

## Request OSB (Ejemplo JSON/XML)

### SOAP Request - ValidaDepositoReferenciadoCB
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>usuario_cb</UserName>
        <Password>password_cb</Password>
      </Authentication>
      <BankingCorrespondent>
        <Id>CB001</Id>
      </BankingCorrespondent>
      <Region>
        <SourceBank>HN01</SourceBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <val:validaDepositoReferenciadoCBRequest xmlns:val="http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes">
      <ACCOUNT>1234567890</ACCOUNT>
      <DOCUMENT_INFO>
        <TYPE>DEBTOR_CODE</TYPE>
        <VALUE>12345678</VALUE>
      </DOCUMENT_INFO>
    </val:validaDepositoReferenciadoCBRequest>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response - ValidaDepositoReferenciadoCB (Exitoso)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>SUCCESS</successIndicator>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <val:validaDepositoReferenciadoCBResponse xmlns:val="http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes">
      <DOCUMENT_NUMBER>DOC123456</DOCUMENT_NUMBER>
      <ACCOUNT>1234567890</ACCOUNT>
      <DEBTOR_INFO>
        <ID>12345678</ID>
        <NAME>JUAN PEREZ LOPEZ</NAME>
      </DEBTOR_INFO>
      <DEBTOR_INFO>
        <ID>87654321</ID>
        <NAME>MARIA GONZALEZ RODRIGUEZ</NAME>
      </DEBTOR_INFO>
    </val:validaDepositoReferenciadoCBResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Validación de Corresponsal Bancario

#### Request a consultarCorresponsalB_db
```xml
<con:InputParameters xmlns:con="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB">
  <con:PV_TIPO_TRANSACCION>7</con:PV_TIPO_TRANSACCION>
  <con:PV_ID_CORRESPONSAL_BANCARIO>CB001</con:PV_ID_CORRESPONSAL_BANCARIO>
  <con:PV_CODIGO_BANCO>HN01</con:PV_CODIGO_BANCO>
</con:InputParameters>
```

#### Response de consultarCorresponsalB_db
```xml
<con:OutputParameters xmlns:con="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB">
  <con:PV_CODIGO_MENSAJE>SUCCESS</con:PV_CODIGO_MENSAJE>
  <con:PV_MENSAJE_ERROR></con:PV_MENSAJE_ERROR>
</con:OutputParameters>
```

### 2. Validación de Servicio Regional

#### Request a ValidaServicioRegional_db
```xml
<vsr:InputParameters xmlns:vsr="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <vsr:PV_CODIGO_SERVICIO>FICBCO0311</vsr:PV_CODIGO_SERVICIO>
  <vsr:PV_CODIGO_BANCO>HN01</vsr:PV_CODIGO_BANCO>
</vsr:InputParameters>
```

#### Response de ValidaServicioRegional_db
```xml
<vsr:OutputParameters xmlns:vsr="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <vsr:PV_CODIGO_ERROR>SUCCESS</vsr:PV_CODIGO_ERROR>
  <vsr:PV_MENSAJE_ERROR></vsr:PV_MENSAJE_ERROR>
</vsr:OutputParameters>
```

### 3. Validación de Depósito Referenciado

#### Request a ValidaDepositoReferenciado_db
```xml
<vdr:InputParameters xmlns:vdr="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaDepositoReferenciado">
  <vdr:PV_NUMERO_CUENTA>1234567890</vdr:PV_NUMERO_CUENTA>
  <vdr:PV_TIPO_DOCUMENTO>1</vdr:PV_TIPO_DOCUMENTO>
  <vdr:PV_DOCUMENTO>12345678</vdr:PV_DOCUMENTO>
</vdr:InputParameters>
```

#### Response de ValidaDepositoReferenciado_db
```xml
<vdr:OutputParameters xmlns:vdr="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaDepositoReferenciado">
  <vdr:PV_NUMERO_DOCUMENTO>DOC123456</vdr:PV_NUMERO_DOCUMENTO>
  <vdr:PV_CUENTA>1234567890</vdr:PV_CUENTA>
  <vdr:PT_CODIGO_DEUDOR>
    <vdr:ITEM>12345678</vdr:ITEM>
    <vdr:ITEM>87654321</vdr:ITEM>
  </vdr:PT_CODIGO_DEUDOR>
  <vdr:PT_NOMBRE_DEUDOR>
    <vdr:ITEM>JUAN PEREZ LOPEZ</vdr:ITEM>
    <vdr:ITEM>MARIA GONZALEZ RODRIGUEZ</vdr:ITEM>
  </vdr:PT_NOMBRE_DEUDOR>
  <vdr:PV_CODIGO_ERROR>SUCCESS</vdr:PV_CODIGO_ERROR>
  <vdr:PV_CODIGO_RETORNO>0</vdr:PV_CODIGO_RETORNO>
  <vdr:PV_MENSAJE_ERROR></vdr:PV_MENSAJE_ERROR>
</vdr:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos Honduras
- **Conexión JCA**: `eis/DB/ConnectionProxyAbanksHN`
- **Esquema**: ABK
- **Package**: `CBR_K_DEP_REFERENCIADOS`
- **Stored Procedure**: `CRB_P_VALIDAR_DEPOSITO_REF`
- **Adapter**: Database Adapter
- **Connection Mode**: Managed

### Servicios WSDL
- **ValidaDepositoReferenciadoCB**: `http://172.23.13.19:8003/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB`
- **Operación**: ValidaDepositoReferenciadoCB
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes`

## Tablas de Mapeo de Entrada

### Mapeo OSB → Servicio Interno (ValidaDepositoReferenciado)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| `$body/val:validaDepositoReferenciadoCBRequest/ACCOUNT` | `fn:string()` | `$body/dep1:validaDepositoReferenciado/ACCOUNT` |
| `$body/val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/TYPE` | `fn:string()` | `$body/dep1:validaDepositoReferenciado/DOCUMENT_INFO/TYPE` |
| `$body/val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/VALUE` | `fn:string()` | `$body/dep1:validaDepositoReferenciado/DOCUMENT_INFO/VALUE` |

### Mapeo Servicio Interno → Base de Datos

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (BD) |
|--------------------------------|----------------------|-------------------|
| `data($body/dep1:validaDepositoReferenciado/ACCOUNT)` | Directo | `ns0:PV_NUMERO_CUENTA` |
| `data($body/dep1:validaDepositoReferenciado/DOCUMENT_INFO/TYPE)` | `if ($tipoDocumento = "DEBTOR_CODE") then "1" else "2"` | `ns0:PV_TIPO_DOCUMENTO` |
| `data($body/dep1:validaDepositoReferenciado/DOCUMENT_INFO/VALUE)` | Directo | `ns0:PV_DOCUMENTO` |

## Tablas de Mapeo de Salida

### Mapeo Base de Datos → Servicio Interno

| Campo Origen (BD) | Transformación/Script | Campo Destino (servicio interno) |
|------------------|----------------------|----------------------------------|
| `data($RSPValidaDepositoReferenciado/vdrsp:PV_NUMERO_DOCUMENTO)` | Directo | `<DOCUMENT_NUMBER>` |
| `data($RSPValidaDepositoReferenciado/vdrsp:PV_CUENTA)` | Directo | `<ACCOUNT>` |
| `$RSPValidaDepositoReferenciado/vdrsp:PT_CODIGO_DEUDOR/vdrsp:ITEM[$x]` | Loop por cada item | `<DEBTOR_INFO><ID>` |
| `$RSPValidaDepositoReferenciado/vdrsp:PT_NOMBRE_DEUDOR/vdrsp:ITEM[$x]` | Loop por cada item | `<DEBTOR_INFO><NAME>` |

### Mapeo Servicio Interno → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| `data($RSPValidaDepositoReferenciado/DOCUMENT_NUMBER)` | Directo | `<DOCUMENT_NUMBER>` |
| `data($RSPValidaDepositoReferenciado/ACCOUNT)` | Directo | `<ACCOUNT>` |
| `$RSPValidaDepositoReferenciado/DEBTOR_INFOS/DEBTOR_INFO` | Mapeo de estructura | `<DEBTOR_INFO>` |

## Reglas de Negocio Detectadas

### 1. Validación de Campos Obligatorios
- **Ubicación**: `ValidaDepositoReferenciadoCB.proxy` - Stage "ValidateMessage"
- **Regla**: ACCOUNT no puede estar vacío
- **Código**: `if (fn:string($body/val:validaDepositoReferenciadoCBRequest/ACCOUNT/text()) = "") then Error("NO ACCOUNT", "La cuenta es necesaria")`

### 2. Validación de Tipo de Documento
- **Ubicación**: `ValidaDepositoReferenciadoCB.proxy` - Stage "ValidateMessage"
- **Regla**: DOCUMENT_INFO.TYPE no puede estar vacío
- **Código**: `if (fn:string($body/val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/TYPE/text()) = "") then Error("NO DOCUMENT TYPE", "El tipo de documento es necesario")`

### 3. Validación de Valor de Documento
- **Ubicación**: `ValidaDepositoReferenciadoCB.proxy` - Stage "ValidateMessage"
- **Regla**: DOCUMENT_INFO.VALUE no puede estar vacío
- **Código**: `if (fn:string($body/val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/VALUE/text()) = "") then Error("NO DOCUMENT VALUE", "El valor del documento es necesario")`

### 4. Mapeo de Tipos de Documento
- **Ubicación**: `validaDepositoReferenciadoIN.xq`
- **Regla**: Conversión de tipos de documento a códigos numéricos
- **Código**: `if ($tipoDocumento = "DEBTOR_CODE") then "1" else "2"`

### 5. Validación de Corresponsal Bancario
- **Ubicación**: `ValidaDepositoReferenciadoCB.proxy` - Stage "ValidarCorresponsal"
- **Regla**: Validar que el corresponsal esté autorizado para la transacción tipo 7
- **Código**: `if (fn:string($RSPConsultaCorresponsal/con:PV_CODIGO_MENSAJE/text()) != 'SUCCESS') then Error`

### 6. Validación de Servicio Regional
- **Ubicación**: `ValidaDepositoReferenciado.proxy` - Stage "ValidateRegionService"
- **Regla**: Validar que el servicio FICBCO0311 esté habilitado para la región
- **Código**: `if (fn:string($RSPValidaServicioRegional/vsr:PV_CODIGO_ERROR/text()) != 'SUCCESS') then Error`

### 7. Validación de Registros Encontrados
- **Ubicación**: `ValidaDepositoReferenciado.proxy` - Stage "FlujoEntrada" HN01
- **Regla**: Si no se encuentran registros, generar error
- **Código**: `if ($codigoValidaDeposito = "-1") then Error("NO RECORDS", "NO RECORDS FOUND")`

### 8. Enrutamiento Regional
- **Ubicación**: `ValidaDepositoReferenciado.proxy` - Branch "Regionalizacion"
- **Regla**: Enrutar según el valor de `./aut:RequestHeader/Region/SourceBank`
- **Código**: `<con:branch name="HN01"><con:operator>equals</con:operator><con:value>"HN01"</con:value>`