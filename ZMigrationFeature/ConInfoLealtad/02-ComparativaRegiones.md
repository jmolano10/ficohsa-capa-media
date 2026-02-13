# Comparativa entre Regiones - ConInfoLealtad

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | NI01 (Nicaragua) | PA01 (Panamá) |
|---------|----------------|------------------|------------------|---------------|
| **Endpoint OSB** | N/A (Business Service interno) | No implementado | No implementado | No implementado |
| **Nombre de Base de Datos** | ConnectionProcesosHN | N/A | N/A | N/A |
| **Esquema** | dbo | N/A | N/A | N/A |
| **Stored Procedure** | OSBConInfoLealtad | N/A | N/A | N/A |
| **Nombre de Conexión** | eis/DB/ConnectionProcesosHN | N/A | N/A | N/A |
| **Tipo de Base de Datos** | SQL Server | N/A | N/A | N/A |
| **Transformaciones clave** | conInfoLealtadHNIn.xqy | N/A | N/A | N/A |
| **Campos diferenciadores** | LEGALID, CUSTOMERNAME, CARDTYPE, LOGO | N/A | N/A | N/A |
| **Errores/Excepciones** | CodigoError, MensajeError | N/A | N/A | N/A |
| **Timeouts/Retrys** | No configurado | N/A | N/A | N/A |
| **Dependencias internas** | consultaPuntosLealtad_db, convertirCodigoPais | N/A | N/A | N/A |
| **Proxy Service Contenedor** | ConsultaPuntosLealtadHN | ConsultaPuntosLealtadGT | ConsultaPuntosLealtadNI | ConsultaPuntosLealtadPA |
| **Uso en Flujo** | Condicional (si CUSTOMER_ID_TYPE=CARD_NUMBER) | No aplica | No aplica | No aplica |
| **Parámetros de Entrada** | NumeroTarjeta, Pais | N/A | N/A | N/A |
| **Formato de Salida** | RowSet con Columns dinámicas | N/A | N/A | N/A |

---

## Detalles por Región

### HN01 - Honduras

#### Características Específicas

**Backend:**
- Conexión directa a base de datos SQL Server mediante DB Adapter
- Schema: `dbo`
- Stored Procedure: `OSBConInfoLealtad`
- Conexión JNDI: `eis/DB/ConnectionProcesosHN`

**Contexto de Uso:**
Este Business Service se invoca únicamente cuando:
1. La consulta inicial a `consultaPuntosLealtad_db` no retorna balance de puntos
2. El cliente proporciona `CUSTOMER_ID_TYPE = "CARD_NUMBER"` (en lugar de Legal ID)
3. La región es Honduras (HN01)

**Flujo de Transformación:**

**Entrada (OSB → DB):**
```xquery
<InputParameters>
    <NumeroTarjeta>{$cardNumber}</NumeroTarjeta>
    <Pais>{$country}</Pais>
</InputParameters>
```

**Parámetros:**
- `$cardNumber`: Extraído de `$body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE`
- `$country`: Convertido de `HN01` a `HND` mediante `convertirCodigoPais`

**Salida (DB → OSB):**
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

**Extracción de Datos:**
```xquery
$legalId = fn-bea:trim(string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'LEGALID']/text()))
$customerName = string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'CUSTOMERNAME']/text())
$cardType = string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'CARDTYPE']/text())
$grupoAfinidad = string($RSPconInfoLealtad/con:RowSet/con:Row/con:Column[upper-case(@name) = 'LOGO']/text())
```

**Campos Diferenciadores:**
- **LEGALID**: Identificación legal del cliente (RTN en Honduras)
- **CUSTOMERNAME**: Nombre completo del cliente
- **CARDTYPE**: Tipo de tarjeta ("CREDIT" o "DEBIT")
- **LOGO**: Código del grupo de afinidad (ej: "625" para Infinite)

**Errores/Excepciones:**
- **CodigoError = -1**: Éxito (sin error)
- **CodigoError != -1**: Error, con descripción en MensajeError
- Errores se asignan a variables `$errorCode` y `$validationMessage`

