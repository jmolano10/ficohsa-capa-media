# Ejemplos y Mapeos - GT01 (Guatemala)

## Request OSB (Ejemplo JSON/XML)

### SOAP Request
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:sol="http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_GT</UserName>
            <Password>PASSWORD_GT</Password>
         </Authentication>
         <Region>
            <SourceBank>GT01</SourceBank>
            <DestinationBank>GT01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <sol:solicitaFinanciamientoTC>
         <CUSTOMER_ID>1234567890123</CUSTOMER_ID>
         <CARD_NUMBER>5555555555554444</CARD_NUMBER>
         <EXPIRATION_DATE>0326</EXPIRATION_DATE>
         <TOTAL_AMOUNT>25000.00</TOTAL_AMOUNT>
         <CURRENCY>GTQ</CURRENCY>
         <NUMBER_OF_PAYMENTS>18</NUMBER_OF_PAYMENTS>
         <DISBURSEMENT_INFO>
            <TYPE>CASH</TYPE>
            <KV_PAIRS>
               <PAIR>
                  <KEY>ADDRESS</KEY>
                  <VALUE>Zona 10, Ciudad de Guatemala</VALUE>
               </PAIR>
            </KV_PAIRS>
         </DISBURSEMENT_INFO>
         <EMAIL_ADDRESS>cliente.gt@email.com</EMAIL_ADDRESS>
         <CREDIT_LINE>EXTERNAL</CREDIT_LINE>
         <TRANSACTION_ID>GTXN987654321</TRANSACTION_ID>
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
         <TRANSACTION_ID>GTXN987654321GT002</TRANSACTION_ID>
         <AMOUNT_REQUESTED>25000.00</AMOUNT_REQUESTED>
         <NUMBER_OF_PAYMENTS>18</NUMBER_OF_PAYMENTS>
         <MONTHLY_PAYMENT>1666.67</MONTHLY_PAYMENT>
         <MONTHLY_INTEREST_RATE>2.8</MONTHLY_INTEREST_RATE>
         <CURRENCY>GTQ</CURRENCY>
         <AVAILABLE_AMOUNT>24200.00</AVAILABLE_AMOUNT>
         <CHARGES>
            <CHARGE>
               <NAME>DISBURSEMENT</NAME>
               <VALUE>500.00</VALUE>
            </CHARGE>
            <CHARGE>
               <NAME>INSURANCE</NAME>
               <VALUE>300.00</VALUE>
            </CHARGE>
            <TOTAL>800.00</TOTAL>
         </CHARGES>
         <STATUS>APPROVED</STATUS>
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
         <messages>Cliente no tiene línea de crédito disponible</messages>
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
   <NOMBRE_PARAMETROS>FICBCO0269.DISBURSERATE.GT01||FICBCO0269.PRODUCTQUANTIFY.GT01</NOMBRE_PARAMETROS>
</ns0:obtenerParametrizacion>
```

#### Response
```xml
<ns0:obtenerParametrizacionResponse xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
   <CONFIGURACIONES>
      <CONFIGURACIONES_ITEM>
         <NAME>FICBCO0269.DISBURSERATE.GT01</NAME>
         <VALUE>1.5</VALUE>
      </CONFIGURACIONES_ITEM>
      <CONFIGURACIONES_ITEM>
         <NAME>FICBCO0269.PRODUCTQUANTIFY.GT01</NAME>
         <VALUE>FINANCIAMIENTO_TC</VALUE>
      </CONFIGURACIONES_ITEM>
   </CONFIGURACIONES>
   <ERROR_MESSAGE></ERROR_MESSAGE>
</ns0:obtenerParametrizacionResponse>
```

### 2. Consulta de Ofertas (Base de Datos BLAZEGT)

#### Request
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta">
   <ns0:Pv_Identidad>1234567890123</ns0:Pv_Identidad>
   <ns0:Pv_Linea>EXTERNAL</ns0:Pv_Linea>
</ns0:InputParameters>
```

#### Response
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta">
   <ns0:Pv_CodigoError>Success</ns0:Pv_CodigoError>
   <ns0:Pv_MensajeError></ns0:Pv_MensajeError>
   <ns0:RowSet>
      <ns0:Row>
         <ns0:Column name="Pn_Plazo">12</ns0:Column>
         <ns0:Column name="Pv_Moneda">GTQ</ns0:Column>
         <ns0:Column name="Pn_Monto">50000.00</ns0:Column>
         <ns0:Column name="Pn_Tasa">28.0</ns0:Column>
      </ns0:Row>
      <ns0:Row>
         <ns0:Column name="Pn_Plazo">18</ns0:Column>
         <ns0:Column name="Pv_Moneda">GTQ</ns0:Column>
         <ns0:Column name="Pn_Monto">75000.00</ns0:Column>
         <ns0:Column name="Pn_Tasa">30.0</ns0:Column>
      </ns0:Row>
      <ns0:Row>
         <ns0:Column name="Pn_Plazo">24</ns0:Column>
         <ns0:Column name="Pv_Moneda">GTQ</ns0:Column>
         <ns0:Column name="Pn_Monto">100000.00</ns0:Column>
         <ns0:Column name="Pn_Tasa">32.0</ns0:Column>
      </ns0:Row>
   </ns0:RowSet>
