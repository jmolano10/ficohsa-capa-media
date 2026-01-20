# Comparativa entre Regiones - ConsultaTransaccionSwitch

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | Otras Regiones (GT01, PA01, NI01, HN02, etc.) |
|---------|-----------------|-----------------------------------------------|
| **Estado de Implementación** | ✅ IMPLEMENTADO | ❌ NO IMPLEMENTADO |
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/CustomerDeposits/ConsultaTransaccionSwitch_v2` | Mismo endpoint (sin implementación) |
| **Nombre de Base de Datos (Validación)** | Oracle Database - ConnectionMiddleware | Mismo (validación regional activa) |
| **Esquemas** | No especificado (inferido del pool) | No especificado |
| **Store Procedure (Validación)** | `MW_P_VALIDA_SERVICIO_REGIONAL` | Mismo SP (retorna error si región no válida) |
| **Nombre de Conexión a Base de datos** | `eis/DB/ConnectionMiddleware` | Mismo |
| **Conexión a T24 (Web Service)** | `consultasTransacciones` (4 endpoints load-balanced) | No aplica (no implementado) |
| **Operación T24** | `Consultadetransaccionswitch` | No aplica |
| **Enquiry T24** | `WS.SWITCH.TRANSACTION` | No aplica |
| **Transformaciones clave** | `consultaTransaccionSwitchHNIn.xq`, `consultaTransaccionSwitchHNOut.xq`, `consultaTransaccionSwitchHOut.xq` | No existen transformaciones específicas |
| **Campos diferenciadores** | Todos los campos del response poblados desde T24 | Response vacío con error |
| **Errores/Excepciones** | Manejo completo de errores T24, validación regional, mapeo de errores | Error estándar: MW-0008 |
| **Timeouts** | 60s operación, 50s conexión | No aplica (falla antes) |
| **Retrys** | 1 retry con 300ms de intervalo | No aplica |
| **Dependencias internas** | ValidaServicioRegional_db, consultasTransacciones, MapeoErrores | Solo ValidaServicioRegional_db |

---

## Detalle por Región

### HN01 - Honduras (Banco Ficohsa)

#### Estado
✅ **COMPLETAMENTE IMPLEMENTADO Y FUNCIONAL**

#### Endpoints OSB

**Proxy Service:**
- URI: `/Middleware/OperationsAndExecution/CustomerDeposits/ConsultaTransaccionSwitch_v2`
- Protocolo: HTTPS
- Binding: SOAP 1.1
- WSDL: `Middleware/v2/Resources/ConsultaTransaccionSwitch/wsdl/consultaTransaccionSwitchPS.wsdl`

#### Base de Datos

**Validación Regional:**
- Tipo: Oracle Database Adapter (JCA)
- Conexión: `eis/DB/ConnectionMiddleware`
- Stored Procedure: `MW_P_VALIDA_SERVICIO_REGIONAL`
- Parámetros:
  - `PV_SERVICIO`: "FICBCO0141"
  - `PV_ORIGEN`: "HN01"
  - `PV_DESTINO`: Valor del header (default: "HN01")
- Salida:
  - `PV_CODIGO_ERROR`: "SUCCESS" si válido
  - `PV_MENSAJE_ERROR`: Mensaje descriptivo
- Cache: 5 minutos (PT5M)

**Nota:** No hay acceso directo a base de datos desde este servicio para HN01, toda la lógica de datos está en T24.

#### Servicios WSDL/SOAP

**consultasTransacciones (T24 Web Service):**
- Namespace: `T24WebServicesImpl`
- Operación: `Consultadetransaccionswitch`
- Endpoints (Load Balanced - Round Robin):
  1. `http://10.9.104.97:7003/svcConsultasTransacciones/services`
  2. `http://10.9.104.32:7004/svcConsultasTransacciones/services`
  3. `http://10.9.104.97:7005/svcConsultasTransacciones/services`
  4. `http://10.9.104.32:7006/svcConsultasTransacciones/services`
- Timeout: 60 segundos
- Connection Timeout: 50 segundos
- Retry: 1 intento, 300ms intervalo
- Retry on Application Errors: Sí

