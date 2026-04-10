# Resumen Ejecutivo - CreditManagementRouter_PS

## Índice de Documentación
- [01-ResumenEjecutivo.md](01-ResumenEjecutivo.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](03-EjemplosYMapeos-HN01.md)
- [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md)
- [03-EjemplosYMapeos-NI01.md](03-EjemplosYMapeos-NI01.md)
- [04-Secuencia-HN01.mmd](04-Secuencia-HN01.mmd)
- [04-Secuencia-GT01.mmd](04-Secuencia-GT01.mmd)
- [04-Secuencia-NI01.mmd](04-Secuencia-NI01.mmd)
- [05-FlujoMultiregión.mmd](05-FlujoMultiregión.mmd)
- [06-ListadoFicheros.md](06-ListadoFicheros.md)
- [07-MapeoErrores.md](07-MapeoErrores.md)

## Propósito de la Funcionalidad

El **CreditManagementRouter_PS** es un proxy service de Oracle Service Bus (OSB) que actúa como router central para servicios de gestión crediticia. Su función principal es enrutar dinámicamente las solicitudes de servicios crediticios hacia los servicios específicos de cada región basándose en los parámetros de SourceBank y DestinationBank.

## Entradas y Salidas Principales

### Entradas
- **REST/SOAP Requests** con endpoint: `v1.0/credit-management`
- **Operaciones soportadas:**
  - `getConsolidatedCustomerRisk`: Consulta de riesgo consolidado del cliente
  - `getCustomerOffers`: Obtención de ofertas crediticias
  - `getCustomerSecondOffer`: Obtención de segunda oferta crediticia
  - `refGetCustomerOffer`: Obtención de ofertas crediticias (versión refactorizada)

### Salidas
- **Respuestas estructuradas** según el esquema XSD correspondiente
- **Códigos de error HTTP** mapeados desde errores internos
- **Información de estado** y mensajes de error estandarizados

## Sistemas/Servicios OSB Involucrados

### Servicios Dependientes por Región

