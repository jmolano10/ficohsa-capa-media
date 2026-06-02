# AS-IS – ConsultaConsolidadaRiesgoClienteHN

## 1. Resumen Ejecutivo

| Campo | Valor |
|-------|-------|
| **Servicio OSB** | ConsultaConsolidadaRiesgoClienteHN |
| **Proxy** | `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN.proxy` |
| **Transporte** | Local (invocación interna entre proxies OSB) |
| **Endpoint público** | `http://172.23.13.19:8003/Middleware/OperationsAndExecution/Cards/consultaConsolidadaRiesgoCliente/` |
| **Business Service** | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/biz/consultaConsolidadaRiesgoCliente_db` |
| **Tipo Adapter** | JCA – Database Adapter (Stored Procedure) |
| **Conexión JCA** | `eis/DB/ConnectionCustomerCreditRisk` |
| **Schema BD** | `CREDITOS_RIESGOS` |
| **Package** | `dbo` |
| **Stored Procedure** | `p_consulta_ONBASE_V2` |
| **Región** | HN (Honduras) |
| **Protocolo** | SOAP 1.1 (document/literal) |

## 2. Descripción Funcional

El servicio **ConsultaConsolidadaRiesgoClienteHN** consolida toda la información de riesgo crediticio de un cliente en Honduras. Recibe un número de identidad (`CUSTOMER_LEGAL_ID`) y retorna un XML consolidado con:

- **Información del cliente** (datos demográficos, score, calificación)
- **Activos (Pasivos)** – Cuentas de ahorro/corriente con transacciones
- **Tarjetas de crédito** – Detalle de tarjetas con historiales de 12 meses
- **Préstamos** – Cartera de préstamos con transacciones históricas
- **Extrafin** – Financiamientos extra (cuotas PIL/Extra en tarjetas)
- **Ofertas pre-aprobadas** – Cálculos por tipo (Ficocrédito, Ficoya, OPI, Retanqueo) a 12/24/36/48/60 meses
- **Buró de crédito (Equifax)** – Referencias activas, históricas, direcciones, teléfonos, SICOM, evaluación, consultas

## 3. Flujo de Ejecución

```
Consumer (SOAP) 
    │
    ▼
[ConsultaConsolidadaRiesgoClienteHN.proxy]  ← Transporte: local
    │
    ├─ Request Pipeline: "ConsultaConsolidadRiesgoCliente"
    │     │
    │     ├─ XQ IN: consultaConsolidadaRiesgoClienteIn.xq
    │     │       Mapeo: CUSTOMER_LEGAL_ID → IDENTIDAD
    │     │
    │     └─ WS-Callout → consultaConsolidadaRiesgoCliente_db (BIZ)
    │              │
    │              └─ JCA DB Adapter → SP: CREDITOS_RIESGOS.dbo.p_consulta_ONBASE_V2(@IDENTIDAD)
    │                      │
    │                      └─ Retorna XML consolidado (FOR XML)
    │
    ├─ Response Transform: "$responseData" = fn-bea:inlinedXML(RowSet/Row[1]/Column[1])
    │
    ├─ Response Pipeline: "FujoSalida"
    │     │
    │     ├─ XQ Header: consultaConsolidadaRiesgoClienteHeaderOut.xq
    │     │       → ResponseHeader (successIndicator: "Success" | "NO RECORS")
    │     │
    │     └─ XQ Body: consultaConsolidadaRiesgoClienteOut.xq
    │              → XML estructurado con LOAN_MAINTENANCE + LOAN_ORIGINATIONS
    │
    └─ Error Handler: "_onErrorHandler"
          → ResponseHeader con successIndicator="ERROR" + fault reason
          → Body vacío: <consultaConsolidadaRiesgoClienteResponse/>
```

## 4. Contrato SOAP (Entrada/Salida)

### 4.1 Request

```xml
<consultaConsolidadaRiesgoCliente xmlns="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
    <CUSTOMER_LEGAL_ID>0801198012345</CUSTOMER_LEGAL_ID>
</consultaConsolidadaRiesgoCliente>
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `CUSTOMER_LEGAL_ID` | string (minLength=1) | Número de identidad del cliente HN |

### 4.2 Response Header

```xml
<ResponseHeader xmlns="http://www.ficohsa.com.hn/middleware.services/autType">
    <successIndicator>Success</successIndicator>
</ResponseHeader>
```

### 4.3 Response Body

Estructura principal del response (simplificada):

