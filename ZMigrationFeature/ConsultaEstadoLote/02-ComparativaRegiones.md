# Comparativa entre Regiones - ConsultaEstadoLote

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | NI01 (Nicaragua) | PA01 (Panamá) |
|---------|----------------|------------------|------------------|---------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/Cards/consultaEstadoLote` | `/Middleware/OperationsAndExecution/Cards/consultaEstadoLote` | `/Middleware/OperationsAndExecution/Cards/consultaEstadoLote` | `/Middleware/OperationsAndExecution/Cards/consultaEstadoLote` |
| **Tipo de Backend** | Base de Datos Oracle | Servicio SOAP Externo (MTR) | Servicio SOAP Externo (MTR) | Servicio SOAP Externo (MTR) |
| **Nombre de Base de Datos** | ConnectionProxyAbanksHN | N/A | N/A | N/A |
| **Esquema** | PMS_K_PAGOS_MASIVOS | N/A | N/A | N/A |
| **Stored Procedure** | PMS_P_CON_ESTADO_LOTE | N/A | N/A | N/A |
| **Nombre de Conexión** | eis/DB/ConnectionProxyAbanksHN | N/A | N/A | N/A |
| **Endpoint WSDL Externo** | N/A | https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint | https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint | https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint |
| **Operación WSDL** | N/A | consultarLote | consultarLote | consultarLote |
| **Namespace WSDL** | N/A | http://servicio.consultalotews.mtrpmsv.cidenet.com.co/ | http://servicio.consultalotews.mtrpmsv.cidenet.com.co/ | http://servicio.consultalotews.mtrpmsv.cidenet.com.co/ |
| **XQuery Entrada** | consultaEstadoLoteIn.xqy | consultaEstadoLoteGTIn.xqy | consultaEstadoLoteNIIn.xqy | consultaEstadoLotePAIn.xqy |
| **XQuery Salida** | consultaEstadoLoteOut.xqy | consultaEstadoLoteGTOut.xqy | consultaEstadoLoteNIOut.xqy | consultaEstadoLotePAOut.xqy |
| **XQuery Header Salida** | consultaEstadoLoteHeaderOut.xqy | consultaEstadoLoteGTHeaderOut.xqy | consultaEstadoLoteNIHeaderOut.xqy | consultaEstadoLotePAHeaderOut.xqy |
| **Validación Acceso Usuario** | Sí (validaAccesoPMS) | No | No | No |
| **Validación Regional** | Sí (ValidaServicioRegional) | Sí (ValidaServicioRegional) | Sí (ValidaServicioRegional) | Sí (ValidaServicioRegional) |
| **Service ID** | FICBCO0231 | FICBCO0231 | FICBCO0231 | FICBCO0231 |
| **Campo UPLOAD_DATE** | Usado en transformación | Usado en transformación | Usado en transformación | Usado en transformación |
| **Manejo de Errores** | MapeoErrores | MapeoErrores | MapeoErrores | MapeoErrores |
| **Timeout Configurado** | No detectado | No detectado | No detectado | No detectado |
| **Retry Configurado** | No detectado | No detectado | No detectado | No detectado |

---

## Detalles por Región

### HN01 - Honduras

#### Características Específicas

**Backend:**
- Conexión directa a base de datos Oracle mediante DB Adapter
- Package: `PMS_K_PAGOS_MASIVOS`
- Stored Procedure: `PMS_P_CON_ESTADO_LOTE`
- Conexión JNDI: `eis/DB/ConnectionProxyAbanksHN`

**Validaciones Adicionales:**
1. **ValidaServicioRegional**: Verifica que el servicio FICBCO0231 esté habilitado para HN01
2. **validaAccesoPMS**: Valida que el usuario tenga acceso al sistema de pagos masivos
   - Parámetros: CUSTOMER_ID, USER_NAME
   - Si falla, retorna error inmediatamente sin consultar el lote

**Flujo de Transformación:**

**Entrada (OSB → DB):**
```xquery
<InputParameters>
    <PV_CODIGOCLIENTE>{CUSTOMER_ID}</PV_CODIGOCLIENTE>
    <PN_NUMEROLOTE>{BANK_BATCH_ID}</PN_NUMEROLOTE>
    <PD_FECINGRESO>{UPLOAD_DATE}</PD_FECINGRESO>