**Request a T24:**
```xml
<ns0:Consultadetransaccionswitch>
    <WebRequestCommon>
        <userName>{credencial_ldap_username}</userName>
        <password>{credencial_ldap_password}</password>
    </WebRequestCommon>
    <WSSWITCHTRANSACTIONType>
        <enquiryInputCollection>
            <columnName>TXN.REF</columnName>
            <criteriaValue>{TRANSACTION_ID}</criteriaValue>
            <operand>EQ</operand>
        </enquiryInputCollection>
    </WSSWITCHTRANSACTIONType>
</ns0:Consultadetransaccionswitch>
```

**Response de T24:**
```xml
<ConsultadetransaccionswitchResponse>
    <Status>
        <successIndicator>Success</successIndicator>
    </Status>
    <WSSWITCHTRANSACTIONType>
        <ZERORECORDS>...</ZERORECORDS> <!-- Si no hay datos -->
        <gWSSWITCHTRANSACTIONDetailType>
            <mWSSWITCHTRANSACTIONDetailType>
                <ID>...</ID>
                <TXNREFERENCE>...</TXNREFERENCE>
                <VALUEDATE>...</VALUEDATE>
                <CURRENCY>...</CURRENCY>
                <AMOUNT>...</AMOUNT>
                <ATMID>...</ATMID>
                <NETWORKID>...</NETWORKID>
                <TRACENUMBER>...</TRACENUMBER>
                <TXNDATE>...</TXNDATE>
                <TXNTIME>...</TXNTIME>
                <MCCCODE>...</MCCCODE>
                <AUTHCODE>...</AUTHCODE>
                <BRANCHNAME>...</BRANCHNAME>
            </mWSSWITCHTRANSACTIONDetailType>
        </gWSSWITCHTRANSACTIONDetailType>
    </WSSWITCHTRANSACTIONType>
</ConsultadetransaccionswitchResponse>
```

#### Mapeos de Datos

**Request OSB → T24:**

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|---------------------|
| `consultaTransaccionSwitch/TRANSACTION_ID` | Directo | `WSSWITCHTRANSACTIONType/enquiryInputCollection/criteriaValue` |
| - | Constante: "TXN.REF" | `WSSWITCHTRANSACTIONType/enquiryInputCollection/columnName` |
| - | Constante: "EQ" | `WSSWITCHTRANSACTIONType/enquiryInputCollection/operand` |
| `RequestHeader/Authentication/UserName` | `getUsername()` - Lookup LDAP: `concat("Middleware/Security/", upper-case($UserName))` | `WebRequestCommon/userName` |
| `RequestHeader/Authentication/UserName` | `getPassword()` - Lookup LDAP: `concat("Middleware/Security/", upper-case($UserName))` con failover a `RequestHeader/Authentication/Password` | `WebRequestCommon/password` |

**Funciones XQuery:**
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