```xml
<consultaConsolidadaRiesgoClienteResponse>
    <LOAN_MAINTENANCE>
        <CUSTOMER_INFO>
            <ID/> <TARGET/> <DATE_OF_BIRTH/> <AGE/> <TYPE/> <SALARY/> <PAYROLL_SALARY/>
            <CREDIT_MONTHS/> <FLAG_BLAZE/> <FLAG_HIT/> <EVALUATION_RESULT/>
            <ADDRESSES_INFO> <ADDRESS_ITEM>...</ADDRESS_ITEM>* </ADDRESSES_INFO>
            <PHONES_INFO> <PHONE_ITEM>...</PHONE_ITEM>* </PHONES_INFO>
            <ADMINISTRATIVE_CHARGES> <CHARGE>...</CHARGE>* </ADMINISTRATIVE_CHARGES>
            <CURRENT_ARREAR_SUMMARY> <ARREAR>...</ARREAR>* </CURRENT_ARREAR_SUMMARY>
            <EXTERNAL_SCORE/>
            <SCORE_INFO> <SCORE_CALCULATION/> <QUALIFICATION/> <RISK_LEVEL/> </SCORE_INFO>
            <ASSETS> <ASSET>...</ASSET>* </ASSETS>
            <LIABILITIES>
                <CREDIT_CARDS_INFO> <CREDIT_CARD>...</CREDIT_CARD>* </CREDIT_CARDS_INFO>
                <LOANS_INFO> <LOAN>...</LOAN>* </LOANS_INFO>
            </LIABILITIES>
        </CUSTOMER_INFO>
    </LOAN_MAINTENANCE>
    <LOAN_ORIGINATIONS>
        <PRE_APPROVED_OFFERS> <OFFER>...</OFFER>* </PRE_APPROVED_OFFERS>
        <INTERNAL_EXTRAS> <EXTRA>...</EXTRA>* </INTERNAL_EXTRAS>
        <REFERENCES_DETAILS>
            <QUERIES> <QUERY_ITEM>...</QUERY_ITEM>* </QUERIES>
            <ACTIVE_REFERENCES> <REFERENCE>...</REFERENCE>* </ACTIVE_REFERENCES>
            <HISTORICAL_REFERENCES> <REFERENCE>...</REFERENCE>* </HISTORICAL_REFERENCES>
        </REFERENCES_DETAILS>
    </LOAN_ORIGINATIONS>
</consultaConsolidadaRiesgoClienteResponse>
```

## 5. Stored Procedure: `CREDITOS_RIESGOS.dbo.p_consulta_ONBASE_V2`

### 5.1 Parámetro de Entrada

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `@IDENTIDAD` | NVARCHAR(20) | Número de identidad del cliente |

### 5.2 Lógica Interna

El SP construye un XML consolidado (`@XML_CLIENTE`) insertando secciones progresivamente mediante `@XML_CLIENTE.modify('insert ...')`:

