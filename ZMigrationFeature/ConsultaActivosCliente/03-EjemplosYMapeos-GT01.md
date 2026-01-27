# Ejemplos y Mapeos - GT01 (Guatemala)

## Request OSB

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_GT</UserName>
            <Password>PASSWORD123</Password>
         </Authentication>
         <Region>
            <SourceBank>GT01</SourceBank>
            <DestinationBank>GT01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaActivosClienteRequest>
         <CUSTOMER_ID>200456789</CUSTOMER_ID>
         <ASSET_TYPE>ALL</ASSET_TYPE>
      </con:consultaActivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB

```xml
<con:consultaActivosClienteResponse>
   <consultaActivosClienteAhorrosResponseType>
      <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
      <consultaActivosClienteResponseRecordType>
         <ASSET_TYPE>AHO</ASSET_TYPE>
         <ASSET_NUMBER>GT1234567890</ASSET_NUMBER>
         <ASSET_NAME>CUENTA AHORRO MONETARIA</ASSET_NAME>
         <ASSET_CURRENCY>GTQ</ASSET_CURRENCY>
         <ASSET_TOTAL_BALANCE>25000.75</ASSET_TOTAL_BALANCE>
         <ASSET_RESERVE_BALANCE>1000.00</ASSET_RESERVE_BALANCE>
         <ASSET_LOCKED_BALANCE>500.00</ASSET_LOCKED_BALANCE>
         <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
         <ASSET_AVAILABLE_BALANCE>23500.75</ASSET_AVAILABLE_BALANCE>
         <ASSET_SOURCE_BANK>GT01</ASSET_SOURCE_BANK>
         <ASSET_PRODUCT_TYPE>AHORRO MONETARIA</ASSET_PRODUCT_TYPE>
      </consultaActivosClienteResponseRecordType>
   </consultaActivosClienteAhorrosResponseType>
   <consultaActivosClienteCorrienteResponseType>
      <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
      <consultaActivosClienteResponseRecordType>
         <ASSET_TYPE>CHQ</ASSET_TYPE>
         <ASSET_NUMBER>GT9876543210</ASSET_NUMBER>
         <ASSET_NAME>CUENTA CORRIENTE EMPRESARIAL</ASSET_NAME>
         <ASSET_CURRENCY>GTQ</ASSET_CURRENCY>
         <ASSET_TOTAL_BALANCE>50000.00</ASSET_TOTAL_BALANCE>
         <ASSET_RESERVE_BALANCE>2000.00</ASSET_RESERVE_BALANCE>
         <ASSET_LOCKED_BALANCE>0.00</ASSET_LOCKED_BALANCE>
         <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
         <ASSET_AVAILABLE_BALANCE>48000.00</ASSET_AVAILABLE_BALANCE>
         <ASSET_SOURCE_BANK>GT01</ASSET_SOURCE_BANK>
         <ASSET_PRODUCT_TYPE>CORRIENTE EMPRESARIAL</ASSET_PRODUCT_TYPE>
      </consultaActivosClienteResponseRecordType>
   </consultaActivosClienteCorrienteResponseType>
   <consultaActivosClienteDepositosResponseType>
      <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
      <consultaActivosClienteResponseRecordType>
         <ASSET_TYPE>DEP</ASSET_TYPE>
         <ASSET_NUMBER>GTDEP123456</ASSET_NUMBER>
         <ASSET_NAME>DEPOSITO A PLAZO 12 MESES</ASSET_NAME>
         <ASSET_CURRENCY>GTQ</ASSET_CURRENCY>
         <ASSET_TOTAL_BALANCE>100000.00</ASSET_TOTAL_BALANCE>
         <ASSET_RESERVE_BALANCE>0.00</ASSET_RESERVE_BALANCE>
         <ASSET_LOCKED_BALANCE>100000.00</ASSET_LOCKED_BALANCE>
         <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
         <ASSET_AVAILABLE_BALANCE>0.00</ASSET_AVAILABLE_BALANCE>
         <ASSET_SOURCE_BANK>GT01</ASSET_SOURCE_BANK>
      </consultaActivosClienteResponseRecordType>
   </consultaActivosClienteDepositosResponseType>
</con:consultaActivosClienteResponse>
```

## Cadenas de Conexión

### Base de Datos Oracle - AbanksGT

**Conexión JCA**: `jca://eis/DB/ConnectionProxyAbanksGT`
- **Tipo**: DB Adapter (JCA)
- **Connection Mode**: Managed
- **Esquema**: OSB_K_CONLISTACUENTAS
- **Package**: OSB_K_CONLISTACUENTAS
- **Stored Procedure Cuentas**: TOPLEVEL$OSB_P_CON_LISTA_CUEN
- **Stored Procedure Depósitos**: Similar para depósitos

