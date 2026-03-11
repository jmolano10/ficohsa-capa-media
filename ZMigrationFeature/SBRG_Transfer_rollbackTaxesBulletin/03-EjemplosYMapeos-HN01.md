# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## 1. Request OSB (SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:tran="https://www.ficohsa.com/regional/transfer/transferTypes"
                  xmlns:com="https://www.ficohsa.com/regional/common/commonTypes">
   <soapenv:Header/>
   <soapenv:Body>
      <tran:rollbackTaxesBullletin>
         <GeneralInfo>
            <com:SourceBank>HN01</com:SourceBank>
            <com:DestinationBank>HN01</com:DestinationBank>
            <com:GlobalId>550e8400-e29b-41d4-a716-446655440000</com:GlobalId>
            <com:ApplicationId>MOBILE_BANKING</com:ApplicationId>
            <com:ApplicationUser>user.test</com:ApplicationUser>
            <com:BranchId>001</com:BranchId>
            <com:TransactionDate>2024-01-15</com:TransactionDate>
            <com:Language>ES</com:Language>
         </GeneralInfo>
         <TransactionId>FT24001123456</TransactionId>
      </tran:rollbackTaxesBullletin>
   </soapenv:Body>
</soapenv:Envelope>
```

## 2. Request OSB (REST/JSON)

```json
{
  "rollbackTaxesBullletin": {
    "GeneralInfo": {
      "SourceBank": "HN01",
      "DestinationBank": "HN01",
      "GlobalId": "550e8400-e29b-41d4-a716-446655440000",
      "ApplicationId": "MOBILE_BANKING",
      "ApplicationUser": "user.test",
      "BranchId": "001",
      "TransactionDate": "2024-01-15",
      "Language": "ES"
    },
    "TransactionId": "FT24001123456"
  }
}
```

## 3. Request Interno a T24 (Transformado)

```xml
<ns3:rollbackTaxesBulletin xmlns:ns3="T24WebServicesImpl">
   <WebRequestCommon>
      <userName>T24_MOBILE_BANKING</userName>
      <password>encrypted_password_from_ldap</password>
      <company></company>
   </WebRequestCommon>
   <FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
      <transactionId>FT24001123456</transactionId>
   </FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
</ns3:rollbackTaxesBulletin>
```

## 4. Response de T24 (Exitoso)

```xml
<ns1:rollbackTaxesBulletinResponse xmlns:ns1="T24WebServicesImpl">
   <Status>
      <transactionId>FT24001123456</transactionId>
      <messageId>MSG-2024-001</messageId>
      <successIndicator>Success</successIndicator>
      <application>FUNDS.TRANSFER</application>
      <messages>Transaction reversed successfully</messages>
   </Status>
   <FUNDSTRANSFERType id="FT24001123456">
      <REVERSALMKR>Y</REVERSALMKR>
      <RECORDSTATUS>RNAU</RECORDSTATUS>
   </FUNDSTRANSFERType>
</ns1:rollbackTaxesBulletinResponse>
```

## 5. Response OSB (SOAP - Exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:tran="https://www.ficohsa.com/regional/transfer/transferTypes">
   <soapenv:Header/>
   <soapenv:Body>
      <tran:rollbackTaxesBullletinResponse>
         <StatusInfo>
            <Status>Success</Status>
            <ValueDate>2024-01-15</ValueDate>
            <DateTime>2024-01-15T10:30:45</DateTime>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
         </StatusInfo>
         <ErrorInfo/>
      </tran:rollbackTaxesBullletinResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## 6. Response de T24 (Error)

```xml
<ns1:rollbackTaxesBulletinResponse xmlns:ns1="T24WebServicesImpl">
   <Status>
      <transactionId></transactionId>
      <messageId>ERR-2024-001</messageId>
      <successIndicator>T24Error</successIndicator>
      <application>FUNDS.TRANSFER</application>
      <messages>Transaction not found or already reversed</messages>
   </Status>
