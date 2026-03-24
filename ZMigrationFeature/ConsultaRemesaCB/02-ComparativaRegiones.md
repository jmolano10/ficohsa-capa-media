# Comparativa entre Regiones - ConsultaRemesaCB

## Regiones Detectadas

Basado en el análisis del código fuente, se ha identificado la siguiente región:

- **HN01**: Honduras (Única región implementada)

## Tabla de Comparación

| Aspecto | HN01 |
|---------|------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/Payments/ConsultaRemesaCB` |
| **Nombre de Base de Datos - Middleware** | `ConnectionMiddleware` (ORA_BANK) |
| **Nombre de Base de Datos - Convenios** | `ConnectionConvenios` (TERCEROS/FLINK) |
| **Esquemas** | ORA_BANK, TERCEROS, FLINK |
| **Store Procedures** | Ver sección detallada abajo |
| **Nombre de Conexión a Base de datos** | `eis/DB/ConnectionMiddleware`, `eis/DB/ConnectionConvenios` |
| **Transformaciones clave** | `consultaRemesaCBHeaderIn.xq`, `consultaRemesaCBIn.xq`, `consultaRemesaCBOut.xq`, `limiteTransacionalRegistrarIn.xq` |
| **Campos diferenciadores** | Ninguno - solo HN01 implementado |
| **Errores/Excepciones** | Manejo centralizado con MapeoErrores (FICBCO0148) |
| **Timeouts** | armarMensajeRecaudo: 60s, enrutadorConvenios: ilimitado |
| **Retries** | armarMensajeRecaudo: 1 retry (30s interval) |
| **Dependencias internas** | ConsultaRemesas, OperacionesCriptograficas, MapeoErrores, EvaluaListasCliente |
| **Validación Regional** | FICBCO0148 (Servicio de consulta de remesas) |
| **Tipos de Remesadoras** | REMESALOCAL, FICOREMESA, ONLINE |
| **Enrutador de Convenios** | http://192.9.200.176:8003/Middleware/OperationsAndExecution/BillingServices/EnrutadorConvenios |
| **Autenticación** | Custom token (UserName/Password en header) |
| **Cifrado** | RSA con clave "ONE-TIME-PASSWORD" |

## Stored Procedures por Región

### HN01 - Honduras

#### Base de Datos: ORA_BANK (Middleware)

| Stored Procedure | Paquete | Operación | Descripción |
|-----------------|---------|-----------|-------------|
| `MW_P_OBTENER_TIPO_REMESADORA` | N/A | ObtenerTipoRemesadora | Obtiene el tipo de remesadora (REMESALOCAL, FICOREMESA, ONLINE) y sus datos de convenio |
| `MW_P_VALIDAR_CORRESPONSAL` | N/A | consultarCorresponsalB | Valida que el corresponsal esté autorizado para tipo de transacción "9" |
| `MW_P_VALIDAR_SERVICIO_REGIONAL` | N/A | ValidaServicioRegional | Valida que el servicio FICBCO0148 esté habilitado para la región |
| `MW_P_LIMITE_TRX_REGISTRAR` | N/A | limiteTrxRegistrar | Registra el límite transaccional con ID cliente, monto y tasa de cambio |
| `OSB_GET_CONFIG` | N/A | obtenerParametrizacion | Obtiene parámetros de configuración por usuario |

#### Base de Datos: TERCEROS (Convenios)

| Stored Procedure | Paquete | Operación | Descripción |
|-----------------|---------|-----------|-------------|
| `CV_K_DATOS_REMESAS$CONSU_X_ID` | `OSB_K_CONSULTARREMLOCALID` | consultarRemLocalId | Consulta remesas locales por ID de remesa |
| `CV_K_DATOS_REMESAS_POR_PAGADOR` | `OSB_K_CONSULTARREMFREMID` | consultarRemFRemXPagador | Consulta Ficohsa Remesas por ID y pagador destino |
| `CV_K_OBTENER_CAMPOS_REMESAS_REL` | `OSB_K_OBTENER_CAMPOS_REMESAS_REL` | obtenerCamposRemesasRel | Obtiene campos para registrar relación consulta-pago |
| `CV_K_INGRESO_REL_CONS_PAGO_REM` | `OSB_K_INGRESO_REL_CONS_PAGO_REM` | ingresoRelConsPagoRem | Inserta relación consulta-pago de remesa |

#### Base de Datos: FLINK (Convenios)

| Stored Procedure | Paquete | Operación | Descripción |
|-----------------|---------|-----------|-------------|
| `OSB_ARMAR_MENSAJE` | `OSB_K_RECAUDOS_REF_ONLINE` | armarMensajeRecaudo | Arma el mensaje XML para enviar al enrutador de convenios |

## Detalles por Región

### HN01 - Honduras

#### Características Específicas

1. **Validación de Corresponsal**
   - Tipo de transacción: "9"
   - Valida código de corresponsal del header
   - Retorna error si corresponsal no autorizado

2. **Descifrado de Credenciales**
   - Solo si existen campos LOGINUSER y LOGINPASS en ADDITIONAL_INFO
   - Algoritmo: RSA
   - Clave: "ONE-TIME-PASSWORD"
   - Servicio: OperacionesCriptograficas.cifrarDatos

3. **Tipos de Remesadoras Soportadas**

   **a) REMESALOCAL**
   - Fuente de datos determinada por parámetro T24C070.{TIPO}.REMITSOURCE
   - Si REMITSOURCE = "T24": Consulta en T24 (sjConsultaRemesaResiliencia)
   - Si REMITSOURCE != "T24": Consulta en tablas FLink (consultarRemLocalId)
   - Registra relación si estado = "DISPONIBLE"

   **b) FICOREMESA**
   - Consulta en tablas TERCEROS (consultarRemFRemXPagador)
   - Requiere parámetro IDPAYERGUSER del usuario
   - Registra relación si estado = "DISPONIBLE"

   **c) ONLINE**
   - Consulta múltiples remesadoras (Moneygram, Uniteller, BTS, Pacific)
   - Usa sjConsultaMultipleRemesadoras (BPEL flow)
   - Selecciona por prioridad si hay múltiples resultados
   - Valida permisos con parámetro REMITALLOW
   - Evalúa listas restrictivas si CHECKLISTS = "Yes"
   - Registra relación si errorCode = "0" (DISPONIBLE)

4. **Parámetros de Configuración**
   - `T24C070.{USERNAME}.REMITALLOW`: Lista de remesadoras permitidas (separadas por ||)
   - `T24C070.{USERNAME}.IDPAYERGUSER`: ID de pagador para Ficohsa Remesas
   - `T24C070.{USERNAME}.CHECKLISTS`: Habilita evaluación de listas (Yes/No)
   - `T24C070.{USERNAME}.CHECKREMITTERID`: Remesadoras que requieren evaluación de listas

### Tipos de Remesas Locales Soportadas

Basado en el análisis del código fuente, se identifican los siguientes tipos de remesas locales por prefijo:

| Prefijo | Tipo de Remesa | Descripción |
|---------|---------------|-------------|
| LX | DOLEX | Remesas Dolex |
| RF | RIA | Remesas RIA |
| FCX, FTL, FOR, FNJ, TAM, CHA, BRX, HEM, HST, PLF, GNA, NBW, NWO, FNW | FICOEXP | Ficohsa Express |
| GPX | GROUPEX | Group Express |
| RT, US, GMT, IDT | REMTRAS | Remesas y Transferencias |
| TF | TRANSFAST | TransFast |
| SIG | SIGUE | Sigue |
| GS | GIROSOL | Girosol |
| Otros | REMESA NO IDENTIFICADA | Tipo no reconocido |

### Configuración de Credenciales LDAP

El sistema utiliza un mecanismo de credenciales LDAP con fallback:
- **Ruta LDAP**: `Middleware/Security/{USERNAME}` (en mayúsculas)
- **Fallback**: Si no encuentra credenciales LDAP, usa las del header del request
- **Uso**: Principalmente para conexiones a T24 en remesas locales

### Parámetros de Configuración Detallados

#### Parámetros por Usuario (T24C070.{USERNAME}.*)
- **REMITALLOW**: Lista de abreviaturas de remesadoras permitidas (separadas por ||)
- **IDPAYERGUSER**: ID de pagador para consultas de Ficohsa Remesas
- **CHECKLISTS**: Habilita evaluación de listas restrictivas (Yes/No)
- **CHECKREMITTERID**: Remesadoras que requieren evaluación de listas

#### Parámetros por Tipo de Remesa (T24C070.{TIPO}.REMITSOURCE)
- **DOLEX.REMITSOURCE**: Fuente de datos para remesas Dolex (T24/FLink)
- **RIA.REMITSOURCE**: Fuente de datos para remesas RIA (T24/FLink)
- **FICOEXP.REMITSOURCE**: Fuente de datos para Ficohsa Express (T24/FLink)
- **GROUPEX.REMITSOURCE**: Fuente de datos para Group Express (T24/FLink)
- **REMTRAS.REMITSOURCE**: Fuente de datos para Remesas y Transferencias (T24/FLink)
- **TRANSFAST.REMITSOURCE**: Fuente de datos para TransFast (T24/FLink)
- **SIGUE.REMITSOURCE**: Fuente de datos para Sigue (T24/FLink)
- **GIROSOL.REMITSOURCE**: Fuente de datos para Girosol (T24/FLink)

5. **Registro de Límites Transaccionales**
   - Se ejecuta en el response si successIndicator = "SUCCESS"
   - Parámetros:
     - PV_ID_CLIENTE: Extraído de ADDITIONAL_INFO/INFO[NAME='ID']/VALUE
     - PV_MONTO_FLOTANTE: REMITTANCE_AMOUNT del response
     - PV_TASA_CAMBIO: EXCHANGE_RATE del response

6. **Mapeo de Estados**
   - errorCode = "0" → DISPONIBLE
   - errorCode = "2" → PAGADA
   - Otros → ERROR con mensaje

7. **Enrutador de Convenios**
   - URL: http://192.9.200.176:8003/Middleware/OperationsAndExecution/BillingServices/EnrutadorConvenios
   - Timeout: Ilimitado (0)
   - Retry: 0
   - Cache: Habilitado (TTL: 30 minutos)

#### Validaciones Específicas

1. **Validación de Servicio Regional**
   - ServiceId: "FICBCO0148"
   - Región: HN01
   - Falla si servicio no habilitado para la región

2. **Validación de Tipo de Consulta**
   - Solo soporta "ID_BASED" (consulta por REMITTANCE_ID)
   - Retorna error si no se proporciona REMITTANCE_ID

3. **Validación de Permisos**
   - Para remesadoras ONLINE, valida que el usuario tenga permiso
   - Compara remittSource contra lista REMITALLOW
   - Retorna error si no tiene permisos

4. **Validación de Listas Restrictivas**
   - Solo para remesadoras ONLINE configuradas
   - Requiere CHECKLISTS = "Yes" y remittSource en CHECKREMITTERID
   - Solo si errorCode = "0" (DISPONIBLE)
   - Usa servicio EvaluaListasCliente

#### Políticas de Error

1. **Error de Validación de Corresponsal**
   - successIndicator: Código de error del SP
   - messages: Mensaje de error del SP
   - Body vacío

2. **Error de Tipo de Remesadora**
   - successIndicator: ERROR
   - messages: Mensaje del SP MW_P_OBTENER_TIPO_REMESADORA
   - Body vacío

3. **Error de Remesadora No Válida**
   - successIndicator: ERROR
   - messages: "Codigo de remesa no valido"
   - Body vacío

4. **Error de Permisos**
   - successIndicator: ERROR
   - messages: "El usuario no tiene permisos para consultar este tipos de claves de remesa"
   - Body vacío

5. **Error General**
   - Capturado por error handler
   - Usa MapeoErrores para homologar
   - Código servicio: FICBCO0148

## Diferencias entre Regiones

**No aplica** - Solo existe implementación para HN01.

## Notas Importantes

1. **Regionalización Limitada**: El servicio ConsultaRemesaCB solo está implementado para Honduras (HN01). El branch de regionalización en ConsultaRemesas solo tiene caso para HN01, con default-branch vacío.

2. **Dependencia de ConsultaRemesas**: ConsultaRemesaCB es un wrapper que agrega:
   - Validación de corresponsal bancario
   - Descifrado de credenciales
   - Registro de límites transaccionales
   - Toda la lógica de consulta está en ConsultaRemesas

3. **Múltiples Fuentes de Datos**: El servicio puede consultar en:
   - Tablas FLink (TERCEROS)
   - T24 (Core bancario)
   - Enrutador de convenios (remesadoras externas)

4. **Seguridad Multicapa**:
   - Autenticación en header
   - Validación de corresponsal
   - Validación de servicio regional
   - Validación de permisos por usuario
   - Evaluación de listas restrictivas (opcional)

5. **Resiliencia**: El servicio sjConsultaRemesaResiliencia proporciona acceso resiliente a T24 para remesas locales.