**Business Services**:
1. `consultaListaCuentas_db`
   - Ruta: `Middleware/v2/BusinessServices/ABKGT/consultaListaCuentas/biz/consultaListaCuentas_db.biz`
   - Operación: `consultaListaCuentas`
   
2. `consultaListaDepositosCliente_db`
   - Ruta: `Middleware/v2/BusinessServices/ABKGT/consultaListaDepositos/biz/consultaListaDepositosCliente_db.biz`
   - Operación: `consultaListaDepositosCliente`

3. `sjConsultaActivosCliente` (Split-Join)
   - Ruta: `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/biz/sjConsultaActivosCliente.biz`
   - Flow: `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/flow/sjConsultaActivosCliente.flow`

## Tablas de Mapeo de Entrada

### Mapeo 1: OSB → consultaListaCuentas (DB)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|-------------------|----------------|-------------------|
| consultaActivosClienteRequest/CUSTOMER_ID | Directo | PV_CUSTOMER_ID |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasGTIn.xq`

### Mapeo 2: OSB → consultaListaDepositos (DB)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|-------------------|----------------|-------------------|
| consultaActivosClienteRequest/CUSTOMER_ID | Directo | PV_CUSTOMER_ID |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosGTIn.xq`

### Mapeo 3: OSB → sjConsultaActivosCliente (Split-Join)

| Campo Origen (OSB) | Transformación | Campo Destino (Split-Join) |
|-------------------|----------------|---------------------------|
| consultaActivosClienteRequest/CUSTOMER_ID | Directo | PV_CUSTOMER_ID |
| consultaActivosClienteRequest/ASSET_TYPE | Directo | PV_ASSET_TYPE |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClientesGTIn.xq`

## Tablas de Mapeo de Salida

### Mapeo: Stored Procedure → OSB (Cuentas)

| Campo Origen (SP) | Transformación | Campo Destino (OSB) |
|------------------|----------------|---------------------|
| OutputParametersCuentas/PV_ERROR_CODE | mensajeRespuesta() | SUCCESS_INDICATOR |
| OutputParametersCuentas/PV_ASSET_TYPE_OUT | Filtro AHO/CHQ | ASSET_TYPE |
| OutputParametersCuentas/PV_ASSET_NUMBER | Directo | ASSET_NUMBER |
| OutputParametersCuentas/PV_ASSET_NAME | Directo | ASSET_NAME |
| OutputParametersCuentas/PV_ASSET_CURRENCY | Directo | ASSET_CURRENCY |
| OutputParametersCuentas/PV_ASSET_TOTAL_BALANCE | Directo | ASSET_TOTAL_BALANCE |
| OutputParametersCuentas/PV_ASSET_RESERVE_BALANCE | Directo | ASSET_RESERVE_BALANCE |
| OutputParametersCuentas/PV_ASSET_LOCKED_BALANCE | Directo | ASSET_LOCKED_BALANCE |
| OutputParametersCuentas/PV_ASSET_VISA_FLOATING_BALANCE | Directo | ASSET_VISA_FLOATING_BALANCE |
| OutputParametersCuentas/PV_ASSET_AVAILABLE_BALANCE | Directo | ASSET_AVAILABLE_BALANCE |
| OutputParametersCuentas/PV_ASSET_PRODUCT_TYPE | Directo | ASSET_PRODUCT_TYPE |
| Constante "GT01" | Directo | ASSET_SOURCE_BANK |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClienteGTOut.xq`

**Función mensajeRespuesta**:
```xquery
declare function mensajeRespuesta($successIndicator as xs:string, $registros as item()*) as xs:string {
  if (upper-case($successIndicator) = 'SUCCESS' and count($registros) > 0) then 'Success'
  else if ((upper-case($successIndicator) = 'SUCCESS' and count($registros) = 0) or upper-case($successIndicator) = 'NO RECORDS') then 'No Records'
  else 'Error'
};
```

### Mapeo: Stored Procedure → OSB (Depósitos)

| Campo Origen (SP) | Transformación | Campo Destino (OSB) |
|------------------|----------------|---------------------|
| OutputParametersDepositos/PV_ERROR_CODE | mensajeRespuesta() | SUCCESS_INDICATOR |
| OutputParametersDepositos/PV_ASSET_TYPE | Directo | ASSET_TYPE |
| OutputParametersDepositos/PV_ASSET_NUMBER | Directo | ASSET_NUMBER |
| OutputParametersDepositos/PV_ASSET_NAME | Directo | ASSET_NAME |
| OutputParametersDepositos/PV_ASSET_CURRENCY | Directo | ASSET_CURRENCY |
| OutputParametersDepositos/PV_ASSET_TOTAL_BALANCE | Directo | ASSET_TOTAL_BALANCE |
| OutputParametersDepositos/PV_ASSET_RESERVE_BALANCE | Directo | ASSET_RESERVE_BALANCE |
| OutputParametersDepositos/PV_ASSET_LOCKED_BALANCE | Directo | ASSET_LOCKED_BALANCE |
| OutputParametersDepositos/PV_ASSET_VISA_FLOATING_BALANCE | Directo | ASSET_VISA_FLOATING_BALANCE |
| OutputParametersDepositos/PV_ASSET_AVAILABLE_BALANCE | Directo | ASSET_AVAILABLE_BALANCE |
| Constante "GT01" | Directo | ASSET_SOURCE_BANK |

