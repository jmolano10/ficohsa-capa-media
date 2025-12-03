# Comparativa entre Regiones - ActualizaDisponibleVentaMonedaExtranjera

## Tabla de Comparación Regional

| Aspecto | HN01 (Honduras) | GT01/PA01/NI01 (Otras Regiones) |
|---------|-----------------|----------------------------------|
| **Endpoint OSB** | ActualizaDisponibleVentaMonedaExtranjeraHN.proxy | ActualizaDisponibleVentaMonedaExtranjera.proxy |
| **Nombre de Base de Datos** | No aplica (usa T24 directo) | MW_P_CONSULTA_RUTA_REGIONAL |
| **Esquemas** | T24WebServicesImpl | consultaRutaRegional_sp |
| **Store Procedure** | No aplica | MW_P_CONSULTA_RUTA_REGIONAL |
| **Nombre de Conexión** | http://172.23.13.19:7003/svcMercadoLibre/services | jca://eis/DB/ConnectionMiddleware |
| **Transformaciones clave** | actualizaDisponibleMonedaFCYIn.xq<br/>actualizaDisponibleVentaMonedaExtranjeraOut.xq | consultaRutaRegionalIn.xq<br/>aplicarValoresPorDefectoRegion.xq |
| **Campos diferenciadores** | Actualización directa T24<br/>FICOFXDEALSTXNINPUTType<br/>8 campos de entrada | Enrutamiento dinámico<br/>PV_UBICACION<br/>Validación XSD obligatoria |
| **Errores/Excepciones** | Manejo directo de errores T24<br/>Status/successIndicator | MapeoErrores con código FICBCO0439<br/>consultaRutaRegional errors |
| **Timeouts/Retrys** | Timeout: 0 (sin límite)<br/>Retry: 0 | Timeout: 0 (sin límite)<br/>Retry: 0 |
| **Dependencias internas** | mercadoLibre.biz<br/>T24 WebServices | consultaRutaRegional_db.biz<br/>MapeoErrores.proxy |
| **Autenticación** | Sin autenticación personalizada | Custom token authentication |
| **Validación XSD** | No implementada | Validación obligatoria con XSD |
| **Manejo de Credenciales** | LDAP lookup con failover | No aplica |
| **Operación Backend** | ActualizaDisponibleMonedaFCY | Enrutamiento a proxy regional |
| **Gestión de Fechas** | Conversión automática fecha actual | No aplica |
| **ID de Servicio** | No aplica | FICBCO0439 |

## Detalles por Región

### HN01 (Honduras) - Implementación Directa

#### Características Específicas
- **Arquitectura**: Conexión directa a T24 sin enrutamiento intermedio
- **Endpoint Backend**: `http://172.23.13.19:7003/svcMercadoLibre/services`
- **Operación T24**: `ActualizaDisponibleMonedaFCY`
- **Protocolo**: SOAP/HTTP directo

#### Flujo de Procesamiento
1. **Entrada**: Recibe request sin validación XSD
2. **Transformación**: Aplica `actualizaDisponibleMonedaFCYIn.xq`
3. **Invocación**: Llama directamente a T24 MercadoLibre
4. **Respuesta**: Transforma con `actualizaDisponibleVentaMonedaExtranjeraOut.xq`
5. **Salida**: Respuesta directa sin mapeo de errores adicional

#### Mapeo de Datos Específico
```xml
<!-- Request a T24 -->
<FICOFXDEALSTXNINPUTType id="{DEAL}">
    <Estado>{STATUS}</Estado>
    <Cliente>{PROFILE}</Cliente>
    <Moneda>{CURRENCY}</Moneda>
    <Monto>{AMOUNT}</Monto>
    <Fecha>{fecha_actual_YYYYMMDD}</Fecha>
    <FechaVencimiento>{END_DATE}</FechaVencimiento>
    <TipodeOperacion>{OPERATION_TYPE}</TipodeOperacion>
    <TipodeAccion>{ACTION_TYPE}</TipodeAccion>
</FICOFXDEALSTXNINPUTType>
```

#### Manejo de Credenciales
- **Función**: `getUsername()` y `getPassword()` con LDAP lookup
- **Failover**: Usa credenciales del header si LDAP falla
- **Path LDAP**: `Middleware/Security/{UPPER(USERNAME)}`

#### Gestión de Fechas
- **Función**: `date-to-string()` convierte fecha actual a formato YYYYMMDD
- **Fecha Automática**: Campo `Fecha` se llena automáticamente con `current-date()`
- **Fecha Vencimiento**: Campo `FechaVencimiento` usa `END_DATE` del request

#### Políticas y Configuración
- **Binding**: SOAP 1.1 sin WSI compliance
- **Transport**: Local (no HTTP externo)
- **Headers**: Todos los headers habilitados
- **Monitoring**: Deshabilitado

### GT01/PA01/NI01 (Otras Regiones) - Enrutamiento Dinámico

