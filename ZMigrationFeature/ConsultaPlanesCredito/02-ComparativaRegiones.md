# Comparativa entre Regiones - ConsultaPlanesCredito

## Tabla de Comparación Regional

| Aspecto | GT01 (Guatemala) | HN01 (Honduras) | NI01 (Nicaragua) | PA01 (Panamá) |
|---------|------------------|-----------------|------------------|---------------|
| **Endpoint OSB** | `/Middleware/v2/ProxyServices/ConsultaPlanesCreditoGT` | `/Middleware/v2/ProxyServices/ConsultaPlanesCreditoHN` | Local (sin URI específica) | Local (sin URI específica) |
| **Nombre de Base de Datos** | ConnectionTarjetas | ConnectionTarjetas | ConnectionTarjetas | ConnectionTarjetas |
| **Esquemas** | dbo | dbo | OSB.dbo | dbo |
| **Store Procedure** | OSBConDatoPlanes | OSBConDatoPlanes | OSBConDatoPlanes | OSBConDatoPlanes |
| **Nombre de Conexión a Base de datos** | eis/DB/ConnectionTarjetas | eis/DB/ConnectionTarjetas | eis/DB/ConnectionTarjetas | eis/DB/ConnectionTarjetas |
| **Transformaciones clave** | consultaPlanesCreditoGTOut.xq | consultaPlanesCreditoHNOut.xq | consultaPlanesCreditoOut.xq | consultaPlanesCreditoPAOut.xq |
| **Campos diferenciadores** | Ninguno específico | Ninguno específico | SchemaName="OSB" en JCA | Ninguno específico |
| **Errores/Excepciones** | MapeoErrores estándar | MapeoErrores con código de error específico | MapeoErrores estándar | MapeoErrores estándar |
| **Timeouts/Retrys** | Sin timeout/0 reintentos | Sin timeout/0 reintentos | Sin timeout/0 reintentos | Sin timeout/0 reintentos |
| **Dependencias internas** | MasterDataGT/conDatosPlanes | MasterDataHN/conDatosPlanes | MasterData/conDatosPlanes | MasterDataPA/conDatosPlanes |
| **Business Service** | MasterDataGT/conDatosPlanes/biz/conDatosPlanes_db | MasterDataHN/conDatosPlanes/biz/conDatosPlanes_db | MasterData/conDatosPlanes/biz/conDatosPlanes_db | MasterDataPA/conDatosPlanes/biz/conDatosPlanes_db |
| **XQuery Input** | conDatosPlanesGTIn.xq | conDatosPlanesHNIn.xq | conDatosPlanesIn.xq | conDatosPlanesPAIn.xq |
| **Selector SOAP** | SOAP body | SOAP body | SOAP action | SOAP action |
| **Provider Transport** | http | http | local | local |

## Detalles por Región

### GT01 (Guatemala)

**Características específicas:**
- **Endpoint**: Expuesto vía HTTP en `/Middleware/v2/ProxyServices/ConsultaPlanesCreditoGT`
- **Transport Provider**: HTTP con configuración de inbound properties
- **SOAP Selector**: SOAP body
- **Business Service**: MasterDataGT/conDatosPlanes_db
- **Transformación Input**: conDatosPlanesGTIn.xq
- **Transformación Output**: consultaPlanesCreditoGTOut.xq
- **Esquema BD**: dbo.OSBConDatoPlanes
- **Manejo de Errores**: Estándar con MapeoErrores

**Validaciones específicas:**
- Validación de esquema XSD en request transform
- Conversión de código de país OSB-ISO3
- Validación de errorCode != '-1' para determinar éxito

**Mapeos específicos:**
- Conversión de fecha con formato 'yyyyMMdd'
- Mapeo directo de campos de base de datos a response

### HN01 (Honduras)

**Características específicas:**
- **Endpoint**: Expuesto vía HTTP en `/Middleware/v2/ProxyServices/ConsultaPlanesCreditoHN`
- **Transport Provider**: HTTP sin configuración específica de properties
- **SOAP Selector**: SOAP body
- **Business Service**: MasterDataHN/conDatosPlanes_db
- **Transformación Input**: conDatosPlanesHNIn.xq
- **Transformación Output**: consultaPlanesCreditoHNOut.xq
- **Esquema BD**: dbo.OSBConDatoPlanes
- **Manejo de Errores**: Con código de error específico en successIndicator

