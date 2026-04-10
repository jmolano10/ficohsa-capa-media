# Comparativa entre Regiones - CreditManagementRouter_PS

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | v1.0/credit-management | v1.0/credit-management | v1.0/credit-management | v1.0/credit-management |
| **Nombre de Base de Datos** | DataWareHouseHN | DataWareHouse | No encontrado | DataWareHouseNI (Requerido) |
| **Esquemas** | ONBASE_V2 | ONBASE_V2 | No encontrado | ONBASE_V2 (Requerido) |
| **Store Procedure** | consulta_ONBASE_V2 | consulta_ONBASE_V2 | No encontrado | consulta_ONBASE_V2 (Requerido) |
| **Nombre de Conexión a Base de datos** | DataWareHouseHN_BS | DataWareHouseGT_BS | No encontrado | DataWareHouseNI_BS (Requerido) |
| **Transformaciones clave** | Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskResponse | Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskGTResponse | No encontrado | Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskNIResponse (Requerido) |
| **Campos diferenciadores** | Campos específicos HN en response | Campos específicos GT en response | No encontrado | Campos específicos NI: RUC, NIO, Factor cambio 36.50 |
| **Errores/Excepciones** | MW-0003 (INVALID REGION REQUEST) | MW-0003 (INVALID REGION REQUEST) | MW-0003 (INVALID REGION REQUEST) | MW-0003, NI-0001 (CEDULA INVALIDA), NI-0002 (RUC INVALIDO) |
| **Timeouts/Retrys** | No configurado explícitamente | No configurado explícitamente | No configurado explícitamente | No configurado explícitamente |
| **Dependencias internas** | RulesManagement, DataWareHouseHN | RulesManagement, DataWareHouse | No activo | RulesManagementNI, DataWareHouseNI (Requerido) |
| **Estado de Configuración** | Active | Active | Configurado pero inactivo | **No configurado - Requiere implementación** |
| **Servicios Específicos** | GetConsolidatedCustomerRiskHN_PS, GetCreditOffersHN_PS | GetConsolidatedCustomerRiskGT_PS, GetCreditOffersGT_PS | No encontrado | GetConsolidatedCustomerRiskNI_PS, GetCreditOffersNI_PS (Requerido) |
| **Moneda Local** | HNL (Lempira) | GTQ (Quetzal) | USD (Dólar) | NIO (Córdoba) |
| **Factor de Cambio** | Variable | 7.75 (aprox) | 1.00 | 36.50 (aprox) |
| **Formato Documento ID** | Cédula hondureña | DPI guatemalteco | Cédula panameña | Cédula: 001-150485-0001A |
| **Formato Documento Fiscal** | RTN | NIT | RUC | RUC: J0310000000001 |

## Sección por Región

### Honduras (HN01)

#### Endpoints y Servicios
- **Proxy Service Principal**: CreditManagementRouter_PS
- **URI Base**: v1.0/credit-management
- **Servicios Dependientes**:
  - DataWareHouseHN/RequestorServices/ProxyServices/v1.0/GetConsolidatedCustomerRisk
  - RulesManagement/RequestorServices/ProxyServices/v1.0/GetCreditOffers
  - RulesManagement/RequestorServices/ProxyServices/v1.0/RefGetCreditOffers

#### Mapeos y Transformaciones
- **Request Mapping**: Tx_GetConsolidatedCustomerRisk_To_consulta_ONBASE_V2.xqy
- **Response Mapping**: Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskResponse.xqy
- **Error Mapping**: Tx_ErrorInfo_To_ConsolidatedCustomerRiskResponse.xqy
- **BLAZE Integration**: Tx_GetCreditOffers_To_BLAZE.xqy, Tx_BLAZE_To_GetCreditOffersResponse.xqy

#### Validaciones y Políticas OSB
- **Autenticación**: HTTP Basic Authentication
- **Validación Regional**: DVM lookup en RegionalParameters
- **Compresión**: Deshabilitada
- **WSS Processing**: Habilitado con processWssHeader="true"