</InputParameters>
```

**Salida (DB → OSB):**
- Mapeo directo desde OutputParameters del SP
- Conversión de arrays Oracle (TVARCHAR30, T_MONTO, TVARCHAR3) a elementos XML
- Conversión de PN_OPTIMISTA (1/0) a YES/NO
- Ajuste de zona horaria en fechas: `fn:adjust-dateTime-to-timezone(PD_FECAPLICACION, ())`

**Campos Diferenciadores:**
- Usa `validationMessage` variable para controlar flujo de error
- Validación de acceso antes de consultar el lote
- Manejo de arrays Oracle nativos

**Errores/Excepciones:**
- Error de validación de acceso: retorna error sin consultar DB
- Error de SP: código y mensaje desde PV_CODIGOMENSAJE y PV_DESCRIPCIONMENSAJE
- Error de pipeline: capturado por error handler, mapeado vía MapeoErrores

---

### GT01 - Guatemala

#### Características Específicas

**Backend:**
- Servicio SOAP externo (MTR - Cidenet)
- Endpoint: `https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint`
- Operación: `consultarLote`

**Validaciones:**
- Solo ValidaServicioRegional (sin validación de acceso de usuario)

**Flujo de Transformación:**

**Entrada (OSB → MTR):**
```xml
<consultarLote>
    <solicitudConsultaLote>
        <fechaRegistroLote>{UPLOAD_DATE as dateTime}</fechaRegistroLote>
        <idBancoOrigen>{SourceBank}</idBancoOrigen>
        <idCliente>{CUSTOMER_ID}</idCliente>
        <idLote>{BANK_BATCH_ID}</idLote>
    </solicitudConsultaLote>
</consultarLote>
```

**Salida (MTR → OSB):**
- Mapeo desde `respuestaConsultaLote/detalleRespuesta`
- Conversión de optimista: 'S' → 'YES', 'N' → 'NO'
- Iteración sobre arrays de cuentas y pagos

**Campos Diferenciadores:**
- Incluye `idBancoOrigen` en request (valor: GT01)
- Estructura de respuesta anidada: cabeceraRespuesta + detalleRespuesta
- Campo `optimista` como string ('S'/'N') en lugar de número

**Errores/Excepciones:**
- Error de servicio: código y mensaje desde `cabeceraRespuesta/codigo` y `cabeceraRespuesta/mensaje`
- Validación de WSDL antes de invocar servicio
- Error de pipeline: capturado por error handler global

**Transformaciones Clave:**
- Función `optimista()` para convertir S/N a YES/NO
- Uso de `fn-bea:trim()` y `upper-case()` para normalizar valores

---

### NI01 - Nicaragua

#### Características Específicas

**Backend:**
- Servicio SOAP externo (MTR - Cidenet) - mismo que GT01
- Endpoint: `https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint`
- Operación: `consultarLote`

**Validaciones:**
- Solo ValidaServicioRegional (sin validación de acceso de usuario)

**Flujo de Transformación:**

**Entrada (OSB → MTR):**
```xml
<consultarLote>
    <solicitudConsultaLote>
        <fechaRegistroLote>{UPLOAD_DATE as dateTime}</fechaRegistroLote>
        <idBancoOrigen>{SourceBank}</idBancoOrigen>
        <idCliente>{CUSTOMER_ID}</idCliente>
        <idLote>{BANK_BATCH_ID}</idLote>
    </solicitudConsultaLote>
</consultarLote>
```

**Salida (MTR → OSB):**
- Idéntica a GT01
- Mapeo desde `respuestaConsultaLote/detalleRespuesta`
- Conversión de optimista: 'S' → 'YES', 'N' → 'NO'

**Campos Diferenciadores:**
- Incluye `idBancoOrigen` en request (valor: NI01)
- Estructura de respuesta idéntica a GT01

**Errores/Excepciones:**
- Manejo idéntico a GT01
- Error de servicio: código y mensaje desde `cabeceraRespuesta`

**Transformaciones Clave:**
- Función `optimista()` idéntica a GT01
- XQuery prácticamente idéntico a GT01, solo difiere en nombre de archivo

---

### PA01 - Panamá

#### Características Específicas

**Backend:**
- Servicio SOAP externo (MTR - Cidenet) - mismo que GT01 y NI01
- Endpoint: `https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint`
- Operación: `consultarLote`

**Validaciones:**
- Solo ValidaServicioRegional (sin validación de acceso de usuario)

**Flujo de Transformación:**

**Entrada (OSB → MTR):**
```xml
<consultarLote>
    <solicitudConsultaLote>
        <fechaRegistroLote>{UPLOAD_DATE as dateTime}</fechaRegistroLote>
        <idBancoOrigen>{SourceBank}</idBancoOrigen>
        <idCliente>{CUSTOMER_ID}</idCliente>
        <idLote>{BANK_BATCH_ID}</idLote>
    </solicitudConsultaLote>
