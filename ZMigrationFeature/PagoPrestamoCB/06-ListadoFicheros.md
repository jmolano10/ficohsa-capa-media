# Listado de Ficheros - PagoPrestamoCB

## Proxy Services

### 1. Proxy Principal
```
Middleware/v2/SProxyServices/PagoPrestamoCB.proxy
```
- **Tipo:** Proxy Service (SOAP)
- **Descripción:** Servicio principal que expone la funcionalidad de pago de préstamos para corresponsales bancarios
- **Endpoint:** `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamoCB`
- **Protocolo:** HTTPS
- **Regiones:** HN01 (completo), GT01 (parcial), PA01 (parcial)

### 2. Proxy de Mapeo de Errores
```
Middleware/v2/ProxyServices/MapeoErrores.proxy
```
- **Tipo:** Proxy Service
- **Descripción:** Servicio para mapear códigos de error internos a mensajes de usuario
- **Operación:** mapeoErrores

---

## Business Services

### 1. Servicio de Caja
```
Middleware/v2/BusinessServices/OSB/PagoPrestamoCB/biz/PagoPrestamoCB.biz
```
- **Tipo:** Business Service (SOAP)
- **Descripción:** Invoca al sistema de caja para ejecutar el pago del préstamo
- **Endpoint:** `http://mwinterbanca:8003/MiddlewareCaja/PagoPrestamoCaja`
- **Operación:** pagoPrestamo

### 2. Actualización de Estado de Transacción
```
Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/biz/actualizaEstadoTransaccion_db.biz
Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/jca/actualizaEstadoTransaccion_db.jca
Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/wsdl/actualizaEstadoTransaccion_db.wsdl
Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/wsdl/actualizaEstadoTransaccion.wsdl
Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/xsd/actualizaEstadoTransaccion_sp.xsd
```
- **Tipo:** DB Adapter
- **Descripción:** Actualiza el estado de la transacción en base de datos
- **Conexión:** eis/DB/ConnectionCollections
- **SP:** COLLECTIONS.OSB_P_MANEJO_TRANSACCIONES.ACTUALIZA_ESTADO_TRANSACCION

### 3. Registro de Estado de Transacción
```
Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/biz/registraEstadoTransaccion_db.biz
Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/jca/registraEstadoTransaccion_db.jca
Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/wsdl/registraEstadoTransaccion_db.wsdl
Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/wsdl/registraEstadoTransaccion.wsdl
Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/xsd/registraEstadoTransaccion_sp.xsd
```
- **Tipo:** DB Adapter
- **Descripción:** Registra la transacción inicial en base de datos
- **Conexión:** eis/DB/ConnectionCollections
- **SP:** COLLECTIONS.OSB_P_MANEJO_TRANSACCIONES.REGISTRA_TRANSACCION_CANAL

### 4. Validación de Servicio Regional
```
Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz
Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca
Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl
Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional.wsdl
Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd
```
- **Tipo:** DB Adapter
- **Descripción:** Valida que el servicio esté habilitado para la región
- **Conexión:** eis/DB/ConnectionMiddleware
- **SP:** MW_P_VALIDA_SERVICIO_REGIONAL

### 5. Consulta de Corresponsal Bancario
```
Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/biz/consultarCorresponsalB_db.biz
Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/jca/consultarCorresponsalB_db.jca
Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/wsdl/consultarCorresponsalB_db.wsdl
Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/wsdl/consultarCorresponsalB.wsdl
Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/xsd/consultarCorresponsalB_sp.xsd
```
- **Tipo:** DB Adapter
- **Descripción:** Consulta la parametrización del corresponsal bancario
- **Conexión:** eis/DB/ConnectionMiddleware
- **SP:** MW_P_VALIDA_CORBAN

### 6. Registro de Uso de Servicio
```
Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_db.biz
Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_db.jca
Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_db.wsdl
Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio.wsdl
Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_sp.xsd
```
- **Tipo:** DB Adapter
- **Descripción:** Registra y controla el uso del servicio por usuario
- **Conexión:** eis/DB/ConnectionMiddleware
- **SP:** MW_P_REGISTRAR_USO_SERVICIO

---

## XQuery Transformations

