# Ejemplos de Request/Response y Mapeo de Datos - HN01

## 1. Request OSB (Ejemplo)

### 1.1 SOAP Envelope Completo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:car="http://www.ficohsa.com.hn/middleware.services/cargaLoteProductosPS/"
                  xmlns:aper="http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_H2H</UserName>
            <Password>PASSWORD123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <aper:cargaLoteProductosRequest>
         <CUSTOMER_ID>1234567</CUSTOMER_ID>
         <PAYROLL_GROUP_ID>GP001</PAYROLL_GROUP_ID>
         <CUSTOMERS>
            <CUSTOMER>
               <CUSTOMER_ID_TYPE>DNI</CUSTOMER_ID_TYPE>
               <LEGAL_ID>0801199012345</LEGAL_ID>
               <LEGAL_ID_EMISSION_DATE>2015-06-15</LEGAL_ID_EMISSION_DATE>
               <GIVEN_NAMES>JUAN CARLOS</GIVEN_NAMES>
               <FAMILY_NAME>LOPEZ MARTINEZ</FAMILY_NAME>
               <DATE_OF_BIRTH>1990-03-20</DATE_OF_BIRTH>
               <GENDER>1</GENDER>
               <MARITAL_STATUS>M</MARITAL_STATUS>
               <HOME_ADDRESS>COL. KENNEDY CALLE 10 CASA 25</HOME_ADDRESS>
               <CELLULAR>50498765432</CELLULAR>
               <PHONE_NUMBER>50422334455</PHONE_NUMBER>
               <PHONE_REFERENCE>CASA</PHONE_REFERENCE>
               <EDUCATION_LEVEL>H</EDUCATION_LEVEL>
               <PROFESSION>101</PROFESSION>
               <START_DAY_JOB>2018-01-15</START_DAY_JOB>
               <JOB_TITTLE>205</JOB_TITTLE>
               <INCOME_CURRENCY>HNL</INCOME_CURRENCY>
               <INCOME_AMOUNT>15000.00</INCOME_AMOUNT>
               <MARRIED_NAME>MARIA</MARRIED_NAME>
               <MARRIED_LASTNAME>RODRIGUEZ</MARRIED_LASTNAME>
               <REFERENCE_NAME>PEDRO</REFERENCE_NAME>
               <REFERENCE_LASTNAME>LOPEZ</REFERENCE_LASTNAME>
               <REFERENCE_PHONE>50499887766</REFERENCE_PHONE>
               <REFERENCE_RELATIONSHIP>1</REFERENCE_RELATIONSHIP>
               <BENEFICIARY_NAME>MARIA RODRIGUEZ DE LOPEZ</BENEFICIARY_NAME>
               <BENEFICIARY_RELATIONSHIP>2</BENEFICIARY_RELATIONSHIP>
            </CUSTOMER>
            <CUSTOMER>
               <CUSTOMER_ID_TYPE>DNI</CUSTOMER_ID_TYPE>
               <LEGAL_ID>0801198523456</LEGAL_ID>
               <LEGAL_ID_EMISSION_DATE>2014-08-10</LEGAL_ID_EMISSION_DATE>
               <GIVEN_NAMES>ANA SOFIA</GIVEN_NAMES>
               <FAMILY_NAME>GARCIA HERNANDEZ</FAMILY_NAME>
               <DATE_OF_BIRTH>1985-07-12</DATE_OF_BIRTH>
               <GENDER>2</GENDER>
               <MARITAL_STATUS>S</MARITAL_STATUS>
               <HOME_ADDRESS>COL. MIRAFLORES BLVD MORAZAN CASA 100</HOME_ADDRESS>
               <CELLULAR>50497654321</CELLULAR>
               <PHONE_NUMBER>50422556677</PHONE_NUMBER>
               <PHONE_REFERENCE>OFICINA</PHONE_REFERENCE>
               <EDUCATION_LEVEL>G</EDUCATION_LEVEL>
               <PROFESSION>150</PROFESSION>
               <START_DAY_JOB>2020-03-01</START_DAY_JOB>
               <JOB_TITTLE>310</JOB_TITTLE>
               <INCOME_CURRENCY>USD</INCOME_CURRENCY>
               <INCOME_AMOUNT>2500.00</INCOME_AMOUNT>
               <REFERENCE_NAME>CARLOS</REFERENCE_NAME>
               <REFERENCE_LASTNAME>GARCIA</REFERENCE_LASTNAME>
               <REFERENCE_PHONE>50498123456</REFERENCE_PHONE>
               <REFERENCE_RELATIONSHIP>3</REFERENCE_RELATIONSHIP>
               <BENEFICIARY_NAME>CARLOS GARCIA LOPEZ</BENEFICIARY_NAME>
               <BENEFICIARY_RELATIONSHIP>1</BENEFICIARY_RELATIONSHIP>
            </CUSTOMER>
         </CUSTOMERS>
      </aper:cargaLoteProductosRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 2. Response OSB (Ejemplo Exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aper="http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <aper:cargaLoteProductosResponse>
         <BANK_BATCH_ID>LOTE20240115001</BANK_BATCH_ID>
      </aper:cargaLoteProductosResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 3. Response OSB (Ejemplo con Error)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aper="http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messages>El usuario y/o cliente no tiene acceso a operaciones host to host</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <aper:cargaLoteProductosResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 4. Servicios Dependientes y Cadenas de Conexión

### 4.1 Validación de Servicio Regional

**Tipo:** Database Adapter - Stored Procedure

**Cadena de Conexión:**
- JNDI: `eis/DB/ConnectionWebServices`
- Tipo: Oracle Database
- Adapter: Database Adapter

**Stored Procedure:**
- Nombre: `ValidaServicioRegional`
- Package: No especificado en el código
- Esquema: No especificado explícitamente

**Operación:** `ValidaServicioRegional`

**Parámetros:**
- Entrada: Service ID, Region
- Salida: PV_CODIGO_ERROR, PV_MENSAJE_ERROR

---

### 4.2 Validación de Acceso H2H

**Tipo:** Database Adapter - Stored Procedure

**Cadena de Conexión:**
- JNDI: `eis/DB/ConnectionWebServices`
- Tipo: Oracle Database
- Adapter: Database Adapter

**Stored Procedure:**
- Nombre: `validaAccesoH2H`
- Package: No especificado en el código
- Esquema: No especificado explícitamente

**Operación:** `validaAccesoH2H`

**Parámetros:**
- Entrada: Usuario, Cliente, País, Operación, ID Proxy
- Salida: PV_DESCRIPCIONMENSAJE

---

### 4.3 Consulta de Cliente (T24)

**Tipo:** SOAP Web Service

**Endpoint:**
- Servicio: `sjConsultaClienteResiliencia`
- Ruta: `Middleware/v3/BusinessServices/ConsultasCliente/biz/sjConsultaClienteResiliencia`
- Sistema: T24 Core Banking

**Operación:** `Consultadecliente`

**Autenticación:**
- Tipo: Basic Authentication
- Usuario: Obtenido de LDAP lookup
- Password: Obtenido de LDAP lookup
- Path LDAP: `Middleware/Security/{USERNAME}`

**WSDL:** No especificado en el código analizado

---

### 4.4 Carga de Lote de Productos

**Tipo:** Database Adapter - Stored Procedure

**Cadena de Conexión:**
- JNDI: `eis/DB/ConnectionWebServices`
- Tipo: Oracle Database
- Adapter: Database Adapter

**Stored Procedure:**
- Nombre: `HTH_P_CARGA_LOTE_PRODUCTOS`
- Package: `HTH_K_APERTURA_MASIVA`
- Esquema: `PAGOSWS` (inferido de tipos de datos)

**Operación:** `cargaLoteProductos`

---

### 4.5 Mapeo de Errores

**Tipo:** Business Service OSB

**Servicio:**
- Ruta: `MWHostToHost/v1/BusinessServices/OSB/mapeoErrores/biz/mapeoErrores`

**Operación:** `mapeoErrores`

**Parámetros:**
- Entrada: Código Error, Mensaje Error
- Salida: Mensaje mapeado

---

## 5. Mapeo de Datos - Llamada 1: Validación Servicio Regional

### 5.1 Request a validaServicioRegional

**Archivo XQuery:** `MWHostToHost/v1/Resources/Generales/xq/validaServicioRegionalIn.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|-------------------|----------------------|--------------------------|
| header/aut:RequestHeader | Parámetro completo | requestHeader |
| "FICBCO0380" | Valor constante | serviceId |

**Fragmento de Código:**
```xquery
<con1:resource ref="MWHostToHost/v1/Resources/Generales/xq/validaServicioRegionalIn"/>
<con1:param name="requestHeader">
    <con1:path>$header/aut:RequestHeader</con1:path>
</con1:param>
<con1:param name="serviceId">
    <con1:path>"FICBCO0380"</con1:path>
</con1:param>
```

### 5.2 Response de validaServicioRegional

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|---------------------|
| val:PV_CODIGO_ERROR | string() | Variable: Evaluación condicional |
| val:PV_MENSAJE_ERROR | string() | header/aut:ResponseHeader/messages |

**Regla de Negocio:**
- **Ubicación:** `CargaLoteProductos.proxy` - Stage `ValidacionServicioRegional`
- **Condición:** `string($RSPValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS'`
- **Acción:** Si no es SUCCESS, construir ResponseHeader con error y terminar ejecución

**Fragmento de Código:**
```xml
<con2:condition>
    <con1:xqueryText>string($RSPValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS'</con1:xqueryText>
</con2:condition>
<con2:actions>
    <con2:replace varName="header" contents-only="true">
        <con2:expr>
            <con1:xqueryText><![CDATA[<aut:ResponseHeader>
      <successIndicator>ERROR</successIndicator>
      <messages>{ string($RSPValidaServicioRegional/val:PV_MENSAJE_ERROR/text()) }</messages>
</aut:ResponseHeader>]]></con1:xqueryText>
        </con2:expr>
    </con2:replace>
</con2:actions>
```

---

## 6. Mapeo de Datos - Llamada 2: Validación Acceso H2H

### 6.1 Request a validaAccesoH2H

**Archivo XQuery:** `MWHostToHost/v1/Resources/CobranzasH2H/xq/validaAccesoH2HIn.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|-------------------|----------------------|--------------------------|
| $operation | upper-case() | operacion |
| body/aper:cargaLoteProductosRequest/CUSTOMER_ID | fn:string() | codigoCliente |
| header/aut:RequestHeader/Authentication/UserName | upper-case(string()) | usuario |
| header/aut:RequestHeader/Region/SourceBank | string() | codigoPais |
| "FICBCO0379" | Valor constante | idProxy |

**Fragmento de Código:**
```xml
<con:resource ref="MWHostToHost/v1/Resources/CobranzasH2H/xq/validaAccesoH2HIn"/>
<con:param name="operacion">
    <con:path>upper-case($operation)</con:path>
</con:param>
<con:param name="codigoCliente">
    <con:path>fn:string($body/aper:cargaLoteProductosRequest/CUSTOMER_ID/text())</con:path>
</con:param>
<con:param name="usuario">
    <con:path>upper-case(string($header/aut:RequestHeader/Authentication/UserName/text()))</con:path>
</con:param>
<con:param name="codigoPais">
    <con:path>string($header/aut:RequestHeader/Region/SourceBank/text())</con:path>
</con:param>
<con:param name="idProxy">
    <con:path>"FICBCO0379"</con:path>
</con:param>
```

### 6.2 Response de validaAccesoH2H

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|---------------------|
| val:PV_DESCRIPCIONMENSAJE | string() | Variable validationMessage |

**Regla de Negocio:**
- **Ubicación:** `CargaLoteProductos.proxy` - Stage `ValidaAccesso`
- **Condición:** `$validationMessage != ''`
- **Acción:** Si hay mensaje, lanzar error "El usuario y/o cliente no tiene acceso a operaciones host to host"

**Fragmento de Código:**
```xml
<con2:assign varName="validationMessage">
    <con2:expr>
        <con:xqueryText>string($RSPValidaAccesoH2H/val:PV_DESCRIPCIONMENSAJE/text())</con:xqueryText>
    </con2:expr>
</con2:assign>
<con2:ifThenElse>
    <con2:case>
        <con2:condition>
            <con:xqueryText>$validationMessage != ''</con:xqueryText>
        </con2:condition>
        <con2:actions>
            <con2:Error>
                <con2:errCode>ERROR</con2:errCode>
                <con2:message>El usuario y/o cliente no tiene acceso a operaciones host to host.</con2:message>
            </con2:Error>
        </con2:actions>
    </con2:case>
</con2:ifThenElse>
```

---

## 7. Mapeo de Datos - Llamada 3: Consulta Cliente T24

### 7.1 Request a sjConsultaClienteResiliencia

**Archivo XQuery:** `MWHostToHost/v1/Resources/CargaLoteProductos/xq/ConsultaClienteIN.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|---------------------|
| header/aut:RequestHeader/Authentication/UserName | getUsername() con LDAP lookup | WebRequestCommon/userName |
| header/aut:RequestHeader/Authentication/Password | getPassword() con LDAP lookup | WebRequestCommon/password |
| body/aper:cargaLoteProductosRequest/CUSTOMER_ID | data() | WSCUSTOMERType/enquiryInputCollection/criteriaValue |
| "@ID" | Valor constante | WSCUSTOMERType/enquiryInputCollection/columnName |
| "EQ" | Valor constante | WSCUSTOMERType/enquiryInputCollection/operand |

**Funciones Especiales:**

```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};

declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};
```

**Fragmento de Código:**
```xquery
<ns1:Consultadecliente>
    <WebRequestCommon>
        <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
                                      data($requestHeader/Authentitacion/UserName)) }</userName>
        <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                                      data($requestHeader/Authentication/Password)) }</password>
    </WebRequestCommon>
    <WSCUSTOMERType>
        <enquiryInputCollection>
            <columnName>@ID</columnName>
            <criteriaValue>{ data($cargaLoteProductosRequest/CUSTOMER_ID) }</criteriaValue>
            <operand>EQ</operand>
        </enquiryInputCollection>
    </WSCUSTOMERType>    
</ns1:Consultadecliente>
```

### 7.2 Response de sjConsultaClienteResiliencia

| Campo Origen (T24) | Transformación/Script | Campo Destino (Variable OSB) |
|-------------------|----------------------|------------------------------|
| Status/successIndicator | fn:string() | Evaluación condicional |
| WSCUSTOMERType/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NAMEOFBUSINESS | fn:data() | Variable para SP |
| WSCUSTOMERType/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/BLOCK | fn:data() | Variable para SP |
| WSCUSTOMERType/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/HOUSENUMBER | fn:data() | Variable para SP |
| WSCUSTOMERType/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/REFERENCES | fn:data() | Variable para SP |
| WSCUSTOMERType/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDSTREET | fn:data() | Variable para SP |
| WSCUSTOMERType/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE | fn:data() | Variable para SP |
| WSCUSTOMERType/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COLONYCODE | fn:data() | Variable para SP |

**Regla de Negocio:**
- **Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLoteHN_request` - Stage `FlujoEntrada`
- **Condición:** `fn:string($RSPConsultaDeCliente/Status/successIndicator/text()) = "Success"`
- **Acción:** Si es Success, continuar con carga de lote. Si no, lanzar error "No se encontró la información del cliente"

**Fragmento de Código:**
```xml
<con1:case>
    <con1:condition>
        <con:xqueryText>fn:string($RSPConsultaDeCliente/Status/successIndicator/text()) = "Success"</con:xqueryText>
    </con1:condition>
    <con1:actions>
        <!-- Continuar con carga de lote -->
    </con1:actions>
</con1:case>
<con1:default>
    <con1:Error>
        <con2:errCode>NO RECORDS</con2:errCode>
        <con1:message>No se encontro la información del cliente</con1:message>
    </con1:Error>
</con1:default>
```


---

## 8. Mapeo de Datos - Llamada 4: Carga Lote Productos (Stored Procedure)

### 8.1 Request a HTH_P_CARGA_LOTE_PRODUCTOS

**Archivo XQuery:** `MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosIN.xq`

#### Tabla de Mapeo - Parámetros Simples

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| body/aper:cargaLoteProductosRequest/CUSTOMER_ID | data() | PV_CODIGOCLIENTE |
| body/aper:cargaLoteProductosRequest/PAYROLL_GROUP_ID | data() | PV_CODIGOGRUPOPLANILLA |
| header/aut:RequestHeader/Authentication/UserName | fn:string() | PV_USUARIO |
| body/aper:cargaLoteProductosRequest/CUSTOMERS/CUSTOMER | fn:count() | PN_NUMEROCLIENTES |
| T24: NAMEOFBUSINESS | Parámetro $nameOfBusiness | PV_NOMBREEMPRESA |
| T24: COLONYCODE | Parámetro $colonyCode | PV_DIRECCIONEMPRESA |
| T24: ADDSTREET | Parámetro $addStreet | PV_CALLEEMPRESA |
| T24: BLOCK | Parámetro $block | PV_BLOQUEEMPRESA |
| T24: HOUSENUMBER | Parámetro $houseNumber | PV_CASAEMPRESA |
| T24: PHONE | Parámetro $phone | PV_TELEFONO_EMPRESA |
| T24: REFERENCES | Parámetro $reference | PV_REFERENCIAEMPRESA |

#### Tabla de Mapeo - Arrays de Clientes (Iteración sobre CUSTOMERS/CUSTOMER)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) | Tipo Array |
|-------------------|----------------------|-------------------|-----------|
| CUSTOMER/CUSTOMER_ID_TYPE | data() | PT_TIPOIDENTIFICACION/PT_TVARCHAR20_ITEM | TVARCHAR20 |
| CUSTOMER/LEGAL_ID | data() | PT_NUMEROIDENTIFICACION/PT_TVARCHAR13_ITEM | TVARCHAR13 |
| CUSTOMER/LEGAL_ID_EMISSION_DATE | data() | PT_FECHAEMISION/PT_TDATE_ITEM | TDATE |
| CUSTOMER/GIVEN_NAMES | data() | PT_NOMBRECLIENTE/PT_TVARCHAR40_ITEM | TVARCHAR40 |
| CUSTOMER/FAMILY_NAME | data() | PT_APELLIDOSCLIENTE/PT_TVARCHAR40_ITEM | TVARCHAR40 |
| CUSTOMER/DATE_OF_BIRTH | data() | PT_FECHANACIMIENTO/PT_TDATE_ITEM | TDATE |
| CUSTOMER/GENDER | data() | PT_GENERO/PT_TNUMBER_ITEM | TNUMBER |
| CUSTOMER/MARITAL_STATUS | data() | PT_ESTADOCIVIL/PT_TVARCHAR20_ITEM | TVARCHAR20 |
| CUSTOMER/HOME_ADDRESS | data() | PT_DIRECCIONHOGAR/PT_TVARCHAR60_ITEM | TVARCHAR60 |
| CUSTOMER/CELLULAR | data() | PT_CELULAR/PT_TVARCHAR11_ITEM | TVARCHAR11 |
| CUSTOMER/PHONE_NUMBER | data() | PT_TELEFONO/PT_TVARCHAR11_ITEM | TVARCHAR11 |
| CUSTOMER/PHONE_REFERENCE | data() | PT_REFERENCIATELEFONO/PT_TVARCHAR20_ITEM | TVARCHAR20 |
| CUSTOMER/EDUCATION_LEVEL | data() | PT_NIVELEDUCATIVO/PT_TVARCHAR20_ITEM | TVARCHAR20 |
| CUSTOMER/PROFESSION | data() | PT_PROFESION/PT_TNUMBER_ITEM | TNUMBER |
| CUSTOMER/START_DAY_JOB | data() | PT_FECHAINGRESOEMPRESA/PT_TDATE_ITEM | TDATE |
| CUSTOMER/JOB_TITTLE | data() | PT_CARGO/PT_TNUMBER_ITEM | TNUMBER |
| CUSTOMER/INCOME_CURRENCY | data() | PT_MONEDAINGRESO/PT_TVARCHAR3_ITEM | TVARCHAR3 |
| CUSTOMER/INCOME_AMOUNT | data() | PT_MONTOINGRESO/PT_TVARCHAR20_ITEM | TVARCHAR20 |
| CUSTOMER/MARRIED_NAME | data() | PT_NOMBRECONYUGUE/PT_TVARCHAR40_ITEM | TVARCHAR40 |
| CUSTOMER/MARRIED_LASTNAME | data() | PT_APELLIDOSCONYUGUE/PT_TVARCHAR40_ITEM | TVARCHAR40 |
| CUSTOMER/REFERENCE_NAME | data() | PT_NOMBREREFERENCIA/PT_TVARCHAR40_ITEM | TVARCHAR40 |
| CUSTOMER/REFERENCE_LASTNAME | data() | PT_APELLIDOSREFERENCIA/PT_TVARCHAR40_ITEM | TVARCHAR40 |
| CUSTOMER/REFERENCE_PHONE | data() | PT_TELEFONOREFERENCIA/PT_TVARCHAR11_ITEM | TVARCHAR11 |
| CUSTOMER/REFERENCE_RELATIONSHIP | data() | PT_PARENTESCOREFERENCIA/PT_TNUMBER_ITEM | TNUMBER |
| CUSTOMER/BENEFICIARY_NAME | data() | PT_NOMBREBENEFICIARIO/PT_TVARCHAR50_ITEM | TVARCHAR50 |
| CUSTOMER/BENEFICIARY_RELATIONSHIP | data() | PT_PARENTESCOBENEFICIARIO/PT_TNUMBER_ITEM | TNUMBER |

**Fragmento de Código - Ejemplo de Iteración:**

```xquery
<ns1:PT_TIPOIDENTIFICACION>
    {
        for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
        return
            <ns1:PT_TVARCHAR20_ITEM>{ data($customer/CUSTOMER_ID_TYPE) }</ns1:PT_TVARCHAR20_ITEM>
    }
</ns1:PT_TIPOIDENTIFICACION>
<ns1:PT_NUMEROIDENTIFICACION>
    {
        for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
        return
            <ns1:PT_TVARCHAR13_ITEM>{ data($customer/LEGAL_ID) }</ns1:PT_TVARCHAR13_ITEM>
    }
</ns1:PT_NUMEROIDENTIFICACION>
```

### 8.2 Response de HTH_P_CARGA_LOTE_PRODUCTOS

| Campo Origen (SP) | Transformación/Script | Campo Destino (Variable OSB) |
|------------------|----------------------|------------------------------|
| car:PV_CODIGOERROR | fn:string() | Variable $codError |
| car:PV_DESCRIPCIONMENSAJE | fn:string() | Variable $descMens |
| car:PV_CODIGOLOTE | fn:string() | Variable $codLote |

**Regla de Negocio:**
- **Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLoteHN_response` - Stage `FlujoSalida`
- **Condición:** `$codError != "SUCCESS"`
- **Acción:** 
  - Si hay error: Construir ResponseHeader con error y response vacío
  - Si es exitoso: Construir ResponseHeader con SUCCESS y response con BANK_BATCH_ID

**Fragmento de Código:**

```xml
<con:ifThenElse>
    <con:case>
        <con:condition>
            <con:xqueryText>$codError != "SUCCESS"</con:xqueryText>
        </con:condition>
        <con:actions>
            <con:replace varName="header" contents-only="true">
                <con:expr>
                    <con:xqueryText><![CDATA[<aut:ResponseHeader>
<successIndicator>{ $codError }</successIndicator>
<messages>{ $descMens }</messages>
</aut:ResponseHeader>]]></con:xqueryText>
                </con:expr>
            </con:replace>
            <con:replace varName="body" contents-only="true">
                <con:expr>
                    <con:xqueryText>&lt;aper:cargaLoteProductosResponse/></con:xqueryText>
                </con:expr>
            </con:replace>
        </con:actions>
    </con:case>
    <con:default>
        <con:replace varName="header" contents-only="true">
            <con:expr>
                <con:xqueryText>&lt;aut:ResponseHeader>
&lt;successIndicator>{ $codError }&lt;/successIndicator>
&lt;/aut:ResponseHeader></con:xqueryText>
            </con:expr>
        </con:replace>
        <con:replace varName="body" contents-only="true">
            <con:expr>
                <con:xqueryTransform>
                    <con:resource ref="MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosOUT"/>
                    <con:param name="codLote">
                        <con:path>$codLote</con:path>
                    </con:param>
                </con:xqueryTransform>
            </con:expr>
        </con:replace>
    </con:default>
</con:ifThenElse>
```

### 8.3 Transformación Final del Response

**Archivo XQuery:** `MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosOUT.xq`

| Campo Origen (Variable) | Transformación/Script | Campo Destino (Response OSB) |
|------------------------|----------------------|------------------------------|
| $codLote | Directo | cargaLoteProductosResponse/BANK_BATCH_ID |

**Fragmento de Código:**

```xquery
declare function xf:cargaLoteProductosOUT($codLote as xs:string)
    as element(ns1:cargaLoteProductosResponse) {
    <ns1:cargaLoteProductosResponse>
        <BANK_BATCH_ID>{ $codLote }</BANK_BATCH_ID>
    </ns1:cargaLoteProductosResponse>
};
```

---

## 9. Mapeo de Datos - Llamada 5: Mapeo de Errores

### 9.1 Request a mapeoErrores

**Archivo XQuery:** `MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageIn.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|-------------------|----------------------|--------------------------|
| $errorCode o successIndicator | Parámetro CODIGO_ERROR | CODIGO_ERROR |
| "FICBCO0380" + "$#$" + mensaje | fn:concat() | MENSAJE_ERROR |

**Fragmento de Código (Error Handler):**

```xml
<con1:assign varName="REQMapeoErrores">
    <con1:expr>
        <con:xqueryTransform>
            <con:resource ref="MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageIn"/>
            <con:param name="MENSAJE_ERROR">
                <con:path>fn:concat("FICBCO0380", "$#$", $errorMessage)</con:path>
            </con:param>
            <con:param name="CODIGO_ERROR">
                <con:path>$errorCode</con:path>
            </con:param>
        </con:xqueryTransform>
    </con1:expr>
</con1:assign>
```

**Fragmento de Código (Response Pipeline):**

```xml
<con3:assign varName="REQMapeoErrores">
    <con3:expr>
        <con2:xqueryTransform>
            <con2:resource ref="MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageIn"/>
            <con2:param name="CODIGO_ERROR">
                <con2:path>fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text()))</con2:path>
            </con2:param>
            <con2:param name="MENSAJE_ERROR">
                <con2:path>fn:concat("FICBCO0380","$#$",fn:string-join($header/aut:ResponseHeader/messages, '||'))</con2:path>
            </con2:param>
        </con2:xqueryTransform>
    </con3:expr>
