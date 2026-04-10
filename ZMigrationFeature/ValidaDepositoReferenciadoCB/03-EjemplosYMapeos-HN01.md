# Ejemplos de Request/Response y Mapeo de Datos - HN01

## Request OSB (Ejemplo JSON/XML)

### SOAP Request Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <Authentication>
                <UserName>CB_USER_HN</UserName>
                <Password>CB_PASS_HN</Password>
            </Authentication>
            <Region>
                <SourceBank>HN01</SourceBank>
            </Region>
            <BankingCorrespondent>
                <Id>CORRESPONDENT_001</Id>
            </BankingCorrespondent>
        </aut:RequestHeader>
    </soap:Header>
    <soap:Body>
        <val:validaDepositoReferenciadoCBRequest xmlns:val="http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes">
            <ACCOUNT>1234567890</ACCOUNT>
            <DOCUMENT_INFO>
                <TYPE>DEBTOR_CODE</TYPE>
                <VALUE>DEB001</VALUE>
            </DOCUMENT_INFO>
        </val:validaDepositoReferenciadoCBRequest>
    </soap:Body>
</soap:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response Exitoso
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>SUCCESS</successIndicator>
            <messages>Consulta exitosa</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <val:validaDepositoReferenciadoCBResponse xmlns:val="http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes">
            <DOCUMENT_NUMBER>DOC123456</DOCUMENT_NUMBER>
            <ACCOUNT>1234567890</ACCOUNT>
            <DEBTOR_INFO>
                <ID>DEB001</ID>
                <NAME>Juan Pérez</NAME>
            </DEBTOR_INFO>
            <DEBTOR_INFO>
                <ID>DEB002</ID>
                <NAME>María García</NAME>
            </DEBTOR_INFO>
        </val:validaDepositoReferenciadoCBResponse>
    </soap:Body>
</soap:Envelope>
```

### SOAP Response con Error
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
        <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
            <successIndicator>ERROR</successIndicator>
            <messages>No se encontraron registros para la cuenta especificada</messages>
        </aut:ResponseHeader>
    </soap:Header>
    <soap:Body>
        <val:validaDepositoReferenciadoCBResponse xmlns:val="http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes"/>
    </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta de Corresponsal Bancario

#### Request a consultarCorresponsalB_db
```xml
<con:InputParameters xmlns:con="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB">
    <con:PV_TIPO_TRANSACCION>7</con:PV_TIPO_TRANSACCION>
    <con:PV_ID_CORRESPONSAL>CORRESPONDENT_001</con:PV_ID_CORRESPONSAL>
    <con:PV_BANCO_ORIGEN>HN01</con:PV_BANCO_ORIGEN>
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
    <vsr:PV_ID_SERVICIO>FICBCO0311</vsr:PV_ID_SERVICIO>
    <vsr:PV_BANCO_ORIGEN>HN01</vsr:PV_BANCO_ORIGEN>
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
    <vdr:PV_DOCUMENTO>DEB001</vdr:PV_DOCUMENTO>
</vdr:InputParameters>
```

#### Response de ValidaDepositoReferenciado_db
```xml
<vdr:OutputParameters xmlns:vdr="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaDepositoReferenciado">
    <vdr:PV_NUMERO_DOCUMENTO>DOC123456</vdr:PV_NUMERO_DOCUMENTO>
    <vdr:PV_CUENTA>1234567890</vdr:PV_CUENTA>
    <vdr:PT_CODIGO_DEUDOR>
        <vdr:ITEM>DEB001</vdr:ITEM>
        <vdr:ITEM>DEB002</vdr:ITEM>
    </vdr:PT_CODIGO_DEUDOR>
    <vdr:PT_NOMBRE_DEUDOR>
        <vdr:ITEM>Juan Pérez</vdr:ITEM>
        <vdr:ITEM>María García</vdr:ITEM>
    </vdr:PT_NOMBRE_DEUDOR>
    <vdr:PV_CODIGO_ERROR>SUCCESS</vdr:PV_CODIGO_ERROR>
    <vdr:PV_CODIGO_RETORNO>0</vdr:PV_CODIGO_RETORNO>
    <vdr:PV_MENSAJE_ERROR></vdr:PV_MENSAJE_ERROR>
</vdr:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos Oracle
- **Nombre de Conexión**: ConnectionProxyAbanksHN
- **URI de Conexión**: jca://eis/DB/ConnectionProxyAbanksHN
- **Esquema/Package**: CBR_K_DEP_REFERENCIADOS
- **Stored Procedure**: CRB_P_VALIDAR_DEPOSITO_REF
- **Adapter**: Database Adapter (DB)
- **Modo de Conexión**: managed

### Servicios WSDL
- **ValidaDepositoReferenciadoCB**: 
  - Endpoint: `http://172.23.13.19:8003/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB`
  - Operación: ValidaDepositoReferenciadoCB
- **DepositosReferenciados**:
  - Endpoint: `/Middleware/OperationsAndExecution/Payments/DepositosReferenciados`
  - Operación: validaDepositoReferenciado

## Tablas de Mapeo de Entrada

### Mapeo CB Request → Servicio Interno (DepositosReferenciados)

| Campo Origen (OSB CB) | Transformación/Script | Campo Destino (Servicio Interno) |
|----------------------|----------------------|----------------------------------|
| `val:validaDepositoReferenciadoCBRequest/ACCOUNT` | `fn:string()` | `vdr:validaDepositoReferenciado/ACCOUNT` |
| `val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/TYPE` | `fn:string()` | `vdr:validaDepositoReferenciado/DOCUMENT_INFO/TYPE` |
| `val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/VALUE` | `fn:string()` | `vdr:validaDepositoReferenciado/DOCUMENT_INFO/VALUE` |
| `$header` | Directo | `$REQHeaderValidaDepositoReferenciado` |

