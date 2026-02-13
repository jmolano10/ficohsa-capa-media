# Ejemplos y Mapeos - HN01 (Honduras)

## Contexto

**ConInfoLealtad** es un Business Service (Stored Procedure SQL Server) usado exclusivamente en Honduras dentro del flujo de **ConsultaPuntosLealtad**. Se invoca cuando el cliente consulta puntos usando un número de tarjeta en lugar de su identificación legal.

---

## Request OSB (Interno - desde Pipeline)

```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoLealtad">
    <ns0:NumeroTarjeta>4111111111111111</ns0:NumeroTarjeta>
    <ns0:Pais>HND</ns0:Pais>
</ns0:InputParameters>
```

**Origen de Datos:**
- `NumeroTarjeta`: `$body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE` (del request original del cliente)
- `Pais`: Convertido de `$header/aut:RequestHeader/Region/SourceBank` (HN01) a ISO3 (HND) mediante `convertirCodigoPais`

---

## Response OSB (Interno - desde Stored Procedure)

### Caso Exitoso

```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoLealtad">
    <ns0:RowSet>
        <ns0:Row>
            <ns0:Column name="LEGALID" sqltype="VARCHAR">0801199012345</ns0:Column>
            <ns0:Column name="CUSTOMERNAME" sqltype="VARCHAR">JUAN CARLOS PEREZ LOPEZ</ns0:Column>
            <ns0:Column name="CARDTYPE" sqltype="VARCHAR">CREDIT</ns0:Column>
            <ns0:Column name="LOGO" sqltype="VARCHAR">625</ns0:Column>
        </ns0:Row>
    </ns0:RowSet>
    <ns0:CodigoError>-1</ns0:CodigoError>
    <ns0:MensajeError></ns0:MensajeError>
</ns0:OutputParameters>
```

### Caso con Error

```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoLealtad">
    <ns0:RowSet/>
    <ns0:CodigoError>1001</ns0:CodigoError>
    <ns0:MensajeError>Tarjeta no encontrada en el sistema</ns0:MensajeError>
</ns0:OutputParameters>
```

---

## Cadenas de Conexión

### Base de Datos SQL Server

- **Tipo**: SQL Server Database
- **JNDI**: `eis/DB/ConnectionProcesosHN`
- **Schema**: `dbo`
- **Stored Procedure**: `OSBConInfoLealtad`
- **Business Service**: `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/biz/conInfoLealtad_db`
- **JCA File**: `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/jca/conInfoLealtad_db.jca`
- **Package**: `dbo` (default schema SQL Server)

**Parámetros del Stored Procedure:**
```sql
EXEC dbo.OSBConInfoLealtad 
    @NumeroTarjeta = '4111111111111111',
    @Pais = 'HND',
    @CodigoError = NULL OUTPUT,
    @MensajeError = NULL OUTPUT
```

---

## Tabla de Mapeo de Entrada

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SQL Server) |
|-------------------|----------------------|----------------------------|
| $body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE | XQuery: data() | NumeroTarjeta |
| $header/aut:RequestHeader/Region/SourceBank | XQuery: convertirCodigoPais("HN01", "OSB-ISO3") → "HND" | Pais |
| N/A | NULL (parámetro OUTPUT) | CodigoError |
| N/A | NULL (parámetro OUTPUT) | MensajeError |

**Referencia**: `Middleware/v2/Resources/ProgramaLealtad/xq/conInfoLealtadHNIn.xqy`

**Fragmento de Código**:
```xquery
declare function xf:conInfoLealtadIn($country as xs:string, $cardNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NumeroTarjeta>{ $cardNumber }</ns0:NumeroTarjeta>
            <ns0:Pais>{ $country }</ns0:Pais>
        </ns0:InputParameters>
};
```

---

## Tabla de Mapeo de Salida

| Campo Origen (SQL Server) | Transformación/Script | Campo Destino (OSB Variable) |
|--------------------------|----------------------|------------------------------|
| RowSet/Row/Column[@name='LEGALID'] | XQuery: fn-bea:trim(string(text())) | $legalId |
| RowSet/Row/Column[@name='CUSTOMERNAME'] | XQuery: string(text()) | $customerName |
| RowSet/Row/Column[@name='CARDTYPE'] | XQuery: string(text()) | $cardType |
| RowSet/Row/Column[@name='LOGO'] | XQuery: string(text()) | $grupoAfinidad |
| CodigoError | XQuery: string(text()) | $errorCode |
| MensajeError | XQuery: string(text()) | $validationMessage |

**Referencia**: Pipeline `ConsultaPuntosLealtadHN.pipeline`, stage `ConsultaInformacionCliente`

