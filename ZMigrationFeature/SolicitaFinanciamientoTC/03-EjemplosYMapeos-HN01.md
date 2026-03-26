# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### SOAP Request
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:sol="http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_PRUEBA</UserName>
            <Password>PASSWORD_PRUEBA</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <sol:solicitaFinanciamientoTC>
         <CUSTOMER_ID>0801199012345</CUSTOMER_ID>
         <CARD_NUMBER>4111111111111111</CARD_NUMBER>
         <EXPIRATION_DATE>1225</EXPIRATION_DATE>
         <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
         <CURRENCY>HNL</CURRENCY>
         <NUMBER_OF_PAYMENTS>12</NUMBER_OF_PAYMENTS>
         <DISBURSEMENT_INFO>
            <TYPE>ACCOUNT_CREDIT</TYPE>
            <KV_PAIRS>
               <PAIR>
                  <KEY>CREDIT_ACCOUNT</KEY>
                  <VALUE>1234567890</VALUE>
               </PAIR>
               <PAIR>
                  <KEY>ADDRESS</KEY>
                  <VALUE>Colonia Palmira, Tegucigalpa</VALUE>
               </PAIR>
            </KV_PAIRS>
         </DISBURSEMENT_INFO>
         <EMAIL_ADDRESS>cliente@email.com</EMAIL_ADDRESS>
         <CREDIT_LINE>INTERNAL</CREDIT_LINE>
         <TRANSACTION_ID>TXN123456789</TRANSACTION_ID>
      </sol:solicitaFinanciamientoTC>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response Exitoso
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:sol="http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <sol:solicitaFinanciamientoTCResponse>
         <TRANSACTION_ID>TXN123456789SF001</TRANSACTION_ID>
         <AMOUNT_REQUESTED>50000.00</AMOUNT_REQUESTED>
         <NUMBER_OF_PAYMENTS>12</NUMBER_OF_PAYMENTS>
         <MONTHLY_PAYMENT>4583.33</MONTHLY_PAYMENT>
         <MONTHLY_INTEREST_RATE>2.5</MONTHLY_INTEREST_RATE>
         <CURRENCY>HNL</CURRENCY>
         <AVAILABLE_AMOUNT>48500.00</AVAILABLE_AMOUNT>
         <CHARGES>
            <CHARGE>
               <NAME>DISBURSEMENT</NAME>
               <VALUE>1000.00</VALUE>
            </CHARGE>
            <CHARGE>
               <NAME>INSURANCE</NAME>
               <VALUE>500.00</VALUE>
            </CHARGE>
            <TOTAL>1500.00</TOTAL>
         </CHARGES>
         <STATUS>PENDING</STATUS>
      </sol:solicitaFinanciamientoTCResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### SOAP Response Error
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:sol="http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messages>No hay ofertas disponibles para el monto y plazo solicitado</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <sol:solicitaFinanciamientoTCResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta de Parametrización

#### Request
```xml
<ns0:obtenerParametrizacion xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
   <NOMBRE_PARAMETROS>FICBCO0269.DISBURSERATE||FICBCO0269.PRODUCTQUANTIFY||FICBCO0269.DISBURSEMENTYPE.ACCOUNT_CREDIT</NOMBRE_PARAMETROS>
</ns0:obtenerParametrizacion>
```

#### Response
```xml
<ns0:obtenerParametrizacionResponse xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
   <CONFIGURACIONES>
      <CONFIGURACIONES_ITEM>
         <NAME>FICBCO0269.DISBURSERATE</NAME>
         <VALUE>2.0</VALUE>
      </CONFIGURACIONES_ITEM>
      <CONFIGURACIONES_ITEM>
         <NAME>FICBCO0269.PRODUCTQUANTIFY</NAME>
         <VALUE>EXTRAFINANCIAMIENTO</VALUE>
      </CONFIGURACIONES_ITEM>
      <CONFIGURACIONES_ITEM>
         <NAME>FICBCO0269.DISBURSEMENTYPE.ACCOUNT_CREDIT</NAME>
         <VALUE>CREDITO_CUENTA</VALUE>
      </CONFIGURACIONES_ITEM>
   </CONFIGURACIONES>
   <ERROR_MESSAGE></ERROR_MESSAGE>
</ns0:obtenerParametrizacionResponse>
```