### Mapeo Servicio Interno → Base de Datos

| Campo Origen (Servicio Interno) | Transformación/Script | Campo Destino (Base de Datos) |
|--------------------------------|----------------------|-------------------------------|
| `dep1:validaDepositoReferenciado/ACCOUNT` | `data()` | `ns0:PV_NUMERO_CUENTA` |
| `dep1:validaDepositoReferenciado/DOCUMENT_INFO/TYPE` | `if ($tipoDocumento = "DEBTOR_CODE") then "1" else "2"` | `ns0:PV_TIPO_DOCUMENTO` |
| `dep1:validaDepositoReferenciado/DOCUMENT_INFO/VALUE` | `data()` | `ns0:PV_DOCUMENTO` |

## Tablas de Mapeo de Salida

### Mapeo Base de Datos → Servicio Interno

| Campo Origen (Base de Datos) | Transformación/Script | Campo Destino (Servicio Interno) |
|------------------------------|----------------------|----------------------------------|
| `vdrsp:PV_NUMERO_DOCUMENTO` | `data()` | `val:DOCUMENT_NUMBER` |
| `vdrsp:PV_CUENTA` | `data()` | `val:ACCOUNT` |
| `vdrsp:PT_CODIGO_DEUDOR/vdrsp:ITEM[$x]` | `for $x in 1 to fn:count()` | `val:DEBTOR_INFOS/DEBTOR_INFO/ID` |
| `vdrsp:PT_NOMBRE_DEUDOR/vdrsp:ITEM[$x]` | `for $x in 1 to fn:count()` | `val:DEBTOR_INFOS/DEBTOR_INFO/NAME` |

### Mapeo Servicio Interno → CB Response

| Campo Origen (Servicio Interno) | Transformación/Script | Campo Destino (OSB CB) |
|--------------------------------|----------------------|------------------------|
| `vdrrsp:DOCUMENT_NUMBER` | `data()` | `val:DOCUMENT_NUMBER` |
| `vdrrsp:ACCOUNT` | `data()` | `val:ACCOUNT` |
| `vdrrsp:DEBTOR_INFOS/DEBTOR_INFO/ID` | `data()` | `val:DEBTOR_INFO/ID` |
| `vdrrsp:DEBTOR_INFOS/DEBTOR_INFO/NAME` | `data()` | `val:DEBTOR_INFO/NAME` |

## Reglas de Negocio Detectadas

### 1. Validación de Campos Obligatorios
- **Ubicación**: ValidaDepositoReferenciadoCB.proxy - Pipeline "Validaciones Generales_request"
- **Regla**: 
  ```xquery
  if (fn:string($body/val:validaDepositoReferenciadoCBRequest/ACCOUNT/text()) = "") then
      Error("NO ACCOUNT", "La cuenta es necesaria")
  ```
- **Campos validados**: ACCOUNT, DOCUMENT_INFO/TYPE, DOCUMENT_INFO/VALUE

### 2. Mapeo de Tipo de Documento
- **Ubicación**: validaDepositoReferenciadoIN.xq
- **Regla**:
  ```xquery
  if ($tipoDocumento = "DEBTOR_CODE") then "1" else "2"
  ```
- **Descripción**: DEBTOR_CODE se mapea a tipo 1, otros tipos a tipo 2

### 3. Validación de Código de Retorno
- **Ubicación**: ValidaDepositoReferenciado.proxy - Pipeline "HN01_request"
- **Regla**:
  ```xquery
  if ($codigoValidaDeposito = "-1") then
      Error("NO RECORDS", "NO RECORDS FOUND")
  ```
- **Descripción**: Si el SP retorna -1, se considera que no hay registros

### 4. Construcción de Array de Deudores
- **Ubicación**: validaDepositoReferenciadoOUT.xq
- **Regla**:
  ```xquery
  for $x in 1 to fn:count($RSPValidaDepositoReferenciado/vdrsp:PT_CODIGO_DEUDOR/vdrsp:ITEM)
  return
      <DEBTOR_INFO>
          <ID>{ data($RSPValidaDepositoReferenciado/vdrsp:PT_CODIGO_DEUDOR/vdrsp:ITEM[$x]) }</ID>
          <NAME>{ data($RSPValidaDepositoReferenciado/vdrsp:PT_NOMBRE_DEUDOR/vdrsp:ITEM[$x]) }</NAME>
      </DEBTOR_INFO>
  ```
- **Descripción**: Correlación por índice entre códigos y nombres de deudores

### 5. Eliminación de Campo BankingCorrespondent
- **Ubicación**: ValidaDepositoReferenciadoCB.proxy - Pipeline "ValidaDepositoReferenciado_request"
- **Regla**:
  ```xml
  <con3:delete varName="header">
      <con3:location>
          <con:xpathText>./aut:RequestHeader/BankingCorrespondent</con:xpathText>
      </con3:location>
  </con3:delete>
  ```
- **Descripción**: Se elimina el campo BankingCorrespondent del header antes de llamar al servicio interno

### 6. Manejo Condicional de Respuesta
- **Ubicación**: ValidaDepositoReferenciadoCB.proxy - Pipeline "ValidaDepositoReferenciado_response"
- **Regla**:
  ```xquery
  if (fn:string($header/aut:ResponseHeader/successIndicator/text())='SUCCESS') then
      <!-- Aplicar transformación de salida -->
  else
      <!-- Retornar respuesta vacía -->
  ```
- **Descripción**: Solo se aplica la transformación de salida si el indicador de éxito es SUCCESS