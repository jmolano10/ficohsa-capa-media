# Ejemplos y Mapeos — HN01 (Honduras) — ConsultaCobranzasH2H

## Request OSB (ejemplo XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:cob="http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_H2H</UserName>
            <Password>PASSWORD123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cob:consultaCobranzas>
         <CUSTOMER_ID>12345678</CUSTOMER_ID>
         <SERVICES>
            <SERVICE>
               <ID>9</ID>
               <DEBTORS>
                  <DEBTOR>
                     <TRACE>TRC001</TRACE>
                     <CODE>DEB001</CODE>
                     <CURRENCY>HNL</CURRENCY>
                     <RETURN_TYPE>ALL</RETURN_TYPE>
                     <EXTENDED_COLLECTION>N</EXTENDED_COLLECTION>
                  </DEBTOR>
               </DEBTORS>
            </SERVICE>
         </SERVICES>
      </cob:consultaCobranzas>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (ejemplo XML — caso exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:cob="http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cob:consultaCobranzasResponse>
         <SERVICES>
            <SERVICE>
               <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
               <ID>9</ID>
               <NAME>Servicio Recaudo Ejemplo</NAME>
               <DEBTORS>
                  <DEBTOR>
                     <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
                     <TRACE>TRC001</TRACE>
                     <CODE>DEB001</CODE>
                     <NAME>Juan Pérez</NAME>
                     <BILLS>
                        <BILL>
                           <ID>FAC-2024-001</ID>
                           <ISSUE_DATE>2024-01-15</ISSUE_DATE>
                           <DUE_DATE>2024-02-15</DUE_DATE>
                           <BALANCES>
                              <BALANCE>
                                 <CURRENCY>HNL</CURRENCY>
                                 <AMOUNT>1500.00</AMOUNT>
                                 <LATE_FEE>50.00</LATE_FEE>
                                 <TOTAL>1550.00</TOTAL>
                              </BALANCE>
                           </BALANCES>
                        </BILL>
                     </BILLS>
                     <DEALSLIP><html><body>Recibo de pago</body></html></DEALSLIP>
                  </DEBTOR>
               </DEBTORS>
            </SERVICE>
         </SERVICES>
      </cob:consultaCobranzasResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Requests/Responses Internos a Servicios Dependientes

### 1. ValidaServicioRegional

**Business Service:** `MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/biz/validaServicioRegional_db`
**Operación:** `ValidaServicioRegional`
**XQuery de entrada:** `MWHostToHost/v1/Resources/Generales/xq/validaServicioRegionalIn`

**Request:**
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <ns0:PV_REQUESTHEADER><!-- RequestHeader completo --></ns0:PV_REQUESTHEADER>
   <ns0:PV_SERVICEID>FICBCO0258</ns0:PV_SERVICEID>
</ns0:InputParameters>
```

**Response:**
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <ns0:PV_CODIGO_ERROR>SUCCESS</ns0:PV_CODIGO_ERROR>
   <ns0:PV_MENSAJE_ERROR></ns0:PV_MENSAJE_ERROR>
</ns0:OutputParameters>
```

### 2. ValidaAccesoH2H

**Business Service:** `MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/biz/validaAccesoH2H_db`
**Operación:** `validaAccesoH2H`
**XQuery de entrada:** `MWHostToHost/v1/Resources/CobranzasH2H/xq/validaAccesoH2HIn`

**Request:**
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoH2H">
   <ns0:PV_NOMBREUSUARIO>USUARIO_H2H</ns0:PV_NOMBREUSUARIO>
   <ns0:PV_OPERACION>CONSULTA</ns0:PV_OPERACION>
   <ns0:PV_IDPROXY>FICBCO0258</ns0:PV_IDPROXY>
   <ns0:PV_CODIGOPAIS>HN01</ns0:PV_CODIGOPAIS>
   <ns0:PV_CODIGOCLIENTE>12345678</ns0:PV_CODIGOCLIENTE>
</ns0:InputParameters>
```

**Response:**
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoH2H">
   <ns0:PV_DESCRIPCIONMENSAJE></ns0:PV_DESCRIPCIONMENSAJE>
</ns0:OutputParameters>
```

> Si `PV_DESCRIPCIONMENSAJE` no está vacío → Error: "El usuario y/o cliente no tiene acceso a operaciones host to host."

### 3. ObtenerParametrizacion (MAXAGREEMENTS)

**Business Service:** `MWHostToHost/v1/BusinessServices/MDW/obtenerParametrizacion/biz/obtenerParametrizacion`
**Operación:** `obtenerParametrizacion`
**XQuery de entrada:** `MWHostToHost/v1/Resources/Generales/xq/obtenerParametrizacionIn`

**Request:**
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
   <ns0:PV_NOMBREPARAMETROS>FICBCO0244.MAXAGREEMENTS</ns0:PV_NOMBREPARAMETROS>
</ns0:InputParameters>
```

**Response:**
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
   <ns0:ERROR_CODE>SUCCESS</ns0:ERROR_CODE>
   <ns0:CONFIGURACIONES>
      <ns0:CONFIGURACIONES_ITEM>
         <ns0:NAME>FICBCO0244.MAXAGREEMENTS</ns0:NAME>
         <ns0:VALUE>50</ns0:VALUE>
      </ns0:CONFIGURACIONES_ITEM>
   </ns0:CONFIGURACIONES>
</ns0:OutputParameters>
```

### 4. ConsultaPeticionesDisponiblesH2H

**Business Service:** `MWHostToHost/v1/BusinessServices/ABKHN/consultaPeticionesDisponiblesH2H/biz/consultaPeticionesDisponiblesH2H_db`
**Operación:** `consultaPeticionesDisponiblesH2H`
**XQuery de entrada:** `MWHostToHost/v1/Resources/CobranzasH2H/xq/consPeticionesDispH2HIn`

**Request:**
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPeticionesDisponiblesH2H">
   <ns0:PV_CODIGOUSUARIO>USUARIO_H2H</ns0:PV_CODIGOUSUARIO>
   <ns0:PV_IDPROXY>FICBCO0258</ns0:PV_IDPROXY>
   <ns0:PV_OPERACION>CONSULTA</ns0:PV_OPERACION>
   <ns0:PN_CANTIDADPETICIONES>1</ns0:PN_CANTIDADPETICIONES>
</ns0:InputParameters>
```

**Response:**
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPeticionesDisponiblesH2H">
   <ns0:PV_DESCRIPCIONMENSAJE></ns0:PV_DESCRIPCIONMENSAJE>
   <ns0:PN_CANTIDADPERMITIDA>100</ns0:PN_CANTIDADPERMITIDA>
   <ns0:PN_CANTIDADEXITOSOS>5</ns0:PN_CANTIDADEXITOSOS>
   <ns0:PN_CANTIDADERRONEOS>0</ns0:PN_CANTIDADERRONEOS>
</ns0:OutputParameters>
```

> Si `PV_DESCRIPCIONMENSAJE` no está vacío → se salta la consulta de convenios y cobranzas, retorna error.

### 5. ConsultaConveniosH2H

**Business Service:** `MWHostToHost/v1/BusinessServices/INTFC/consultaConveniosH2H/biz/consultaConveniosH2H_db`
**Operación:** `consultaConveniosH2H`
**XQuery de entrada:** `MWHostToHost/v1/Resources/ConsultaCobranzasH2H/xq/consultaConveniosH2HIn`

**Request:**
```xml
<ns1:InputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConveniosH2H">
   <ns1:PT_IDSERVICIO>
      <ns1:PT_IDSERVICIO_ITEM>9</ns1:PT_IDSERVICIO_ITEM>
   </ns1:PT_IDSERVICIO>
   <ns1:PV_CODIGOPAIS>HN01</ns1:PV_CODIGOPAIS>
</ns1:InputParameters>
```

**Response:**
```xml
<ns1:OutputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConveniosH2H">
   <ns1:PV_DESCRIPCIONMENSAJE></ns1:PV_DESCRIPCIONMENSAJE>
   <ns1:PT_INFOCONVENIOS>
      <ns1:PT_INFOCONVENIOS_ITEM>
         <ns1:ID_SERVICIO>9</ns1:ID_SERVICIO>
         <ns1:ID_CONTRATO>CONV-001</ns1:ID_CONTRATO>
         <ns1:DESCRIPCION>Servicio Recaudo Ejemplo</ns1:DESCRIPCION>
      </ns1:PT_INFOCONVENIOS_ITEM>
   </ns1:PT_INFOCONVENIOS>
</ns1:OutputParameters>
```

### 6. Split-Join ConsultaCobranzasH2H

**Business Service:** `MWHostToHost/v1/BusinessServices/SJS/consultaCobranzasH2H/biz/sjConsultaCobranzasH2H`
**Operación:** `sjConsulta`
**XQuery de entrada:** `MWHostToHost/v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HIn`
**XQuery de salida:** `MWHostToHost/v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HOut`

**Request:**
```xml
<ns0:sjConsultaCobranzas xmlns:ns0="http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes">
   <USER_NAME>USUARIO_H2H</USER_NAME>
   <PASSWORD>PASSWORD123</PASSWORD>
   <SOURCE_BANK>HN01</SOURCE_BANK>
   <CUSTOMER_ID>12345678</CUSTOMER_ID>
   <SERVICES>
      <SERVICE>
         <ID>9</ID>
         <CONTRACT_ID>CONV-001</CONTRACT_ID>
         <NAME>Servicio Recaudo Ejemplo</NAME>
         <DEBTORS>
            <DEBTOR>
               <TRACE>TRC001</TRACE>
               <CODE>DEB001</CODE>
               <CURRENCY>HNL</CURRENCY>
               <RETURN_TYPE>ALL</RETURN_TYPE>
               <EXTENDED_COLLECTION>N</EXTENDED_COLLECTION>
            </DEBTOR>
         </DEBTORS>
      </SERVICE>
   </SERVICES>
</ns0:sjConsultaCobranzas>
```

**Response:**
```xml
<ns0:sjConsultaCobranzasResponse xmlns:ns0="http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes">
   <SUCCESS_AMOUNT>1</SUCCESS_AMOUNT>
   <ERROR_AMOUNT>0</ERROR_AMOUNT>
   <SERVICES>
      <SERVICE>
         <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
         <ID>9</ID>
         <NAME>Servicio Recaudo Ejemplo</NAME>
         <DEBTORS>
            <DEBTOR>
               <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
               <TRACE>TRC001</TRACE>
               <CODE>DEB001</CODE>
               <NAME>Juan Pérez</NAME>
               <BILLS>
                  <BILL>
                     <ID>FAC-2024-001</ID>
                     <ISSUE_DATE>2024-01-15</ISSUE_DATE>
                     <DUE_DATE>2024-02-15</DUE_DATE>
                     <BALANCES>
                        <BALANCE>
                           <CURRENCY>HNL</CURRENCY>
                           <AMOUNT>1500.00</AMOUNT>
                           <LATE_FEE>50.00</LATE_FEE>
                           <TOTAL>1550.00</TOTAL>
                        </BALANCE>
                     </BALANCES>
                  </BILL>
               </BILLS>
               <DEALSLIP>[html][body]Recibo de pago[/body][/html]</DEALSLIP>
            </DEBTOR>
         </DEBTORS>
      </SERVICE>
   </SERVICES>
</ns0:sjConsultaCobranzasResponse>
```

### 7. ActualizaPeticionesDisponiblesH2H

**Business Service:** `MWHostToHost/v1/BusinessServices/ABKHN/actualizaPeticionesDisponiblesH2H/biz/actualizaPeticionesDisponiblesH2H_db`
**Operación:** `actualizaPeticionesDisponiblesH2H`
**XQuery de entrada:** `MWHostToHost/v1/Resources/CobranzasH2H/xq/actualizaPeticionesDisponiblesH2HIn`

**Request:**
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaPeticionesDisponiblesH2H">
   <ns0:PV_CODIGOUSUARIO>USUARIO_H2H</ns0:PV_CODIGOUSUARIO>
   <ns0:PV_IDPROXY>FICBCO0258</ns0:PV_IDPROXY>
   <ns0:PV_OPERACION>CONSULTA</ns0:PV_OPERACION>
   <ns0:PN_CANTIDADEXITOSOS>1</ns0:PN_CANTIDADEXITOSOS>
   <ns0:PN_CANTIDADERRONEOS>0</ns0:PN_CANTIDADERRONEOS>
</ns0:InputParameters>
```

---

## Cadenas de Conexión Detectadas

| Servicio | Tipo | Referencia OSB | Esquema/BD | SP/Operación |
|----------|------|----------------|------------|--------------|
| ValidaServicioRegional | DB Adapter | `MDW/validaServicioRegional/biz/validaServicioRegional_db` | MDW | ValidaServicioRegional |
| ValidaAccesoH2H | DB Adapter | `INTFC/validaAccesoH2H/biz/validaAccesoH2H_db` | INTFC | validaAccesoH2H |
| ObtenerParametrizacion | DB Adapter | `MDW/obtenerParametrizacion/biz/obtenerParametrizacion` | ORA_BANK | OSB_GET_CONFIG |
| ConsultaPeticionesDisponibles | DB Adapter | `ABKHN/consultaPeticionesDisponiblesH2H/biz/consultaPeticionesDisponiblesH2H_db` | ABKHN | consultaPeticionesDisponiblesH2H |
| ConsultaConveniosH2H | DB Adapter | `INTFC/consultaConveniosH2H/biz/consultaConveniosH2H_db` | INTFC | consultaConveniosH2H |
| sjConsultaCobranzasH2H | Split-Join | `SJS/consultaCobranzasH2H/biz/sjConsultaCobranzasH2H` | N/A | sjConsulta |
| ActualizaPeticionesDisponibles | DB Adapter | `ABKHN/actualizaPeticionesDisponiblesH2H/biz/actualizaPeticionesDisponiblesH2H_db` | ABKHN | actualizaPeticionesDisponiblesH2H |
| MapeoErrores | OSB Service | `OSB/mapeoErrores/biz/mapeoErrores` | N/A | mapeoErrores |
| RegistrarBitacoraH2H | DB Adapter | `INTFC/registrarBitacoraH2H/biz/registrarBitacoraH2H_db` | INTFC | registrarBitacoraH2H |

---

## Tablas de Mapeo de Entrada

### ValidaAccesoH2H — Entrada (validaAccesoH2HIn.xq)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|---------------------|----------------|---------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `upper-case()` | `PV_NOMBREUSUARIO` |
| `$operation` | `upper-case()` | `PV_OPERACION` |
| Literal `'FICBCO0258'` | — | `PV_IDPROXY` |
| `$header/aut:RequestHeader/Region/SourceBank` | `string()` | `PV_CODIGOPAIS` |
| `$body/cob:consultaCobranzas/CUSTOMER_ID` | `string()` | `PV_CODIGOCLIENTE` |

### ConsultaPeticionesDisponiblesH2H — Entrada (consPeticionesDispH2HIn.xq)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|---------------------|----------------|---------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `upper-case()` | `PV_CODIGOUSUARIO` |
| Literal `"FICBCO0258"` | — | `PV_IDPROXY` |
| `$operation` | `upper-case()` | `PV_OPERACION` |
| `count($body/cob:consultaCobranzas/SERVICES/SERVICE/DEBTORS/DEBTOR)` | `count()` | `PN_CANTIDADPETICIONES` |

### ConsultaConveniosH2H — Entrada (consultaConveniosH2HIn.xq)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|---------------------|----------------|---------------------|
| `$body/cob:consultaCobranzas/SERVICES/SERVICE/ID` | `distinct-values()`, iteración `for` | `PT_IDSERVICIO/PT_IDSERVICIO_ITEM` |
| `$header/aut:RequestHeader/Region/SourceBank` | `string()` | `PV_CODIGOPAIS` |

### Split-Join ConsultaCobranzas — Entrada (sjConsultaRecaudoH2HIn.xq)

| Campo Origen (OSB) | Transformación | Campo Destino (SJ) |
|---------------------|----------------|---------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `upper-case()` | `USER_NAME` |
| `$header/aut:RequestHeader/Authentication/Password` | `data()` | `PASSWORD` |
| `$header/aut:RequestHeader/Region/SourceBank` | `data()` | `SOURCE_BANK` |
| `$body/cob:consultaCobranzas/CUSTOMER_ID` | `data()` | `CUSTOMER_ID` |
| `$body/cob:consultaCobranzas/SERVICES/SERVICE/ID` | `data()` | `SERVICES/SERVICE/ID` |
| `$RSPConsultaConveniosH2H/PT_INFOCONVENIOS_ITEM[ID_SERVICIO=ID]/ID_CONTRATO` | Lookup por ID_SERVICIO | `SERVICES/SERVICE/CONTRACT_ID` |
| `$RSPConsultaConveniosH2H/PT_INFOCONVENIOS_ITEM[ID_SERVICIO=ID]/DESCRIPCION` | Lookup por ID_SERVICIO | `SERVICES/SERVICE/NAME` |
| `$body/cob:consultaCobranzas/SERVICES/SERVICE/DEBTORS` | Copia directa (nodos) | `SERVICES/SERVICE/DEBTORS` |

### ActualizaPeticionesDisponiblesH2H — Entrada (actualizaPeticionesDisponiblesH2HIn.xq)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|---------------------|----------------|---------------------|
| `$header/aut:RequestHeader/Authentication/UserName` | `upper-case()` | `PV_CODIGOUSUARIO` |
| Literal `"FICBCO0258"` | — | `PV_IDPROXY` |
| `$operation` | `upper-case()` | `PV_OPERACION` |
| `$RSPsjConsulta/SUCCESS_AMOUNT` | `xs:int()` | `PN_CANTIDADEXITOSOS` |
| `$RSPsjConsulta/ERROR_AMOUNT` | `xs:int()` | `PN_CANTIDADERRONEOS` |

---

## Tablas de Mapeo de Salida

### Split-Join ConsultaCobranzas — Salida (sjConsultaRecaudoH2HOut.xq)

| Campo Origen (SJ Response) | Transformación | Campo Destino (OSB Response) |
|-----------------------------|----------------|-------------------------------|
| `SERVICES/SERVICE/SUCCESS_INDICATOR` | `data()` | `SERVICES/SERVICE/SUCCESS_INDICATOR` |
| `SERVICES/SERVICE/ERROR_MESSAGE` | `data()` | `SERVICES/SERVICE/ERROR_MESSAGE` |
| `SERVICES/SERVICE/ID` | `distinct-values()` + agrupación | `SERVICES/SERVICE/ID` |
| `SERVICES/SERVICE/NAME` | `data()` (primer elemento del grupo) | `SERVICES/SERVICE/NAME` |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/SUCCESS_INDICATOR` | `data()` | `DEBTORS/DEBTOR/SUCCESS_INDICATOR` |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/ERROR_MESSAGE` | `data()` | `DEBTORS/DEBTOR/ERROR_MESSAGE` |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/TRACE` | `data()` | `DEBTORS/DEBTOR/TRACE` |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/CODE` | `data()` | `DEBTORS/DEBTOR/CODE` |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/NAME` | `data()` | `DEBTORS/DEBTOR/NAME` |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/BILLS/BILL/*` | Copia directa | `DEBTORS/DEBTOR/BILLS/BILL/*` |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/DEALSLIP` | `transformarReciboHTML()` (si serviceId=9: reemplaza `[]@` por `<>"`) | `DEBTORS/DEBTOR/DEALSLIP` |

---

## Reglas de Negocio Detectadas

### 1. Validación de número máximo de solicitudes
- **Ubicación:** Stage `ValidaNumeroSolicitudes` en pipeline `HNBanco_ConsultaCobranzasH2H_request`
- **Regla:** `count(DEBTORS/DEBTOR) > maxRequestAllowed` → Error "Contratos en solicitud exceden cantidad permitida"
- **Código:**
```xquery
xs:int($maxRequestIn) > xs:int($maxRequestAllowed)
```

### 2. Transformación de recibo HTML (serviceId=9)
- **Ubicación:** `sjConsultaRecaudoH2HOut.xq`, función `transformarReciboHTML`
- **Regla:** Si `$serviceId = "9"`, reemplaza `[` por `<`, `]` por `>`, `@` por `"`
- **Código:**
```xquery
if($serviceId = "9") then (
    replace( replace( replace($dealSlip,'\[','<'), '\]','>'), '@','"')
) else (
    $dealSlip
)
```

### 3. Agrupación de servicios por ID en respuesta
- **Ubicación:** `sjConsultaRecaudoH2HOut.xq`
- **Regla:** Los servicios se agrupan por `distinct-values(ID)` y los deudores de múltiples respuestas del Split-Join se consolidan bajo un solo SERVICE
- **Código:**
```xquery
for $id in distinct-values($SERVICES/SERVICE/ID)
    let $servicesById := $SERVICES/SERVICE[ ID = $id ]
    let $service1 := $servicesById[1]
```

### 4. Cuota de peticiones diarias
- **Ubicación:** Stage `ValidaCantidadPeticionesXdía`
- **Regla:** Si `PV_DESCRIPCIONMENSAJE` no está vacío, se salta toda la lógica de consulta y retorna error
- **Comportamiento:** La variable `$validationMessage` se propaga a los stages siguientes como flag de bypass

### 5. Parametrización MAXAGREEMENTS por región
- **Ubicación:** Stage `ObtenerParametrizacion`
- **Regla:** HN01 usa `FICBCO0244.MAXAGREEMENTS`, GT01 usa `FICBCO0244.MAXAGREEMENTS.GT`
- **Código:**
```xquery
if ( $souceBank = 'HN01' ) then ("FICBCO0244.MAXAGREEMENTS")
else if ( $souceBank = 'GT01' ) then ("FICBCO0244.MAXAGREEMENTS.GT")
else ()
```

### 6. Enriquecimiento con convenios
- **Ubicación:** `sjConsultaRecaudoH2HIn.xq`
- **Regla:** Se busca en `PT_INFOCONVENIOS` el convenio que coincida con el `ID_SERVICIO` para agregar `CONTRACT_ID` y `NAME` al request del Split-Join
- **Código:**
```xquery
let $infoConvenio := $PT_INFOCONVENIOS/ns3:PT_INFOCONVENIOS_ITEM[ ns3:ID_SERVICIO = data($service/ID) ]
```