</con3:assign>
```

### 9.2 Response de mapeoErrores

**Archivo XQuery:** `MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageOut.xq`

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|---------------------|
| mapeoErroresResponse | Parámetro completo | header/aut:ResponseHeader |
| successIndicator | Parámetro | header/aut:ResponseHeader/successIndicator |

**Fragmento de Código:**

```xml
<con3:replace varName="header" contents-only="true">
    <con3:expr>
        <con2:xqueryTransform>
            <con2:resource ref="MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageOut"/>
            <con2:param name="mapeoErroresResponse">
                <con2:path>$RSPMapeoErrores</con2:path>
            </con2:param>
            <con2:param name="successIndicator">
                <con2:path>fn:string($header/aut:ResponseHeader/successIndicator/text())</con2:path>
            </con2:param>
        </con2:xqueryTransform>
    </con3:expr>
</con3:replace>
```

---

## 10. Reglas de Negocio Detectadas

### 10.1 Validación de Campos Obligatorios

**Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLotePP_request` - Stage `ValidateMessage`

**Regla 1: CUSTOMER_ID no puede estar vacío**
```xml
<con2:condition>
    <con:xqueryText>fn:string($body/aper:cargaLoteProductosRequest/CUSTOMER_ID/text()) = ""</con:xqueryText>
</con2:condition>
<con2:actions>
    <con2:Error>
        <con2:errCode>NO CUSTOMER ID</con2:errCode>
        <con2:message>El id de cliente no puede ir vacio</con2:message>
    </con2:Error>
</con2:actions>
```

