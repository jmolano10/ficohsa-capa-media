# Listado de Ficheros - ModificaClienteDesembolsoLineaCredito

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/ModificaClienteDesembolsoLineaCredito.proxy`
  - Función: Punto de entrada, validaciones generales, enrutamiento regional
  - Service ID: FICBCO0364
  - Endpoint: /Middleware/OperationsAndExecution/CustomerLoans/ModificaClienteDLC

### Proxy Regional HN01
- `Middleware/v2/ProxyServices/ModificaClienteDesembolsoLineaCreditoHN.proxy`
  - Función: Implementación específica Honduras
  - Orquesta: ConsultaCliente + modificaClienteSolEmprendedor_db

## Business Services

### Base de Datos - Modificación Cliente
- `Middleware/v2/BusinessServices/ServiciosEmpresariales/modificaClienteSolEmprendedor/biz/modificaClienteSolEmprendedor_db.biz`
- `Middleware/v2/BusinessServices/ServiciosEmpresariales/modificaClienteSolEmprendedor/jca/modificaClienteSolEmprendedor_db.jca`
- `Middleware/v2/BusinessServices/ServiciosEmpresariales/modificaClienteSolEmprendedor/wsdl/modificaClienteSolEmprendedor.wsdl`
- `Middleware/v2/BusinessServices/ServiciosEmpresariales/modificaClienteSolEmprendedor/wsdl/modificaClienteSolEmprendedor_db.wsdl`
- `Middleware/v2/BusinessServices/ServiciosEmpresariales/modificaClienteSolEmprendedor/xsd/modificaClienteSolEmprendedor_sp.xsd`

### Validación Regional
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional.wsdl`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd`

## Resources - WSDL y XSD

### WSDL Principal
- `Middleware/v2/Resources/ModificaClienteDesembolsoLineaCredito/wsdl/modificaClienteDesembolsoLineaCreditoPS.wsdl`
  - Contrato SOAP del servicio
  - Namespace: http://www.ficohsa.com.hn/middleware.services/modificaClienteDesembolsoLineaCreditoPS/

### XSD Tipos de Datos
- `Middleware/v2/Resources/ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd`
  - Define: modificaClienteDesembolsoLineaCredito (request/response)
  - Tipos complejos: customerArrayType, productInfoArrayType, creditLinesArrayType, etc.

### XSD Headers
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`
  - Define: RequestHeader, ResponseHeader
  - Namespace: http://www.ficohsa.com.hn/middleware.services/autType

### XSD ConsultaCliente
- `Middleware/v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd`
  - Define: consultaClienteRequest, consultaClienteResponse
  - Namespace: http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes

## Transformaciones XQuery

### Transformación Consulta Cliente
- `Middleware/v2/Resources/ModificaClienteDesembolsoLineaCredito/xq/consultaClienteHNIn.xq`
  - Función: Transforma request modificación → request consulta
  - Input: modificaClienteDesembolsoLineaCredito
  - Output: consultaClienteRequest

### Transformación Modificación BD
- `Middleware/v2/Resources/ModificaClienteDesembolsoLineaCredito/xq/modificaClienteSolEmprendedorHNIn.xq`
  - Función: Transforma request OSB + respuesta consulta → InputParameters SP
  - Inputs: modificaClienteDesembolsoLineaCredito, consultaClienteResponse
  - Output: InputParameters (estructura SP)

### Transformaciones Generales
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
  - Función: Construye request para ValidaServicioRegional
  - Parámetros: serviceId, requestHeader

- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
  - Función: Aplica valores por defecto según región
  - Input: requestHeader
  - Output: requestHeader modificado

### Transformaciones MapeoErrores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
  - Función: Construye request para MapeoErrores
  - Parámetros: MENSAJE_ERROR, CODIGO_ERROR

- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`
  - Función: Construye ResponseHeader desde respuesta MapeoErrores
  - Parámetros: mapeoErroresResponse1, successIndicator

## Servicios Dependientes (Referencias)

### ConsultaCliente v3
- `Middleware/v3/ProxyServices/ConsultaCliente.proxy`
  - Función: Consulta información completa del cliente
  - Operación: consultaCliente

### MapeoErrores
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`
  - Función: Traduce códigos de error técnicos a mensajes de negocio
  - Operación: mapeoErrores

## Configuración y Políticas

### Políticas WS-Security
- No se encontraron archivos de políticas explícitas
- Configuración: wsdl-policy-attachments (en proxy)

### Configuración JCA
- Connection Factory: eis/DB/ConnectionDLC
- Adapter Type: DB (Oracle Database Adapter)
- Interaction Spec: DBStoredProcedureInteractionSpec

## Base de Datos

### Schema y Objetos
- **Schema**: DLC
- **Stored Procedure**: DLC_P_MODIFICAR_CLIENTE
- **Tipos Oracle**:
  - DLC.TVARCHAR256
  - DLC.T_LOAN_LIMITS_DLC
  - DLC.OT_LOAN_LIMITS_DLC
  - DLC.T_DESTINATION_PRODUCTS_DLC
  - DLC.OT_DESTINATION_PRODUCTS_DLC
  - DLC.T_DEBIT_ACCOUNTS_DLC
  - DLC.OT_DEBIT_ACCOUNTS_DLC
  - DLC.T_CREDIT_LINES_DLC
  - DLC.OT_CREDIT_LINES_DLC
  - DLC.T_LOAN_PRODUCTS_DLC
  - DLC.OT_LOAN_PRODUCTS_DLC
  - DLC.T_REPAYMENT_TYPES_DLC
  - DLC.OT_REPAYMENT_TYPES_DLC
  - DLC.T_RATES_DLC
  - DLC.RT_RATES_DLC
  - DLC.T_CHARGES_DLC
  - DLC.RT_CHARGES_DLC
  - DLC.T_RANGE_DLC
  - DLC.RT_RANGE_DLC

## Tests

**No se encontraron archivos de test en el repositorio analizado.**

Recomendación: Crear tests unitarios y de integración para:
- Validación XSD
- Transformaciones XQuery
- Flujo completo HN01
- Casos de error

## Archivos de Configuración

### Properties
- No se encontraron archivos .properties específicos para esta funcionalidad
- Configuración probablemente en nivel de servidor OSB

### Deployment Descriptors
- No se encontraron descriptores de despliegue explícitos
- Configuración embebida en archivos .proxy y .biz

## Resumen de Conteo

| Tipo de Archivo | Cantidad |
|-----------------|----------|
| Proxy Services | 2 |
| Business Services (.biz) | 2 |
| JCA Adapters (.jca) | 2 |
| WSDL | 5 |
| XSD | 4+ |
| XQuery (.xq) | 6 |
| Total | 21+ |

## Rutas Base

- **Proxies**: `Middleware/v2/ProxyServices/`
- **Business Services**: `Middleware/v2/BusinessServices/`
- **Resources**: `Middleware/v2/Resources/`
- **Schemas**: `Middleware/v2/Resources/*/xsd/`
- **Transformations**: `Middleware/v2/Resources/*/xq/`

## Notas

1. Todos los paths son relativos al workspace root
2. Archivos verificados contra código fuente
3. No se incluyen archivos generados automáticamente
4. Versión analizada: v2 (con dependencia en v3 para ConsultaCliente)