#### Características Específicas
- **Arquitectura**: Enrutamiento dinámico basado en región
- **Endpoint**: `/Middleware/OperationsAndExecution/ConsumerService/ActualizaDisponibleVentaMonedaExtranjera`
- **Protocolo**: HTTPS con autenticación personalizada
- **Servicio ID**: `FICBCO0439`

#### Flujo de Procesamiento
1. **Validación**: Validación XSD obligatoria con 8 campos
2. **Consulta Regional**: Invoca `consultaRutaRegional` con servicio ID
3. **Enrutamiento**: Redirección dinámica según `PV_UBICACION`
4. **Mapeo Errores**: Procesamiento con `MapeoErrores` si hay fallos
5. **Respuesta**: Header y body según resultado de enrutamiento

#### Stored Procedure de Enrutamiento
```sql
MW_P_CONSULTA_RUTA_REGIONAL(
    PV_SERVICIO => 'FICBCO0439',
    PV_ORIGEN => {SourceBank del header},
    PV_DESTINO => {DestinationBank del header},
    PV_OPERACION => {operación},
    PV_VERSION => 'V2',
    PV_USUARIO => {username}
)
```

#### Validación XSD Obligatoria
```xml
<!-- Esquema validado -->
<actualizaDisponibleVentaMonedaExtranjera>
    <PROFILE>string</PROFILE>           <!-- Obligatorio -->
    <CURRENCY>string</CURRENCY>         <!-- Obligatorio -->
    <AMOUNT>string</AMOUNT>             <!-- Obligatorio -->
    <DEAL>string</DEAL>                 <!-- Obligatorio -->
    <STATUS>string</STATUS>             <!-- Obligatorio -->
    <OPERATION_TYPE>string</OPERATION_TYPE> <!-- Obligatorio -->
    <END_DATE>string</END_DATE>         <!-- Obligatorio -->
    <ACTION_TYPE>string</ACTION_TYPE>   <!-- Obligatorio -->
</actualizaDisponibleVentaMonedaExtranjera>
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

### 1. Complejidad de Entrada
- **HN01**: 8 campos procesados directamente sin validación XSD
- **Otras**: 8 campos validados obligatoriamente con XSD antes del procesamiento

### 2. Arquitectura de Conectividad
- **HN01**: Conexión directa a T24, sin intermediarios
- **Otras**: Enrutamiento dinámico con consulta previa a base de datos

### 3. Gestión de Fechas
- **HN01**: Conversión automática de fecha actual a formato T24
- **Otras**: No maneja fechas, delega a proxy regional

### 4. Manejo de Autenticación
- **HN01**: Sin autenticación en el proxy, manejo interno de credenciales
- **Otras**: Autenticación personalizada con tokens en headers

### 5. Gestión de Errores
- **HN01**: Manejo directo de errores T24
- **Otras**: Mapeo estándar de errores con servicio centralizado

### 6. Configuración de Transporte
- **HN01**: Transporte local sin HTTPS
- **Otras**: HTTPS obligatorio con configuración de seguridad

### 7. Identificación de Servicio
- **HN01**: Sin ID de servicio específico
- **Otras**: Servicio identificado como FICBCO0439

## Impacto en Migración

### Consideraciones HN01
- Verificar conectividad directa con T24 en ambiente destino
- Migrar configuración LDAP para lookup de credenciales
- Validar operación `ActualizaDisponibleMonedaFCY` en T24 destino
- Confirmar estructura `FICOFXDEALSTXNINPUTType` en T24 destino
- Validar función de conversión de fechas

### Consideraciones Otras Regiones
- Migrar stored procedure `MW_P_CONSULTA_RUTA_REGIONAL`
- Configurar tabla de enrutamiento regional para FICBCO0439
- Verificar configuración de proxies destino por región
- Migrar servicio `MapeoErrores` como dependencia
- Validar esquema XSD en ambiente destino

### Puntos de Sincronización
- Ambas implementaciones usan el mismo WSDL y XSD base
- Headers de respuesta compatibles entre regiones
- Estructura de response idéntica independiente de la región
- Mismos 8 campos de entrada en ambas arquitecturas

### Riesgos Específicos de Migración

#### HN01
- **Dependencia T24**: Validar disponibilidad de operación específica
- **Gestión de Fechas**: Confirmar formato de fechas en T24 destino
- **Deals**: Validar estructura y estados de deals en ambiente destino
- **LDAP**: Migrar configuración de credenciales

#### Otras Regiones
- **Enrutamiento**: Configurar correctamente tabla de enrutamiento
- **Validación XSD**: Confirmar esquemas en ambiente destino
- **Proxies Regionales**: Crear proxies específicos por región si no existen
- **Base de Datos**: Migrar stored procedure y configuración JCA

### Orden de Migración Recomendado
1. **Servicios Base**: consultaRutaRegional, MapeoErrores
2. **Esquemas**: XSD y WSDL
3. **Transformaciones**: XQuery files
4. **Proxy HN01**: Para testing directo con T24
5. **Proxy Principal**: Para enrutamiento dinámico
6. **Configuración Regional**: Tabla de enrutamiento y proxies regionales
7. **Pruebas Integrales**: Validación end-to-end por región