**Fragmento de Código**:
```xquery
$legalId = fn-bea:trim(string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'LEGALID']/text()))
$customerName = string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'CUSTOMERNAME']/text())
$cardType = string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'CARDTYPE']/text())
$grupoAfinidad = string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'LOGO']/text())
$errorCode = string($RSPconInfoLealtad/con:CodigoError/text())
$validationMessage = string($RSPconInfoLealtad/con:MensajeError/text())
```

---

## Reglas de Negocio Detectadas

### 1. Conversión de Código de País
**Ubicación**: Pipeline `ConsultaPuntosLealtadHN`, stage `ConsultaInformacionCliente`

**Lógica**:
```
codigoPais = convertirCodigoPais(
    codigoPais: SourceBank,
    sentidoConversion: "OSB-ISO3"
)
// HN01 → HND
// GT01 → GTM
// NI01 → NIC
// PA01 → PAN
```

**Fragmento de Código**:
```xquery
<con1:assign varName="codigoPais">
    <con1:expr>
        <con3:xqueryTransform>
            <con3:resource ref="Middleware/v2/Resources/Generales/xq/convertirCodigoPais"/>
            <con3:param name="codigoPais">
                <con3:path>string($header/aut:RequestHeader/Region/SourceBank/text())</con3:path>
            </con3:param>
            <con3:param name="sentidoConversion">
                <con3:path>"OSB-ISO3"</con3:path>
            </con3:param>
        </con3:xqueryTransform>
    </con1:expr>
</con1:assign>
```

### 2. Condición de Invocación
**Ubicación**: Pipeline `ConsultaPuntosLealtadHN`, stage `ConsultaInformacionCliente`

**Lógica**:
```
SI not(exists($RSPconsultaPuntosLealtad/PT_PUNTOS_LEALTAD/BALANCE)) ENTONCES
    // La consulta inicial no retornó balance
    
    SI $customerIdType = "CARD_NUMBER" ENTONCES
        // Cliente proporcionó número de tarjeta
        
        Invocar conInfoLealtad_db
    SINO
        errorCode = 'ERROR'
        validationMessage = 'CUSTOMER_ID_TYPE no soportado'
    FIN SI
FIN SI
```

**Fragmento de Código**:
```xml
<con2:ifThenElse>
    <con2:case>
        <con2:condition>
            <con3:xqueryText>not(exists($RSPconsultaPuntosLealtad/con1:PT_PUNTOS_LEALTAD/con1:BALANCE))</con3:xqueryText>
        </con2:condition>
        <con2:actions>
            <con1:ifThenElse>
                <con1:case>
                    <con1:condition>
                        <con2:xqueryText>$customerIdType = "CARD_NUMBER"</con2:xqueryText>
                    </con1:condition>
                    <con1:actions>
                        <!-- Invocar conInfoLealtad_db -->
                    </con1:actions>
                </con1:case>
                <con1:default>
                    <con1:assign varName="errorCode">
                        <con1:expr>
                            <con3:xqueryText>'ERROR'</con3:xqueryText>
                        </con1:expr>
                    </con1:assign>
                    <con1:assign varName="validationMessage">
                        <con1:expr>
                            <con3:xqueryText>'CUSTOMER_ID_TYPE no soportado'</con3:xqueryText>
                        </con1:expr>
                    </con1:assign>
                </con1:default>
            </con1:ifThenElse>
        </con2:actions>
    </con2:case>
</con2:ifThenElse>
```

### 3. Determinación de Programa de Lealtad por Tipo de Tarjeta
**Ubicación**: Pipeline `ConsultaPuntosLealtadHN`, stage `ConsultaProgramaLealtad`

**Lógica**:
```
SI $cardType = 'DEBIT' ENTONCES
    $programaLealtad = '1'  // Mastercard Rewards
SINO
    // Consultar consultaProgramaLealtad_db con $grupoAfinidad (LOGO)
    $programaLealtad = resultado de consulta
FIN SI
```

**Fragmento de Código**:
```xml
<con2:ifThenElse>
    <con2:case>
        <con2:condition>
            <con3:xqueryText>$validationMessage = '' and $cardType = 'DEBIT'</con3:xqueryText>
        </con2:condition>
        <con2:actions>
            <con2:assign varName="programaLealtad">
                <con3:xqueryText>'1'</con3:xqueryText>
            </con2:assign>
        </con2:actions>
    </con2:case>
    <con2:default>
        <!-- Consultar consultaProgramaLealtad_db -->
    </con2:default>
</con2:ifThenElse>
```

### 4. Limpieza de Legal ID
**Ubicación**: Pipeline `ConsultaPuntosLealtadHN`, stage `ConsultaInformacionCliente`

