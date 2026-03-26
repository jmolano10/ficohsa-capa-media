# Comparativa entre Regiones - ConsultaGestionesMonetarias

## Tabla de Comparación Regional

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) |
|---------|-----------------|------------------|---------------|
| **Endpoint OSB** | /Middleware/OperationsAndExecution/BundledProducts/ConsultaGestionesMonetarias | /Middleware/OperationsAndExecution/BundledProducts/ConsultaGestionesMonetarias | /Middleware/OperationsAndExecution/BundledProducts/ConsultaGestionesMonetarias |
| **Nombre de Base de Datos** | Oracle Database (ConnectionInterfazSFC) | Oracle Database (ConnectionInterfazSFC) | Oracle Database (ConnectionInterfazSFC) |
| **Esquemas** | SALESFORCE | SALESFORCE | SALESFORCE |
| **Store Procedure** | SFC_P_CON_GESTIONES_MONETARIAS | SFC_P_CON_GESTIONES_MONETARIAS | SFC_P_CON_GESTIONES_MONETARIAS |
| **Nombre de Conexión** | eis/DB/ConnectionInterfazSFC | eis/DB/ConnectionInterfazSFC | eis/DB/ConnectionInterfazSFC |
| **Transformaciones de Entrada** | consultaGestionesMonetariasIn.xq | consultaGestionesMonetariasGTIn.xq | consultaGestionesMonetariasPAIn.xq |
| **Transformaciones de Salida** | consultaGestionesMonetariasOut.xq | consultaGestionesMonetariasGTOut.xq | consultaGestionesMonetariasPAOut.xq |
| **Transformaciones Header** | consultaGestionesMonetariasHeaderOut.xq | consultaGestionesMonetariasGTHeaderOut.xq | consultaGestionesMonetariasPAHeaderOut.xq |
| **Campos Diferenciadores** | Ninguno detectado | Ninguno detectado | Ninguno detectado |
| **Errores/Excepciones** | Mapeo centralizado con FICBCO0287 | Mapeo centralizado con FICBCO0287 | Mapeo centralizado con FICBCO0287 |
| **Timeouts/Retrys** | Retry: 0, Interval: 30s | Retry: 0, Interval: 30s | Retry: 0, Interval: 30s |
| **Dependencias Internas** | ValidaServicioRegional, MapeoErrores | ValidaServicioRegional, MapeoErrores | ValidaServicioRegional, MapeoErrores |

## Análisis Detallado por Región

### HN01 - Honduras

#### Características Específicas
- **Pipeline Request**: `HN01_ConsultasGestionesMonetarias_request`
- **Pipeline Response**: `HN01_ConsultasGestionesMonetarias_response`
- **XQuery Entrada**: `consultaGestionesMonetariasIn.xq`
- **XQuery Salida**: `consultaGestionesMonetariasOut.xq`
- **XQuery Header**: `consultaGestionesMonetariasHeaderOut.xq`

#### Transformaciones de Entrada
```xquery
<ns1:InputParameters>
    <ns1:PN_NUMUSU>{ data($consultaGestionesMonetarias/NUMUSU) }</ns1:PN_NUMUSU>
    <ns1:PV_PAIS>{ data($consultaGestionesMonetarias/PAIS) }</ns1:PV_PAIS>
    <ns1:PV_DETALLE>{ data($consultaGestionesMonetarias/DETALLE_GESTION) }</ns1:PV_DETALLE>
</ns1:InputParameters>
```

#### Validaciones Específicas
- Validación XSD estándar
- Validación regional con serviceId "FICBCO0287"
- Manejo de errores centralizado

#### Políticas OSB
- Logging: debug level
- SLA alerting: normal level
- Pipeline alerting: normal level
- Monitoring: disabled

### GT01 - Guatemala

#### Características Específicas
- **Pipeline Request**: `GT01_ConsultasGestionesMonetarias_request`
- **Pipeline Response**: `GT01_ConsultasGestionesMonetarias_response`
- **XQuery Entrada**: `consultaGestionesMonetariasGTIn.xq`
- **XQuery Salida**: `consultaGestionesMonetariasGTOut.xq`
- **XQuery Header**: `consultaGestionesMonetariasGTHeaderOut.xq`