**Response T24 → OSB:**

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|---------------------|
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNREFERENCE` | `data()` | `consultaTransaccionSwitchResponse/TRANSACTION_ID` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/ATMID` | `data()` | `consultaTransaccionSwitchResponse/ATM_ID` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/NETWORKID` | `data()` | `consultaTransaccionSwitchResponse/NETWORK_ID` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TRACENUMBER` | `data()` | `consultaTransaccionSwitchResponse/ATM_TRACE_NUMBER` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/ID` | `data()` | `consultaTransaccionSwitchResponse/FULL_TRACE_NUMBER` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNDATE` | `data()` | `consultaTransaccionSwitchResponse/TRANSACTION_DATE` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNTIME` | `data()` | `consultaTransaccionSwitchResponse/TRANSACTION_TIME` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/AMOUNT` | `data()` | `consultaTransaccionSwitchResponse/AMOUNT` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/CURRENCY` | `data()` | `consultaTransaccionSwitchResponse/CURRENCY` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/AUTHCODE` | `data()` | `consultaTransaccionSwitchResponse/AUTHORIZATION` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/MCCCODE` | `data()` | `consultaTransaccionSwitchResponse/MCCCODE` |
| `WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/BRANCHNAME` | `data()` | `consultaTransaccionSwitchResponse/BRANCH_NAME` |

**ResponseHeader:**

| Campo Origen | Transformación/Script | Campo Destino |
|-------------|----------------------|---------------|
| Variable `$SuccessIndicator` | Lógica: `if (empty($RSPConsultadetransaccionswitch/WSSWITCHTRANSACTIONType[1]/ZERORECORDS/text())) then "SUCCESS" else "NO RECORDS"` | `ResponseHeader/successIndicator` |
| Variable `$Message` | Si SUCCESS: "Consulta Exitosa", Si NO RECORDS: `data($RSPConsultadetransaccionswitch/WSSWITCHTRANSACTIONType[1]/ZERORECORDS)` | `ResponseHeader/messages` |

#### Reglas de Negocio

**RN-001: Validación de Esquema XSD**
- **Ubicación:** Stage "ValidacionXSD" en pipeline "ValidacionesGenerales_request"
- **Descripción:** Valida que el request cumpla con el esquema `consultaTransaccionSwitchTypes.xsd`
- **Elemento validado:** `consultaTransaccionSwitch`
- **Acción en fallo:** Genera fault, se captura en error handler

**RN-002: Validación de Servicio Regional**
- **Ubicación:** Stage "ValidacionServicioRegional" en pipeline "ValidacionesGenerales_request"
- **Descripción:** Verifica que el servicio FICBCO0141 esté habilitado para la región HN01
- **Stored Procedure:** `MW_P_VALIDA_SERVICIO_REGIONAL`
- **Condición:** `$respValidaServicioRegional/val:PV_CODIGO_ERROR/text() != 'SUCCESS'`
- **Acción en fallo:** 
  - Retorna response vacío
  - Header con `successIndicator=ERROR`
  - Mensaje del SP en `messages`
  - Reply inmediato (no continúa flujo)

**RN-003: Aplicar Valores por Defecto de Región**
- **Ubicación:** Stage "ValidacionServicioRegional", caso default
- **Descripción:** Si la validación es exitosa, aplica valores por defecto a la región
- **XQuery:** `aplicarValoresPorDefectoRegion.xq`
- **Lógica:**
  - Si `SourceBank` está vacío → "HN01"
  - Si `DestinationBank` está vacío → valor de `SourceBank` (o "HN01")

**RN-004: Enrutamiento Regional**
- **Ubicación:** Branch node "RegionalizacionPaisEmpresa"
- **Descripción:** Enruta el request al pipeline correspondiente según `SourceBank`
- **Condición:** `./aut:RequestHeader/Region/SourceBank = 'HN01'`
- **Acción:** Ejecuta pipeline "ConsultaTxnHND"
- **Default:** Ejecuta pipeline "Default_ConsultatxnSwitch" (retorna error MW-0008)

**RN-005: Obtención de Credenciales LDAP**
- **Ubicación:** XQuery `consultaTransaccionSwitchHNIn.xq`, funciones `getUsername()` y `getPassword()`
- **Descripción:** Obtiene credenciales de T24 desde configuración LDAP del servidor OSB
- **Path LDAP:** `Middleware/Security/{UPPER_CASE(UserName)}`
- **Failover:** Si falla `getPassword()`, usa `RequestHeader/Authentication/Password`
- **Acción en fallo:** Si no encuentra credenciales, el servicio falla

**RN-006: Construcción de Enquiry T24**
- **Ubicación:** XQuery `consultaTransaccionSwitchHNIn.xq`
- **Descripción:** Construye el request para el enquiry WS.SWITCH.TRANSACTION en T24
- **Criterio de búsqueda:**
  - `columnName`: "TXN.REF" (campo de transacción en T24)
  - `criteriaValue`: TRANSACTION_ID del request
  - `operand`: "EQ" (igual exacto)

**RN-007: Detección de Sin Resultados**
- **Ubicación:** Stage "ConsultaCoreResponse", pipeline "ConsultaTxnHND_response"
- **Descripción:** Detecta si T24 no encontró la transacción
- **Condición:** `empty($RSPConsultadetransaccionswitch/WSSWITCHTRANSACTIONType[1]/ZERORECORDS/text())`
- **Acción si hay ZERORECORDS:**
  - `successIndicator`: "NO RECORDS"
  - `messages`: Contenido de ZERORECORDS
  - Response body vacío
- **Acción si hay datos:**
  - `successIndicator`: "SUCCESS"
  - `messages`: "Consulta Exitosa"
  - Response body con datos transformados

**RN-008: Mapeo de Errores**
- **Ubicación:** Stage "MapeoError" en pipeline "ValidacionesGenerales_response"
- **Descripción:** Homologa errores a códigos estándar del middleware
- **Condición:** `fn:upper-case($header/aut:ResponseHeader/successIndicator/text()) != "SUCCESS"`
- **Servicio:** Proxy "MapeoErrores", operación `mapeoErrores`
- **Parámetros:**
  - `CODIGO_ERROR`: successIndicator actual
  - `MENSAJE_ERROR`: `concat("FICBCO0141", "$#$", string-join(messages, '||'))`
- **Salida:** ResponseHeader actualizado con código y mensaje homologados

**RN-009: Manejo de Errores Generales**
- **Ubicación:** Pipeline de error "_onErrorHandler"
- **Descripción:** Captura cualquier error no manejado (faults, excepciones)
- **Acciones:**
  1. Extrae `errorCode` de `$fault/ctx:errorCode`
  2. Extrae `errorMessage` de `$fault/ctx:reason`
  3. Invoca MapeoErrores con estos valores
  4. Construye response vacío
  5. Retorna con header de error

#### Políticas OSB

**Seguridad:**
- HTTPS obligatorio en endpoint de entrada
- Autenticación mediante credenciales LDAP para T24
- No hay políticas WS-Security configuradas (binding-mode: wsdl-policy-attachments sin políticas)

**Monitoreo:**
- Monitoring habilitado
- Intervalo de agregación: 10 segundos
- Nivel: Pipeline

**Logging:**
- Habilitado
- Nivel: Debug

**Alerting:**
- SLA Alerting: Habilitado (nivel normal)
- Pipeline Alerting: Habilitado (nivel normal)

**Reporting:**
- Habilitado

**Throttling:**
- Deshabilitado (sin límite de concurrencia)

**Result Caching (Validación Regional):**
- Habilitado
- TTL: 5 minutos
- Token: Concatenación de PV_SERVICIO + PV_ORIGEN + PV_DESTINO

#### Handlers

**Error Handler:**
- Nombre: `_onErrorHandler-9214655891527116282-67c51532.16be20a1e86.-7e24`
- Tipo: Pipeline de error
- Acciones:
  1. Captura error code y reason
  2. Invoca MapeoErrores
  3. Construye response de error
  4. Reply

#### Timeouts y Retrys

**Validación Regional (DB):**
- Retry count: 0
- Retry interval: 30 segundos
- Retry on application errors: Sí

**Consulta T24:**
- Timeout: 60 segundos
- Connection timeout: 50 segundos
- Retry count: 1
- Retry interval: 300ms
- Retry on application errors: Sí

#### Dependencias Internas

1. **ValidaServicioRegional_db**
   - Tipo: Business Service (JCA - Database Adapter)
   - Propósito: Validar habilitación regional del servicio
   - Criticidad: Alta (bloquea ejecución si falla)

2. **consultasTransacciones**
   - Tipo: Business Service (SOAP)
   - Propósito: Consultar transacción en T24
   - Criticidad: Alta (es la fuente de datos principal)

3. **MapeoErrores**
   - Tipo: Proxy Service
   - Propósito: Homologar códigos de error
   - Criticidad: Media (mejora experiencia de usuario, no crítico)

4. **Credenciales LDAP**
   - Tipo: Configuración OSB
   - Path: `Middleware/Security/{USERNAME}`
   - Propósito: Autenticación en T24
   - Criticidad: Alta (sin credenciales, el servicio falla)

---

### GT01 - Guatemala (Banco Ficohsa)

#### Estado
❌ **NO IMPLEMENTADO**

#### Comportamiento Actual

Cuando se invoca el servicio con `SourceBank = 'GT01'`:

1. Pasa validación XSD (estructura correcta)
2. Ejecuta validación regional contra `MW_P_VALIDA_SERVICIO_REGIONAL`
   - Si el SP retorna error → respuesta de error inmediata
   - Si el SP retorna SUCCESS → continúa al siguiente paso
3. Entra al branch "RegionalizacionPaisEmpresa"
4. No coincide con ningún branch específico → va a default-branch
5. Ejecuta pipeline "Default_ConsultatxnSwitch"
6. En el response pipeline, genera error:
   - Error Code: `MW-0008`
   - Error Message: `SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY`
7. Retorna response vacío con header de error

#### Archivos Faltantes

Para implementar GT01, se necesitarían:
- `consultaTransaccionSwitchGTIn.xq` (transformación request)
- `consultaTransaccionSwitchGTOut.xq` (transformación response)
- Configuración de endpoints T24 para Guatemala
- Branch específico en el proxy con condición `SourceBank = 'GT01'`
- Pipeline request/response para Guatemala

#### Diferencias Esperadas vs HN01

Basado en patrones de otros servicios del repositorio:
- Posiblemente diferentes endpoints de T24
- Posibles diferencias en estructura de datos de T24 Guatemala
- Posibles campos adicionales o diferentes en el enquiry
- Credenciales LDAP específicas para Guatemala

---

### PA01 - Panamá (Banco Ficohsa)

#### Estado
❌ **NO IMPLEMENTADO**

#### Comportamiento Actual
Idéntico a GT01 (ver sección anterior).

#### Archivos Faltantes
- `consultaTransaccionSwitchPAIn.xq`
- `consultaTransaccionSwitchPAOut.xq`
- Configuración de endpoints T24 para Panamá
- Branch y pipeline específicos

---

### NI01 - Nicaragua (Banco Ficohsa)

#### Estado
❌ **NO IMPLEMENTADO**

#### Comportamiento Actual
Idéntico a GT01 (ver sección anterior).

#### Archivos Faltantes
- `consultaTransaccionSwitchNIIn.xq`
- `consultaTransaccionSwitchNIOut.xq`
- Configuración de endpoints T24 para Nicaragua
- Branch y pipeline específicos

---

### HN02 - Honduras (Otra Entidad)

#### Estado
❌ **NO IMPLEMENTADO**

#### Comportamiento Actual
Idéntico a GT01 (ver sección anterior).

#### Notas
- Posiblemente corresponde a otra entidad bancaria en Honduras
- Requeriría configuración completamente separada de HN01

---

## Resumen de Diferencias Clave

### Implementación
- **HN01:** Flujo completo implementado con transformaciones, conexión a T24, manejo de errores
- **Otras:** Solo estructura base, sin lógica de negocio

### Transformaciones
- **HN01:** 3 XQuery específicos (In, Out, HeaderOut)
- **Otras:** Ninguna transformación específica

### Conexiones Externas
- **HN01:** 
  - Base de datos (validación regional)
  - T24 Web Service (4 endpoints load-balanced)
  - MapeoErrores (homologación)
- **Otras:** Solo base de datos (validación regional)

### Manejo de Errores
- **HN01:** 
  - Validación XSD
  - Validación regional
  - Detección de "sin resultados"
  - Mapeo de errores T24
  - Error handler completo
- **Otras:** 
  - Validación XSD
  - Validación regional
  - Error genérico MW-0008

### Campos de Response
- **HN01:** 12 campos poblados desde T24
- **Otras:** Response vacío

---

## Recomendaciones para Implementación de Regiones Faltantes

### Paso 1: Análisis de Requerimientos
1. Confirmar si las regiones GT01, PA01, NI01, HN02 requieren este servicio
2. Identificar diferencias en el core bancario T24 de cada país
3. Validar disponibilidad del enquiry WS.SWITCH.TRANSACTION en cada T24

### Paso 2: Configuración de Infraestructura
1. Obtener endpoints de T24 para cada región
2. Configurar credenciales LDAP específicas por región
3. Actualizar stored procedure `MW_P_VALIDA_SERVICIO_REGIONAL` para incluir las nuevas regiones

### Paso 3: Desarrollo
1. Crear XQuery de transformación por región (clonar y adaptar los de HN01)
2. Agregar branches en el proxy para cada región
3. Crear pipelines request/response específicos
4. Adaptar mapeos si hay diferencias en estructura de datos

### Paso 4: Pruebas
1. Pruebas unitarias de transformaciones
2. Pruebas de integración con T24 de cada región
3. Pruebas de manejo de errores
4. Pruebas de performance y carga

### Paso 5: Documentación
1. Actualizar este documento con detalles de cada región
2. Documentar diferencias específicas encontradas
3. Crear guías de troubleshooting por región