</ns0:OutputParameters>
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
      <USERNAME>user.gt@ficohsa.com</USERNAME>
      <PASSWORD>passwordGT456</PASSWORD>
      <SESSION>00D7F0000008gHq!ARMAQFJvn9876543210zyxwvu</SESSION>
   </SALESFORCE_INFO>
</ns0:loginSalesforceResponse>
```

### 4. Crear Gestión Extra (Salesforce Regional)

#### Request
```xml
<ns2:CrearExtra xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:Cliente>1234567890123</ns2:Cliente>
   <ns2:Plazo>18</ns2:Plazo>
   <ns2:Monto>25000.00</ns2:Monto>
   <ns2:TasaInteres>30.0</ns2:TasaInteres>
   <ns2:Moneda>GTQ</ns2:Moneda>
   <ns2:numTarjeta>5555555555554444</ns2:numTarjeta>
   <ns2:TipoDesembolso>CASH</ns2:TipoDesembolso>
   <ns2:Direccion>Zona 10, Ciudad de Guatemala</ns2:Direccion>
   <ns2:CorreoElectronico>cliente.gt@email.com</ns2:CorreoElectronico>
   <ns2:ComisionDesembolso>1.5</ns2:ComisionDesembolso>
   <ns2:ProductoCuotificar>FINANCIAMIENTO_TC</ns2:ProductoCuotificar>
   <ns2:Pais>Guatemala</ns2:Pais>
</ns2:CrearExtra>
```

#### Response
```xml
<ns2:CrearExtraResponse xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:result>
      <ns2:CodigoError>SUCCESS</ns2:CodigoError>
      <ns2:IdGestion>GT002</ns2:IdGestion>
      <ns2:cuotaMensual>1666.67</ns2:cuotaMensual>
      <ns2:tasaMensual>2.8</ns2:tasaMensual>
      <ns2:valorDesembolso>500.00</ns2:valorDesembolso>
      <ns2:valorSeguro>300.00</ns2:valorSeguro>
      <ns2:estadoGestion>APROBADO</ns2:estadoGestion>
   </ns2:result>
</ns2:CrearExtraResponse>
```

## Cadenas de Conexión y Credenciales

### Base de Datos - consultaOferta_db (Guatemala)
- **Nombre de BD**: BLAZEGT
- **Esquema**: BLAZEGT
- **Stored Procedure**: consultaOferta
- **Parámetros de Entrada**:
  - Pv_Identidad (VARCHAR2): ID del cliente
  - Pv_Linea (VARCHAR2): Línea de crédito
- **Parámetros de Salida**:
  - Pv_CodigoError (VARCHAR2): Código de resultado
  - Pv_MensajeError (VARCHAR2): Mensaje de error
  - RowSet: Conjunto de ofertas disponibles
- **Conexión**: `Middleware/v2/BusinessServices/BLAZEGT/consultaOferta/biz/consultaOferta_db`

### Salesforce - SalesforceRGNIngresaGestionExtra
- **Endpoint WSDL**: Configurado en Business Service Regional
- **Operación**: CrearExtra
- **Autenticación**: Session ID obtenido de LoginSalesforce
- **Conexión**: `Middleware/v2/BusinessServices/External/SalesforceRGNIngresaGestionExtra/biz/SalesforceRGNIngresaGestionExtra`

### Parametrización - ObtenerParametrizacion
- **Base de Datos**: ORA_BANK
- **Tabla/Vista**: OSB_GET_CONFIG
- **Parámetros Específicos GT01**:
  - FICBCO0269.DISBURSERATE.GT01
  - FICBCO0269.PRODUCTQUANTIFY.GT01
- **Conexión**: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`

## Tablas de Mapeo de Entrada

### Mapeo OSB → consultaOferta (Base de Datos BLAZEGT)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| CUSTOMER_ID | data($solicitaFinanciamientoTC/CUSTOMER_ID) | Pv_Identidad |
| CREDIT_LINE | data($solicitaFinanciamientoTC/CREDIT_LINE) | Pv_Linea |

**Archivo XQuery**: `consultaOfertaGTIn.xq`

