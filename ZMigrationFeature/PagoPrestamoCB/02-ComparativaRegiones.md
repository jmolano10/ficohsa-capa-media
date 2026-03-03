# Comparativa entre Regiones - PagoPrestamoCB

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamoCB` | `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamoCB` | `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamoCB` | No Implementado |
| **Estado de Implementación** | ✅ Completo | ⚠️ Parcial (Pipeline vacío) | ⚠️ Parcial (Pipeline vacío) | ❌ No Implementado |
| **Base de Datos** | ConnectionCollections | ConnectionCollections | ConnectionCollections | N/A |
| **Esquema BD Transacciones** | COLLECTIONS | COLLECTIONS | COLLECTIONS | N/A |
| **Esquema BD Middleware** | (Default) | (Default) | (Default) | N/A |
| **Store Procedure - Registro** | OSB_P_MANEJO_TRANSACCIONES.REGISTRA_TRANSACCION_CANAL | OSB_P_MANEJO_TRANSACCIONES.REGISTRA_TRANSACCION_CANAL | OSB_P_MANEJO_TRANSACCIONES.REGISTRA_TRANSACCION_CANAL | N/A |
| **Store Procedure - Actualización** | OSB_P_MANEJO_TRANSACCIONES.ACTUALIZA_ESTADO_TRANSACCION | OSB_P_MANEJO_TRANSACCIONES.ACTUALIZA_ESTADO_TRANSACCION | OSB_P_MANEJO_TRANSACCIONES.ACTUALIZA_ESTADO_TRANSACCION | N/A |
| **Store Procedure - Validación Regional** | MW_P_VALIDA_SERVICIO_REGIONAL | MW_P_VALIDA_SERVICIO_REGIONAL | MW_P_VALIDA_SERVICIO_REGIONAL | N/A |
| **Store Procedure - Validación Corresponsal** | MW_P_VALIDA_CORBAN | MW_P_VALIDA_CORBAN | MW_P_VALIDA_CORBAN | N/A |
| **Store Procedure - Uso Servicio** | MW_P_REGISTRAR_USO_SERVICIO | MW_P_REGISTRAR_USO_SERVICIO | MW_P_REGISTRAR_USO_SERVICIO | N/A |
| **Nombre de Conexión BD Transacciones** | eis/DB/ConnectionCollections | eis/DB/ConnectionCollections | eis/DB/ConnectionCollections | N/A |
| **Nombre de Conexión BD Middleware** | eis/DB/ConnectionMiddleware | eis/DB/ConnectionMiddleware | eis/DB/ConnectionMiddleware | N/A |
| **Endpoint Servicio Caja** | http://mwinterbanca:8003/MiddlewareCaja/PagoPrestamoCaja | http://mwinterbanca:8003/MiddlewareCaja/PagoPrestamoCaja | http://mwinterbanca:8003/MiddlewareCaja/PagoPrestamoCaja | N/A |
| **Transformaciones XQuery** | PagoPrestamoCBHdrIn.xq, PagoPrestamoCBIn.xq | No Aplica (Pipeline vacío) | No Aplica (Pipeline vacío) | N/A |
| **Java Callout** | Utilities.FormatearPrestamo | No Aplica (Pipeline vacío) | No Aplica (Pipeline vacío) | N/A |
| **Campos Diferenciadores** | Implementación completa | Sin implementación | Sin implementación | No soportado |
| **Errores/Excepciones** | Manejo completo de errores | Error MW-0008 | Error MW-0008 | Error MW-0008 |
| **Timeouts** | 0 (sin límite) | 0 (sin límite) | 0 (sin límite) | N/A |
| **Retries** | 0 (sin reintentos) | 0 (sin reintentos) | 0 (sin reintentos) | N/A |
| **Dependencias Internas** | 7 servicios | 3 servicios (validaciones) | 3 servicios (validaciones) | N/A |
| **Tipo de Pago Permitido** | CASH únicamente | N/A | N/A | N/A |
| **Validación de Moneda** | Sí (según parametrización) | Sí (según parametrización) | Sí (según parametrización) | N/A |
| **Control de Cuotas** | Sí | Sí | Sí | N/A |
| **Mapeo de Errores** | Sí | Sí | Sí | N/A |
| **Logging Level** | Debug | Debug | Debug | N/A |
| **Service ID** | FICBCO0211 | FICBCO0211 | FICBCO0211 | N/A |

---

## Sección Detallada por Región

### 1. HN01 - Honduras (Implementación Completa)

#### 1.1. Características Generales

- **Estado:** ✅ Completamente Implementado
- **Pipeline Request:** `HN01_PagoPrestamo_request`
- **Pipeline Response:** `HN01_PagoPrestamo_response`
- **Código de País:** HN01

#### 1.2. Endpoints y Conexiones

**Endpoint OSB:**
```
URI: /SMiddleware/OperationsAndExecution/Payments/PagoPrestamoCB
Protocolo: HTTPS
Método: POST (SOAP)
```

**Endpoint Servicio de Caja:**
```
URI: http://mwinterbanca:8003/MiddlewareCaja/PagoPrestamoCaja
Protocolo: HTTP
Método: POST (SOAP)
Operación: pagoPrestamo
```

**Conexiones a Base de Datos:**
```
1. eis/DB/ConnectionCollections (Esquema: COLLECTIONS)
   - Registro de transacciones
   - Actualización de estados

