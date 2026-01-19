# Comparativa entre Regiones - ModificaClienteDesembolsoLineaCredito

## Regiones Detectadas

A partir del análisis del código fuente, se han identificado las siguientes regiones:

1. **HN01** - Honduras (IMPLEMENTADA)
2. **Otras regiones** - No implementadas (retornan error genérico)

**Nota**: El código muestra un patrón de regionalización mediante el campo `RequestHeader/Region/SourceBank`, pero solo HN01 tiene implementación completa.

---

## Tabla Comparativa General

| Aspecto | HN01 (Honduras) | Otras Regiones |
|---------|-----------------|----------------|
| **Estado** | ✅ Implementado | ❌ No implementado |
| **Endpoint OSB** | http://172.23.13.19:8003/Middleware/OperationsAndExecution/CustomerLoans/ModificaClienteDLC | Mismo endpoint |
| **Proxy Regional** | ModificaClienteDesembolsoLineaCreditoHN.proxy | N/A |
| **Base de Datos** | Oracle | N/A |
| **Esquema** | DLC | N/A |
| **Store Procedure** | DLC_P_MODIFICAR_CLIENTE | N/A |
| **Conexión BD** | eis/DB/ConnectionDLC | N/A |
| **Transformaciones** | consultaClienteHNIn.xq, modificaClienteSolEmprendedorHNIn.xq | N/A |
| **Campos Diferenciadores** | NAME, LEGAL_ID, TARGET de ConsultaCliente | N/A |
| **Errores/Excepciones** | MapeoErrores + Error Handler específico | MW-0008 genérico |
| **Timeout** | No explícito | No explícito |
| **Retry** | 0 reintentos | N/A |
| **Dependencias** | ConsultaCliente v3, ValidaServicioRegional, modificaClienteSolEmprendedor_db | ValidaServicioRegional |
| **Service ID** | FICBCO0364 | FICBCO0364 |
| **Logging** | DEBUG | DEBUG |

---

## Detalle HN01 - Honduras

### Arquitectura
```
Cliente → ModificaClienteDesembolsoLineaCredito
           ↓ ValidacionXSD
           ↓ ValidaServicioRegional
           ↓ Branch: HN01
           ↓
         ModificaClienteDesembolsoLineaCreditoHN
           ↓
           ├─→ ConsultaCliente (v3)
           │   └─→ Core Banking/T24
           │
           └─→ modificaClienteSolEmprendedor_db
               └─→ Oracle DB (DLC.DLC_P_MODIFICAR_CLIENTE)
```

### Endpoints y Conexiones

**SOAP Endpoint:**
- URL: http://172.23.13.19:8003/Middleware/OperationsAndExecution/CustomerLoans/ModificaClienteDLC
- Protocolo: SOAP 1.1
- Binding: Document/Literal

**Base de Datos:**
- JNDI: eis/DB/ConnectionDLC
- Schema: DLC
- SP: DLC_P_MODIFICAR_CLIENTE
- Modo: Managed

**Servicios:**
- ConsultaCliente: Middleware/v3/ProxyServices/ConsultaCliente
- ValidaServicioRegional: Middleware/v2/BusinessServices/ValidaServicioRegional

### Transformaciones

**consultaClienteHNIn.xq:**
- Entrada: modificaClienteDesembolsoLineaCredito
- Salida: consultaClienteRequest
- Mapeo: CUSTOMER_ID_TYPE="CUSTOMER_ID", CUSTOMER_ID_VALUE=BASIC/ID

**modificaClienteSolEmprendedorHNIn.xq:**
- Entradas: consultaClienteResponse + modificaClienteDesembolsoLineaCredito
- Salida: InputParameters (18 parámetros)
- Mapeo: Campos básicos + 8 arrays anidados

### Campos Diferenciadores

**Obtenidos de ConsultaCliente (no del request):**
- P_CUSTOMER_NAME
- P_LEGAL_ID
- P_TARGET_ID
- P_TARGET_DESCRIPTION

**Campos con Lógica Especial:**
- P_EMAILS_OLD/NEW: Pares para actualización
- ACTION en arrays: ADD/DEL/UPD

### Validaciones

1. XSD contra serviciosEmpresarialesTypes.xsd
2. ValidaServicioRegional (ServiceId=FICBCO0364)
3. ConsultaCliente debe retornar SUCCESS
4. Stored Procedure valida reglas de negocio

### Manejo de Errores

**Proxy Principal:**
- Captura errores de validación
- Invoca MapeoErrores
- Construye ResponseHeader con error mapeado

**Proxy Regional HN:**
- Captura errores de servicios
- Construye ResponseHeader directo
- No usa MapeoErrores

### Timeouts y Retry

- Retry Count: 0
- Retry Interval: 30s
- Retry Application Errors: true
- Load Balancing: round-robin

### Dependencias

**Servicios OSB:**
1. ValidaServicioRegional_db
2. ConsultaCliente (v3)
3. MapeoErrores

**Base de Datos:**
- Schema: DLC
- SP: DLC_P_MODIFICAR_CLIENTE
- 18 tipos Oracle complejos

---

## Detalle Otras Regiones

### Estado Actual
❌ No implementadas

### Comportamiento
- Recibe request
- Ejecuta validaciones generales
- Branch evalúa SourceBank
- Si no es HN01 → default-branch
- Retorna error MW-0008

### Preparación
Branch node listo para agregar casos:
```xml
<con:branch name="GT01">
  <con:operator>equals</con:operator>
  <con:value>'GT01'</con:value>
  <con:flow>
    <con:route-node name="ModificaClienteDLCGT">
      <con:service ref="Middleware/v2/ProxyServices/ModificaClienteDesembolsoLineaCreditoGT"/>
    </con:route-node>
  </con:flow>
</con:branch>
```

---

## Diferencias Clave

| Aspecto | HN01 | Otras |
|---------|------|-------|
| Proxy Regional | ✅ | ❌ |
| Consulta Previa | ✅ | ❌ |
| SP Modificación | ✅ | ❌ |
| Transformaciones | 2 XQuery | ❌ |
| Error Handling | Completo | Genérico |

---

## Recomendaciones

1. Unificar manejo de errores
2. Parametrizar conexiones
3. Documentar diferencias regionales
4. Implementar feature flags
5. Monitoreo por región

**Última Actualización**: 2024
