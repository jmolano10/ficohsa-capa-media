# Comparación entre Regiones - RetiroEfectivoCBS

## Tabla de Comparación

| Aspecto | HN01 (Honduras) |
|---------|-----------------|
| **Endpoint OSB** | `/SMiddleware/OperationsAndExecution/Payments/RetiroEfectivoCBS` |
| **Nombre de Base de Datos** | ConnectionMiddleware |
| **Esquemas** | MW_P_CON_COMISION_CORBAN |
| **Store Procedure** | MW_P_CON_COMISION_CORBAN |
| **Nombre de Conexión a Base de datos** | eis/DB/ConnectionMiddleware |
| **Transformaciones clave** | retiroEfectivoTengoT24In.xq, retiroEfectivoOut.xq, consultaComisionesCBIn.xq |
| **Campos diferenciadores** | Región HN01 en header |
| **Errores/Excepciones** | MapeoErrores con código FICBCO0218 |
| **Timeouts/Retrys** | Retry: 0, Timeout: 0 (sin límite) |
| **Dependencias internas** | T24, ConsultaCuentas, Transferencias |
| **Servicio ID** | FICBCO0218 |
| **Endpoint T24** | http://10.242.104.55:7005/svcRegistraTransaccionTengo/services |
| **Operación T24** | RetiroEfectivoTengo |
| **Validación Regional** | ValidaServicioRegional con FICBCO0218 |
| **Moneda Soportada** | Configurada por corresponsal |
| **Tipo Transacción** | Configurado por corresponsal (código 4) |

## Detalles por Región

### HN01 (Honduras)

#### Endpoints y Configuración
- **Proxy Service**: RetiroEfectivoCBS.proxy
- **URI**: `/SMiddleware/OperationsAndExecution/Payments/RetiroEfectivoCBS`
- **Protocolo**: SOAP 1.1
- **Autenticación**: Custom token con usuario/contraseña

#### Mapeos y Transformaciones
- **Request Transformation**: retiroEfectivoTengoT24In.xq
- **Response Transformation**: retiroEfectivoOut.xq
- **Comisiones Input**: consultaComisionesCBIn.xq
- **Header Output**: retiroEfectivoHeaderOut.xq

#### Validaciones Específicas
1. **Validación de Esquema**: Contra retiroEfectivoCBTypes.xsd
2. **Validación Regional**: Servicio FICBCO0218 para región HN01
3. **Validación de Corresponsal**: Consulta de parámetros específicos
4. **Validación de Moneda**: Verificación contra moneda permitida del corresponsal
5. **Validación de Fondos**: Saldo disponible >= (monto + comisión)

#### Políticas OSB
- **Monitoring**: Deshabilitado
- **Reporting**: Habilitado
- **SLA Alerting**: Nivel normal
- **Pipeline Alerting**: Nivel normal
- **Logging**: Debug level
- **Result Caching**: Habilitado pero no soportado

#### Handlers de Error
- **Error Principal**: _onErrorHandler-7673551469624593921--2ee7fb83.159ffda2f1e.-7c26
- **Error Registro**: _onErrorHandler-923290688092160005-383abb3c.1840c45270e.-7758
- **Mapeo de Errores**: Integración con servicio MapeoErrores

#### Dependencias de Base de Datos
- **Conexión**: eis/DB/ConnectionMiddleware
- **Stored Procedure Principal**: MW_P_CON_COMISION_CORBAN
- **Parámetros de Entrada**:
  - PV_MONTO: Monto de la transacción
  - PV_MONEDA: Moneda de la transacción
  - PV_CODIGO_TRANSACCION: Código '4' para retiro efectivo
  - PV_USUARIO_TRANSACCION: Usuario en mayúsculas

#### Dependencias de Servicios Web
- **T24 Service**: svcRegistraTransaccionTengo
  - **Endpoint**: http://10.242.104.55:7005/svcRegistraTransaccionTengo/services
  - **Operación**: RetiroEfectivoTengo
  - **Timeout**: Sin límite configurado
  
- **Consulta Cuentas**: consultaCuentasBS
  - **Operación**: Consultadesaldodecuenta
  - **Propósito**: Verificación de saldo disponible

- **Transferencias**: transferenciasBS
  - **Operación**: Transfmodelbankentrecuentas
  - **Propósito**: Cobro de comisión

#### Flujo de Estados de Transacción
1. **REGISTRADO**: Estado inicial al registrar la transacción
2. **VALIDANDO_RUTA_REGIONAL**: Durante validación regional
3. **VALIDACION_REGIONAL_EXITOSA**: Validación regional completada
4. **OBTENIENDO_PARAMETRIA_CORRESPONSAL**: Consultando parámetros del corresponsal
5. **VALIDANDO_MONEDA_TRANSACCION**: Validando moneda permitida
6. **OBTENIENDO_COMISION**: Calculando comisión aplicable
7. **CONSULTANDO_CUENTA**: Verificando saldo de cuenta
8. **CUENTA_VALIDADA**: Cuenta con fondos suficientes
9. **REALIZANDO_TRANSFERENCIA**: Ejecutando transferencia principal
10. **REALIZANDO_COBRO_COMISION**: Cobrando comisión si aplica
11. **TRANSACCION_EXITOSA**: Transacción completada exitosamente

#### Códigos de Error Específicos
- **MW-0001**: SERVICE QUOTA EXCEEDED
- **R03**: Número de Cuenta Inexistente
- **R01**: Fondos Insuficientes
- **ERROR**: Errores generales de validación

#### Configuración de Retry y Timeout
- **Retry Count**: 0 (sin reintentos)
- **Retry Interval**: 30 segundos
- **Connection Timeout**: 0 (sin límite)
- **Request Timeout**: 0 (sin límite)

## Observaciones

### Región Única Implementada
Actualmente, el servicio **RetiroEfectivoCBS** solo tiene implementación para la región **HN01 (Honduras)**. El flujo de regionalización está configurado con un branch condicional que evalúa `./aut:RequestHeader/Region/SourceBank`, pero solo existe el branch para 'HN01'. Cualquier otra región caería en el branch por defecto que no tiene implementación específica.

### Arquitectura Extensible
La estructura del proxy service está diseñada para soportar múltiples regiones:
- Branch condicional por región en el router
- Pipelines separados por región (HN01_request, HN01_response)
- Pipeline genérico de validaciones común a todas las regiones

### Dependencias Comunes
Todos los servicios de soporte (validación regional, consulta de corresponsal, registro de uso, etc.) son compartidos entre regiones, lo que facilita la extensión a nuevas regiones manteniendo la consistencia en las validaciones básicas.