**Regla 2: PAYROLL_GROUP_ID es obligatorio**
```xml
<con2:condition>
    <con:xqueryText>fn:string($body/aper:cargaLoteProductosRequest/PAYROLL_GROUP_ID/text()) = ""</con:xqueryText>
</con2:condition>
<con2:actions>
    <con2:Error>
        <con2:errCode>NO PAYROLL GROUP</con2:errCode>
        <con2:message>El código de grupo planilla es necesario</con2:message>
    </con2:Error>
</con2:actions>
```

### 10.2 Validación de Servicio Regional

**Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLotePP_request` - Stage `ValidacionServicioRegional`

**Regla:** El servicio FICBCO0380 debe estar habilitado para la región

```xml
<con2:condition>
    <con1:xqueryText>string($RSPValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS'</con1:xqueryText>
</con2:condition>
<con2:actions>
    <con2:replace varName="header" contents-only="true">
        <con2:expr>
            <con1:xqueryText><![CDATA[<aut:ResponseHeader>
      <successIndicator>ERROR</successIndicator>
      <messages>{ string($RSPValidaServicioRegional/val:PV_MENSAJE_ERROR/text()) }</messages>
</aut:ResponseHeader>]]></con1:xqueryText>
        </con2:expr>
    </con2:replace>
    <con1:reply isError="false"/>
</con2:actions>
```

### 10.3 Validación de Acceso H2H

**Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLotePP_request` - Stage `ValidaAccesso`

**Regla:** Usuario y cliente deben tener acceso a operaciones Host-to-Host

```xml
<con2:condition>
    <con:xqueryText>$validationMessage != ''</con:xqueryText>
</con2:condition>
<con2:actions>
    <con2:Error>
        <con2:errCode>ERROR</con2:errCode>
        <con2:message>El usuario y/o cliente no tiene acceso a operaciones host to host.</con2:message>
    </con2:Error>
</con2:actions>
```

### 10.4 Validación de Existencia de Cliente en T24

**Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLoteHN_request` - Stage `FlujoEntrada`

**Regla:** El cliente corporativo debe existir en T24 con status Success

```xml
<con1:condition>
    <con:xqueryText>fn:string($RSPConsultaDeCliente/Status/successIndicator/text()) = "Success"</con:xqueryText>
</con1:condition>
<con1:actions>
    <!-- Continuar con proceso -->
</con1:actions>
<con1:default>
    <con1:Error>
        <con2:errCode>NO RECORDS</con2:errCode>
        <con1:message>No se encontro la información del cliente</con1:message>
    </con1:Error>
</con1:default>
```

### 10.5 Regionalización

**Ubicación:** `CargaLoteProductos.proxy` - Branch Node `Regionalizacion`

**Regla:** Solo HN01 está implementado, otras regiones retornan error

```xml
<con:branch-table variable="header">
    <con:xpath>
        <con:xpathText>./aut:RequestHeader/Region/SourceBank</con:xpathText>
    </con:xpath>
    <con:branch name="HN01">
        <con:operator>equals</con:operator>
        <con:value>"HN01"</con:value>
        <con:flow>
            <con:pipeline-node name="ConsultaDetalleLoteHN">
                <!-- Implementación completa -->
            </con:pipeline-node>
        </con:flow>
    </con:branch>
    <con:default-branch>
        <con:flow>
            <con:pipeline-node name="Default">
                <!-- Error: SERVICE NOT IMPLEMENTED -->
            </con:pipeline-node>
        </con:flow>
    </con:default-branch>
</con:branch-table>
```

### 10.6 Manejo de Errores del Stored Procedure

**Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLoteHN_response` - Stage `FlujoSalida`

**Regla:** Si el SP retorna código diferente a SUCCESS, mapear error

```xml
<con:condition>
    <con:xqueryText>$codError != "SUCCESS"</con:xqueryText>
</con:condition>
<con:actions>
    <con:replace varName="header" contents-only="true">
        <con:expr>
            <con:xqueryText><![CDATA[<aut:ResponseHeader>
<successIndicator>{ $codError }</successIndicator>
<messages>{ $descMens }</messages>
</aut:ResponseHeader>]]></con:xqueryText>
        </con:expr>
    </con:replace>
    <con:replace varName="body" contents-only="true">
        <con:expr>
            <con:xqueryText>&lt;aper:cargaLoteProductosResponse/></con:xqueryText>
        </con:expr>
    </con:replace>
</con:actions>
```

### 10.7 Mapeo de Errores en Response Pipeline

**Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLotePP_response` - Stage `MapeoError`

**Regla:** Si successIndicator != "SUCCESS", mapear error mediante servicio

```xml
<con3:condition>
    <con:xqueryText>fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text())) != "SUCCESS"</con:xqueryText>