### 2. Consulta de Ofertas (Base de Datos)

#### Request
```xml
<ns1:InputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta">
   <ns1:Pv_Identidad>0801199012345</ns1:Pv_Identidad>
   <ns1:Pv_Linea>INTERNAL</ns1:Pv_Linea>
</ns1:InputParameters>
```

#### Response
```xml
<ns1:OutputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta">
   <ns1:Pv_CodigoError>Success</ns1:Pv_CodigoError>
   <ns1:Pv_MensajeError></ns1:Pv_MensajeError>
   <ns1:RowSet>
      <ns1:Row>
         <ns1:Column name="Pn_Plazo">12</ns1:Column>
         <ns1:Column name="Pv_Moneda">HNL</ns1:Column>
         <ns1:Column name="Pn_Monto">100000.00</ns1:Column>
         <ns1:Column name="Pn_Tasa">30.0</ns1:Column>
      </ns1:Row>
      <ns1:Row>
         <ns1:Column name="Pn_Plazo">24</ns1:Column>
         <ns1:Column name="Pv_Moneda">HNL</ns1:Column>
         <ns1:Column name="Pn_Monto">100000.00</ns1:Column>
         <ns1:Column name="Pn_Tasa">32.0</ns1:Column>
      </ns1:Row>
   </ns1:RowSet>
</ns1:OutputParameters>
```

### 3. Login Salesforce

#### Request
```xml
<ns0:loginSalesforce xmlns:ns0="http://www.ficohsa.com.hn/middleware.services/loginSalesforceTypes">
   <username></username>
   <password></password>
   <createNewSession>false</createNewSession>
</ns0:loginSalesforce>
```

#### Response
```xml
<ns0:loginSalesforceResponse xmlns:ns0="http://www.ficohsa.com.hn/middleware.services/loginSalesforceTypes">
   <SALESFORCE_INFO>
      <USERNAME>user@ficohsa.com</USERNAME>
      <PASSWORD>password123</PASSWORD>
      <SESSION>00D7F0000008gHq!ARMAQFJvn1234567890abcdef</SESSION>
   </SALESFORCE_INFO>
</ns0:loginSalesforceResponse>
```

### 4. Crear Gestión Extra (Salesforce)

#### Request
```xml
<ns2:CrearExtra xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:Cliente>0801199012345</ns2:Cliente>
   <ns2:Plazo>12</ns2:Plazo>
   <ns2:Monto>50000.00</ns2:Monto>
   <ns2:TasaInteres>30.0</ns2:TasaInteres>
   <ns2:Moneda>HNL</ns2:Moneda>
   <ns2:numTarjeta>4111111111111111</ns2:numTarjeta>
   <ns2:TipoDesembolso>CREDITO_CUENTA</ns2:TipoDesembolso>
   <ns2:CuentaCredito>1234567890</ns2:CuentaCredito>
   <ns2:Direccion>Colonia Palmira, Tegucigalpa</ns2:Direccion>
   <ns2:CorreoElectronico>cliente@email.com</ns2:CorreoElectronico>
   <ns2:ComisionDesembolso>2.0</ns2:ComisionDesembolso>
   <ns2:ProductoCuotificar>EXTRAFINANCIAMIENTO</ns2:ProductoCuotificar>
   <ns2:Pais>Honduras</ns2:Pais>
</ns2:CrearExtra>
```

#### Response
```xml
<ns2:CrearExtraResponse xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:result>
      <ns2:CodigoError>SUCCESS</ns2:CodigoError>
      <ns2:IdGestion>SF001</ns2:IdGestion>
      <ns2:cuotaMensual>4583.33</ns2:cuotaMensual>
      <ns2:tasaMensual>2.5</ns2:tasaMensual>
      <ns2:valorDesembolso>1000.00</ns2:valorDesembolso>
      <ns2:valorSeguro>500.00</ns2:valorSeguro>
      <ns2:estadoGestion>EN PROCESO</ns2:estadoGestion>
   </ns2:result>
</ns2:CrearExtraResponse>
```

