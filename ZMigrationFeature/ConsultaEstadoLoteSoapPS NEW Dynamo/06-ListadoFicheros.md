# Listado de Ficheros - ConsultaEstadoLoteSoapPS

## 1. Proxy Services (Servicios de Entrada)

### 1.1. Capa Virtual 11g

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/PS/PagosMasivos/ConsultaEstadoLoteSoapPS.proxy` | Proxy Service | Punto de entrada SOAP para clientes legacy (11g). URI: `/regional/massivePayment/soap/getBatchStatus/v11g` |

### 1.2. Capa Regional v2

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/PS/v2/GetBatchStatusSoapPS.proxy` | Proxy Service | Servicio regional v2 con validación y enrutamiento. URI: `/regional/massivePayment/soap/getBatchStatus/v2` |

---

## 2. Pipelines (Lógica de Procesamiento)

### 2.1. Capa Virtual 11g

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/PP/PagosMasivos/ConsultaEstadoLotePP.pipeline` | Pipeline | Pipeline que procesa request de Virtual 11g, invoca template y transforma response |

### 2.2. Capa Regional v2

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/PP/v2/GetBatchStatusPP.pipeline` | Pipeline | Pipeline regional con validación, regionalización y logging |

---

## 3. Templates (Plantillas Reutilizables)

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/PP/MassivePaymentRegional11gFicohsaTemplatePG16857.ptx` | Template | Template para Virtual 11g con autenticación, enrutamiento regional y manejo de errores |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/PP/MassivePaymentRegionalFicohsaTemplatePG16857.ptx` | Template | Template para Regional v2 con validación, regionalización, logging y manejo de errores |

---

## 4. Business Services (Servicios de Salida)

### 4.1. Capa Virtual 11g → Regional v2

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/BS/PagosMasivos/GetBatchStatusSoapBS.bix` | Business Service | Invoca servicio Regional v2 vía SOAP. URL: `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v1` |

### 4.2. Capa Regional v2 → Country v2

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/BS/v2/GetBatchStatusCountryGenericRestBS.bix` | Business Service | Invoca servicio Country vía REST. URL dinámica obtenida de regionalización |

### 4.3. Servicios Auxiliares

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/BS/GetCountryURLByNameRegionalRestBS.bix` | Business Service | Obtiene URL del servicio Country según región |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/BS/LoggingRegionalRestBS.bix` | Business Service | Registra logs en filesystem |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS.bix` | Business Service | Mapea errores técnicos a errores de negocio |

---

## 5. Transformaciones XQuery

### 5.1. Transformaciones de Entrada (Virtual 11g → Regional v2)

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/Transformations/PagosMasivos/GetBatchStatus/Virtual11gToGetBatchStatus.xqy` | XQuery | Transforma request de Virtual 11g a formato Regional v2. Mapea CUSTOMER_ID, BANK_BATCH_ID, GeneralInfo |

### 5.2. Transformaciones de Salida (Regional v2 → Virtual 11g)

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/Transformations/PagosMasivos/GetBatchStatus/GetBatchStatusToVirtual11gHeaderHN.xqy` | XQuery | Transforma response header de Regional v2 a Virtual 11g. Mapea StatusInfo, ErrorInfo a ResponseHeader |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/Transformations/PagosMasivos/GetBatchStatus/GetBatchStatusToVirtual11gBodyHN.xqy` | XQuery | Transforma response body de Regional v2 a Virtual 11g. Mapea todos los campos de getBatchStatusResponse a consultaEstadoLoteResponse |

### 5.3. Transformaciones Auxiliares

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/Transformations/VirtualAuthentication.xqy` | XQuery | Genera header de autenticación Base64 desde username:password |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/Transformations/ServiceToLog.xqy` | XQuery | Transforma datos del servicio a formato de log |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/Transformations/ServiceToRegionalizacion.xqy` | XQuery | Transforma datos del servicio a request de regionalización |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/Transformations/ServicesToError.xqy` | XQuery | Transforma errores técnicos a formato de error de negocio |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/Transformations/ErrorToGetBatchStatus.xqy` | XQuery | Transforma errores a formato getBatchStatusResponse |

---

## 6. Esquemas XSD (Definiciones de Datos)

### 6.1. Esquemas Virtual 11g

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/Schemas/PagosMasivos/pagosMasivosTypes.xsd` | XSD | Define tipos de datos para Virtual 11g: consultaEstadoLote, consultaEstadoLoteResponse, accountType, paymentType |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/Schemas/HeaderElements.xsd` | XSD | Define RequestHeader y ResponseHeader con Authentication, Region, successIndicator |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/Schemas/PagosMasivos/PagingTypes.xsd` | XSD | Define tipos de paginación (no usado en esta funcionalidad) |