</con3:condition>
<con3:actions>
    <con3:wsCallout>
        <con3:service ref="MWHostToHost/v1/BusinessServices/OSB/mapeoErrores/biz/mapeoErrores"/>
        <con3:operation>mapeoErrores</con3:operation>
        <!-- Mapeo de error -->
    </con3:wsCallout>
</con3:actions>
```

### 10.8 Validación de Esquema XML

**Ubicación:** `CargaLoteProductos.proxy` - Pipeline `ConsultaDetalleLotePP_request` - Stage `ValidateMessage`

**Regla:** Validar request contra esquema aperturaMasivaTypes.xsd

```xml
<con2:validate>
    <con2:schema ref="MWHostToHost/v1/Resources/AperturaMasiva/xsd/aperturaMasivaTypes"/>
    <con2:schemaElement xmlns:aper="http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes">aper:cargaLoteProductosRequest</con2:schemaElement>
    <con2:varName>body</con2:varName>
    <con2:location>
        <con:xpathText>./aper:cargaLoteProductosRequest</con:xpathText>
    </con2:location>
</con2:validate>
```

---

## 11. Catálogos y Valores Permitidos

### 11.1 GENDER (Género)
- **1**: Masculino
- **2**: Femenino

### 11.2 MARITAL_STATUS (Estado Civil)
- **S**: Soltero (Single)
- **L**: Unión Libre (Living together)
- **M**: Casado (Married)
- **D**: Divorciado (Divorced)
- **W**: Viudo (Widowed)

### 11.3 EDUCATION_LEVEL (Nivel Educativo)
- **A**: Analfabeto
- **P**: Primaria
- **S**: Secundaria
- **H**: Educación Superior (Higher education)
- **G**: Graduado (Graduate)

### 11.4 INCOME_CURRENCY (Moneda de Ingresos)
- **HNL**: Lempira Hondureño
- **USD**: Dólar Estadounidense

### 11.5 Códigos Numéricos

**PROFESSION (Profesión):** Código numérico de 3 dígitos (catálogo no especificado en código)

**JOB_TITTLE (Cargo):** Código numérico de 3 dígitos (catálogo no especificado en código)

**REFERENCE_RELATIONSHIP (Parentesco Referencia):** Código numérico de 3 dígitos (catálogo no especificado en código)

**BENEFICIARY_RELATIONSHIP (Parentesco Beneficiario):** Código numérico de 3 dígitos (catálogo no especificado en código)

---

## 12. Códigos de Error Identificados

| Código Error | Mensaje | Origen |
|-------------|---------|--------|
| NO CUSTOMER ID | El id de cliente no puede ir vacio | Validación OSB |
| NO PAYROLL GROUP | El código de grupo planilla es necesario | Validación OSB |
| ERROR | El usuario y/o cliente no tiene acceso a operaciones host to host | Validación H2H |
| NO RECORDS | No se encontró la información del cliente | Consulta T24 |
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Región no implementada |
| SUCCESS | Operación exitosa | Stored Procedure |
| (Otros) | Mapeados por servicio mapeoErrores | Stored Procedure |

---

## 13. Resumen de Flujo de Datos

1. **Cliente → OSB:** Request SOAP con datos de lote de empleados
2. **OSB → Validación Regional:** Verificar servicio habilitado (FICBCO0380)
3. **OSB → Validación H2H:** Verificar acceso usuario/cliente (FICBCO0379)
4. **OSB → T24:** Consultar datos del cliente corporativo
5. **OSB → Stored Procedure:** Enviar lote completo con datos empresa + empleados
6. **Stored Procedure → OSB:** Retornar código de lote o error
7. **OSB → Cliente:** Response SOAP con BANK_BATCH_ID o mensaje de error
