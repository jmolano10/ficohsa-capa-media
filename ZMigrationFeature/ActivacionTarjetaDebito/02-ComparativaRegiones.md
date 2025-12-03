# Comparativa entre Regiones - ActivacionTarjetaDebito

## Tabla de Comparación Regional

| Aspecto | HN01 (Honduras) | Otras Regiones |
|---------|-----------------|----------------|
| **Endpoint OSB** | ActivacionTarjetaDebito.proxy (branch HN01) | ActivacionTarjetaDebito.proxy (default branch) |
| **Nombre de Base de Datos** | No aplica (usa T24 directo) | ValidaServicioRegional |
| **Esquemas** | T24WebServicesImpl | ValidaServicioRegional_sp |
| **Store Procedure** | No aplica | ValidaServicioRegional |
| **Nombre de Conexión** | tarjetasDebitoBS | ValidaServicioRegional_db |
| **Transformaciones clave** | consultaMaestraTDIn.xq<br/>activacionTarjetaDebitoIn.xq<br/>activacionTarjetaDebitoHeaderOut.xq | validaServicioRegionalIn.xq<br/>aplicarValoresPorDefectoRegion.xq |
| **Campos diferenciadores** | Activación completa T24<br/>Consulta maestra previa<br/>Bitácora completa | Validación regional únicamente<br/>Error por defecto |
| **Errores/Excepciones** | Manejo específico T24<br/>Validación de campos<br/>Mensajes personalizados | Error estándar: "SERVICE NOT IMPLEMENTED YET"<br/>MapeoErrores con FICBCO0324 |
| **Timeouts/Retrys** | No configurado | No configurado |
| **Dependencias internas** | tarjetasDebitoBS<br/>RegistrarBitacoraOSB_v2 | ValidaServicioRegional_db<br/>MapeoErrores |
| **Autenticación** | LDAP lookup con failover | No aplica |
| **Validación XSD** | Implementada | Implementada |
| **Manejo de Credenciales** | LDAP lookup con failover | No aplica |
| **Operación Backend** | ConsultaMaestraTarjetaDebito<br/>Activaciondetarjetadedebito | ValidaServicioRegional |
| **ID de Servicio** | FICBCO0324 | FICBCO0324 |
| **Bitácora** | Request y Response completos | No implementada |

## Detalles por Región

### HN01 (Honduras) - Implementación Completa

#### Características Específicas
- **Arquitectura**: Flujo completo con consulta previa y activación
- **Endpoint Backend**: tarjetasDebitoBS (T24)
- **Operaciones**: ConsultaMaestraTarjetaDebito + Activaciondetarjetadedebito
- **Protocolo**: T24 WebServices

#### Flujo de Procesamiento
1. **Bitácora Request**: Registro completo de entrada
2. **Validación Campo**: Verifica DEBIT_CARD_NUMBER no vacío
3. **Consulta Maestra**: Busca información de la tarjeta
4. **Validación Producto**: Verifica PRODUCTTYPE existe
5. **Activación**: Ejecuta activación con ID compuesto
6. **Bitácora Response**: Registro completo de salida

#### Mapeo de Datos Específico
```xml
<!-- Consulta Maestra -->
<WSFICODEBITCARDCUSTOMERType>
    <enquiryInputCollection>
        <columnName>@ID</columnName>
        <criteriaValue>...{DEBIT_CARD_NUMBER}</criteriaValue>
        <operand>LK</operand>
    </enquiryInputCollection>
</WSFICODEBITCARDCUSTOMERType>

<!-- Activación -->
<LATAMCARDORDERACTIVETDWSType id="{PRODUCTTYPE}.{DEBIT_CARD_NUMBER}"/>
```

#### Manejo de Credenciales
- **Función**: `getUsername()` y `getPassword()` con LDAP lookup
- **Failover**: Usa credenciales del header si LDAP falla
- **Path LDAP**: `Middleware/Security/{UPPER(USERNAME)}`