**Validaciones específicas:**
- Validación de esquema XSD en request transform
- Conversión de código de país OSB-ISO3
- Validación de errorCode != '-1' para determinar éxito

**Diferencias en manejo de errores:**
```xml
<successIndicator>{ $errorCode }</successIndicator>
```
En lugar del estándar "ERROR"

### NI01 (Nicaragua)

**Características específicas:**
- **Endpoint**: Local (sin URI específica)
- **Transport Provider**: Local
- **SOAP Selector**: SOAP action
- **Business Service**: MasterData/conDatosPlanes_db
- **Transformación Input**: conDatosPlanesIn.xq
- **Transformación Output**: consultaPlanesCreditoOut.xq
- **Esquema BD**: OSB.dbo.OSBConDatoPlanes (único con SchemaName)
- **Manejo de Errores**: Estándar con MapeoErrores

**Características únicas:**
- **SchemaName**: "OSB" especificado en la configuración JCA
- **Transport**: Local en lugar de HTTP
- **SOAP Selector**: SOAP action en lugar de SOAP body

**Configuración JCA específica:**
```xml
<property name="SchemaName" value="OSB"/>
<property name="PackageName" value="dbo"/>
```

### PA01 (Panamá)

**Características específicas:**
- **Endpoint**: Local (sin URI específica)
- **Transport Provider**: Local
- **SOAP Selector**: SOAP action
- **Business Service**: MasterDataPA/conDatosPlanes_db
- **Transformación Input**: conDatosPlanesPAIn.xq
- **Transformación Output**: consultaPlanesCreditoPAOut.xq
- **Esquema BD**: dbo.OSBConDatoPlanes
- **Manejo de Errores**: Estándar con MapeoErrores

**Validaciones específicas:**
- Validación de esquema XSD en request transform
- Conversión de código de país OSB-ISO3
- Validación de errorCode != '-1' para determinar éxito

**Transformación específica:**
- Uso de variable `$OutputParameters` en lugar de acceso directo
- Formato de fecha idéntico a otras regiones

## Diferencias Principales Identificadas

### 1. Configuración de Transport
- **GT01 y HN01**: Utilizan transport HTTP con endpoints específicos
- **NI01 y PA01**: Utilizan transport local sin endpoints HTTP

### 2. Selector SOAP
- **GT01 y HN01**: SOAP body selector
- **NI01 y PA01**: SOAP action selector

### 3. Esquema de Base de Datos
- **NI01**: Único que especifica SchemaName="OSB" en configuración JCA
- **Otras regiones**: Solo especifican PackageName="dbo"

### 4. Manejo de Errores
- **HN01**: Incluye el código de error específico en successIndicator
- **Otras regiones**: Utilizan "ERROR" estándar en caso de fallo

### 5. Transformaciones XQuery
- **Todas las regiones**: Utilizan la misma lógica de transformación pero con archivos específicos
- **PA01**: Utiliza variable intermedia `$OutputParameters`
- **Otras**: Acceso directo al parámetro `$outputParameters`

## Consideraciones para Migración

### Unificación Posible
1. **Stored Procedure**: Todas las regiones utilizan el mismo SP (OSBConDatoPlanes)
2. **Lógica de Transformación**: Idéntica en todas las regiones
3. **Estructura de Response**: Completamente uniforme

### Diferencias a Mantener
1. **Configuración de Esquema**: NI01 requiere SchemaName="OSB"
2. **Transport Configuration**: GT01/HN01 vs NI01/PA01
3. **SOAP Selector**: Diferencias entre regiones

### Recomendaciones
1. **Consolidar Transformaciones**: Crear una transformación única parametrizada
2. **Estandarizar Manejo de Errores**: Unificar el formato de error response
3. **Configuración Centralizada**: Parametrizar las diferencias de configuración por región
4. **Monitoreo Unificado**: Habilitar monitoreo consistente en todas las regiones