# Comparativa entre Regiones - SolicitaFinanciamientoTC

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | Otras Regiones |
|---------|-----------------|------------------|----------------|
| **Endpoint OSB** | SolicitaFinanciamientoTC_request | SolicitaFinanciamientoTCGT_request | Default_SolicitaFinanciamientoTC_request |
| **Base de Datos** | VASA | BLAZEGT | No implementado |
| **Esquemas** | ProcesosHN | BLAZEGT | N/A |
| **Stored Procedure** | consultaOferta | consultaOferta | N/A |
| **Conexión BD** | Middleware/v2/BusinessServices/ProcesosHN/consultaOferta/biz/consultaOferta_db | Middleware/v2/BusinessServices/BLAZEGT/consultaOferta/biz/consultaOferta_db | N/A |
| **Transformaciones Entrada** | consultaOfertaIn.xq | consultaOfertaGTIn.xq | N/A |
| **Transformaciones Salida** | solicitaFinanciamientoTCOut.xq | solicitaFinanciamientoTCRGNGTOut.xq | N/A |
| **Salesforce Service** | SalesforceHNIngresaGestionExtra | SalesforceRGNIngresaGestionExtra | N/A |
| **Transformación Salesforce** | ingresaGestionExtraIn.xq | ingresaGestionExtraRGNGTIn.xq | N/A |
| **Parametrización Tasa** | FICBCO0269.DISBURSERATE | FICBCO0269.DISBURSERATE.GT01 | N/A |
| **Parametrización Producto** | FICBCO0269.PRODUCTQUANTIFY | FICBCO0269.PRODUCTQUANTIFY.GT01 | N/A |
| **Tipo Desembolso** | FICBCO0269.DISBURSEMENTYPE.{TYPE} | Directo desde request | N/A |
| **País Salesforce** | Honduras | Guatemala | N/A |
| **Campos Diferenciadores** | TipoDesembolso parametrizado | TipoDesembolso del request | Error implementación |
| **Errores/Excepciones** | Manejo completo con retry | Manejo completo con retry | MW-0008 |
| **Timeouts/Retrys** | Retry automático INVALID_SESSION_ID | Retry automático INVALID_SESSION_ID | N/A |
| **Dependencias Internas** | ValidaCondicionesCredito.xq | ValidaCondicionesCredito.xq | N/A |

## Sección por Región

### HN01 (Honduras)

#### Endpoints y Servicios
- **Proxy Service**: SolicitaFinanciamientoTC.proxy
- **Pipeline Request**: SolicitaFinanciamientoTC_request
- **Pipeline Response**: SolicitaFinanciamientoTC_response
- **Error Handler**: _onErrorHandler-7908611298617121392--4ebd19fc.164898eb0db.-76ad

#### Mapeos y Transformaciones
- **Entrada BD**: `consultaOfertaIn.xq`
  - Mapea CUSTOMER_ID → Pv_Identidad
  - Mapea CREDIT_LINE → Pv_Linea
- **Entrada Salesforce**: `ingresaGestionExtraIn.xq`
  - Incluye todos los campos del request
  - Agrega parámetros de configuración
  - País fijo: "Honduras"
- **Salida**: `solicitaFinanciamientoTCOut.xq`
  - Mapea respuesta de Salesforce a estructura OSB
  - Calcula AVAILABLE_AMOUNT
  - Mapea estados: EN PROCESO/INGRESADA → PENDING, APROBADO → APPROVED, otros → REJECTED

#### Validaciones y Políticas OSB
- Validación XSD contra solicitudFinanciamientoTCTypes
- Validación de servicio regional con serviceId "FICBCO0269"
- Validación de condiciones crediticias con validaCondicionesCredito.xq
- Manejo de sesiones Salesforce con retry automático

#### Configuración Específica
- **Parámetros**:
  - `FICBCO0269.DISBURSERATE`: Tasa de desembolso
  - `FICBCO0269.PRODUCTQUANTIFY`: Producto a cuotificar
  - `FICBCO0269.DISBURSEMENTYPE.{TYPE}`: Tipo de desembolso parametrizado
- **Base de Datos**: Conexión a VASA/ProcesosHN
- **Salesforce**: SalesforceHNIngresaGestionExtra