#### Honduras (HN01) - ✅ Implementado
- **DataWareHouseHN/RequestorServices/ProxyServices/v1.0/**: GetConsolidatedCustomerRisk
- **RulesManagement/RequestorServices/ProxyServices/v1.0/**: GetCreditOffers, RefGetCreditOffers

#### Guatemala (GT01) - ✅ Implementado
- **DataWareHouse/RequestorServices/ProxyServices/v1.0/GetConsolidatedCustomerRisk**: GetConsolidatedCustomerRiskGT_PS
- **RulesManagement/RequestorServices/ProxyServices/v1.0/GetCreditOffers**: GetCreditOffersGT_PS

#### Nicaragua (NI01) - ⚠️ Requiere Implementación
- **DataWareHouseNI/RequestorServices/ProxyServices/v1.0/**: GetConsolidatedCustomerRiskNI_PS (Requerido)
- **RulesManagement/RequestorServices/ProxyServices/v1.0/**: GetCreditOffersNI_PS (Requerido)

### Servicios de Soporte
- **CommonResources/MiddlewareDB/ProviderServices/BusinessServices/GetErrorMessages/v1.0/GetErrorMessages_BS**: Gestión de errores
- **CommonResources/MiddlewareDB/ProviderServices/BusinessServices/SetLogInfoService/v1.0/SetLogInfoService_BS**: Logging de transacciones

## Regiones Detectadas

Basándose en el análisis del archivo DVM RegionalParameters y la estructura del código:

1. **HN01** - Honduras ✅ **Completamente Implementado**
2. **GT01** - Guatemala ✅ **Completamente Implementado**
3. **PA01** - Panamá ⚠️ **Configurado pero sin implementación específica**
4. **NI01** - Nicaragua ❌ **No configurado - Requiere implementación completa**

### Estado Detallado por Región

#### Nicaragua (NI01) - Plan de Implementación Requerido

**Estado Actual**: No configurado en RegionalParameters.dvm para servicios crediticios

**Componentes Requeridos**:
- Configuración DVM para NI01
- Proxies específicos: GetConsolidatedCustomerRiskNI_PS, GetCreditOffersNI_PS
- Business Services: DataWareHouseNI_BS, RulesManagementNI_BS
- Transformaciones XQuery específicas para NI01
- Validaciones de documentos nicaragüenses (Cédula, RUC)
- Configuración de moneda NIO y factor de cambio
- JAR files específicos: ConsolidatedCustomerRiskNI.jar, CreditOffersNI.jar

**Características Específicas NI01**:
- **Moneda Local**: NIO (Córdoba Nicaragüense)
- **Factor de Cambio**: ~36.50 USD a NIO
- **Formato Cédula**: 001-150485-0001A (patrón: ^[0-9]{3}-[0-9]{6}-[0-9]{4}[A-Z]$)
- **Formato RUC**: J0310000000001 (patrón: ^J[0-9]{13}$)
- **Tasa Base Propuesta**: 15.5%

## Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
- **Dependencia de DVM**: El enrutamiento depende completamente del archivo RegionalParameters.dvm
- **Punto único de falla**: El router centraliza todas las operaciones crediticias
- **Validación regional**: Error MW-0003 si la región no está activa o configurada
- **Nicaragua no implementada**: NI01 requiere desarrollo completo desde cero

### Limitaciones Funcionales
- **Regiones limitadas**: Solo HN01 y GT01 tienen implementaciones completas
- **Nicaragua sin soporte**: NI01 no está configurado ni implementado
- **Operaciones fijas**: Solo 4 operaciones soportadas actualmente
- **Autenticación básica**: Solo HTTP Basic Authentication configurada

### Riesgos Específicos NI01
- **Implementación desde cero**: Requiere desarrollo completo de todos los componentes
- **Validaciones específicas**: Formatos de documentos nicaragüenses únicos
- **Reglas de negocio**: Necesita configuración específica para el mercado nicaragüense
- **Testing extensivo**: Requiere validación completa de todos los flujos

## Métricas o SLAs

### Configuración de Monitoreo
- **Tracing habilitado**: `<oper:tracingEnabled>true</oper:tracingEnabled>`
- **Monitoring nivel servicio**: `enabled="true" level="service" aggregationInterval="360"`
- **Intervalo de agregación**: 360 segundos (6 minutos)

### Códigos de Servicio por Operación
- **getConsolidatedCustomerRisk**: Código '3'
- **getCreditOffers**: Código '8'  
- **getCustomerSecondOffer**: Código '43'
- **refGetCustomerOffer**: Código '8'

## Arquitectura de Enrutamiento

El servicio utiliza un patrón de **Dynamic Routing** basado en:

1. **Validación regional** mediante DVM lookup
2. **Asignación de variables** comunes (codigoServicio, language, sourceBank, destinationBank, serviceName)
3. **Enrutamiento dinámico** hacia el servicio específico de la región
4. **Manejo centralizado de errores** con logging y mapeo de códigos HTTP

## Transformaciones Principales

### Transformaciones Existentes
- **Mapeo de errores**: CommonResources/XQ/Tx_ErrorMap_To_ErrorInfo
- **Logging de transacciones**: CommonResources/MiddlewareDB/ProviderServices/XQ/Tx_Msg_To_SetLogInfo
- **Transformaciones específicas por operación** en pipelines de respuesta

### Transformaciones Requeridas para NI01
- **Tx_GetConsolidatedCustomerNIRisk_To_consulta_ONBASE_V2.xqy**
- **Tx_consulta_ONBASE_V2_To_GetConsolidatedCustomerRiskNIResponse.xqy**
- **Tx_GetCreditOffersNI_To_BLAZE.xqy**
- **Tx_BLAZE_To_GetCreditOffersNIResponse.xqy**
- **Tx_ErrorInfo_To_ConsolidatedCustomerRiskNIResponse.xqy**

## Plan de Implementación Nicaragua (NI01)

### Fase 1: Configuración Base (Estimado: 1-2 semanas)
1. **Actualizar RegionalParameters.dvm** con entradas NI01
2. **Configurar business services** DataWareHouseNI_BS
3. **Establecer conexiones** de base de datos específicas

### Fase 2: Desarrollo de Servicios (Estimado: 2-3 semanas)
1. **Desarrollar proxies** GetConsolidatedCustomerRiskNI_PS, GetCreditOffersNI_PS
2. **Crear pipelines** específicos para NI01
3. **Implementar validaciones** de documentos nicaragüenses

### Fase 3: Transformaciones (Estimado: 2-3 semanas)
1. **Desarrollar transformaciones XQuery** específicas NI
2. **Implementar mapeos** de moneda NIO
3. **Configurar conversiones** USD ↔ NIO

### Fase 4: Reglas de Negocio (Estimado: 2-3 semanas)
1. **Configurar BLAZE Advisor** para Nicaragua
2. **Implementar reglas crediticias** específicas del mercado nicaragüense
3. **Configurar límites y tasas** regionales

### Fase 5: Testing y Validación (Estimado: 2-3 semanas)
1. **Pruebas unitarias** por servicio
2. **Pruebas de integración** E2E
3. **Validación de transformaciones** y mapeos
4. **Testing de manejo de errores** específicos NI

**Tiempo Total Estimado**: 9-14 semanas

## Consideraciones de Migración

### Configuración DVM Crítica
- Debe migrarse correctamente el archivo RegionalParameters.dvm
- **Agregar entradas específicas para NI01** en el DVM
- Verificar que todas las regiones objetivo estén configuradas

### Dependencias de Servicios
- Verificar disponibilidad de servicios dependientes en destino
- **Desarrollar servicios específicos para NI01** desde cero
- Configurar business services para DataWareHouseNI

### Políticas de Seguridad
- Migrar configuración de autenticación HTTP Basic
- Aplicar mismas políticas de seguridad a servicios NI01

### Monitoreo y Alertas
- Configurar métricas y alertas en el nuevo entorno
- **Incluir monitoreo específico para NI01** una vez implementado
- Establecer SLAs específicos para el mercado nicaragüense

### Validaciones Específicas por Región
- **HN01**: Cédula hondureña, RTN, moneda HNL
- **GT01**: DPI guatemalteco, NIT, moneda GTQ, factor cambio 7.75
- **NI01**: Cédula nicaragüense, RUC, moneda NIO, factor cambio 36.50

## Recomendaciones

### Para Migración Inmediata
1. **Migrar HN01 y GT01** que están completamente implementados
2. **Documentar dependencias** de PA01 para futura implementación
3. **Planificar implementación de NI01** como proyecto separado

### Para Implementación NI01
1. **Seguir patrones existentes** de GT01 como referencia
2. **Implementar validaciones específicas** para documentos nicaragüenses
3. **Configurar reglas de negocio** apropiadas para el mercado local
4. **Realizar testing exhaustivo** antes del despliegue

### Para Mantenimiento
1. **Centralizar configuraciones** regionales en DVM
2. **Estandarizar patrones** de transformación entre regiones
3. **Implementar monitoreo** proactivo por región
4. **Documentar procedimientos** de adición de nuevas regiones