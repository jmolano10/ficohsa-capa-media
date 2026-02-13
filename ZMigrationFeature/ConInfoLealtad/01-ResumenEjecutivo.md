# Resumen Ejecutivo - ConInfoLealtad

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo](05-FlujoMultiregion.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**ConInfoLealtad** es un Business Service (Stored Procedure de SQL Server) que se utiliza **exclusivamente en Honduras (HN01)** como parte del flujo de **ConsultaPuntosLealtad**. Su propósito es:

- Obtener información del cliente asociado a una tarjeta de crédito/débito
- Recuperar datos necesarios para consultar puntos de lealtad cuando el cliente proporciona un número de tarjeta en lugar de su identificación legal
- Extraer información como: Legal ID, Nombre del Cliente, Tipo de Tarjeta, y Grupo de Afinidad (Logo)

**Contexto de Uso**: Este servicio se invoca únicamente cuando:
1. El cliente consulta puntos de lealtad usando `CUSTOMER_ID_TYPE = "CARD_NUMBER"`
2. La consulta inicial a `consultaPuntosLealtad` no retorna balance de puntos
3. La región es Honduras (HN01)

## 2. Entradas y Salidas Principales

### Entrada (InputParameters)

```xml
<InputParameters>
    <NumeroTarjeta>string (max 19 caracteres)</NumeroTarjeta>
    <Pais>string (max 10 caracteres)</Pais>
    <CodigoError>int (opcional)</CodigoError>
    <MensajeError>string (max 4000 caracteres, opcional)</MensajeError>
</InputParameters>
```

**Campos:**
- `NumeroTarjeta`: Número de tarjeta de crédito o débito (16-19 dígitos)
- `Pais`: Código ISO3 del país (ej: "HND" para Honduras)
- `CodigoError`: Parámetro de salida (inicialmente null)
- `MensajeError`: Parámetro de salida (inicialmente null)

### Salida (OutputParameters)

```xml
<OutputParameters>
    <RowSet>
        <Row>
            <Column name="LEGALID" sqltype="VARCHAR">0801199012345</Column>
            <Column name="CUSTOMERNAME" sqltype="VARCHAR">JUAN PEREZ LOPEZ</Column>
            <Column name="CARDTYPE" sqltype="VARCHAR">CREDIT</Column>
            <Column name="LOGO" sqltype="VARCHAR">625</Column>
        </Row>
    </RowSet>
    <CodigoError>-1</CodigoError>
    <MensajeError></MensajeError>
</OutputParameters>
```

**Campos del RowSet:**
- `LEGALID`: Identificación legal del cliente (RTN en Honduras)
- `CUSTOMERNAME`: Nombre completo del cliente
- `CARDTYPE`: Tipo de tarjeta ("CREDIT" o "DEBIT")
- `LOGO`: Código del grupo de afinidad/programa de lealtad

**Códigos de Error:**
- `-1`: Éxito (sin error)
- Otros valores: Código de error específico con mensaje en `MensajeError`

## 3. Sistemas/Servicios OSB Involucrados

### Business Service
- **Nombre**: `conInfoLealtad_db`
- **Ubicación**: `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/biz/conInfoLealtad_db.bix`
- **Tipo**: DB Adapter (JCA) - SQL Server
- **Conexión**: `eis/DB/ConnectionProcesosHN`
- **Package**: `dbo`
- **Stored Procedure**: `OSBConInfoLealtad`

### Proxy Service Contenedor
- **Nombre**: `ConsultaPuntosLealtadHN`
- **Ubicación**: `Middleware/v2/ProxyServices/ConsultaPuntosLealtadHN.proxy`
- **WSDL**: `consultaPuntosLealtadPS.wsdl`
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/programaLealtad/`

### Transformaciones XQuery
- **Entrada**: `Middleware/v2/Resources/ProgramaLealtad/xq/conInfoLealtadHNIn.xqy`
- **Salida**: Procesamiento inline en el pipeline (extracción de columnas del RowSet)

### Servicios Relacionados
1. **consultaPuntosLealtad_db**: Consulta inicial de puntos (puede no retornar datos)
2. **convertirCodigoPais**: Convierte código de región OSB (HN01) a ISO3 (HND)
3. **consultaProgramaLealtad_db**: Determina el programa de lealtad según grupo de afinidad
4. **Mastercard CustomerService** o **VisionPlus**: Consulta de puntos según programa

## 4. Riesgos/Limitaciones Conocidas

### Riesgos Técnicos

1. **Dependencia de Base de Datos SQL Server**
   - Punto único de falla: `eis/DB/ConnectionProcesosHN`
   - No se detectan mecanismos de retry o circuit breaker
   - Timeout no configurado explícitamente

2. **Región Específica**
   - Solo implementado para Honduras (HN01)
   - Otras regiones (GT01, NI01, PA01) no tienen equivalente
   - Dificulta la estandarización multiregión

3. **Flujo Condicional Complejo**
   - Se invoca solo si `consultaPuntosLealtad` no retorna balance
   - Depende de `CUSTOMER_ID_TYPE = "CARD_NUMBER"`
   - Múltiples condiciones anidadas pueden causar confusión

4. **Manejo de Errores**
   - Códigos de error no estandarizados
   - Mensajes de error pueden ser genéricos
   - No se mapean a códigos de error OSB estándar

### Limitaciones Funcionales

1. **Solo Tarjetas**
   - No soporta otros tipos de identificación
   - Requiere número de tarjeta válido de 16-19 dígitos

2. **Sin Cache**
   - Cada consulta impacta directamente la base de datos
   - Puede causar problemas de performance con alto volumen

3. **Información Limitada**
   - Solo retorna datos básicos del cliente
   - No incluye información de cuentas o productos adicionales

4. **Dependencia de Datos Maestros**
   - Requiere que la tarjeta esté registrada en el sistema
   - Datos desactualizados pueden causar errores

### Limitaciones de Seguridad

1. **Número de Tarjeta en Logs**
   - Logging en nivel "debug" puede exponer números de tarjeta
   - No se detecta enmascaramiento de datos sensibles

2. **Sin Validación de Formato**
   - No valida formato de número de tarjeta (Luhn algorithm)
   - Acepta cualquier string de hasta 19 caracteres

## 5. Métricas o SLAs

### Configuración de Monitoreo (Proxy Service Contenedor)
- **Monitoring**: Deshabilitado (`enabled="false"`)
- **Message Tracing**: Deshabilitado
- **Aggregation Interval**: 10 segundos (cuando habilitado)
- **SLA Alerting**: Habilitado (nivel normal)
- **Reporting**: Habilitado
- **Logging**: Habilitado (nivel debug)

### SLAs Esperados (No Documentados)
- No se encontraron SLAs explícitos en el código
- Se recomienda definir:
  - Tiempo de respuesta objetivo: < 500ms (consulta DB simple)
  - Disponibilidad: 99.5%
  - Tasa de error: < 1%

### Alertas
- No se detectaron alertas específicas para este Business Service
- Hereda alertas del Proxy Service contenedor

## 6. Regiones Detectadas

**ConInfoLealtad** es específico de **una sola región**:

### HN01 - Honduras (Banco Ficohsa Honduras)
- **Implementación**: Stored Procedure SQL Server
- **Base de Datos**: ConnectionProcesosHN
- **Uso**: Consulta de información de cliente por número de tarjeta

### Otras Regiones
- **GT01 (Guatemala)**: No implementado
- **NI01 (Nicaragua)**: No implementado
- **PA01 (Panamá)**: No implementado

**Nota**: Las otras regiones no requieren este servicio porque:
- Pueden tener implementaciones diferentes en sus flujos de ConsultaPuntosLealtad
- Pueden usar servicios alternativos para obtener información del cliente
- Pueden requerir siempre Legal ID en lugar de número de tarjeta

## 7. Arquitectura General

```
Cliente → ConsultaPuntosLealtadHN (OSB Proxy)
           ↓
    Validación XSD
           ↓
    consultaPuntosLealtad_db (Oracle)
           ↓
    ¿Balance existe? → SÍ → Continuar flujo
           ↓ NO
    ¿CUSTOMER_ID_TYPE = "CARD_NUMBER"?
           ↓ SÍ
    convertirCodigoPais (HN01 → HND)
           ↓
    conInfoLealtad_db (SQL Server) ← ESTE SERVICIO
           ↓
    Extraer: LEGALID, CUSTOMERNAME, CARDTYPE, LOGO
           ↓
    consultaProgramaLealtad_db
           ↓
    Consultar Puntos (Mastercard o VisionPlus)
           ↓
    Respuesta al Cliente
```

## 8. Flujo de Invocación

### Condiciones para Invocar ConInfoLealtad

1. **Región**: `SourceBank = "HN01"`
2. **Consulta Inicial Fallida**: `not(exists($RSPconsultaPuntosLealtad/PT_PUNTOS_LEALTAD/BALANCE))`
3. **Tipo de ID**: `$customerIdType = "CARD_NUMBER"`

### Datos Extraídos

```xquery
$legalId = fn-bea:trim(string($RSPconInfoLealtad/RowSet/Row/Column[upper-case(@name) = 'LEGALID']/text()))
$customerName = string($RSPconInfoLealtad/RowSet/Row/Column[upper-case(@name) = 'CUSTOMERNAME']/text())
$cardType = string($RSPconInfoLealtad/RowSet/Row/Column[upper-case(@name) = 'CARDTYPE']/text())
$grupoAfinidad = string($RSPconInfoLealtad/RowSet/Row/Column[upper-case(@name) = 'LOGO']/text())
```

### Uso Posterior

- **$legalId**: Usado para identificar al cliente en Mastercard Rewards
- **$customerName**: Incluido en la respuesta final
- **$cardType**: Determina si es tarjeta de débito (programa lealtad = '1')
- **$grupoAfinidad**: Determina el programa de lealtad específico

## 9. Consideraciones para Migración

### Prioridad Alta

1. **Evaluar Necesidad del Servicio**
   - Determinar si otras regiones requieren funcionalidad similar
   - Considerar unificar con servicios existentes de consulta de cliente

2. **Estandarizar Manejo de Errores**
   - Mapear códigos de error SQL Server a códigos OSB estándar
   - Implementar mensajes de error consistentes

3. **Seguridad de Datos**
   - Implementar enmascaramiento de números de tarjeta en logs
   - Validar formato de tarjeta antes de consultar DB

4. **Configuración de Timeouts**
   - Definir timeout explícito para consulta DB
   - Implementar retry logic para errores transitorios

### Prioridad Media

1. **Optimización de Performance**
   - Implementar cache para consultas frecuentes
   - Considerar índices en tabla de tarjetas

2. **Monitoreo**
   - Habilitar monitoring del Proxy Service
   - Agregar métricas específicas para este Business Service

3. **Documentación**
   - Documentar estructura de tabla consultada
   - Documentar lógica del Stored Procedure

### Prioridad Baja

1. **Refactorización**
   - Considerar reemplazar Stored Procedure con consulta SQL directa
   - Evaluar migración a servicio REST

2. **Testing**
   - Crear tests unitarios para transformaciones XQuery
   - Crear tests de integración para flujo completo

## 10. Dependencias Identificadas

### Upstream (Servicios que invocan ConInfoLealtad)
- `ConsultaPuntosLealtadHN.pipeline` (stage: ConsultaInformacionCliente)

### Downstream (Servicios invocados por ConInfoLealtad)
- Ninguno (es un leaf service - consulta directa a DB)

### Servicios Relacionados en el Flujo
1. `consultaPuntosLealtad_db` (consulta inicial)
2. `convertirCodigoPais` (conversión de código de región)
3. `consultaProgramaLealtad_db` (determinar programa)
4. `Mastercard CustomerService` o `VisionPlus` (consulta de puntos)
5. `canjearPuntosEfectivo_db` (equivalencia en efectivo, opcional)
6. `registraPuntosLealtad_db` (registro de consulta)

### Base de Datos
- **Conexión**: `eis/DB/ConnectionProcesosHN`
- **Tipo**: SQL Server
- **Schema**: `dbo`
- **Stored Procedure**: `OSBConInfoLealtad`
- **Tabla(s)**: No especificadas (dentro del SP)

## 11. Notas Adicionales

- **Encoding**: XQuery usa encoding por defecto (no especificado)
- **XQuery Version**: 2004-draft
- **Namespace**: `http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoLealtad`
- **Función Trim**: Usa `fn-bea:trim()` para limpiar espacios del Legal ID
- **Case Insensitive**: Usa `upper-case(@name)` para comparar nombres de columnas
- **Error Handling**: Códigos de error se asignan a variables y se procesan en stages posteriores