### GT01 (Guatemala)

#### Endpoints y Servicios
- **Proxy Service**: SolicitaFinanciamientoTC.proxy
- **Pipeline Request**: SolicitaFinanciamientoTCGT_request
- **Pipeline Response**: SolicitaFinanciamientoTCGT_response
- **Error Handler**: _onErrorHandler-1384382121503434113--426f75e4.16fa9cf67de.-4acc

#### Mapeos y Transformaciones
- **Entrada BD**: `consultaOfertaGTIn.xq`
  - Mapea CUSTOMER_ID → Pv_Identidad
  - Mapea CREDIT_LINE → Pv_Linea
- **Entrada Salesforce**: `ingresaGestionExtraRGNGTIn.xq`
  - Similar a HN01 pero sin parámetro tipoDesembolso
  - Toma TipoDesembolso directamente del request
  - País fijo: "Guatemala"
- **Salida**: `solicitaFinanciamientoTCRGNGTOut.xq`
  - Similar mapeo que HN01
  - Misma lógica de cálculos y estados

#### Validaciones y Políticas OSB
- Mismas validaciones que HN01
- Validación XSD y servicio regional
- Validación de condiciones crediticias
- Manejo de sesiones Salesforce con retry

#### Configuración Específica
- **Parámetros**:
  - `FICBCO0269.DISBURSERATE.GT01`: Tasa de desembolso específica GT
  - `FICBCO0269.PRODUCTQUANTIFY.GT01`: Producto específico GT
  - No usa parametrización de tipo desembolso
- **Base de Datos**: Conexión a BLAZEGT
- **Salesforce**: SalesforceRGNIngresaGestionExtra

### Otras Regiones (Default)

#### Comportamiento
- **Pipeline**: Default_SolicitaFinanciamientoTC_request/response
- **Respuesta**: Error MW-0008 "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- **Sin implementación**: No hay lógica de negocio implementada

## Diferencias Clave Identificadas

### 1. Parametrización Regional
- **HN01**: Parámetros sin sufijo regional
- **GT01**: Parámetros con sufijo `.GT01`
- **Tipo Desembolso**: HN01 usa parametrización, GT01 usa valor directo del request

### 2. Servicios de Base de Datos
- **HN01**: VASA/ProcesosHN con esquema específico
- **GT01**: BLAZEGT con esquema específico
- **Misma interfaz**: Ambos usan consultaOferta con mismos parámetros

### 3. Servicios Salesforce
- **HN01**: SalesforceHNIngresaGestionExtra (específico Honduras)
- **GT01**: SalesforceRGNIngresaGestionExtra (regional Guatemala)
- **Diferente país**: Campo "Pais" hardcodeado por región

### 4. Transformaciones XQuery
- **Entrada BD**: Archivos separados pero lógica idéntica
- **Entrada Salesforce**: Diferencias en manejo de TipoDesembolso
- **Salida**: Archivos separados pero lógica similar

### 5. Manejo de Errores
- **HN01 y GT01**: Manejo completo con retry de sesión Salesforce
- **Otras regiones**: Solo error de no implementación
- **Mapeo de errores**: Mismo servicio MapeoErrores para todas las regiones

### 6. Bitácora y Auditoría
- **Todas las regiones**: Mismo sistema de bitácora
- **Service ID**: FICBCO0269 para todas las regiones
- **Diferenciación**: Por banco origen/destino en headers

## Consideraciones para Unificación

### Oportunidades de Consolidación
1. **Lógica de validación**: Idéntica entre HN01 y GT01
2. **Estructura de response**: Misma lógica de mapeo
3. **Manejo de errores**: Patrón común implementable
4. **Bitácora**: Ya unificada

### Diferencias que Mantener
1. **Conexiones de BD**: Específicas por región
2. **Servicios Salesforce**: Específicos por región
3. **Parametrización**: Valores diferentes por región
4. **País en Salesforce**: Campo específico por región

### Recomendaciones
1. **Unificar XQuery**: Usar parámetros para diferencias menores
2. **Configuración externa**: Externalizar diferencias de configuración
3. **Factory pattern**: Para selección de servicios por región
4. **Validación común**: Reutilizar lógica de validación