</ns1:rollbackTaxesBulletinResponse>
```

## 7. Response OSB (SOAP - Error)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:tran="https://www.ficohsa.com/regional/transfer/transferTypes">
   <soapenv:Header/>
   <soapenv:Body>
      <tran:rollbackTaxesBullletinResponse>
         <StatusInfo>
            <Status>T24Error</Status>
            <TransactionId></TransactionId>
            <ValueDate>2024-01-15</ValueDate>
            <DateTime>2024-01-15T10:30:45</DateTime>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
         </StatusInfo>
         <ErrorInfo>
            <Code>TRF-404</Code>
            <Error>TRANSACTION_NOT_FOUND</Error>
            <Description>La transacción no fue encontrada o ya fue reversada</Description>
            <ShortDescription>Transacción no encontrada</ShortDescription>
            <DateTime>2024-01-15T10:30:45</DateTime>
            <GlobalId>550e8400-e29b-41d4-a716-446655440000</GlobalId>
            <Details>
               <SystemId>T24</SystemId>
               <SystemStatus>T24Error</SystemStatus>
               <MessageId>T24Error</MessageId>
               <Messages>Transaction not found or already reversed</Messages>
            </Details>
         </ErrorInfo>
      </tran:rollbackTaxesBullletinResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 8. Cadenas de Conexión y Credenciales

### Conexión a T24
- **Tipo**: SOAP Web Service
- **URL**: http://172.23.13.19:7003/RollbackTaxesBulletin/services
- **Puerto**: T24WebServicesImplPort
- **Namespace**: T24WebServicesImpl
- **Operación**: rollbackTaxesBulletin
- **WSDL**: ReversarTransaccion.wsdl
- **Método**: POST
- **Content-Type**: text/xml; charset=utf-8
- **SOAPAction**: rollbackTaxesBulletin

### Credenciales LDAP
- **Patrón**: `SB_Security/Common/{ApplicationId en mayúsculas}`
- **Ejemplo**: `SB_Security/Common/MOBILE_BANKING`
- **Función**: fn-bea:lookupBasicCredentials()
- **Extracción**: ExtractCredentials.xqy
- **Campos obtenidos**:
  - username: Usuario T24
  - password: Contraseña T24 (encriptada en LDAP)

---

## 9. Tablas de Mapeo de Entrada (OSB → T24)

### Mapeo Principal
| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|---------------------|
| `rollbackTaxesBullletin/TransactionId` | Directo | `rollbackTaxesBulletin/FUNDSTRANSFERREFCOLLACTRFREVCOPYType/transactionId` |
| `rollbackTaxesBullletin/GeneralInfo/ApplicationId` | Extracción LDAP: `fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($ApplicationId)))` → username | `rollbackTaxesBulletin/WebRequestCommon/userName` |
| `rollbackTaxesBullletin/GeneralInfo/ApplicationId` | Extracción LDAP: `fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($ApplicationId)))` → password | `rollbackTaxesBulletin/WebRequestCommon/password` |
| N/A | Constante: cadena vacía | `rollbackTaxesBulletin/WebRequestCommon/company` |

**Archivo de transformación**: `RollbackTaxesBulletinToT24.xqy`

**Fragmento de código**:
```xquery
<ns3:rollbackTaxesBulletin>
    <WebRequestCommon>
        <userName>{fn:data($userConnInfo/ns2:username)}</userName>
        <password>{fn:data($userConnInfo/ns2:password)}</password>
        <company></company>
    </WebRequestCommon>
    <FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
        <transactionId>{fn:data($input/TransactionId)}</transactionId>
    </FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
</ns3:rollbackTaxesBulletin>
```

---

## 10. Tablas de Mapeo de Salida (T24 → OSB - Caso Exitoso)

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|---------------------|
| `rollbackTaxesBulletinResponse/Status/successIndicator` | Directo (si existe) | `rollbackTaxesBullletinResponse/StatusInfo/Status` |
| N/A | Función: `fn:substring(fn:string(fn:current-dateTime()),0,11)` | `rollbackTaxesBullletinResponse/StatusInfo/ValueDate` |
| N/A | Función: `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `rollbackTaxesBullletinResponse/StatusInfo/DateTime` |
| `$globalId` (parámetro del request original) | Directo | `rollbackTaxesBullletinResponse/StatusInfo/GlobalId` |

**Archivo de transformación**: `T24ToRollbackTaxesBulletin.xqy`

