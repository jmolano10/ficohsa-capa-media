# Listado de Ficheros - Depositoenefectivofase11

## Proxy Services

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| PagoPrestamoCaja.proxy | MiddlewareCaja/ProxyServices/PagoPrestamoCaja.proxy | Servicio proxy principal para pagos de préstamo |

## Business Services

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| Depositos.biz | MiddlewareCaja/BussinessServices/Depositos.biz | Servicio de negocio para operaciones de depósito |
| ObtenerParametrizacion_db.biz | MiddlewareCaja/BussinessServices/ObtenerParametrizacion_db.biz | Obtención de parámetros de configuración |
| consultarPtmoMigrado_db.biz | MiddlewareCaja/BussinessServices/consultarPtmoMigrado_db.biz | Validación de préstamos migrados |
| PagoPrestamo_db.biz | MiddlewareCaja/BussinessServices/PagoPrestamo_db.biz | Registro de pagos en base de datos |
| ConsultasCuenta.biz | MiddlewareCaja/BussinessServices/ConsultasCuenta.biz | Consultas de información de cuentas |

## Pipelines y Transformaciones XQuery

### Transformaciones de Entrada
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| DepositoEfectivoMonedaLocalIn.xq | MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/DepositoEfectivoMonedaLocalIn.xq | Transformación para depósito en moneda local |
| PagoPrestamoCajaValidacionIn.xq | MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoCajaValidacionIn.xq | Validaciones de entrada |
| ConsultaGeneralPrestamoIn.xq | MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/ConsultaGeneralPrestamoIn.xq | Consulta general de préstamo |
| ConsultaDetalleCuentaIn.xq | MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/ConsultaDetalleCuentaIn.xq | Consulta detalle de cuenta |
| PagoPrestamoIn.xq | MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoIn.xq | Transformación pago préstamo |

### Transformaciones de Salida
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| PagoPrestamoCajaOut.xq | MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoCajaOut.xq | Transformación de respuesta principal |
| PagoPrestamoCajaHeaderOut.xq | MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoCajaHeaderOut.xq | Transformación de header de respuesta |

### Transformaciones de Utilidad
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| obtenerUUID.xq | MiddlewareCaja/Resources/xqueries/General/obtenerUUID.xq | Generación de UUID único |
| obtenerParametrizacionIn.xq | MiddlewareCaja/Resources/xqueries/General/obtenerParametrizacionIn.xq | Obtención de parámetros |
| validarTipoPrestamo.xq | MiddlewareCaja/Resources/xqueries/ConsultaGeneralPrestamo/validarTipoPrestamo.xq | Validación tipo de préstamo |
| ConsultarPtmoMigradoIn.xq | MiddlewareCaja/Resources/xqueries/ConsultaGeneralPrestamo/ConsultarPtmoMigradoIn.xq | Consulta préstamo migrado |

## WSDL y Esquemas

### WSDL Files
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| PagoPrestamoCaja.wsdl | MiddlewareCaja/Resources/wsdls/PagoPrestamoCaja.wsdl | Definición WSDL del servicio |
| Depositos.wsdl | MiddlewareCaja/Resources/wsdls/Depositos.wsdl | WSDL para operaciones de depósito |
| ObtenerParametrizacion_db.wsdl | MiddlewareCaja/Resources/wsdls/ObtenerParametrizacion_db.wsdl | WSDL obtención parámetros |
| consultarPtmoMigrado_db.wsdl | MiddlewareCaja/Resources/wsdls/consultarPtmoMigrado_db.wsdl | WSDL consulta préstamo migrado |
| PagoPrestamo_db.wsdl | MiddlewareCaja/Resources/wsdls/PagoPrestamo_db.wsdl | WSDL pago préstamo DB |

### XSD Schemas
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| PagoPrestamoCaja.xsd | MiddlewareCaja/Resources/xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd | Esquema principal del servicio |
| Autenticacion.xsd | MiddlewareCaja/Resources/xsds/General/Autenticacion.xsd | Esquema de autenticación |
| XMLSchema_-420276392.xsd | MiddlewareCaja/Resources/xsds/Depositos/XMLSchema_-420276392.xsd | Esquema para depósitos T24 |

## JCA Adapters

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| ObtenerParametrizacion.jca | MiddlewareCaja/Resources/jcas/General/ObtenerParametrizacion.jca | Adaptador JCA para parámetros |
| ConsultarPtmoMigrado.jca | MiddlewareCaja/Resources/jcas/ConsultaPtmoMigrado/ConsultarPtmoMigrado.jca | Adaptador JCA consulta préstamo |
| PagoPrestamoCaja.jca | MiddlewareCaja/Resources/jcas/PagoPrestamoCaja/PagoPrestamoCaja.jca | Adaptador JCA pago préstamo |

## Archivos de Configuración

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| .project | MiddlewareCaja/.project | Configuración del proyecto Eclipse |
| org.eclipse.wst.common.component | MiddlewareCaja/.settings/org.eclipse.wst.common.component | Configuración componentes Eclipse |
| org.eclipse.wst.common.project.facet.core.xml | MiddlewareCaja/.settings/org.eclipse.wst.common.project.facet.core.xml | Configuración facetas proyecto |
| org.eclipse.wst.validation.prefs | MiddlewareCaja/.settings/org.eclipse.wst.validation.prefs | Preferencias de validación |

## Servicios Relacionados (Dependencias)

### Proxy Services Relacionados
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| ConsultaGeneralPrestamo.proxy | MiddlewareCaja/ProxyServices/ConsultaGeneralPrestamo.proxy | Consulta general de préstamos |
| ReversarTransaccion.proxy | MiddlewareCaja/ProxyServices/ReversarTransaccion.proxy | Reversión de transacciones |

### Business Services Relacionados
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| registrarErrorPagoPtmo_db.biz | MiddlewareCaja/BussinessServices/registrarErrorPagoPtmo_db.biz | Registro de errores de pago |

## Archivos de Base de Datos

### Stored Procedures (Referencias)
- **consultarPtmoMigrado**: Validación de préstamos migrados
- **pagoPrestamo**: Registro de transacciones de pago
- **obtenerParametrizacion**: Obtención de parámetros del sistema

### Parámetros de Configuración Requeridos
- **T24T043.HNLCREDITAACCTNO**: Cuenta contable para créditos en HNL

## Archivos de Pruebas

| Tipo | Descripción | Ubicación Estimada |
|------|-------------|-------------------|
| Unit Tests | Pruebas unitarias XQuery | No encontrado |
| Integration Tests | Pruebas de integración | No encontrado |
| SOAPUI Projects | Proyectos de pruebas SOAP | No encontrado |

## Resumen de Conteo

| Tipo de Archivo | Cantidad |
|-----------------|----------|
| Proxy Services | 1 |
| Business Services | 5 |
| XQuery Files | 9 |
| WSDL Files | 5 |
| XSD Files | 3 |
| JCA Adapters | 3 |
| Config Files | 4 |
| **Total** | **30** |

## Dependencias Externas

### Servicios T24
- **Depositoefecenmonedalocal**: Operación T24 para depósito HNL
- **TELLERFICOLCYCASHINType**: Tipo de transacción T24

### Base de Datos Oracle
- **Esquema**: OSB_K_PAGO_PRESTAMO
- **TNS**: ORA_BANK

### Librerías y Frameworks
- Oracle Service Bus 11g/12c
- Oracle WebLogic Server
- Oracle Database JDBC Driver