### 6.2. Esquemas Regional v2

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/Schemas/GetBatchStatusTypes.xsd` | XSD | Define tipos de datos para Regional v2: getBatchStatus, getBatchStatusResponse, accountType, paymentType, queryType |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/Schemas/CommonTypes.xsd` | XSD | Define tipos comunes: GeneralInfoType, StatusInfoType, ErrorInfoType |

---

## 7. WSDL (Contratos de Servicio)

### 7.1. WSDL Virtual 11g

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/Resources/PagosMasivos/consultaEstadoLotePS.wsdl` | WSDL | Contrato SOAP para Virtual 11g. Define operación consultaEstadoLote con RequestHeader/ResponseHeader |

### 7.2. WSDL Regional v2

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/Resources/GetBatchStatus.wsdl` | WSDL | Contrato SOAP para Regional v2. Define operación getBatchStatus |

### 7.3. WADL (REST)

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/Resources/v2/GetBatchStatusCountryGenericRestBS.wadl` | WADL | Contrato REST para invocación a Country Service |

---

## 8. Archivos de Configuración

### 8.1. Proyectos Maven

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/pom.xml` | Maven POM | Configuración de proyecto Virtual 11g |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/pom.xml` | Maven POM | Configuración de proyecto GetBatchStatus |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/pom.xml` | Maven POM | Configuración de proyecto Commons |

### 8.2. Descriptores OSB

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/servicebus.sboverview` | SB Overview | Descriptor de proyecto OSB Virtual |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/servicebus.sboverview` | SB Overview | Descriptor de proyecto OSB GetBatchStatus |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/servicebus.sboverview` | SB Overview | Descriptor de proyecto OSB Commons |

### 8.3. Proyectos JDeveloper

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/SBRG_MassivePayment_Commons_Virtual.jpr` | JDeveloper Project | Proyecto JDeveloper para Virtual |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_GetBatchStatus/SBRG_MassivePayment_GetBatchStatus.jpr` | JDeveloper Project | Proyecto JDeveloper para GetBatchStatus |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons/SBRG_MassivePayment_Commons.jpr` | JDeveloper Project | Proyecto JDeveloper para Commons |

---

## 9. Archivos JAR (Deployments)

### 9.1. Deployments Relacionados

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/JAR/PG-16857/PRD/GetBatchStatusToVirtual11gBodyHN.jar` | JAR | Deployment de transformación body HN (Producción) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/PG-16857/QA/GetBatchStatusToVirtual11gBodyHN.jar` | JAR | Deployment de transformación body HN (QA) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/PG-16857/DEV/GetBatchStatusToVirtual11gBodyHN.jar` | JAR | Deployment de transformación body HN (DEV) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/TEMHS-1157/PRD/Refactoring_UploadBatchFile_GetBatchStatus.jar` | JAR | Deployment de refactoring (Producción) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/TEMHS-1157/QA/Refactoring_UploadBatchFile_GetBatchStatus.jar` | JAR | Deployment de refactoring (QA) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/TEMHS-1157/DEV/Refactoring_UploadBatchFile_GetBatchStatus.jar` | JAR | Deployment de refactoring (DEV) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/TEMHS-1503/PRD/001CallBothEnginesGetBatchStatus.jar` | JAR | Deployment de llamada a ambos engines (Producción) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/TEMHS-1503/QA/001CallBothEnginesGetBatchStatus.jar` | JAR | Deployment de llamada a ambos engines (QA) |
| `ficohsacore-rgmassivepayment-32637f107667/JAR/TEMHS-1503/DEV/001CallBothEnginesGetBatchStatus.jar` | JAR | Deployment de llamada a ambos engines (DEV) |

---

## 10. Archivos de Políticas y Seguridad

**Nota:** Las políticas de seguridad están configuradas en los archivos .proxy y .bix, no en archivos separados:

- **Virtual 11g:** WSS (WS-Security) con `processWssHeader="true"`
- **Regional v2:** `oracle/http_basic_auth_over_ssl_service_policy` (OWSM)
- **Country BS:** `oracle/http_basic_auth_over_ssl_client_policy` (OWSM)

---

## 11. Tests Relevantes

**Nota:** No se encontraron archivos de test específicos en el código fuente analizado. Los tests deberían estar en:
- Proyectos de test separados
- Herramientas externas (SoapUI, Postman, etc.)
- Repositorios de test independientes

---

## 12. Archivos Relacionados (No Directamente Usados)

### 12.1. Otros Servicios de Pagos Masivos

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/PS/PagosMasivos/ConsultaDetalleLoteSoapPS.proxy` | Proxy Service | Servicio relacionado para consultar detalle de lote |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Commons_Virtual/BS/PagosMasivos/GetBatchDetailSoapBS.bix` | Business Service | Business Service para detalle de lote |

### 12.2. Router

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Router/BS/ConsultaEstadoLote11gBS.bix` | Business Service | Router para versión 11g |
| `ficohsacore-rgmassivepayment-32637f107667/SBRG_MassivePayment/SBRG_MassivePayment_Router/SJ/CallBothEnginesGetBatchStatusSJ.flow` | Service Job | Job para llamar a ambos engines |

---

## 13. Resumen de Archivos por Categoría

| Categoría | Cantidad | Ubicación Principal |
|-----------|----------|---------------------|
| Proxy Services | 2 | `PS/PagosMasivos/`, `PS/v2/` |
| Pipelines | 2 | `PP/PagosMasivos/`, `PP/v2/` |
| Templates | 2 | `PP/` (Commons) |
| Business Services | 6 | `BS/PagosMasivos/`, `BS/v2/`, `BS/` (Commons) |
| Transformaciones XQuery | 8 | `Transformations/PagosMasivos/GetBatchStatus/`, `Transformations/` (Commons) |
| Esquemas XSD | 6 | `Schemas/PagosMasivos/`, `Schemas/` (Commons, GetBatchStatus) |
| WSDL | 2 | `Resources/PagosMasivos/`, `Resources/` (GetBatchStatus) |
| WADL | 1 | `Resources/v2/` |
| Archivos de Configuración | 9 | Raíz de cada proyecto |
| Archivos JAR | 9 | `JAR/` (varios tickets) |

**Total de Archivos Principales:** 47

---

## 14. Notas sobre Búsqueda de Archivos

### 14.1. Técnicas de Búsqueda Utilizadas

1. **Búsqueda por Nombre:** `ConsultaEstadoLoteSoapPS`, `GetBatchStatus`
2. **Análisis de Referencias:** Seguimiento de `ref=` en archivos XML
3. **Análisis de Imports:** Seguimiento de `import` en XQuery y XSD
4. **Análisis de Invocaciones:** Seguimiento de `wsCallout`, `route`, `xqueryTransform`

### 14.2. Archivos No Encontrados

Los siguientes tipos de archivos **NO se encontraron** en el código fuente:

- **Properties Files:** No se encontraron archivos `.properties` específicos para esta funcionalidad
- **Java Callouts:** No se detectaron invocaciones a clases Java custom
- **POJOs:** No se encontraron clases Java en el código analizado
- **Tests Unitarios:** No se encontraron archivos de test
- **Documentación Técnica:** No se encontraron archivos de documentación (excepto esta generada)

### 14.3. Archivos en Otros Repositorios

Los siguientes archivos pueden estar en repositorios separados:

- **Servicio Country (Honduras):** Implementación específica de Honduras
- **Servicio Country (Guatemala):** Implementación específica de Guatemala
- **Servicio Country (Nicaragua):** Implementación específica de Nicaragua
- **Servicio Country (Panamá):** Implementación específica de Panamá
- **Servicio de Regionalización:** Implementación del servicio `GetCountryURLByName`
- **Servicio de Logging:** Implementación del servicio `LoggingRegionalRestBS`
- **Servicio de Errores:** Implementación del servicio `GetCustomErrorByStackTrace`

---

## 15. Estructura de Directorios

```
ficohsacore-rgmassivepayment-32637f107667/
└── SBRG_MassivePayment/
    ├── SBRG_MassivePayment_Commons_Virtual/
    │   ├── PS/PagosMasivos/
    │   │   └── ConsultaEstadoLoteSoapPS.proxy
    │   ├── PP/PagosMasivos/
    │   │   └── ConsultaEstadoLotePP.pipeline
    │   ├── BS/PagosMasivos/
    │   │   └── GetBatchStatusSoapBS.bix
    │   ├── Transformations/PagosMasivos/GetBatchStatus/
    │   │   ├── Virtual11gToGetBatchStatus.xqy
    │   │   ├── GetBatchStatusToVirtual11gHeaderHN.xqy
    │   │   └── GetBatchStatusToVirtual11gBodyHN.xqy
    │   ├── Resources/PagosMasivos/
    │   │   └── consultaEstadoLotePS.wsdl
    │   └── Schemas/PagosMasivos/
    │       └── pagosMasivosTypes.xsd
    ├── SBRG_MassivePayment_GetBatchStatus/
    │   ├── PS/v2/
    │   │   └── GetBatchStatusSoapPS.proxy
    │   ├── PP/v2/
    │   │   └── GetBatchStatusPP.pipeline
    │   ├── BS/v2/
    │   │   └── GetBatchStatusCountryGenericRestBS.bix
    │   ├── Transformations/
    │   │   └── ErrorToGetBatchStatus.xqy
    │   ├── Resources/
    │   │   └── GetBatchStatus.wsdl
    │   └── Schemas/
    │       └── GetBatchStatusTypes.xsd
    └── SBRG_MassivePayment_Commons/
        ├── PP/
        │   ├── MassivePaymentRegional11gFicohsaTemplatePG16857.ptx
        │   └── MassivePaymentRegionalFicohsaTemplatePG16857.ptx
        ├── BS/
        │   ├── GetCountryURLByNameRegionalRestBS.bix
        │   ├── LoggingRegionalRestBS.bix
        │   └── GetCustomErrorByStackTraceRegionalRestBS.bix
        ├── Transformations/
        │   ├── VirtualAuthentication.xqy
        │   ├── ServiceToLog.xqy
        │   ├── ServiceToRegionalizacion.xqy
        │   └── ServicesToError.xqy
        └── Schemas/
            └── CommonTypes.xsd