2. eis/DB/ConnectionMiddleware (Esquema: Default)
   - Validación regional
   - Validación de corresponsal
   - Control de uso de servicio
```

#### 1.3. Mapeos de Datos

**Transformación de Header (PagoPrestamoCBHdrIn.xq):**
```xquery
Input: RequestHeader
Output: AutenticacionRequestHeader

Mapeo:
- UserName: Busca credenciales en LDAP (Middleware/Security/{USERNAME})
  - Si no encuentra: usa RequestHeader/Authentication/UserName
- Password: Busca credenciales en LDAP
  - Si no encuentra: usa RequestHeader/Authentication/Password
```

**Transformación de Body (PagoPrestamoCBIn.xq):**
```xquery
Input: pagoPrestamo (formato CB)
Output: pagoPrestamo (formato Caja)

Mapeo:
- LOAN_NUMBER → LOAN_NUMBER (formateado con Java Callout)
- PAYMENT_AMOUNT → PAYMENT_AMOUNT
- PAYMENT_CURRENCY → PAYMENT_CURRENCY
- PAYMENT_TYPE → PAYMENT_TYPE (modificado a ACCOUNT_DEBIT si es CASH)
- DEBIT_ACCOUNT → DEBIT_ACCOUNT (cuenta del corresponsal si es CASH)
- CHEQUE_NUMBER → CHEQUE_NUMBER (opcional)
- BANK_CODE → BANK_CODE (opcional)
- INTERFACE_REFERENCE_NO → INTERFACE_REFERENCE_NO (opcional)
- DESCRIPTION → "CODIGO_CORRESPONSAL" (hardcoded)
- REPAY_TYPE → TRANSACTION_ID_BC (del request original)
```

#### 1.4. Validaciones Específicas

1. **Validación de Esquema XML:**
   - Schema: `XMLSchema_-541390746.xsd`
   - Element: `pagoPrestamo`
   - Ubicación: `./pag:pagoPrestamo`

2. **Validación de Tipo de Pago:**
   ```
   Condición: PAYMENT_TYPE = 'CASH'
   Si NO cumple: Error MW-0002 "Los tipos de pago de prestamo permitidos deben ser Cash"
   Si cumple: 
     - DEBIT_ACCOUNT se reemplaza con cuenta del corresponsal
     - PAYMENT_TYPE se cambia a 'ACCOUNT_DEBIT'
   ```

3. **Validación Regional:**
   ```
   Service ID: FICBCO0211
   Stored Procedure: MW_P_VALIDA_SERVICIO_REGIONAL
   Parámetros:
     - PV_CODIGO_SERVICIO: "FICBCO0211"
     - PV_CODIGO_PAIS: SourceBank (HN01)
   Resultado Esperado: PV_CODIGO_ERROR = 'SUCCESS'
   ```

4. **Validación de Corresponsal:**
   ```
   Stored Procedure: MW_P_VALIDA_CORBAN
   Parámetros:
     - PV_COD_CORRESPONSAL: BankingCorrespondent/Id
     - PN_TIPO_TRANSACCION: '2' (Pago de Préstamo)
     - PV_CODIGO_PAIS: SourceBank (HN01)
   Resultado Esperado: PV_CODIGO_MENSAJE = 'SUCCESS'
   Datos Obtenidos:
     - PV_CUENTA_DEBITO: Cuenta del corresponsal
     - PV_MONEDA_PERMITIDA: Moneda válida para transacción
     - PV_TIPO_TRANSACCION: Tipo de transacción permitida
   ```

5. **Validación de Moneda:**
   ```
   Condición: PAYMENT_CURRENCY = PV_MONEDA_PERMITIDA
   Si NO cumple: Error "MONEDA INVALIDA PARA TRANSACCION"
   ```

6. **Validación de Cuota de Uso:**
   ```
   Stored Procedure: MW_P_REGISTRAR_USO_SERVICIO
   Parámetros:
     - PV_ID_SERVICIO: "FICBCO0211"
     - PV_ID_USUARIO: UserName
     - PV_BANCO_ORIGEN: SourceBank (HN01)
     - PN_OPERACION: 1 (Tomar cuota)
   Resultado Esperado: PN_CODIGO_ERROR = "0"
   Si NO cumple: Error MW-0001 "SERVICE QUOTA EXCEEDED"
   ```

#### 1.5. Políticas OSB

- **Binding Mode:** wsdl-policy-attachments
- **Security:** HTTPS habilitado
- **Monitoring:** Deshabilitado
- **SLA Alerting:** Habilitado (nivel normal)
- **Pipeline Alerting:** Habilitado (nivel normal)
- **Logging:** Habilitado (nivel debug)
- **Reporting:** Habilitado

#### 1.6. Handlers y Manejo de Errores

**Error Handler Principal (_onErrorHandler-2414871139748681568--6c155157.156c301061a.-7fe7):**

1. **Stage: ExceptionHandler**
   - Log del error: `"ERROR_OSB: FICBCO0211 - " + errorCode`
   - Actualiza estado de transacción a "TRANSACCION_EXITOSA" o estado actual
   - Evalúa tipo de error:
     - **BEA-382505** (Error de validación): Mapea error sin liberar cuota
     - **MW-0001** (Cuota excedida): Devuelve error sin liberar cuota
     - **MW-0002** (Tipo de pago inválido): Devuelve error sin liberar cuota
     - **Otros errores**: Libera cuota de servicio

2. **Stage: ManejoError**
   - Asigna variables de error (errorCode, errorMessage)
   - Invoca servicio MapeoErrores para traducir error
   - Construye ResponseHeader con error mapeado
   - Devuelve respuesta vacía con error

**Error Handler Secundario (_onErrorHandler-6202391981550097452--67a00edf.15a28f39e33.-7efd):**

1. **Stage: ErroRegistroTxn**
   - Log del error: `"ERROR_OSB: FICBCO0211 - " + errorCode`
   - Resume ejecución (no interrumpe flujo)
   - Usado para errores en registro de transacción

#### 1.7. Flujo de Estados de Transacción

```
1. REGISTRADO
   ↓ (Registro inicial en BD)