**Fragmento de código**:
```xquery
<ns2:rollbackTaxesBullletinResponse>
    <StatusInfo>
        {
            if ($coreResponse/Status/successIndicator)
            then <Status>{fn:data($coreResponse/Status/successIndicator)}</Status>
            else ()
        }
        <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
        <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
        <GlobalId>{fn:data($globalId)}</GlobalId>
    </StatusInfo>  
</ns2:rollbackTaxesBullletinResponse>
```

---

## 11. Tablas de Mapeo de Salida (Error → OSB)

| Campo Origen | Transformación/Script | Campo Destino (OSB) |
|-------------|----------------------|---------------------|
| `$status` (parámetro) | Directo | `rollbackTaxesBullletinResponse/StatusInfo/Status` |
| N/A | Constante: cadena vacía | `rollbackTaxesBullletinResponse/StatusInfo/TransactionId` |
| N/A | Función: `fn:substring(fn:string(fn:current-dateTime()),0,11)` | `rollbackTaxesBullletinResponse/StatusInfo/ValueDate` |
| N/A | Función: `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `rollbackTaxesBullletinResponse/StatusInfo/DateTime` |
| `$globalId` (parámetro) | Directo | `rollbackTaxesBullletinResponse/StatusInfo/GlobalId` |
| `$responseError/ns1:code` | Directo desde servicio de mapeo | `rollbackTaxesBullletinResponse/ErrorInfo/Code` |
| `$responseError/ns1:error` | Directo desde servicio de mapeo | `rollbackTaxesBullletinResponse/ErrorInfo/Error` |
| `$responseError/ns1:description` | Directo desde servicio de mapeo | `rollbackTaxesBullletinResponse/ErrorInfo/Description` |
| `$responseError/ns1:shortDescription` | Directo desde servicio de mapeo | `rollbackTaxesBullletinResponse/ErrorInfo/ShortDescription` |
| N/A | Función: `fn:substring(fn:string(fn:current-dateTime()),0,20)` | `rollbackTaxesBullletinResponse/ErrorInfo/DateTime` |
| `$globalId` (parámetro) | Directo | `rollbackTaxesBullletinResponse/ErrorInfo/GlobalId` |
| `$targetSystem` (parámetro) | Directo | `rollbackTaxesBullletinResponse/ErrorInfo/Details/SystemId` |
| `$status` (parámetro) | Directo | `rollbackTaxesBullletinResponse/ErrorInfo/Details/SystemStatus` |
| `$codeError` (parámetro) | Directo | `rollbackTaxesBullletinResponse/ErrorInfo/Details/MessageId` |
| `$messageError` (parámetro) | Directo | `rollbackTaxesBullletinResponse/ErrorInfo/Details/Messages` |

**Archivo de transformación**: `ErrorToRollbackTaxesBulletin.xqy`

**Fragmento de código**:
```xquery
<ns2:rollbackTaxesBullletinResponse>
    <StatusInfo>
        <Status>{fn:data($status)}</Status>
        <TransactionId></TransactionId>
        <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
        <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
        <GlobalId>{fn:data($globalId)}</GlobalId>
    </StatusInfo>
    <ErrorInfo>
        <Code>{fn:data($responseError/ns1:code)}</Code>
        <Error>{fn:data($responseError/ns1:error)}</Error>
        <Description>{fn:data($responseError/ns1:description)}</Description>
        <ShortDescription>{fn:data($responseError/ns1:shortDescription)}</ShortDescription>
        <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
        <GlobalId>{fn:data($globalId)}</GlobalId>
        <Details>
            <SystemId>{fn:data($targetSystem)}</SystemId>
            <SystemStatus>{fn:data($status)}</SystemStatus>
            <MessageId>{fn:data($codeError)}</MessageId>
            <Messages>{fn:data($messageError)}</Messages>
        </Details>
    </ErrorInfo>