```

---

## 16. Dependencias entre Archivos

### 16.1. Flujo de Dependencias Principal

```
ConsultaEstadoLoteSoapPS.proxy
  └─> ConsultaEstadoLotePP.pipeline
      └─> MassivePaymentRegional11gFicohsaTemplatePG16857.ptx
          ├─> Virtual11gToGetBatchStatus.xqy
          ├─> VirtualAuthentication.xqy
          └─> GetBatchStatusSoapBS.bix
              └─> GetBatchStatusSoapPS.proxy (Regional v2)
                  └─> GetBatchStatusPP.pipeline
                      └─> MassivePaymentRegionalFicohsaTemplatePG16857.ptx
                          ├─> GetCountryURLByNameRegionalRestBS.bix
                          ├─> LoggingRegionalRestBS.bix
                          ├─> GetCustomErrorByStackTraceRegionalRestBS.bix
                          ├─> ServiceToLog.xqy
                          ├─> ServiceToRegionalizacion.xqy
                          ├─> ServicesToError.xqy
                          └─> GetBatchStatusCountryGenericRestBS.bix
                              └─> Country Service (Honduras/Guatemala/Nicaragua/Panamá)
```

### 16.2. Dependencias de Transformación Response

```
GetBatchStatusPP.pipeline (Response)
  └─> ConsultaEstadoLotePP.pipeline (Response)
      ├─> GetBatchStatusToVirtual11gHeaderHN.xqy
      └─> GetBatchStatusToVirtual11gBodyHN.xqy
```

### 16.3. Dependencias de Esquemas

```
consultaEstadoLotePS.wsdl
  └─> pagosMasivosTypes.xsd
      └─> PagingTypes.xsd

GetBatchStatus.wsdl
  └─> GetBatchStatusTypes.xsd
      └─> CommonTypes.xsd
```

---

Esta lista exhaustiva incluye todos los archivos detectados en el análisis del código fuente para la funcionalidad ConsultaEstadoLoteSoapPS.