2. VALIDACION_REGIONAL
   ↓ (Validación de servicio regional)
3. VALIDACION_REGIONAL_EXITOSA
   ↓ (Validación exitosa)
4. VALIDANDO_PARAMETRIA_CORRESPONSAL
   ↓ (Consulta de corresponsal)
5. PARAMETRIA_OBTENIDA_CORRECTAMENTE
   ↓ (Parametrización obtenida)
6. REALIZANDO_LLAMADO_PAGO_PRESTAMO_CAJA
   ↓ (Invocación a servicio de caja)
7. TRANSACCION_EXITOSA
   ↓ (Pago exitoso)
8. Fin

Estados de Error:
- ERROR_OBTENIENDO_SERVICIO_REGIONAL
- ERROR_OBTENIENDO_PARAMETRIZACION_CORRESPONSAL
- ERROR_MONEDA_INVALIDA
- TIPO_DE_PAGO_NO_ES_CASH
```

#### 1.8. Dependencias Internas

1. **Middleware/v2/BusinessServices/OSB/PagoPrestamoCB/biz/PagoPrestamoCB.biz**
   - Tipo: Business Service (SOAP)
   - Operación: pagoPrestamo
   - Timeout: 0 (sin límite)
   - Retry: 0 (sin reintentos)

2. **Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/biz/registraEstadoTransaccion_db.biz**
   - Tipo: DB Adapter
   - SP: COLLECTIONS.OSB_P_MANEJO_TRANSACCIONES.REGISTRA_TRANSACCION_CANAL
   - Operación: registraEstadoTransaccion

3. **Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/biz/actualizaEstadoTransaccion_db.biz**
   - Tipo: DB Adapter
   - SP: COLLECTIONS.OSB_P_MANEJO_TRANSACCIONES.ACTUALIZA_ESTADO_TRANSACCION
   - Operación: actualizaEstadoTransaccion

4. **Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz**
   - Tipo: DB Adapter
   - SP: MW_P_VALIDA_SERVICIO_REGIONAL
   - Operación: ValidaServicioRegional

5. **Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/biz/consultarCorresponsalB_db.biz**
   - Tipo: DB Adapter
   - SP: MW_P_VALIDA_CORBAN
   - Operación: consultarCorresponsalB

6. **Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_db.biz**
   - Tipo: DB Adapter
   - SP: MW_P_REGISTRAR_USO_SERVICIO
   - Operación: registrarUsoServicio

7. **Middleware/v2/ProxyServices/MapeoErrores.proxy**
   - Tipo: Proxy Service
   - Operación: mapeoErrores
   - Función: Mapea códigos de error a mensajes de usuario

#### 1.9. Reglas de Negocio Detectadas

**Regla 1: Conversión de Tipo de Pago CASH**
```
Ubicación: PagoPrestamoCB.proxy - Stage PagoPrestamo
Condición: $tipoPago = 'CASH'
Acción:
  - DEBIT_ACCOUNT = $cuentaDebito (cuenta del corresponsal)
  - PAYMENT_TYPE = 'ACCOUNT_DEBIT'