**Lógica**:
```
legalId = trim(LEGALID)
// Elimina espacios en blanco al inicio y final
// Importante para comparaciones y uso posterior
```

**Fragmento de Código**:
```xquery
$legalId = fn-bea:trim(string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'LEGALID']/text()))
```

**Razón**: Los datos en SQL Server pueden tener espacios adicionales (CHAR vs VARCHAR)

### 5. Comparación Case-Insensitive de Nombres de Columnas
**Ubicación**: Pipeline `ConsultaPuntosLealtadHN`, stage `ConsultaInformacionCliente`

**Lógica**:
```
Para cada columna en RowSet:
    SI upper-case(column/@name) = 'LEGALID' ENTONCES
        extraer valor
    FIN SI
```

**Fragmento de Código**:
```xquery
$RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'LEGALID']/text()
```

**Razón**: SQL Server puede retornar nombres de columnas en diferentes casos (LEGALID, LegalId, legalid)

### 6. Manejo de Errores del Stored Procedure
**Ubicación**: Pipeline `ConsultaPuntosLealtadHN`, stage `ConsultaInformacionCliente`

**Lógica**:
```
errorCode = CodigoError del SP
validationMessage = MensajeError del SP

SI errorCode != "-1" ENTONCES
    // Error en consulta
    // Abortar flujo y retornar error al cliente
SINO
    // Éxito
    // Continuar con datos extraídos
FIN SI
```

**Fragmento de Código**:
```xquery
$errorCode = string($RSPconInfoLealtad/con:CodigoError/text())
$validationMessage = string($RSPconInfoLealtad/con:MensajeError/text())
```

**Códigos de Error Conocidos:**
- `-1`: Éxito (sin error)
- `1001`: Tarjeta no encontrada
- `1002`: País no válido
- Otros: Errores de base de datos o lógica de negocio

---

## Flujo Completo de Uso

### Paso 1: Cliente Consulta Puntos con Tarjeta

```xml
<soapenv:Envelope>
    <soapenv:Header>
        <aut:RequestHeader>
            <Region>
                <SourceBank>HN01</SourceBank>
            </Region>
        </aut:RequestHeader>
    </soapenv:Header>
    <soapenv:Body>
        <prog:consultaPuntosLealtad>
            <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
            <CUSTOMER_ID_VALUE>4111111111111111</CUSTOMER_ID_VALUE>
            <RETURN_CASH_EQUIVALENT>YES</RETURN_CASH_EQUIVALENT>
        </prog:consultaPuntosLealtad>
    </soapenv:Body>
</soapenv:Envelope>
```

### Paso 2: Consulta Inicial Falla (sin balance)

```
consultaPuntosLealtad_db → No retorna BALANCE
```

### Paso 3: Invocar conInfoLealtad

```
convertirCodigoPais(HN01) → HND
conInfoLealtad_db(NumeroTarjeta=4111111111111111, Pais=HND)
```

### Paso 4: Extraer Datos

```
$legalId = "0801199012345"
$customerName = "JUAN CARLOS PEREZ LOPEZ"
$cardType = "CREDIT"
$grupoAfinidad = "625"
```

### Paso 5: Determinar Programa

```
SI $cardType = "DEBIT" → programaLealtad = '1'
SINO → consultaProgramaLealtad_db(logo=625) → programaLealtad = '2'
```

### Paso 6: Consultar Puntos

```
SI programaLealtad = '1' → Mastercard CustomerService.getPointDetails(legalId)
SI programaLealtad = '2' → VisionPlus.PointsAdjustmentInquiry(accountNumber)
```

### Paso 7: Respuesta al Cliente

```xml
<prog:consultaPuntosLealtadResponse>
    <LEGAL_ID>0801199012345</LEGAL_ID>
    <CUSTOMER_NAME>JUAN CARLOS PEREZ LOPEZ</CUSTOMER_NAME>
    <AVAILABLE_POINTS>15000</AVAILABLE_POINTS>
    <CASH_EQUIVALENT>3750.00</CASH_EQUIVALENT>
    <CASH_CURRENCY>HNL</CASH_CURRENCY>
</prog:consultaPuntosLealtadResponse>
```

---

## Notas Adicionales

- **Encoding**: XQuery usa encoding por defecto (UTF-8)
- **XQuery Version**: 2004-draft
- **Namespace**: `http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoLealtad`
- **Función Trim**: `fn-bea:trim()` es específica de Oracle/BEA
- **Case Insensitive**: `upper-case(@name)` asegura compatibilidad con diferentes casos
- **Error Handling**: Códigos de error se propagan a través de variables
- **Performance**: Consulta directa a DB sin cache (puede ser lenta con alto volumen)