#### Handlers y Configuraciones
- **Error Handler**: error-N3f5776ff.N1b0c9075.0.18061bcda9a.N7d02
- **Monitoring**: Habilitado con nivel "service" y agregación de 360 segundos
- **Tracing**: Habilitado

### Guatemala (GT01)

#### Endpoints y Servicios
- **Proxy Service Principal**: CreditManagementRouter_PS (mismo que HN01)
- **URI Base**: v1.0/credit-management
- **Servicios Dependientes**:
  - DataWareHouse/RequestorServices/ProxyServices/v1.0/GetConsolidatedCustomerRisk/GetConsolidatedCustomerRiskGT_PS
  - RulesManagement/RequestorServices/ProxyServices/v1.0/GetCreditOffers/GetCreditOffersGT_PS

#### Mapeos y Transformaciones
- **Request Mapping**: Tx_GetConsolidatedCustomerGTRisk_To_consulta_ONBASE_V2.xqy
- **Response Mapping**: Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskGTResponse.xqy
- **Error Mapping**: Tx_ErrorInfo_To_ConsolidatedCustomerRiskGTResponse.xqy
- **BLAZE Integration**: Tx_GetCreditOffersGT_To_BLAZE.xqy, Tx_BLAZE_To_GetCreditOffersGTResponse.xqy

#### Validaciones y Políticas OSB
- **Configuración idéntica a HN01** en términos de autenticación y políticas
- **Validación Regional**: Misma lógica DVM pero con parámetros GT01

#### Handlers y Configuraciones
- **Misma configuración de error handling** que HN01
- **Monitoring y Tracing**: Configuración idéntica

### Panamá (PA01)

#### Estado de Implementación
- **Configuración DVM**: Presente en RegionalParameters.dvm
- **Estado**: Configurado como "Active" para algunos servicios base pero sin implementación específica para CreditManagement
- **Servicios Específicos**: No encontrados para gestión crediticia

#### Limitaciones Detectadas
- No se encontraron proxies específicos para PA01 en CreditManagement
- Configuración presente solo para servicios base como GetAccountDetail_PS

### Nicaragua (NI01)

#### Estado de Implementación
- **Configuración DVM**: **No encontrada** en RegionalParameters.dvm para servicios crediticios
- **Estado**: **No configurado** para CreditManagement
- **Servicios Específicos**: **No encontrados - Requieren desarrollo completo**

#### Requerimientos para Implementación NI01

##### Configuración DVM Requerida
```xml
<row>
  <cell>SourceBank.NI01.DestinationBank.NI01</cell>
  <cell>GetConsolidatedCustomerRisk_PS</cell>
  <cell>Indica si la región está activa.</cell>
  <cell>DataWareHouseNI/RequestorServices/ProxyServices/v1.0/GetConsolidatedCustomerRisk</cell>
  <cell>Active</cell>
</row>
<row>
  <cell>SourceBank.NI01.DestinationBank.NI01</cell>
  <cell>GetCreditOffers_PS</cell>
  <cell>Indica si la región está activa.</cell>
  <cell>RulesManagement/RequestorServices/ProxyServices/v1.0/GetCreditOffers</cell>
  <cell>Active</cell>
</row>
```

##### Servicios a Desarrollar
- **GetConsolidatedCustomerRiskNI_PS.proxy**
- **GetCreditOffersNI_PS.proxy**
- **DataWareHouseNI_BS** (Business Service)
- **RulesManagementNI_BS** (Business Service)

##### Transformaciones XQuery Requeridas
- **Tx_GetConsolidatedCustomerNIRisk_To_consulta_ONBASE_V2.xqy**
- **Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskNIResponse.xqy**
- **Tx_GetCreditOffersNI_To_BLAZE.xqy**
- **Tx_BLAZE_To_GetCreditOffersNIResponse.xqy**
- **Tx_ErrorInfo_To_ConsolidatedCustomerRiskNIResponse.xqy**

##### Validaciones Específicas NI01
- **Formato Cédula**: `^[0-9]{3}-[0-9]{6}-[0-9]{4}[A-Z]$` (ej: 001-150485-0001A)
- **Formato RUC**: `^J[0-9]{13}$` (ej: J0310000000001)
- **Moneda**: NIO (Córdoba Nicaragüense)
- **Factor de Cambio**: 36.50 (aproximado USD a NIO)