Justificación: Los pagos en efectivo se debitan de la cuenta del corresponsal
```

**Regla 2: Formateo de Número de Préstamo**
```
Ubicación: PagoPrestamoCB.proxy - Stage PagoPrestamo
Java Callout: ficohsa.utilities.Utilities.FormatearPrestamo
Input: LOAN_NUMBER (string)
Output: prestamoValidado (string formateado)
Justificación: Normalización del formato de número de préstamo
```

**Regla 3: Sobrescritura de Campos**
```
Ubicación: PagoPrestamoCBIn.xq
Reglas:
  - DESCRIPTION = "CODIGO_CORRESPONSAL" (hardcoded)
  - REPAY_TYPE = TRANSACTION_ID_BC (del request)
Justificación: Identificación de transacción de corresponsal
```

**Regla 4: Control de Cuotas de Uso**
```
Ubicación: PagoPrestamoCB.proxy - Stage ValidacionUsoServicio
Operación 1 (Tomar cuota): Antes de procesar transacción
Operación 2 (Liberar cuota): Después de procesar transacción (exitosa o con error)
Excepción: No se libera cuota si error es MW-0001 (cuota excedida)
```

**Regla 5: Validación de Moneda por Corresponsal**
```
Ubicación: PagoPrestamoCB.proxy - Stage ValidarCorresponsal
Condición: PAYMENT_CURRENCY != PV_MONEDA_PERMITIDA
Acción: Error "MONEDA INVALIDA PARA TRANSACCION"
Justificación: Cada corresponsal tiene monedas permitidas específicas
```

---

### 2. GT01 - Guatemala (Implementación Parcial)

#### 2.1. Características Generales

- **Estado:** ⚠️ Parcialmente Implementado
- **Pipeline Request:** `GT01_PagoPrestamo_request` (Vacío)
- **Pipeline Response:** `GT01_PagoPrestamo_response` (Vacío)
- **Código de País:** GT01

#### 2.2. Implementación Actual

**Pipeline Request:**
```xml
<con:stage name="ProxyRequest">
  <con:context/>
  <!-- Sin acciones implementadas -->
</con:stage>
```

**Pipeline Response:**
```xml
<con:stage name="ProxyResponse">
  <con:context/>
  <!-- Sin acciones implementadas -->
</con:stage>
```

#### 2.3. Comportamiento

1. **Validaciones Generales:** ✅ Se ejecutan (compartidas con todas las regiones)
   - Validación de esquema XML
   - Registro de transacción
   - Validación regional
   - Validación de corresponsal
   - Control de cuotas

2. **Procesamiento Específico:** ❌ No implementado
   - No hay transformación de datos
   - No hay invocación a servicio de caja
   - No hay actualización de estado final

3. **Resultado:** Error MW-0008
   ```
   Error Code: MW-0008
   Message: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
   ```

#### 2.4. Diferencias con HN01

| Aspecto | HN01 | GT01 |
|---------|------|------|
| Transformación de Header | ✅ Implementada | ❌ No implementada |
| Transformación de Body | ✅ Implementada | ❌ No implementada |
| Java Callout | ✅ FormatearPrestamo | ❌ No implementado |
| Invocación a Caja | ✅ Implementada | ❌ No implementada |
| Actualización de Estado | ✅ Implementada | ❌ No implementada |
| Liberación de Cuota | ✅ Implementada | ❌ No implementada |

#### 2.5. Requisitos para Implementación Completa

1. **Validar Endpoint de Caja:**
   - Confirmar si Guatemala usa el mismo endpoint que Honduras
   - Verificar si requiere endpoint específico

2. **Validar Transformaciones:**
   - Confirmar si las transformaciones de HN01 aplican para GT01
   - Identificar diferencias en formato de datos

3. **Validar Reglas de Negocio:**
   - Confirmar si la regla de conversión CASH aplica
   - Verificar si el formateo de préstamo es el mismo

4. **Implementar Pipeline:**
   - Copiar lógica de HN01 o crear específica
   - Ajustar transformaciones según necesidad

---

### 3. PA01 - Panamá (Implementación Parcial)

#### 3.1. Características Generales

- **Estado:** ⚠️ Parcialmente Implementado
- **Pipeline Request:** `PA01_PagoPrestamo_request` (Vacío)
- **Pipeline Response:** `PA01_PagoPrestamo_response` (Vacío)
- **Código de País:** PA01

#### 3.2. Implementación Actual

**Pipeline Request:**
```xml
<con:stage name="ProxyRequest">
  <con:context/>
  <!-- Sin acciones implementadas -->