### 1. Transformación de Header de Entrada
```
Middleware/v2/Resources/PagoPrestamoCB/xq/PagoPrestamoCBHdrIn.xq
```
- **Descripción:** Transforma el header del request OSB al formato de caja
- **Input:** RequestHeader
- **Output:** AutenticacionRequestHeader
- **Funciones:**
  - `getUsername()`: Busca credenciales en LDAP
  - `getPassword()`: Busca credenciales en LDAP
  - Fail-over a credenciales del request si no encuentra en LDAP

### 2. Transformación de Body de Entrada
```
Middleware/v2/Resources/PagoPrestamoCB/xq/PagoPrestamoCBIn.xq
```
- **Descripción:** Transforma el body del request OSB al formato de caja
- **Input:** pagoPrestamo (formato CB)
- **Output:** pagoPrestamo (formato Caja)
- **Transformaciones:**
  - Copia campos básicos
  - Sobrescribe DESCRIPTION con "CODIGO_CORRESPONSAL"
  - Sobrescribe REPAY_TYPE con TRANSACTION_ID_BC

### 3. Registro de Transacción
```
Middleware/v2/Resources/PagoPrestamoCB/xq/registraTransaccionPrestamo.xq
```
- **Descripción:** Construye el request para registrar la transacción en BD
- **Input:** Datos del request y header
- **Output:** InputParameters para SP REGISTRA_TRANSACCION_CANAL

### 4. Actualización de Estado de Transacción
```
Middleware/v2/Resources/PagoPrestamoCB/xq/actualizaEstadoTransaccionPrestamo.xq
```
- **Descripción:** Construye el request para actualizar el estado de la transacción
- **Input:** Datos de estado y transacción
- **Output:** InputParameters para SP ACTUALIZA_ESTADO_TRANSACCION

### 5. Validación de Servicio Regional
```
Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq
```
- **Descripción:** Construye el request para validar servicio regional
- **Input:** RequestHeader y serviceId
- **Output:** InputParameters para SP MW_P_VALIDA_SERVICIO_REGIONAL

### 6. Aplicar Valores por Defecto Región CB
```
Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegionCB.xq
```
- **Descripción:** Aplica valores por defecto para región de corresponsal bancario
- **Input:** RequestHeader
- **Output:** RequestHeader con valores por defecto

### 7. Consulta de Corresponsal
```
Middleware/v2/Resources/Genericos/consultarCorresponsalBIn.xq
```
- **Descripción:** Construye el request para consultar corresponsal
- **Input:** Datos del corresponsal
- **Output:** InputParameters para SP MW_P_VALIDA_CORBAN

### 8. Registro de Uso de Servicio
```
Middleware/Business_Resources/general/UsoServicio/registroUsoServicioIn.xq
```
- **Descripción:** Construye el request para registrar uso de servicio
- **Input:** Datos de servicio y usuario
- **Output:** InputParameters para SP MW_P_REGISTRAR_USO_SERVICIO

### 9. Mapeo de Errores - Entrada
```
Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq
```
- **Descripción:** Construye el request para mapear errores
- **Input:** Código y mensaje de error
- **Output:** Request para servicio MapeoErrores

### 10. Mapeo de Errores - Salida
```
Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq
```
- **Descripción:** Construye el response con error mapeado
- **Input:** Response de MapeoErrores
- **Output:** ResponseHeader con error mapeado

### 11. Mapeo de Error de Validación
```
Middleware/v2/Resources/Genericos/mapeoErrorValidate.xq
```
- **Descripción:** Mapea errores de validación de esquema
- **Input:** Fault de validación
- **Output:** ResponseHeader con error de validación

---

## WSDL Files

### 1. WSDL del Servicio de Caja
```
Middleware/v2/BusinessServices/OSB/PagoPrestamoCB/wsdl/PagoPrestamoCaja.wsdl
```
- **Descripción:** Contrato WSDL del servicio de caja
- **Namespace:** http://www.ficohsa.com.hn/middleware.services/pagoPrestamoPS/
- **Port:** pagoPrestamoPSSOAP
- **Operation:** pagoPrestamo

---

## XSD Schemas

### 1. Schema de Tipos de Pago de Préstamo
```
Middleware/v2/BusinessServices/OSB/PagoPrestamoCB/xsd/XMLSchema_-541390746.xsd
```
- **Descripción:** Define los tipos de datos para request y response
- **Namespace:** http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes
- **Elementos:**
  - pagoPrestamo (request)
  - pagoPrestamoResponse (response)

