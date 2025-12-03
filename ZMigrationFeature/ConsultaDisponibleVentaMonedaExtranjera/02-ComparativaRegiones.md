# Comparativa entre Regiones - ConsultaDisponibleVentaMonedaExtranjera

## Tabla de Comparación Regional

| Aspecto | HN01 (Honduras) | GT01/PA01/NI01 (Otras Regiones) |
|---------|-----------------|----------------------------------|
| **Endpoint OSB** | ConsultaDisponibleVentaMonedaExtranjeraHN.proxy | ConsultaDisponibleVentaMonedaExtranjera.proxy |
| **Nombre de Base de Datos** | No aplica (usa T24 directo) | MW_P_CONSULTA_RUTA_REGIONAL |
| **Esquemas** | T24WebServicesImpl | consultaRutaRegional_sp |
| **Store Procedure** | No aplica | MW_P_CONSULTA_RUTA_REGIONAL |
| **Nombre de Conexión** | http://172.23.13.19:7003/svcMercadoLibre/services | jca://eis/DB/ConnectionMiddleware |
| **Transformaciones clave** | consultaMontoDisponibleVentaDolarIn.xq<br/>consultaDisponibleVentaMonedaExtranjeraOut.xq | consultaRutaRegionalIn.xq<br/>aplicarValoresPorDefectoRegion.xq |
| **Campos diferenciadores** | Consulta directa T24<br/>FICOESELLTABLEENTRIESFXWSType | Enrutamiento dinámico<br/>PV_UBICACION |
| **Errores/Excepciones** | Manejo directo de errores T24<br/>Status/successIndicator | MapeoErrores con código FICBCO0434<br/>consultaRutaRegional errors |
| **Timeouts/Retrys** | Timeout: 0 (sin límite)<br/>Retry: 0 | Timeout: 0 (sin límite)<br/>Retry: 0 |
| **Dependencias internas** | mercadoLibre.biz<br/>T24 WebServices | consultaRutaRegional_db.biz<br/>MapeoErrores.proxy |
| **Autenticación** | Sin autenticación personalizada | Custom token authentication |
| **Validación XSD** | No implementada | Validación obligatoria con XSD |
| **Manejo de Credenciales** | LDAP lookup con failover | No aplica |
| **Operación Backend** | consultamontodisponiblevtadolar | Enrutamiento a proxy regional |

## Detalles por Región

### HN01 (Honduras) - Implementación Directa

#### Características Específicas
- **Arquitectura**: Conexión directa a T24 sin enrutamiento intermedio
- **Endpoint Backend**: `http://172.23.13.19:7003/svcMercadoLibre/services`
- **Operación T24**: `consultamontodisponiblevtadolar`
- **Protocolo**: SOAP/HTTP directo

#### Flujo de Procesamiento
1. **Entrada**: Recibe request sin validación XSD
2. **Transformación**: Aplica `consultaMontoDisponibleVentaDolarIn.xq`
3. **Invocación**: Llama directamente a T24 MercadoLibre
4. **Respuesta**: Transforma con `consultaDisponibleVentaMonedaExtranjeraOut.xq`
5. **Salida**: Respuesta directa sin mapeo de errores adicional

#### Mapeo de Datos Específico
```xml
<!-- Request a T24 -->
<FICOESELLTABLEENTRIESFXWSType>
    <enquiryInputCollection>
        <columnName>CURRENCY</columnName>
        <criteriaValue>{CURRENCY del request}</criteriaValue>
        <operand>EQ</operand>
    </enquiryInputCollection>
</FICOESELLTABLEENTRIESFXWSType>
```

#### Manejo de Credenciales
- **Función**: `getUsername()` y `getPassword()` con LDAP lookup
- **Failover**: Usa credenciales del header si LDAP falla
- **Path LDAP**: `Middleware/Security/{UPPER(USERNAME)}`

#### Políticas y Configuración
- **Binding**: SOAP 1.1 sin WSI compliance
- **Transport**: Local (no HTTP externo)
- **Headers**: Todos los headers habilitados
- **Monitoring**: Deshabilitado

### GT01/PA01/NI01 (Otras Regiones) - Enrutamiento Dinámico

#### Características Específicas
- **Arquitectura**: Enrutamiento dinámico basado en región
- **Endpoint**: `/Middleware/OperationsAndExecution/ConsumerService/ConsultaDisponibleVentaMonedaExtranjera`
- **Protocolo**: HTTPS con autenticación personalizada
- **Servicio ID**: `FICBCO0434`

#### Flujo de Procesamiento
1. **Validación**: Validación XSD obligatoria
2. **Consulta Regional**: Invoca `consultaRutaRegional` con servicio ID
3. **Enrutamiento**: Redirección dinámica según `PV_UBICACION`
4. **Mapeo Errores**: Procesamiento con `MapeoErrores` si hay fallos
5. **Respuesta**: Header y body según resultado de enrutamiento

#### Stored Procedure de Enrutamiento
```sql
MW_P_CONSULTA_RUTA_REGIONAL(
    PV_SERVICIO => 'FICBCO0434',
    PV_ORIGEN => {SourceBank del header},
    PV_DESTINO => {DestinationBank del header},
    PV_OPERACION => {operación},
    PV_VERSION => 'V2',
    PV_USUARIO => {username}
)
```

#### Autenticación Personalizada
- **Tipo**: Custom token authentication
- **Username XPath**: `./aut:RequestHeader/Authentication/UserName/text()`
- **Password XPath**: `./aut:RequestHeader/Authentication/Password/text()`
- **Variable**: `header`

#### Políticas y Configuración
- **Binding**: SOAP 1.1 con validación XSD
- **Transport**: HTTPS obligatorio
- **Security**: Autenticación personalizada habilitada
- **Monitoring**: Habilitado con nivel DEBUG

## Diferencias Críticas Identificadas

### 1. Arquitectura de Conectividad
- **HN01**: Conexión directa a T24, sin intermediarios
- **Otras**: Enrutamiento dinámico con consulta previa a base de datos

### 2. Validación de Entrada
- **HN01**: Sin validación XSD, procesamiento directo
- **Otras**: Validación XSD obligatoria antes del procesamiento

### 3. Manejo de Autenticación
- **HN01**: Sin autenticación en el proxy, manejo interno de credenciales
- **Otras**: Autenticación personalizada con tokens en headers

### 4. Gestión de Errores
- **HN01**: Manejo directo de errores T24
- **Otras**: Mapeo estándar de errores con servicio centralizado

### 5. Configuración de Transporte
- **HN01**: Transporte local sin HTTPS
- **Otras**: HTTPS obligatorio con configuración de seguridad

### 6. Dependencias de Sistema
- **HN01**: Dependencia directa de T24 y LDAP
- **Otras**: Dependencia de base de datos middleware y servicios de enrutamiento

## Impacto en Migración

### Consideraciones HN01
- Verificar conectividad directa con T24 en ambiente destino
- Migrar configuración LDAP para lookup de credenciales
- Validar operación `consultamontodisponiblevtadolar` en T24 destino

### Consideraciones Otras Regiones
- Migrar stored procedure `MW_P_CONSULTA_RUTA_REGIONAL`
- Configurar tabla de enrutamiento regional
- Verificar configuración de proxies destino por región
- Migrar servicio `MapeoErrores` como dependencia

### Puntos de Sincronización
- Ambas implementaciones usan el mismo WSDL y XSD base
- Headers de respuesta compatibles entre regiones
- Estructura de response idéntica independiente de la región