</con:stage>
```

**Pipeline Response:**
```xml
<con:stage name="ProxyResponse1">
  <con:context/>
  <!-- Sin acciones implementadas -->
</con:stage>
```

#### 3.3. Comportamiento

Idéntico a GT01:

1. **Validaciones Generales:** ✅ Se ejecutan
2. **Procesamiento Específico:** ❌ No implementado
3. **Resultado:** Error MW-0008

#### 3.4. Diferencias con HN01

Mismas diferencias que GT01 (ver sección 2.4)

#### 3.5. Requisitos para Implementación Completa

Mismos requisitos que GT01 (ver sección 2.5)

---

### 4. NI01 - Nicaragua (No Implementado)

#### 4.1. Características Generales

- **Estado:** ❌ No Implementado
- **Pipeline:** No existe
- **Código de País:** NI01

#### 4.2. Comportamiento

1. **Enrutamiento:** No existe branch para NI01
2. **Resultado:** Se ejecuta el branch por defecto (Default_PagoPrestamo)
3. **Error:** MW-0008 "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

#### 4.3. Requisitos para Implementación

1. **Agregar Branch en Regionalización:**
   ```xml
   <con:branch name="NI01">
     <con:operator>equals</con:operator>
     <con:value>'NI01'</con:value>
     <con:flow>
       <con:pipeline-node name="NI01_PagoPrestamo">
         <con:request>NI01_PagoPrestamo_request</con:request>
         <con:response>NI01_PagoPrestamo_response</con:response>
       </con:pipeline-node>
     </con:flow>
   </con:branch>
   ```

2. **Crear Pipelines:**
   - NI01_PagoPrestamo_request
   - NI01_PagoPrestamo_response

3. **Implementar Lógica:**
   - Transformaciones específicas
   - Invocación a servicio de caja
   - Actualización de estados

---

## Resumen de Diferencias Clave

### Diferencias Técnicas

| Aspecto | Diferencia | Impacto |
|---------|-----------|---------|
| **Implementación Regional** | Solo HN01 completo | Alto - Requiere desarrollo para GT01, PA01, NI01 |
| **Endpoint de Caja** | Mismo para todas las regiones | Medio - Puede requerir endpoints específicos |
| **Transformaciones** | Solo definidas para HN01 | Alto - Requiere análisis de diferencias regionales |
| **Validaciones** | Compartidas entre regiones | Bajo - Reutilizables |
| **Manejo de Errores** | Compartido entre regiones | Bajo - Reutilizable |

### Diferencias de Negocio

| Aspecto | HN01 | GT01/PA01/NI01 |
|---------|------|----------------|
| **Tipo de Pago** | Solo CASH | No definido |
| **Formateo de Préstamo** | Java Callout específico | No definido |
| **Cuenta de Débito** | Cuenta del corresponsal | No definido |
| **Moneda Permitida** | Validada por corresponsal | No definido |

### Recomendaciones de Implementación

1. **Prioridad Alta:**
   - Completar implementación de GT01 y PA01
   - Validar si las reglas de HN01 aplican a otras regiones

2. **Prioridad Media:**
   - Implementar NI01 si es requerido
   - Configurar endpoints específicos por región si es necesario

3. **Prioridad Baja:**
   - Optimizar código compartido
   - Implementar monitoreo específico por región

---

**Conclusión:**

La funcionalidad PagoPrestamoCB tiene una implementación completa y funcional para Honduras (HN01), pero requiere desarrollo adicional para Guatemala (GT01), Panamá (PA01) y Nicaragua (NI01). Las validaciones generales son compartidas entre todas las regiones, lo que facilita la extensión a nuevas regiones. Sin embargo, es crítico validar las diferencias de negocio y técnicas antes de replicar la implementación de HN01 a otras regiones.