### Mapeo OSB → CrearExtra (Salesforce Regional)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (Salesforce) |
|-------------------|----------------------|---------------------------|
| CUSTOMER_ID | data($solicitaFinanciamientoTC/CUSTOMER_ID) | Cliente |
| NUMBER_OF_PAYMENTS | xs:decimal(data($solicitaFinanciamientoTC/NUMBER_OF_PAYMENTS)) | Plazo |
| TOTAL_AMOUNT | data($solicitaFinanciamientoTC/TOTAL_AMOUNT) | Monto |
| $tasaInteres | $tasaInteres | TasaInteres |
| CURRENCY | data($solicitaFinanciamientoTC/CURRENCY) | Moneda |
| CARD_NUMBER | data($solicitaFinanciamientoTC/CARD_NUMBER) | numTarjeta |
| DISBURSEMENT_INFO/TYPE | data($solicitaFinanciamientoTC/DISBURSEMENT_INFO/TYPE) | TipoDesembolso |
| DISBURSEMENT_INFO/KV_PAIRS/PAIR[KEY='CREDIT_ACCOUNT']/VALUE | data($CREDIT_ACCOUNT) | CuentaCredito |
| DISBURSEMENT_INFO/KV_PAIRS/PAIR[KEY='ADDRESS']/VALUE | data($ADDRESS) | Direccion |
| EMAIL_ADDRESS | data($solicitaFinanciamientoTC/EMAIL_ADDRESS) | CorreoElectronico |
| $tasaDesembolso | data($tasaDesembolso) | ComisionDesembolso |
| $productoCuotificar | $productoCuotificar | ProductoCuotificar |
| Constante | "Guatemala" | Pais |

**Archivo XQuery**: `ingresaGestionExtraRGNGTIn.xq`

**Diferencia clave con HN01**: No usa parametrización para TipoDesembolso, toma el valor directamente del request.

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

**Archivo XQuery**: `solicitaFinanciamientoTCRGNGTOut.xq`

### Función de Mapeo de Estados (Idéntica a HN01)
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

**Lógica**: Misma validación que HN01 - verifica coincidencia de:
- Plazo solicitado (NUMBER_OF_PAYMENTS)
- Moneda solicitada (CURRENCY)
- Monto igual o mayor al solicitado (TOTAL_AMOUNT)

### 2. Cálculo de Tasa de Interés
**Ubicación**: Pipeline SolicitaFinanciamientoTCGT_request, stage AnalisisVasaVsSolicitudCliente

**Lógica XQuery** (Idéntica a HN01):
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
**Ubicación**: Error Handler `_onErrorHandler-1384382121503434113--426f75e4.16fa9cf67de.-4acc`

**Lógica**: 
- Detecta error que contiene "INVALID_SESSION_ID"
- Ejecuta login automático a Salesforce
- Reintenta la operación con nueva sesión
- Usa SalesforceRGNIngresaGestionExtra en lugar de SalesforceHNIngresaGestionExtra

### 4. Cálculo de Monto Disponible
**Ubicación**: `solicitaFinanciamientoTCRGNGTOut.xq`

**Fórmula** (Idéntica a HN01):
```xquery
<AVAILABLE_AMOUNT>
{
     $solicitaFinanciamientoTC/TOTAL_AMOUNT - sum( ($crearExtraResponse/ns1:result/ns1:valorSeguro, $crearExtraResponse/ns1:result/ns1:valorDesembolso))
}
</AVAILABLE_AMOUNT>
```

### 5. Parametrización Regional
**Ubicación**: Pipeline SolicitaFinanciamientoTCGT_request, stage ParametrizacionMiddleware

**Diferencia clave con HN01**:
```xquery
// Tasa de desembolso con sufijo regional
fn:concat('FICBCO0269.DISBURSERATE.',$header/aut:RequestHeader/Region/SourceBank/text())

// Producto con sufijo regional  
fn:concat('FICBCO0269.PRODUCTQUANTIFY.',$header/aut:RequestHeader/Region/SourceBank/text())
```

**No parametriza tipo de desembolso**: Usa directamente el valor del request en lugar de buscar parametrización.

### 6. Tipo de Desembolso Directo
**Ubicación**: `ingresaGestionExtraRGNGTIn.xq`

**Diferencia con HN01**:
```xquery
// GT01: Toma directamente del request
<ns2:TipoDesembolso>{ data($solicitaFinanciamientoTC/DISBURSEMENT_INFO/TYPE) }</ns2:TipoDesembolso>

// HN01: Usa parámetro configurado
<ns2:TipoDesembolso>{data( $tipoDesembolso) }</ns2:TipoDesembolso>
```

## Diferencias Específicas con HN01

### 1. Parametrización
- **GT01**: Parámetros con sufijo `.GT01`
- **GT01**: No parametriza tipo de desembolso
- **GT01**: Solo 2 parámetros vs 3 en HN01

### 2. Base de Datos
- **GT01**: BLAZEGT en lugar de VASA
- **GT01**: Esquema BLAZEGT en lugar de ProcesosHN

### 3. Salesforce
- **GT01**: SalesforceRGNIngresaGestionExtra (regional)
- **GT01**: País "Guatemala" en lugar de "Honduras"

### 4. Transformaciones
- **GT01**: Archivos XQuery específicos con sufijo GT o RGN
- **GT01**: Lógica simplificada para tipo de desembolso

### 5. Error Handling
- **GT01**: Error handler específico con ID diferente
- **GT01**: Misma lógica pero servicios diferentes