</ns2:rollbackTaxesBullletinResponse>
```

---

## 12. Reglas de Negocio Detectadas

### Regla 1: Extracción de Credenciales desde LDAP
- **Ubicación**: `SBHN_Transfer_Commons/Transformations/ExtractCredentials.xqy`
- **Descripción**: Obtiene credenciales de T24 desde LDAP basándose en el ApplicationId
- **Lógica**:
  ```xquery
  declare function fic:getUsername ($LDAPId as xs:string) as xs:string { 
      let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))
      return $data/con:username/text()
  };
  
  declare function fic:getPassword ($LDAPId as xs:string) as xs:string {      
      let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPId)))
      return $data/con:password/text()
  };
  ```
- **Failover**: Si no encuentra credenciales, usa el ApplicationId directamente
  ```xquery
  <ns1:username>{fn-bea:fail-over(fic:getUsername(data($account/ns1:userLogin)), data($account/ns1:userLogin))}</ns1:username>
  ```

### Regla 2: Evaluación de Éxito de Transacción
- **Ubicación**: `SBHN_Transfer_RollbackTaxesBullletin/PP/RollbackTaxesBulletinPP.pipeline` (StageTargetSystemToRegional)
- **Descripción**: Determina si la reversión fue exitosa
- **Condición**: `$codeErrorService = 'Success'`
- **Fragmento**:
  ```xml
  <con1:ifThenElse>
      <con1:case>
          <con1:condition>
              <con2:xqueryText>$codeErrorService= 'Success'</con2:xqueryText>
          </con1:condition>
          <con1:actions>
              <!-- Transformación exitosa -->
          </con1:actions>
      </con1:case>
      <con1:default>
          <!-- Manejo de error -->
      </con1:default>
  </con1:ifThenElse>
  ```

### Regla 3: Generación de Fechas
- **Ubicación**: `SBHN_Transfer_RollbackTaxesBullletin/Transformations/T24ToRollbackTaxesBulletin.xqy`
- **Descripción**: Genera fechas actuales para la respuesta
- **ValueDate**: Extrae primeros 10 caracteres de dateTime (YYYY-MM-DD)
  ```xquery
  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
  ```
- **DateTime**: Extrae primeros 19 caracteres de dateTime (YYYY-MM-DDTHH:mm:ss)
  ```xquery
  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
  ```

### Regla 4: Ocultamiento de Datos Sensibles en Logs
- **Ubicación**: `SBHN_Transfer_Commons/PP/TransferHondurasFicohsaTemplate.ptx` (StageLoggingInput)
- **Descripción**: Si la variable `$security = 'Y'`, oculta el request en los logs
- **Fragmento**:
  ```xml
  <con1:ifThenElse>
      <con1:case>
          <con1:condition>
              <con2:xqueryText>$security= 'Y'</con2:xqueryText>
          </con1:condition>
          <con1:actions>
              <con1:replace varName="requestServiceOri" contents-only="true">
                  <con1:expr>
                      <con2:xqueryText>''</con2:xqueryText>
                  </con1:expr>
              </con1:replace>
          </con1:actions>
      </con1:case>
  </con1:ifThenElse>
  ```
- **Nota**: En RollbackTaxesBulletinPP, `$security` se asigna como 'Y', por lo que los requests se ocultan en logs

### Regla 5: Mapeo de Errores Regionales
- **Ubicación**: Invocación a `GetCustomErrorByStackTraceRegionalRestBS`
- **Descripción**: Traduce errores de T24 a códigos y mensajes regionales
- **Parámetros**:
  - `systemApplication`: 'T24'
  - `service`: 'Transfer/RollbackTaxesBulletin'
  - `errorMessage`: Mensaje de error de T24
  - `errorCode`: Código de error de T24
  - `language`: Idioma del request (ES/EN)
- **Ubicación en pipeline**: StageTargetSystemToRegional (rama default del ifThenElse)

### Regla 6: Asignación de Variables de Contexto
- **Ubicación**: `SBHN_Transfer_RollbackTaxesBullletin/PP/RollbackTaxesBulletinPP.pipeline` (action-override)
- **Descripción**: Asigna valores constantes para el contexto de la operación
- **Variables**:
  ```xml
  service = 'Transfer/RollbackTaxesBulletin'
  version = 'v1'
  key = 'TransactionId'
  value = data($body/tran:rollbackTaxesBullletin/TransactionId/text())
  method = 'SOAP'
  operationTargetSystem = 'Reversionpagorecaudorefdbcta'
  targetSystem = 'T24'
  security = 'Y'
  ```

### Regla 7: Preservación del GlobalId
- **Ubicación**: Todas las transformaciones
- **Descripción**: El GlobalId del request original se preserva en todas las respuestas para trazabilidad
- **Implementación**: Se pasa como parámetro `$globalId` a las transformaciones de salida
- **Extracción**: `data($originalBody//GeneralInfo/GlobalId)`