## Reglas de Negocio

### Regla 1: Enrutamiento por Tipo de Activo

**Ubicación**: `ConsultaActivosCliente.proxy` - Pipeline `GT01_ConsultaActivosCliente_request`

```xml
<con2:ifThenElse>
  <con2:case>
    <con2:condition>
      <con1:xqueryText>fn:string($product) = "AHO" or fn:string($product) = "CHQ" or fn:string($product) = "CTA"</con1:xqueryText>
    </con2:condition>
    <con2:actions>
      <con2:wsCallout>
        <con2:service ref="Middleware/v2/BusinessServices/ABKGT/consultaListaCuentas/biz/consultaListaCuentas_db"/>
      </con2:wsCallout>
    </con2:actions>
  </con2:case>
  <con2:case>
    <con2:condition>
      <con1:xqueryText>fn:string($product) = "DEP"</con1:xqueryText>
    </con2:condition>
    <con2:actions>
      <con2:wsCallout>
        <con2:service ref="Middleware/v2/BusinessServices/ABKGT/consultaListaDepositos/biz/consultaListaDepositosCliente_db"/>
      </con2:wsCallout>
    </con2:actions>
  </con2:case>
  <con2:case>
    <con2:condition>
      <con1:xqueryText>fn:string($product) = "ALL"</con1:xqueryText>
    </con2:condition>
    <con2:actions>
      <con2:wsCallout>
        <con2:service ref="Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/biz/sjConsultaActivosCliente"/>
      </con2:wsCallout>
    </con2:actions>
  </con2:case>
</con2:ifThenElse>
```

### Regla 2: Split-Join Paralelo (ASSET_TYPE = ALL)

**Ubicación**: `sjConsultaActivosCliente.flow`

**Descripción**: Ejecuta en paralelo consultas de cuentas y depósitos.

```xml
<bpel:flow bea:name="invokeCustomerOperations">
  <bpel:scope bea:name="consultaListaCuentas">
    <bpel:sequence>
      <bpel:assign>
        <!-- Transformación para cuentas -->
      </bpel:assign>
      <bpel:invoke operation="consultaListaCuentas" partnerLink="consultaListaCuentas_db"/>
    </bpel:sequence>
  </bpel:scope>
  <bpel:scope bea:name="consultaListaDepositos">
    <bpel:sequence>
      <bpel:assign>
        <!-- Transformación para depósitos -->
      </bpel:assign>
      <bpel:invoke operation="consultaListaDepositosCliente" partnerLink="consultaListaDepositosCliente_db"/>
    </bpel:sequence>
  </bpel:scope>
</bpel:flow>
```

### Regla 3: Filtrado por Tipo en Transformación

**Ubicación**: `sjConsultaActivosClienteGTOut.xq`

**Descripción**: Filtra cuentas por tipo (AHO/CHQ) en la transformación de salida.

```xquery
for $i in (1 to count($assetNumber))
return
if (fn:string($assetTypeOut[$i]) = "AHO") then (
  <ns1:consultaActivosClienteResponseRecordType>
    <!-- Campos para ahorro -->
  </ns1:consultaActivosClienteResponseRecordType>
) else ()
```

### Regla 4: Validación de Funcionalidad Usuario

**Ubicación**: `ConsultaActivosCliente.proxy` - Stage `FlujoEntrada`

**Descripción**: Valida permisos del usuario para funcionalidad SALDOS_ACTIVOS.

```xml
<con2:wsCallout>
  <con2:service ref="Middleware/v2/BusinessServices/ValidaFuncionalidadUsuario/biz/ValidaFuncionalidadUsuario_db"/>
  <con2:operation>ValidaFuncionalidadUsuario</con2:operation>
</con2:wsCallout>
```

**Lógica**:
```xquery
if (data($RspFuncionalidadUsuario/val:PV_CODIGO_ERROR) = 'SUCCESS') then
  data($RspFuncionalidadUsuario/val:PV_VALOR)
else
  "ALL"
```

---

**Nota**: Guatemala utiliza arquitectura Split-Join para ejecución paralela, mejorando el rendimiento en consultas de múltiples tipos de activos.