**Timeouts/Retrys:**
- No configurado explícitamente
- Depende de configuración global del DB Adapter

**Dependencias Internas:**
1. **convertirCodigoPais**: Convierte HN01 → HND
   - XQuery: `Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xqy`
   - Parámetros: `codigoPais="HN01"`, `sentidoConversion="OSB-ISO3"`

2. **consultaPuntosLealtad_db**: Consulta inicial (puede fallar)
   - Business Service: `Middleware/v2/BusinessServices/CLIENTDATA/consultaPuntosLealtad/biz/consultaPuntosLealtad_db`

3. **consultaProgramaLealtad_db**: Determina programa de lealtad
   - Business Service: `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
   - Usa `$grupoAfinidad` (LOGO) para determinar programa

**Uso de Datos Extraídos:**

| Campo | Variable OSB | Uso Posterior |
|-------|-------------|---------------|
| LEGALID | $legalId | Identificar cliente en Mastercard Rewards (appID) |
| CUSTOMERNAME | $customerName | Incluir en respuesta final |
| CARDTYPE | $cardType | Si = "DEBIT" → programaLealtad = '1' (Mastercard) |
| LOGO | $grupoAfinidad | Determinar programa de lealtad específico |

**Reglas de Negocio:**

1. **Conversión de Código de País:**
```xquery
$codigoPais = convertirCodigoPais(
    codigoPais: string($header/aut:RequestHeader/Region/SourceBank/text()),
    sentidoConversion: "OSB-ISO3"
)
// HN01 → HND
```

2. **Determinación de Programa de Lealtad:**
```xquery
if ($cardType = 'DEBIT') then
    $programaLealtad = '1'  // Mastercard Rewards
else
    // Consultar consultaProgramaLealtad_db con $grupoAfinidad
```

3. **Manejo de Logo Infinite:**
```xquery
$logoInfinite = '625'
if ($grupoAfinidad = $logoInfinite and exists($body/prog:consultaPuntosLealtad/PROGRAM_ID/text())) then
    $programaLealtad = $body/prog:consultaPuntosLealtad/PROGRAM_ID/text()
else
    $programaLealtad = string($RSPconsultaProgramaLealtad/con:PV_CODIGOLEALTAD/text())
```

4. **Validación de Errores:**
```xquery
$errorCode = string($RSPconInfoLealtad/con:CodigoError/text())
$validationMessage = string($RSPconInfoLealtad/con:MensajeError/text())

if ($errorCode != "-1") then
    // Abortar flujo con error
else
    // Continuar con datos extraídos
