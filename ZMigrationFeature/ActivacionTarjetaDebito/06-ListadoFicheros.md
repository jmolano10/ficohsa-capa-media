# Listado de Ficheros - ActivacionTarjetaDebito

## Proxy Services

### Servicios Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ActivacionTarjetaDebito.proxy`

### Servicios de Soporte
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/MapeoErrores.proxy`

## Business Services

### Servicios de Base de Datos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`

### Servicios T24
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/tarjetasDebito/Resources/tarjetasDebitoBS.biz`

### Servicios de Bitácora
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/OSB/RegistrarBitacoraOSB_v2/biz/RegistrarBitacoraOSB_v2.biz`

## Recursos de Transformación

### XQuery - Funcionalidad Principal
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActivacionTarjetaDebito/xq/consultaMaestraTDIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActivacionTarjetaDebito/xq/activacionTarjetaDebitoIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActivacionTarjetaDebito/xq/activacionTarjetaDebitoHeaderOut.xq`

### XQuery - Servicios Generales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/registrarBitacoraOSBIn.xq`

### XQuery - Utilidades
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/general/UUID/obtenerUUID.xq`

### XQuery - Mapeo de Errores
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

## Esquemas XSD

### Esquemas Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActivacionTarjetaDebito/xsd/activacionTarjetaDebitoTypes.xsd`

### Esquemas T24
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd`

### Esquemas de Soporte
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

## WSDL

### WSDL Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActivacionTarjetaDebito/wsdl/activacionTarjetaDebitoPS.wsdl`

## Archivos JAR de Despliegue

### Versiones de Producción
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/2019.10.2.3/PM-2040/PRD/activacionTarjetaDebito.jar`

### Versiones de QA
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/2019.10.2.3/PM-2040/QA/Entregable-I/activacionTarjetaDebito.jar`

## Dependencias Externas Identificadas

### Sistemas Backend
- T24 TarjetasDebito (operaciones: ConsultaMaestraTarjetaDebito, Activaciondetarjetadedebito)
- Base de datos Middleware (ValidaServicioRegional)
- LDAP Security (path: Middleware/Security/)

### Stored Procedures
- ValidaServicioRegional (referenciado en configuración JCA)

## Funciones Personalizadas Identificadas

### Funciones XQuery Específicas
- `getUsername()` - Lookup de credenciales en LDAP
- `getPassword()` - Lookup de password en LDAP
- `obtenerUUID()` - Generación de UUIDs únicos

## Resumen de Conteo de Archivos

| Tipo de Archivo | Cantidad | Observaciones |
|-----------------|----------|---------------|
| Proxy Services | 1 | Principal con branch condicional |
| Business Services | 3 | ValidaServicioRegional + tarjetasDebitoBS + RegistrarBitacoraOSB_v2 |
| XQuery Files | 8 | Transformaciones principales y de soporte |
| XSD Schemas | 3 | Tipos principales + T24 + headers |
| WSDL Files | 1 | Principal |
| JAR Files | 2 | Despliegues PRD y QA |
| **Total** | **18** | Archivos principales identificados |

## Características Específicas de ActivacionTarjetaDebito

### Diferencias con Otras Funcionalidades
- **Implementación Parcial**: Solo Honduras funcional
- **Bitácora Completa**: Request y response registrados
- **Validación Previa**: Consulta maestra antes de activación
- **ID Compuesto**: Usa PRODUCTTYPE + CARD_NUMBER
- **Branch Condicional**: Enrutamiento por región en mismo proxy

### Dependencias Críticas Únicas
- **RegistrarBitacoraOSB_v2**: Crítico para auditoría en HN01
- **tarjetasDebitoBS**: Específico para operaciones de tarjetas
- **obtenerUUID**: Para vinculación de bitácora request/response

## Notas de Migración

### Archivos Críticos para Migración
1. **Proxy principal**: Con branch condicional por región
2. **Business services**: ValidaServicioRegional y tarjetasDebitoBS
3. **Servicio bitácora**: RegistrarBitacoraOSB_v2 (crítico para HN01)
4. **XQuery transformations**: Especialmente las funciones de credenciales
5. **Esquemas XSD**: Validación de entrada

### Orden Sugerido de Migración
1. Servicios de soporte (ValidaServicioRegional, MapeoErrores)
2. Servicio de bitácora (RegistrarBitacoraOSB_v2)
3. Esquemas XSD y WSDL
4. Business service T24 (tarjetasDebitoBS)
5. XQuery transformations (incluyendo funciones personalizadas)
6. Proxy principal con branch condicional
7. Configuración LDAP y credenciales
8. Tests por región (HN01 funcional, otras con error esperado)

### Consideraciones Especiales
- **Implementación Parcial**: Solo HN01 tiene funcionalidad completa
- **Bitácora**: Dependencia crítica para auditoría
- **Branch Condicional**: Validar lógica de enrutamiento por región
- **Credenciales**: Configurar LDAP lookup correctamente
- **Otras Regiones**: Decidir si implementar o mantener error por defecto