## Cadenas de Conexión y Credenciales

### Base de Datos - consultaOferta_db
- **Nombre de BD**: VASA
- **Esquema**: ProcesosHN
- **Stored Procedure**: consultaOferta
- **Parámetros de Entrada**:
  - Pv_Identidad (VARCHAR2): ID del cliente
  - Pv_Linea (VARCHAR2): Línea de crédito
- **Parámetros de Salida**:
  - Pv_CodigoError (VARCHAR2): Código de resultado
  - Pv_MensajeError (VARCHAR2): Mensaje de error
  - RowSet: Conjunto de ofertas disponibles
- **Conexión**: `Middleware/v2/BusinessServices/ProcesosHN/consultaOferta/biz/consultaOferta_db`

### Salesforce - SalesforceHNIngresaGestionExtra
- **Endpoint WSDL**: Configurado en Business Service
- **Operación**: CrearExtra
- **Autenticación**: Session ID obtenido de LoginSalesforce
- **Conexión**: `Middleware/v2/BusinessServices/External/SalesforceHNIngresaGestionExtra/biz/SalesforceHNIngresaGestionExtra`

### Parametrización - ObtenerParametrizacion
- **Base de Datos**: ORA_BANK
- **Tabla/Vista**: OSB_GET_CONFIG
- **Conexión**: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`

## Tablas de Mapeo de Entrada

### Mapeo OSB → consultaOferta (Base de Datos)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| CUSTOMER_ID | data($solicitaFinanciamientoTC/CUSTOMER_ID) | Pv_Identidad |
| CREDIT_LINE | data($solicitaFinanciamientoTC/CREDIT_LINE) | Pv_Linea |

**Archivo XQuery**: `consultaOfertaIn.xq`

### Mapeo OSB → CrearExtra (Salesforce)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (Salesforce) |
|-------------------|----------------------|---------------------------|
| CUSTOMER_ID | data($solicitaFinanciamientoTC/CUSTOMER_ID) | Cliente |
| NUMBER_OF_PAYMENTS | xs:integer(data($solicitaFinanciamientoTC/NUMBER_OF_PAYMENTS)) | Plazo |
| TOTAL_AMOUNT | xs:decimal(data($solicitaFinanciamientoTC/TOTAL_AMOUNT)) | Monto |
| $tasaInteres | xs:decimal(data($tasaInteres)) | TasaInteres |
| CURRENCY | data($solicitaFinanciamientoTC/CURRENCY) | Moneda |
| CARD_NUMBER | data($solicitaFinanciamientoTC/CARD_NUMBER) | numTarjeta |
| $tipoDesembolso | data($tipoDesembolso) | TipoDesembolso |
| DISBURSEMENT_INFO/KV_PAIRS/PAIR[KEY='CREDIT_ACCOUNT']/VALUE | data($CREDIT_ACCOUNT) | CuentaCredito |
| DISBURSEMENT_INFO/KV_PAIRS/PAIR[KEY='ADDRESS']/VALUE | data($ADDRESS) | Direccion |
| EMAIL_ADDRESS | data($solicitaFinanciamientoTC/EMAIL_ADDRESS) | CorreoElectronico |
| $tasaDesembolso | xs:decimal(data($tasaDesembolso)) | ComisionDesembolso |
| $productoCuotificar | $productoCuotificar | ProductoCuotificar |
| Constante | "Honduras" | Pais |

**Archivo XQuery**: `ingresaGestionExtraIn.xq`

## Tablas de Mapeo de Salida

### Mapeo CrearExtraResponse (Salesforce) → OSB Response
| Campo Origen (Salesforce) | Transformación/Script | Campo Destino (OSB) |
|---------------------------|----------------------|-------------------|
| IdGestion | concat($solicitaFinanciamientoTC/TRANSACTION_ID, $IdGestion) | TRANSACTION_ID |
| $solicitaFinanciamientoTC/TOTAL_AMOUNT | data($solicitaFinanciamientoTC/TOTAL_AMOUNT) | AMOUNT_REQUESTED |
| $solicitaFinanciamientoTC/NUMBER_OF_PAYMENTS | data($solicitaFinanciamientoTC/NUMBER_OF_PAYMENTS) | NUMBER_OF_PAYMENTS |
| cuotaMensual | data($cuotaMensual) | MONTHLY_PAYMENT |
| tasaMensual | data($tasaMensual) | MONTHLY_INTEREST_RATE |
| $solicitaFinanciamientoTC/CURRENCY | data($solicitaFinanciamientoTC/CURRENCY) | CURRENCY |
| Cálculo | $solicitaFinanciamientoTC/TOTAL_AMOUNT - sum(valorSeguro, valorDesembolso) | AVAILABLE_AMOUNT |
| valorDesembolso | data($valorDesembolso) | CHARGES/CHARGE[NAME='DISBURSEMENT']/VALUE |
| valorSeguro | data($valorSeguro) | CHARGES/CHARGE[NAME='INSURANCE']/VALUE |
| Cálculo | sum(valorSeguro, valorDesembolso) | CHARGES/TOTAL |
| estadoGestion | getMessageStatus(data($estadoGestion)) | STATUS |

**Archivo XQuery**: `solicitaFinanciamientoTCOut.xq`

### Función de Mapeo de Estados
```xquery
declare function getMessageStatus($messageStatus as xs:string) 
as xs:string{
    if (upper-case($messageStatus) = ("EN PROCESO","INGRESADA")) then ("PENDING") else
    if (upper-case($messageStatus) = "APROBADO") then ("APPROVED") else 
    "REJECTED"
};
```

## Reglas de Negocio Detectadas

### 1. Validación de Condiciones Crediticias
**Ubicación**: `Middleware/v2/Resources/SolicitudFinanciamientoTC/xq/validaCondicionesCredito.xq`

**Lógica**: Valida que exista una oferta que coincida con:
- Plazo solicitado (NUMBER_OF_PAYMENTS)
- Moneda solicitada (CURRENCY)
- Monto igual o mayor al solicitado (TOTAL_AMOUNT)

### 2. Cálculo de Tasa de Interés
**Ubicación**: Pipeline SolicitaFinanciamientoTC_request, stage AnalisisVasaVsSolicitudCliente

**Lógica XQuery**:
```xquery
let $numberOfPayments := string($body/sol:solicitaFinanciamientoTC/NUMBER_OF_PAYMENTS/text())
let $totalAmount := string($body/sol:solicitaFinanciamientoTC/TOTAL_AMOUNT/text())
let $currency := string($body/sol:solicitaFinanciamientoTC/CURRENCY/text())
for $row at $i in $RSPconsultaOferta/con:RowSet/con:Row 
    where $row/con:Column[@name='Pn_Plazo' and text() = $numberOfPayments] 
          and $row/con:Column[@name='Pv_Moneda' and text() = $currency]
          and $row/con:Column[@name='Pn_Monto' and number(text()) >= number($totalAmount)]
          return fn:string($row/con:Column[@name='Pn_Tasa']/text())
```

### 3. Manejo de Sesiones Salesforce
**Ubicación**: Error Handlers en pipelines

**Lógica**: 
- Detecta error `INVALID_SESSION_ID`
- Ejecuta login automático a Salesforce
- Reintenta la operación con nueva sesión
- Implementa patrón retry automático

### 4. Cálculo de Monto Disponible
**Ubicación**: `solicitaFinanciamientoTCOut.xq`

**Fórmula**:
```xquery
<AVAILABLE_AMOUNT>
{
     $solicitaFinanciamientoTC/TOTAL_AMOUNT - sum( ($crearExtraResponse/ns1:result/ns1:valorSeguro, $crearExtraResponse/ns1:result/ns1:valorDesembolso))
}
</AVAILABLE_AMOUNT>
```

### 5. Parametrización Dinámica de Tipo Desembolso
**Ubicación**: Pipeline SolicitaFinanciamientoTC_request, stage ParametrizacionMiddleware

**Lógica**:
```xquery
fn:concat('FICBCO0269.DISBURSEMENTYPE.',fn:upper-case($body/sol:solicitaFinanciamientoTC/DISBURSEMENT_INFO/TYPE/text()))
```

Construye dinámicamente el nombre del parámetro basado en el tipo de desembolso del request.