##### JAR Files Requeridos
- **ConsolidatedCustomerRiskNI.jar**
- **CreditOffersNI.jar**
- **GetConsolidatedCustomerRiskNIOut.jar**

## Diferencias Clave entre Regiones Activas

### HN01 vs GT01 vs NI01 (Propuesto)

#### Diferencias en Transformaciones
1. **Archivos XQuery específicos**:
   - HN01: Usa transformaciones genéricas sin sufijo regional
   - GT01: Usa transformaciones con sufijo "GT"
   - NI01: Requiere transformaciones con sufijo "NI"

2. **Estructura de Response**:
   - HN01: Campos estándar con moneda HNL
   - GT01: Campos adicionales para GTQ y factor de cambio
   - NI01: Campos específicos para NIO, RUC y validaciones nicaragüenses

#### Diferencias en Servicios Backend
1. **DataWareHouse**:
   - HN01: DataWareHouseHN/RequestorServices/
   - GT01: DataWareHouse/RequestorServices/ (sin sufijo regional)
   - NI01: DataWareHouseNI/RequestorServices/ (requerido)

2. **Naming Convention**:
   - HN01: Servicios con sufijo "HN"
   - GT01: Servicios con sufijo "GT"
   - NI01: Servicios con sufijo "NI" (requerido)

#### Diferencias en Validaciones
1. **Documentos de Identidad**:
   - HN01: Cédula hondureña y RTN
   - GT01: DPI guatemalteco y NIT
   - NI01: Cédula nicaragüense (formato específico) y RUC

2. **Monedas y Conversiones**:
   - HN01: HNL (Lempira) - factor variable
   - GT01: GTQ (Quetzal) - factor ~7.75
   - NI01: NIO (Córdoba) - factor ~36.50

#### Diferencias en Reglas de Negocio
1. **Tasas de Interés Base**:
   - HN01: Variable según mercado
   - GT01: 12.5% base
   - NI01: 15.5% base (propuesto)

2. **Límites de Crédito**:
   - HN01: Basado en salario en HNL
   - GT01: Basado en salario en GTQ
   - NI01: Basado en salario en NIO (propuesto)

## Consideraciones para Migración

### Regiones Completamente Funcionales
- **HN01**: Implementación completa y activa
- **GT01**: Implementación completa y activa

### Regiones Parcialmente Configuradas
- **PA01**: Requiere implementación específica para CreditManagement

### Regiones No Configuradas
- **NI01**: **Requiere configuración e implementación completa desde cero**

### Plan de Implementación NI01

#### Fase 1: Configuración Base
1. Actualizar RegionalParameters.dvm
2. Crear business services DataWareHouseNI_BS
3. Configurar conexiones de base de datos

#### Fase 2: Desarrollo de Servicios
1. Desarrollar GetConsolidatedCustomerRiskNI_PS
2. Desarrollar GetCreditOffersNI_PS
3. Crear pipelines específicos NI01

#### Fase 3: Transformaciones
1. Desarrollar transformaciones XQuery NI
2. Implementar validaciones de documentos nicaragüenses
3. Configurar mapeos de moneda NIO

#### Fase 4: Reglas de Negocio
1. Configurar BLAZE Advisor para Nicaragua
2. Implementar reglas crediticias específicas NI
3. Configurar límites y tasas regionales

#### Fase 5: Testing y Validación
1. Pruebas unitarias por servicio
2. Pruebas de integración E2E
3. Validación de transformaciones y mapeos
4. Testing de manejo de errores específicos NI

### Dependencias Críticas por Región
1. **Archivos DVM**: RegionalParameters.dvm debe incluir NI01
2. **Servicios Backend**: NI01 requiere servicios específicos completos
3. **Transformaciones XQuery**: NI01 requiere desarrollo completo
4. **JAR Dependencies**: Archivos JAR específicos para NI01
5. **Base de Datos**: Configuración DataWareHouseNI independiente
6. **Validaciones**: Lógica específica para documentos nicaragüenses