| Orden | Variable XML | Tabla/Vista Origen | Schema |
|-------|-------------|-------------------|--------|
| 1 | `@XML_CLIENTE` (raíz) | `HN_ONBASE.MA_CLIENTES` | CREDITOS_RIESGOS |
| 2 | `@XML_PASIVOS` | `HN_ONBASE.MA_PASIVOS` | CREDITOS_RIESGOS |
| 3 | `@XML_TRXPASIVOS` | `HN_ONBASE.MA_TRANSACCIONESPASIVOS` JOIN `MA_PASIVOS` | CREDITOS_RIESGOS |
| 4 | `@XML_TARJETAS` | `HN_ONBASE.MA_TARJETAS` | CREDITOS_RIESGOS |
| 5 | `@XML_TRXTARJETAS` | `HN_ONBASE.MA_TRANSACCIONESTARJETA` | CREDITOS_RIESGOS |
| 6 | `@XML_EXTRAFIN` | `HN_ONBASE.EXTRAFIN` JOIN `MA_TARJETAS` | CREDITOS_RIESGOS |
| 7 | `@XML_PRESTAMOS` | `HN_ONBASE.Ma_Prestamos` | CREDITOS_RIESGOS |
| 8 | `@XML_TRXPRESTAMOS` | `HN_ONBASE.MA_TRANSACCIONESPRESTAMO` JOIN `Ma_Prestamos` | CREDITOS_RIESGOS |
| 9 | `@XML_OFERTA` | `HN_ONBASE.MA_OFERTA_PREAPROBADA` | CREDITOS_RIESGOS |
| 10 | `@XML_EQX_CONTROL` | `[svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL` + `RecordScore` | Linked Server |
| 11 | `@XML_RECORDB` | `[svrpruebas].BURO_EXTERNO.DBO.RecordB` + `EQX_CONTROL` | Linked Server |
| 12 | `@XML_RECORDD` | `[svrpruebas].BURO_EXTERNO.DBO.RecordD` + `EQX_CONTROL` | Linked Server |
| 13 | `@XML_RECORDT` | `[svrpruebas].BURO_EXTERNO.DBO.RecordT` + `EQX_CONTROL` | Linked Server |
| 14 | `@XML_RECORDPRB` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDPRB` + `EQX_CONTROL` + `RECORDhB` | Linked Server |
| 15 | `@XML_RECORDPRD` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDPRD` + `EQX_CONTROL` + `RECORDHD` | Linked Server |
| 16 | `@XML_RECORDPRT` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDPRT` + `EQX_CONTROL` + `RECORDHT` | Linked Server |
| 17 | `@XML_RecordHB` | `[svrpruebas].BURO_EXTERNO.DBO.recordb` + `recordhB` + `EQX_CONTROL` | Linked Server |
| 18 | `@XML_RecordHD` | `[svrpruebas].BURO_EXTERNO.DBO.RecordD` + `EQX_CONTROL` + `recordhD` | Linked Server |
| 19 | `@XML_RECORDHT` | `[svrpruebas].BURO_EXTERNO.DBO.RecordT` + `EQX_CONTROL` + `recordhT` | Linked Server |
| 20 | `@XML_RecordA` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDA` + `EQX_CONTROL` | Linked Server |
| 21 | `@XML_RecordTel` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDTEL` + `EQX_CONTROL` | Linked Server |
| 22 | `@XML_RecordH` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDH` + `EQX_CONTROL` | Linked Server |
| 23 | `@XML_RecordS` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDS` + `EQX_CONTROL` | Linked Server |
| 24 | `@XML_RECORDC` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDC` + `EQX_CONTROL` | Linked Server |
| 25 | `@XML_RECORDEVALUACION` | `[svrpruebas].BURO_EXTERNO.DBO.RECORDEVALUACION` + `EQX_CONTROL` | Linked Server |

### 5.3 Manejo de Errores

```sql
BEGIN CATCH
    -- Construye XML de error con IDENTIDAD + ERROR_MESSAGE()
    SELECT @ErrorXML AS CLIENTE;
END CATCH
```

### 5.4 Dependencias a Buró Externo

El SP hace un **llamado previo a Equifax** (implícito vía `@id_estudio`) para obtener el estudio crediticio vigente. Las tablas del buró están en un **Linked Server** (`[svrpruebas].BURO_EXTERNO.DBO`).

## 6. Artefactos OSB

| Tipo | Ruta | Descripción |
|------|------|-------------|
| Proxy Service | `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN.proxy` | Punto de entrada SOAP |
| Business Service | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/biz/consultaConsolidadaRiesgoCliente_db.biz` | Invocación al SP vía JCA |
| JCA Config | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/jca/consultaConsolidadaRiesgoCliente_db.jca` | Configuración del adapter DB |
| WSDL Proxy | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoClientePS.wsdl` | Contrato público del proxy |
| WSDL BIZ (abstract) | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoCliente.wsdl` | Contrato del adapter |
| WSDL BIZ (concrete) | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoCliente_db.wsdl` | Binding concreto JCA |
| XSD SP | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp.xsd` | Schema del SP (InputParameters/OutputParameters) |
| XSD Types | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd` | Schema de tipos del proxy |
| XQ Input | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteIn.xq` | Transformación request |
| XQ Output | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteOut.xq` | Transformación response |
| XQ Header | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteHeaderOut.xq` | Header de respuesta |

## 7. Conexiones y Dependencias

| Recurso | Tipo | Detalle |
|---------|------|---------|
| `eis/DB/ConnectionCustomerCreditRisk` | JNDI DataSource | Conexión a BD CREDITOS_RIESGOS (SQL Server) |
| `[svrpruebas].BURO_EXTERNO.DBO` | Linked Server | Conexión a BD de Buró Equifax Honduras |
| Schema `CREDITOS_RIESGOS.HN_ONBASE` | Schema SQL Server | Tablas de riesgo cliente HN (ONBASE) |