#### Transformaciones de Entrada
```xquery
<ns1:InputParameters>
    <ns1:PN_NUMUSU>{ data($consultaGestionesMonetarias/NUMUSU) }</ns1:PN_NUMUSU>
    <ns1:PV_PAIS>{ data($consultaGestionesMonetarias/PAIS) }</ns1:PV_PAIS>
    <ns1:PV_DETALLE>{ data($consultaGestionesMonetarias/DETALLE_GESTION) }</ns1:PV_DETALLE>
</ns1:InputParameters>
```

#### Diferencias con HN01
- **Archivos XQuery específicos**: Aunque el contenido es idéntico, utiliza archivos separados para Guatemala
- **Namespace específico**: Utiliza namespace específico para GT en las transformaciones
- **Pipeline dedicado**: Pipeline específico para Guatemala con misma lógica

### PA01 - Panamá

#### Características Específicas
- **Pipeline Request**: `PA01_ConsultasGestionesMonetarias_request`
- **Pipeline Response**: `PA01_ConsultasGestionesMonetarias_response`
- **XQuery Entrada**: `consultaGestionesMonetariasPAIn.xq`
- **XQuery Salida**: `consultaGestionesMonetariasPAOut.xq`
- **XQuery Header**: `consultaGestionesMonetariasPAHeaderOut.xq`

#### Transformaciones de Entrada
```xquery
<ns1:InputParameters>
    <ns1:PN_NUMUSU>{ data($consultaGestionesMonetarias/NUMUSU) }</ns1:PN_NUMUSU>
    <ns1:PV_PAIS>{ data($consultaGestionesMonetarias/PAIS) }</ns1:PV_PAIS>
    <ns1:PV_DETALLE>{ data($consultaGestionesMonetarias/DETALLE_GESTION) }</ns1:PV_DETALLE>
</ns1:InputParameters>
```

#### Diferencias con Otras Regiones
- **Archivos XQuery específicos**: Archivos dedicados para Panamá
- **Namespace específico**: Namespace específico para PA
- **Pipeline dedicado**: Pipeline específico con misma estructura

## Diferencias Técnicas Identificadas

### Similitudes entre Regiones
1. **Estructura de Datos**: Todas las regiones utilizan la misma estructura de entrada y salida
2. **Stored Procedure**: Mismo SP (SFC_P_CON_GESTIONES_MONETARIAS) para todas las regiones
3. **Conexión de BD**: Misma conexión JCA (ConnectionInterfazSFC)
4. **Esquema de BD**: Mismo esquema SALESFORCE
5. **Validaciones**: Mismas validaciones XSD y regionales
6. **Manejo de Errores**: Sistema centralizado de mapeo de errores

### Diferencias Identificadas
1. **Archivos de Transformación**: Cada región tiene sus propios archivos XQuery aunque el contenido sea idéntico
2. **Pipelines Dedicados**: Cada región tiene pipelines específicos
3. **Namespaces**: Cada transformación utiliza namespaces específicos por región

## Configuración de Enrutamiento

### Lógica de Branch
```xml
<con1:branch-table variable="header">
    <con1:xpath>./aut:RequestHeader/Region/SourceBank</con1:xpath>
    <con1:branch name="HN01">
        <con1:operator>equals</con1:operator>
        <con1:value>'HN01'</con1:value>
    </con1:branch>
    <con1:branch name="GT01">
        <con1:operator>equals</con1:operator>
        <con1:value>'GT01'</con1:value>
    </con1:branch>
    <con1:branch name="PA01">
        <con1:operator>equals</con1:operator>
        <con1:value>'PA01'</con1:value>
    </con1:branch>
    <con1:default-branch>
        <!-- Error: SERVICE NOT IMPLEMENTED YET -->
    </con1:default-branch>
</con1:branch-table>
```

## Conclusiones

### Sin Diferencias Funcionales Detectadas
Después del análisis exhaustivo del código fuente, se determina que **no existen diferencias funcionales significativas** entre las regiones HN01, GT01 y PA01 para la funcionalidad ConsultaGestionesMonetarias.

### Diferencias Estructurales
Las únicas diferencias son de **organización de código**:
- Archivos XQuery separados por región
- Pipelines dedicados por región
- Namespaces específicos

### Recomendaciones
1. **Consolidación**: Las transformaciones idénticas podrían consolidarse en un solo archivo
2. **Mantenimiento**: La estructura actual facilita el mantenimiento regional independiente
3. **Escalabilidad**: La arquitectura permite agregar diferencias regionales futuras sin impacto