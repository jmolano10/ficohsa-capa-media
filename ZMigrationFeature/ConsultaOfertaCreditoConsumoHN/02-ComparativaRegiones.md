# Comparativa entre Regiones - ConsultaOfertaCreditoConsumo

## Regiones Identificadas

- **HN01** – Honduras
- **GT01** – Guatemala

---

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) |
|---------|-----------------|------------------|
| **Proxy de Entrada** | `ConsultaOfertaCreditoConsumo.proxy` → enruta a `ConsultaOfertaCreditoConsumoHN.pipeline` | `ConsultaOfertaCreditoConsumo.proxy` → enruta a `ConsultaOfertaCreditoConsumoGT.pipeline` |
| **Endpoint Motor de Decisión** | FICO Blaze Cloud REST: `https://app.dms.uset2.ficoanalyticcloud.com/34ahtjvkip/A5JJwBSiBLVtg1DwTkNlOAeKKbL/RmaDynamicWebService/solutionid/34ahtjvkip` | OIC SOAP: `https://oic.ocservices.ficohsa.com/ic/ws/integration/v1/flows/soap/EPORIGINACIONESG_SOAP/1.0/` |
| **Operación Motor de Decisión** | `epOriginacionesHonduras` | `processWithDecisionFlow2` |
| **Protocolo API** | REST (SOAP wrapping interno, Bearer token) | SOAP (HTTP Basic Auth vía Service Account `DEVCLOUD`) |
| **Autenticación API** | Bearer Token obtenido de `TokenizacionProcesamientoBlazeProxyService` | HTTP Basic Auth (Service Account) + Token en payload |
| **Consulta Riesgo Consolidado** | Sí – `ConsultaConsolidadaRiesgoClienteHN` (wsCallout previo) | No – no se invoca servicio de riesgo consolidado previo |
| **XQuery Request (Cloud)** | `consultaOfertaCreditoConsumoCloudIn.xqy` – recibe `consultaOfertaCreditoConsumoRequest` + `consultaConsolidadaRiesgoClienteResponse` | `processWithDecisionFlow2In.xqy` – recibe `consultaOfertaCreditoConsumoRequest` + `token` |
| **XQuery Response** | `consultaOfertaCreditoConsumoCloudOut.xqy` – mapea `epOriginacionesHondurasResponse` | `consultaOfertaCreditoConsumoGTOut.xqy` – mapea `processWithDecisionFlow2Response` |
| **Almacenamiento de Oferta** | Sí – `AlmacenaInformacionOfertaHonduras_db` (publish/fire-and-forget) | No – no se almacena resultado |
| **Base de Datos Almacenamiento** | `jca://eis/DB/ConnectionCustomerCreditRisk` | N/A |
| **Esquema BD** | `CREDITOS_RIESGOS` | N/A |
| **Package BD** | `HN_ONBASE` | N/A |
| **Stored Procedure** | `AlmacenaInformacionOfertaHonduras` | N/A |
| **Conexión BD** | `ConnectionCustomerCreditRisk` | N/A |
| **Transformaciones Clave** | `consultaConsolidadoRiesgoClienteIn` → `consultaOfertaCreditoConsumoCloudIn` → `consultaOfertaCreditoConsumoCloudOut` → `almacenaInformacionHondurasIN` | `processWithDecisionFlow2In` → `consultaOfertaCreditoConsumoGTOut` |
| **Campos Diferenciadores Request** | Usa respuesta de ConsultaConsolidadaRiesgoCliente como input adicional al motor Blaze | Envía `token` como campo dentro del request al motor OIC; envía `referenciaSIB` del cliente |
| **Validación de Error API** | Captura HTTP response code (401, 503) con error handler específico → asigna `$ErrorCode` → `resume` | Verifica `auditSteps[type = 'ERROR']` en la respuesta; si hay pasos ERROR retorna mensajes |
| **Manejo de Error Global** | Error handler del pipeline: `DESCISION MODELER: $errorMessage` | Error handler del pipeline: `fault/ctx:errorCode` + `fault/ctx:reason` |
| **Timeout API** | 60s (connection: 65s) | 70s (connection: 65s) |
| **Retry** | 0 | 0 |
| **Endpoint Proxy OSB** | `http://mwomnicanal:8003/Middleware/ReferenceData/CommonBusinessInformation/consultaOfertaCreditoConsumo` | Mismo endpoint (enrutamiento dinámico por `SourceBank`) |
| **ServiceId Regional** | `FICBCO0399` | `FICBCO0399` |