## 8. Proxies Dependientes

Este proxy es invocado por otros proxies OSB que necesitan la consulta consolidada de riesgo:

| Proxy | Ruta |
|-------|------|
| ConsultaOfertaCreditoConsumo | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaConsolidadoRiesgoClienteIn.xq` |
| ConsultaPrestamoATM | `Middleware/v2/Resources/ConsultaPrestamoATM/xq/consultaConsolidadaRiesgoClienteIn.xq` |

> **Nota:** Si se requiere documentar estos proxies externos, ejecutar la herramienta AS-IS con sus rutas respectivas.

## 9. Mapeo de Datos Relevante

### 9.1 Request: XQ Input
```
CUSTOMER_LEGAL_ID → @IDENTIDAD (parámetro del SP)
```

### 9.2 Response: XQ Output (estructura principal)

El XQ de salida transforma el XML plano del SP en la estructura tipada del XSD:

| Nodo SP (XML) | Nodo Response BIAN |
|---------------|-------------------|
| `/CLIENTE/@*` (atributos root) | `LOAN_MAINTENANCE/CUSTOMER_INFO/*` |
| `/CLIENTE/PASIVOS/CUENTA` | `CUSTOMER_INFO/ASSETS/ASSET` |
| `/CLIENTE/TRANSACCIONESPASIVOS/CUENTA` | `ASSET/PRODUCT_TRANSACTIONS/TRANSACTION` |
| `/CLIENTE/TARJETAS/CUENTA` | `CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD` |
| `/CLIENTE/TRANSACCIONESTARJETA/CUENTA` | `CREDIT_CARD/PRODUCT_TRANSACTIONS/TRANSACTION` (12 periodos) |
| `/CLIENTE/PRESTAMOS/CUENTA` | `CUSTOMER_INFO/LIABILITIES/LOANS_INFO/LOAN` |
| `/CLIENTE/TRANSACCIONESPRESTAMO/CUENTA` | `LOAN/PRODUCT_TRANSACTIONS/TRANSACTION` |
| `/CLIENTE/OFERTAPREAPROBADA/OFERTA` | `LOAN_ORIGINATIONS/PRE_APPROVED_OFFERS/OFFER` (4 tipos) |
| `/CLIENTE/EXTRAFIN/CUENTA` | `LOAN_ORIGINATIONS/INTERNAL_EXTRAS/EXTRA` |
| `/CLIENTE/RECORDC/CUENTA` | `REFERENCES_DETAILS/QUERIES/QUERY_ITEM` |
| `/CLIENTE/RECORDB/CUENTA` | `REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE` (BancaVigente) |
| `/CLIENTE/RECORDD/CUENTA` | `REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE` (ComercioVigente) |
| `/CLIENTE/RECORDT/CUENTA` | `REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE` (TarjetaVigente) |
| `/CLIENTE/RECORDPRB/CUENTA` | `REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE` (BancaHistorico) |
| `/CLIENTE/RECORDPRD/CUENTA` | `REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE` (ComercioHistorico) |
| `/CLIENTE/RECORDPRT/CUENTA` | `REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE` (TarjetaHistorico) |
| `/CLIENTE/RECORDHB/CUENTA` | Enriquecimiento de RECORDB (MoraHistórica, conteoHistórico) |
| `/CLIENTE/RECORDHD/CUENTA` | Enriquecimiento de RECORDD |
| `/CLIENTE/RECORDHT/CUENTA` | Enriquecimiento de RECORDT |
| `/CLIENTE/RECORDA/CUENTA` | `CUSTOMER_INFO/ADDRESSES_INFO/ADDRESS_ITEM` |
| `/CLIENTE/RECORDTEL/CUENTA` | `CUSTOMER_INFO/PHONES_INFO/PHONE_ITEM` |
| `/CLIENTE/RECORDH/CUENTA` | `CUSTOMER_INFO/ADMINISTRATIVE_CHARGES/CHARGE` |
| `/CLIENTE/RECORDS/CUENTA` | `CUSTOMER_INFO/CURRENT_ARREAR_SUMMARY/ARREAR` |
| `/CLIENTE/RECORDEVALUACION/CUENTA` | `CUSTOMER_INFO/EVALUATION_RESULT` |
| `/CLIENTE/EQX_CONTROL/CUENTA` | `CUSTOMER_INFO/EXTERNAL_SCORE` + `SCORE_INFO` |