</consultarLote>
```

**Salida (MTR → OSB):**
- Idéntica a GT01 y NI01
- Mapeo desde `respuestaConsultaLote/detalleRespuesta`
- Conversión de optimista: 'S' → 'YES', 'N' → 'NO'

**Campos Diferenciadores:**
- Incluye `idBancoOrigen` en request (valor: PA01)
- Estructura de respuesta idéntica a GT01 y NI01

**Errores/Excepciones:**
- Manejo idéntico a GT01 y NI01
- Error de servicio: código y mensaje desde `cabeceraRespuesta`

**Transformaciones Clave:**
- Función `optimista()` idéntica a GT01 y NI01
- XQuery prácticamente idéntico a GT01 y NI01, solo difiere en nombre de archivo

---

## Diferencias Clave entre Regiones

### Arquitectura de Backend

| Aspecto | HN01 | GT01/NI01/PA01 |
|---------|------|----------------|
| Tecnología | Oracle Database | SOAP Web Service |
| Protocolo | JDBC/JCA | HTTPS/SOAP |
| Latencia Esperada | Baja (local) | Media (red) |
| Punto de Falla | Base de datos | Servicio externo + red |
| Escalabilidad | Limitada por DB | Limitada por servicio |

### Validaciones

| Validación | HN01 | GT01/NI01/PA01 |
|------------|------|----------------|
| ValidaServicioRegional | ✓ | ✓ |
| validaAccesoPMS | ✓ | ✗ |

### Transformaciones

| Aspecto | HN01 | GT01/NI01/PA01 |
|---------|------|----------------|
| Estructura Request | Flat (3 campos) | Anidada (solicitudConsultaLote) |
| Estructura Response | Flat con arrays | Anidada (cabeceraRespuesta + detalleRespuesta) |
| Campo idBancoOrigen | No usado | Incluido en request |
| Conversión Optimista | 1/0 → YES/NO | S/N → YES/NO |
| Manejo de Arrays | Arrays Oracle nativos | Elementos XML repetidos |

### Manejo de Errores

| Aspecto | HN01 | GT01/NI01/PA01 |
|---------|------|----------------|
| Fuente de Error | PV_CODIGOMENSAJE / PV_DESCRIPCIONMENSAJE | cabeceraRespuesta/codigo / mensaje |
| Validación Previa | validaAccesoPMS puede abortar | Solo ValidaServicioRegional |
| Mapeo de Errores | MapeoErrores | MapeoErrores |

---

## Recomendaciones de Unificación

### Prioridad Alta

1. **Unificar Arquitectura de Backend**
   - Evaluar migrar HN01 a servicio MTR o viceversa
   - Considerar crear capa de abstracción común

2. **Estandarizar Validaciones**
   - Implementar validación de acceso en todas las regiones o removerla de HN01
   - Documentar razón de la diferencia

3. **Normalizar Manejo de Errores**
   - Crear códigos de error estándar independientes del backend
   - Implementar logging consistente

### Prioridad Media

1. **Consolidar XQuery**
   - GT01, NI01 y PA01 tienen XQuery casi idéntico
   - Crear XQuery genérico parametrizado por región

2. **Externalizar Configuración**
   - Mover endpoints a archivos de configuración
   - Permitir cambios sin redespliegue

3. **Implementar Monitoreo Diferenciado**
   - HN01 requiere monitoreo de DB
   - GT01/NI01/PA01 requieren monitoreo de servicio externo

### Prioridad Baja

1. **Optimizar Transformaciones**
   - Reducir iteraciones en XQuery
   - Evaluar uso de XSLT para transformaciones complejas

2. **Documentar Diferencias de Negocio**
   - Validar si diferencias son técnicas o de negocio
   - Documentar razones de cada diferencia