### 2. Schema de Headers
```
Middleware/v2/Resources/esquemas_generales/HeaderElementsCB.xsd
```
- **Descripción:** Define los elementos del header para corresponsales bancarios
- **Namespace:** http://www.ficohsa.com.hn/middleware.services/autType
- **Elementos:**
  - RequestHeader
  - ResponseHeader

---

## Java Callouts

### 1. Utilidades
```
Middleware/v2/Resources/Utilities/Java/Utilities.jar
```
- **Clase:** ficohsa.utilities.Utilities
- **Método:** FormatearPrestamo(String)
- **Descripción:** Formatea el número de préstamo según estándar del banco
- **Input:** Número de préstamo (String)
- **Output:** Número de préstamo formateado (String)

---

## Configuration Files

### 1. JCA Adapters
```
Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/jca/actualizaEstadoTransaccion_db.jca
Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/jca/registraEstadoTransaccion_db.jca
Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca
Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/jca/consultarCorresponsalB_db.jca
Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_db.jca
```
- **Descripción:** Configuración de adaptadores de base de datos
- **Contiene:**
  - Connection factory
  - Stored procedure name
  - Schema name
  - Package name

---

## Políticas y Seguridad

### 1. Credenciales LDAP
```
Middleware/Security/{USERNAME}
```
- **Descripción:** Credenciales almacenadas en servicio LDAP
- **Formato:** Basic Credentials
- **Campos:**
  - username
  - password

---

## Tests Relevantes

**Nota:** No se encontraron archivos de test específicos para esta funcionalidad en el repositorio analizado.

---

## Resumen de Ficheros por Categoría

### Proxy Services: 2 archivos
- PagoPrestamoCB.proxy
- MapeoErrores.proxy

### Business Services: 6 servicios (30+ archivos)
- PagoPrestamoCB (servicio de caja)
- actualizaEstadoTransaccion_db
- registraEstadoTransaccion_db
- ValidaServicioRegional_db
- consultarCorresponsalB_db
- registrarUsoServicio_db

### XQuery Transformations: 11 archivos
- PagoPrestamoCBHdrIn.xq
- PagoPrestamoCBIn.xq
- registraTransaccionPrestamo.xq
- actualizaEstadoTransaccionPrestamo.xq
- validaServicioRegionalIn.xq
- aplicarValoresPorDefectoRegionCB.xq
- consultarCorresponsalBIn.xq
- registroUsoServicioIn.xq
- mapeoErroresUsageIn.xq
- mapeoErroresUsageOut.xq
- mapeoErrorValidate.xq

### WSDL Files: 7+ archivos
- PagoPrestamoCaja.wsdl
- actualizaEstadoTransaccion_db.wsdl
- registraEstadoTransaccion_db.wsdl
- ValidaServicioRegional_db.wsdl
- consultarCorresponsalB_db.wsdl
- registrarUsoServicio_db.wsdl
- mapeoErroresProxy.wsdl

### XSD Schemas: 7+ archivos
- XMLSchema_-541390746.xsd
- HeaderElementsCB.xsd
- actualizaEstadoTransaccion_sp.xsd
- registraEstadoTransaccion_sp.xsd
- ValidaServicioRegional_sp.xsd
- consultarCorresponsalB_sp.xsd
- registrarUsoServicio_sp.xsd

### Java Libraries: 1 archivo
- Utilities.jar

### JCA Adapters: 5 archivos
- actualizaEstadoTransaccion_db.jca
- registraEstadoTransaccion_db.jca
- ValidaServicioRegional_db.jca
- consultarCorresponsalB_db.jca
- registrarUsoServicio_db.jca

---

## Total de Ficheros Involucrados

**Aproximadamente 60+ archivos** distribuidos en:
- Proxy Services
- Business Services
- XQuery Transformations
- WSDL Contracts
- XSD Schemas
- Java Libraries
- JCA Adapters
- Configuration Files

---

**Nota:** Todas las rutas son relativas al directorio raíz del workspace:
```
/Users/julian.molano/Github/ficohsa-capa-media/Fuentes/ficohsacore-osb-7e5cceccb837/
```

---

**Fecha de Análisis:** 2024
**Versión del Documento:** 1.0