#### Validaciones Específicas
- **Campo Obligatorio**: `$cardNumber != ""`
- **Producto Válido**: `$productType != ""`
- **Mensajes Personalizados**: Según respuesta T24 o ZERORECORDS

#### Bitácora Completa
- **Request**: UUID, contenido, usuario, región, fecha
- **Response**: UUID vinculado, resultado, mensaje error, transactionId
- **Servicio**: RegistrarBitacoraOSB_v2

### Otras Regiones - Implementación por Defecto

#### Características Específicas
- **Arquitectura**: Solo validación regional
- **Endpoint**: ValidaServicioRegional_db
- **Protocolo**: JCA/Database
- **Resultado**: Error estándar

#### Flujo de Procesamiento
1. **Validación XSD**: Esquema de entrada
2. **Validación Regional**: Consulta disponibilidad del servicio
3. **Error por Defecto**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
4. **Mapeo Errores**: Procesamiento estándar

#### Stored Procedure de Validación
```sql
ValidaServicioRegional(
    PV_SERVICIO => 'FICBCO0324',
    PV_ORIGEN => {SourceBank del header},
    PV_DESTINO => {DestinationBank del header},
    PV_USUARIO => {username}
)
```

#### Respuesta Estándar
```xml
<aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messages>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</messages>
</aut:ResponseHeader>
<activacionTarjetaDebitoResponse/>
```

## Diferencias Críticas Identificadas

### 1. Nivel de Implementación
- **HN01**: Implementación completa funcional
- **Otras**: Solo validación con error por defecto

### 2. Complejidad del Flujo
- **HN01**: Flujo de 6 pasos con consulta previa
- **Otras**: Flujo de 3 pasos con error inmediato

### 3. Dependencias de Sistema
- **HN01**: T24, LDAP, Bitácora
- **Otras**: Solo base de datos middleware

### 4. Manejo de Bitácora
- **HN01**: Bitácora completa request/response
- **Otras**: Sin bitácora

### 5. Validaciones de Negocio
- **HN01**: Validaciones específicas de tarjetas
- **Otras**: Solo validación regional

### 6. Gestión de Errores
- **HN01**: Errores específicos por contexto
- **Otras**: Error genérico estándar

## Impacto en Migración

### Consideraciones HN01
- Verificar conectividad con tarjetasDebitoBS en ambiente destino
- Migrar configuración LDAP para lookup de credenciales
- Validar operaciones T24 en ambiente destino
- Migrar servicio RegistrarBitacoraOSB_v2 como dependencia crítica

### Consideraciones Otras Regiones
- Decidir si implementar funcionalidad o mantener error
- Migrar stored procedure ValidaServicioRegional
- Configurar tabla de servicios por región
- Evaluar necesidad de implementación futura

### Puntos de Sincronización
- Ambas implementaciones usan el mismo WSDL y XSD
- Headers de respuesta compatibles
- Mismo ID de servicio (FICBCO0324)
- Validación XSD común

### Riesgos Específicos de Migración

#### HN01
- **Dependencia T24**: Validar disponibilidad de servicios específicos
- **Bitácora**: Migrar como dependencia crítica
- **LDAP**: Configurar lookup de credenciales
- **Validaciones**: Confirmar reglas de negocio

#### Otras Regiones
- **Implementación Futura**: Evaluar si desarrollar funcionalidad
- **Validación Regional**: Configurar correctamente
- **Mensajes**: Mantener consistencia de errores

### Orden de Migración Recomendado
1. **Servicios Base**: ValidaServicioRegional, MapeoErrores
2. **Bitácora**: RegistrarBitacoraOSB_v2 (crítico para HN01)
3. **Esquemas**: XSD y WSDL
4. **Transformaciones**: XQuery files
5. **Proxy Principal**: Con branch condicional
6. **Configuración Regional**: Tabla de servicios
7. **Pruebas**: Validación por región

### Consideraciones de Desarrollo Futuro
- **Otras Regiones**: Evaluar implementación similar a HN01
- **Estandarización**: Unificar patrones de bitácora
- **Validaciones**: Implementar validaciones comunes
- **Monitoreo**: Establecer métricas por región