```

---

### GT01 - Guatemala

#### Estado de Implementación
**No implementado**

**Razón**: El flujo de ConsultaPuntosLealtad en Guatemala puede:
- Requerir siempre Legal ID (no soportar CARD_NUMBER)
- Usar un servicio diferente para obtener información del cliente
- Tener una implementación alternativa no documentada

**Proxy Service**: `ConsultaPuntosLealtadGT.proxy` existe pero no usa conInfoLealtad

---

### NI01 - Nicaragua

#### Estado de Implementación
**No implementado**

**Razón**: Similar a Guatemala, el flujo de ConsultaPuntosLealtad en Nicaragua puede tener una implementación diferente.

**Proxy Service**: `ConsultaPuntosLealtadNI.proxy` existe pero no usa conInfoLealtad

---

### PA01 - Panamá

#### Estado de Implementación
**No implementado**

**Razón**: Similar a Guatemala y Nicaragua.

**Proxy Service**: `ConsultaPuntosLealtadPA.proxy` existe pero no usa conInfoLealtad

---

## Diferencias Clave entre Regiones

### Arquitectura de Backend

| Aspecto | HN01 | GT01/NI01/PA01 |
|---------|------|----------------|
| Servicio conInfoLealtad | Implementado (SQL Server) | No implementado |
| Consulta por Tarjeta | Soportado | Desconocido |
| Base de Datos | SQL Server (ConnectionProcesosHN) | N/A |
| Stored Procedure | OSBConInfoLealtad | N/A |

### Flujo de ConsultaPuntosLealtad

| Aspecto | HN01 | GT01/NI01/PA01 |
|---------|------|----------------|
| CUSTOMER_ID_TYPE soportados | LEGAL_ID, CARD_NUMBER | Probablemente solo LEGAL_ID |
| Servicio de Información Cliente | conInfoLealtad_db | Desconocido |
| Conversión de Código País | Sí (HN01 → HND) | Probablemente no necesario |

### Programas de Lealtad

| Aspecto | HN01 | GT01/NI01/PA01 |
|---------|------|----------------|
| Mastercard Rewards | Soportado (programa '1') | Desconocido |
| VisionPlus | Soportado (programa '2') | Desconocido |
| Determinación por CARDTYPE | Sí (DEBIT → Mastercard) | Desconocido |
| Determinación por LOGO | Sí (grupo de afinidad) | Desconocido |

---

## Análisis de Diferencias

### ¿Por qué solo HN01?

**Posibles razones:**

1. **Diferencias en Sistemas Core**
   - Honduras puede usar un sistema core diferente (SQL Server vs Oracle)
   - Otras regiones pueden tener la información en tablas diferentes

2. **Requisitos de Negocio**
   - Honduras puede requerir soporte para consulta por tarjeta
   - Otras regiones pueden requerir siempre Legal ID

3. **Programas de Lealtad Diferentes**
   - Honduras tiene múltiples programas (Mastercard, VisionPlus)
   - Otras regiones pueden tener programas más simples

4. **Evolución del Sistema**
   - conInfoLealtad puede ser un servicio legacy específico de Honduras
   - Otras regiones pueden usar servicios más modernos

### Impacto en Migración

**Riesgos:**
- Dificulta estandarización multiregión
- Requiere mantener lógica específica de Honduras
- Puede causar confusión en equipos de desarrollo

**Oportunidades:**
- Evaluar si otras regiones necesitan funcionalidad similar
- Considerar crear servicio genérico de consulta de cliente
- Unificar con servicios existentes de otras regiones

---

## Recomendaciones

### Prioridad Alta

1. **Documentar Flujos de Otras Regiones**
   - Analizar ConsultaPuntosLealtadGT/NI/PA
   - Identificar servicios equivalentes a conInfoLealtad
   - Documentar diferencias de implementación

2. **Evaluar Necesidad de Estandarización**
   - Determinar si todas las regiones deben soportar consulta por tarjeta
   - Considerar crear servicio genérico multiregión
   - Evaluar impacto en clientes y canales

3. **Migración de SQL Server**
   - Considerar migrar a Oracle para consistencia
   - Evaluar impacto en performance y disponibilidad
   - Planificar estrategia de migración

### Prioridad Media

1. **Crear Servicio Genérico**
   - Diseñar API REST para consulta de información de cliente
   - Soportar múltiples tipos de identificación
   - Implementar para todas las regiones

2. **Optimizar Flujo de Honduras**
   - Reducir número de consultas a base de datos
   - Implementar cache para datos de cliente
   - Mejorar manejo de errores

3. **Testing Multiregión**
   - Crear tests de integración para cada región
   - Validar comportamiento con diferentes tipos de ID
   - Probar escenarios de error

### Prioridad Baja

1. **Refactorización**
   - Considerar eliminar dependencia de Stored Procedure
   - Migrar a consultas SQL directas
   - Evaluar uso de servicios REST

2. **Documentación**
   - Documentar lógica del Stored Procedure OSBConInfoLealtad
   - Crear diagramas de flujo por región
   - Documentar diferencias de negocio

---

## Conclusión

**ConInfoLealtad** es un servicio específico de Honduras (HN01) sin equivalente en otras regiones. Esta diferencia refleja:
- Variaciones en sistemas core por región
- Requisitos de negocio específicos de Honduras
- Evolución independiente de cada región

Para una migración exitosa, es crítico:
1. Entender por qué solo Honduras tiene este servicio
2. Evaluar si otras regiones necesitan funcionalidad similar
3. Considerar estandarización vs. mantener diferencias regionales