---

## Detalle por Región

### HN01 – Honduras

**Flujo:**
1. El pipeline principal (`ConsultaOfertaCreditoConsumo.pipeline`) valida XSD y consulta ruta regional con `FICBCO0399`.
2. La variable `$ubicacion` retorna `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumoHN` → enrutamiento dinámico.
3. Pipeline HN:
   - **Stage 1** – Obtener Identidad: extrae `$identidad` = `CUSTOMER_INFO/ID`
   - **Stage 2** – Llamado ConsultaConsolidadaRiesgoCliente: wsCallout a `ConsultaConsolidadaRiesgoClienteHN` pasando `customerLegalID`
   - **Stage 3** – ObtenerToken: wsCallout a `TokenizacionProcesamientoBlazeProxyService`
   - **Stage 4** – ProcesamientoEntradaCloud: si `$tokenApi != ''`, transforma request con `consultaOfertaCreditoConsumoCloudIn.xqy` y llama a `blazeCloudApiRestBS` (operación `epOriginacionesHonduras`) con Bearer token
   - **Response Stage** – ProcesamientoSalida: si no hay error, transforma con `consultaOfertaCreditoConsumoCloudOut.xqy`; si hay error, retorna mensajes según código HTTP
   - **Response Stage** – Almacenar Oferta: publish a `AlmacenaInformacionOfertaHonduras_db` con `almacenaInformacionHondurasIN.xqy` pasando XML serializado + identidad

**Particularidades HN:**
- Consulta previa de riesgo consolidado como insumo para el motor de decisión
- Almacenamiento asíncrono de la oferta en BD
- Manejo específico de códigos HTTP del API cloud (401=Token inválido, 503=Servicio no disponible)
- Token se obtiene de un servicio interno de tokenización

---

### GT01 – Guatemala

**Flujo:**
1. El pipeline principal valida XSD y consulta ruta regional con `FICBCO0399`.
2. La variable `$ubicacion` retorna `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumoGT` → enrutamiento dinámico.
3. Pipeline GT:
   - **Stage 1** – ObtenerToken: wsCallout a `TokenizacionProcesamientoBlaze` (proxy diferente al de HN); valida `successIndicator` del header de respuesta
   - **Stage 2** – OriginacionesGT: si `$validationMessage = ""` (token OK):
     - Extrae token: `$RSPtokenizacionProcesamientoBlaze/TOKEN`
     - Transforma request con `processWithDecisionFlow2In.xqy` pasando request OSB + token
     - Llama a `originacionesGT` (operación `processWithDecisionFlow2`) vía OIC
   - **Response Stage** – ProcesamientoSalida:
     - Verifica `auditSteps[type = 'ERROR']` en respuesta
     - Si no hay error: transforma con `consultaOfertaCreditoConsumoGTOut.xqy`
     - Si hay error: extrae `stepMessage` de cada `auditSteps` tipo ERROR

**Particularidades GT:**
- No consulta riesgo consolidado previo
- El token se envía como campo dentro del payload al motor OIC (no como header Authorization)
- No almacena resultado en BD
- La validación de error se basa en `auditSteps` internos de la respuesta OIC
- Usa HTTP Basic Auth (Service Account `DEVCLOUD`) para autenticarse ante OIC
