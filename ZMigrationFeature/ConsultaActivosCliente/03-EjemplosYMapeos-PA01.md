# Ejemplos y Mapeos - PA01 (Panamá)

## Request OSB

```xml
<con:consultaActivosClienteRequest>
   <CUSTOMER_ID>300789012</CUSTOMER_ID>
   <ASSET_TYPE>ALL</ASSET_TYPE>
</con:consultaActivosClienteRequest>
```

**Header**:
```xml
<aut:RequestHeader>
   <Authentication>
      <UserName>USUARIO_PA</UserName>
      <Password>PASSWORD123</Password>
   </Authentication>
   <Region>
      <SourceBank>PA01</SourceBank>
      <DestinationBank>PA01</DestinationBank>
   </Region>
</aut:RequestHeader>
```

## Response OSB

```xml
<con:consultaActivosClienteResponse>
   <consultaActivosClienteAhorrosResponseType>
      <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
      <consultaActivosClienteResponseRecordType>
         <ASSET_TYPE>AHO</ASSET_TYPE>
         <ASSET_NUMBER>PA5678901234</ASSET_NUMBER>
         <ASSET_NAME>CUENTA AHORRO PERSONAL</ASSET_NAME>
         <ASSET_CURRENCY>USD</ASSET_CURRENCY>
         <ASSET_TOTAL_BALANCE>12500.00</ASSET_TOTAL_BALANCE>
         <ASSET_RESERVE_BALANCE>500.00</ASSET_RESERVE_BALANCE>
         <ASSET_LOCKED_BALANCE>0.00</ASSET_LOCKED_BALANCE>
         <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
         <ASSET_AVAILABLE_BALANCE>12000.00</ASSET_AVAILABLE_BALANCE>
         <ASSET_SOURCE_BANK>PA01</ASSET_SOURCE_BANK>
         <ASSET_PRODUCT_TYPE>AHORRO PERSONAL</ASSET_PRODUCT_TYPE>
      </consultaActivosClienteResponseRecordType>
   </consultaActivosClienteAhorrosResponseType>
   <consultaActivosClienteCorrienteResponseType>
      <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
   </consultaActivosClienteCorrienteResponseType>
   <consultaActivosClienteDepositosResponseType>
      <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
      <consultaActivosClienteResponseRecordType>
         <ASSET_TYPE>DEP</ASSET_TYPE>
         <ASSET_NUMBER>PADEP987654</ASSET_NUMBER>
         <ASSET_NAME>DEPOSITO A PLAZO 6 MESES</ASSET_NAME>
         <ASSET_CURRENCY>USD</ASSET_CURRENCY>
         <ASSET_TOTAL_BALANCE>50000.00</ASSET_TOTAL_BALANCE>
         <ASSET_RESERVE_BALANCE>0.00</ASSET_RESERVE_BALANCE>
         <ASSET_LOCKED_BALANCE>50000.00</ASSET_LOCKED_BALANCE>
         <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
         <ASSET_AVAILABLE_BALANCE>0.00</ASSET_AVAILABLE_BALANCE>
         <ASSET_SOURCE_BANK>PA01</ASSET_SOURCE_BANK>
      </consultaActivosClienteResponseRecordType>
   </consultaActivosClienteDepositosResponseType>
</con:consultaActivosClienteResponse>
```

## Cadenas de Conexión

### Base de Datos Oracle - AbanksPA

**Conexión JCA**: `jca://eis/DB/ConnectionProxyAbanksPA`
- **Tipo**: DB Adapter (JCA)
- **Connection Mode**: Managed
- **Dispatch Policy**: weblogic.wsee.mdb.DispatchPolicy
- **Esquema**: OSB_K_CONLISTACUENTAS
- **Package**: OSB_K_CONLISTACUENTAS
- **Stored Procedure Cuentas**: TOPLEVEL$OSB_P_CON_LISTA_CUEN
- **Stored Procedure Depósitos**: Similar para depósitos

**Business Services**:
1. `consultaListaCuentas_db`
   - Ruta: `Middleware/v2/BusinessServices/ABKPA/consultaListaCuentas/biz/consultaListaCuentas_db.biz`
   - Operación: `consultaListaCuentas`
   - Retry: 1
   
2. `consultaListaDepositosCliente_db`
   - Ruta: `Middleware/v2/BusinessServices/ABKPA/consultaListaDepositos/biz/consultaListaDepositosCliente_db.biz`
   - Operación: `consultaListaDepositosCliente`

3. `sjConsultaActivosCliente` (Split-Join)
   - Ruta: `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/biz/sjConsultaActivosCliente.biz`
   - Flow: `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/flow/sjConsultaActivosCliente.flow`

## Tablas de Mapeo de Entrada

### Mapeo 1: OSB → consultaListaCuentas (DB)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|-------------------|----------------|-------------------|
| consultaActivosClienteRequest/CUSTOMER_ID | Directo | PV_CUSTOMER_ID |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasPAIn.xq`

### Mapeo 2: OSB → consultaListaDepositos (DB)

| Campo Origen (OSB) | Transformación | Campo Destino (SP) |
|-------------------|----------------|-------------------|
| consultaActivosClienteRequest/CUSTOMER_ID | Directo | PV_CUSTOMER_ID |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosPAIn.xq`

### Mapeo 3: OSB → sjConsultaActivosCliente (Split-Join)

| Campo Origen (OSB) | Transformación | Campo Destino (Split-Join) |
|-------------------|----------------|---------------------------|
| consultaActivosClienteRequest/CUSTOMER_ID | Directo | PV_CUSTOMER_ID |
| consultaActivosClienteRequest/ASSET_TYPE | Directo | PV_ASSET_TYPE |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClientesPAIn.xq`

## Tablas de Mapeo de Salida

### Mapeo: Stored Procedure → OSB

**Idéntico a GT01**, con la única diferencia:

| Campo Origen (SP) | Transformación | Campo Destino (OSB) |
|------------------|----------------|---------------------|
| Constante "PA01" | Directo | ASSET_SOURCE_BANK |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClientePAOut.xq`

## Reglas de Negocio

### Arquitectura y Lógica

**Panamá (PA01) utiliza la misma arquitectura y reglas de negocio que Guatemala (GT01)**:

1. **Enrutamiento por Tipo de Activo**: Idéntico a GT01
2. **Split-Join Paralelo**: Idéntico a GT01
3. **Filtrado por Tipo**: Idéntico a GT01
4. **Validación de Funcionalidad Usuario**: Idéntico a GT01

### Diferencias con GT01

| Aspecto | GT01 | PA01 |
|---------|------|------|
| **Conexión DB** | ConnectionProxyAbanksGT | ConnectionProxyAbanksPA |
| **Retry** | 0 | 1 |
| **Dispatch Policy** | No configurado | weblogic.wsee.mdb.DispatchPolicy |
| **ASSET_SOURCE_BANK** | "GT01" | "PA01" |
| **Moneda Principal** | GTQ (Quetzal) | USD (Dólar) |

### Configuración Específica

**Retry Policy**:
```xml
<tran:retry-count>1</tran:retry-count>
<tran:retry-interval>30</tran:retry-interval>
<tran:retry-application-errors>true</tran:retry-application-errors>
```

**Dispatch Policy**:
```xml
<jca:dispatch-policy>weblogic.wsee.mdb.DispatchPolicy</jca:dispatch-policy>
```

---

**Nota**: Panamá comparte la misma implementación técnica que Guatemala, con diferencias mínimas en configuración de infraestructura y parámetros regionales.
