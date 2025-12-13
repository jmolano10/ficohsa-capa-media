# Comparativa entre Regiones - ConsultaInformacionLaboral

## Tabla de Comparación

| Aspecto | HN01 (Honduras Principal) | HN02 (Honduras FPC) |
|---------|---------------------------|---------------------|
| **Endpoint OSB** | `/Middleware/ReferenceData/BusinessPartner/ConsultaInformacionLaboral` | `/Middleware/ReferenceData/BusinessPartner/ConsultaInformacionLaboral` |
| **Nombre de Base de Datos** | No implementado | ConnectionFicopen |
| **Esquemas** | N/A | FO |
| **Store Procedure** | N/A | FO_WEB_SERVICE$DEME_HIS_INFO_ |
| **Nombre de Conexión a Base de datos u OSB** | N/A | eis/DB/ConnectionFicopen |
| **Transformaciones clave** | N/A | consultaInformacionLaboralIn_HNFPC.xq, consultaInformacionLaboralOut_HNFPC.xq |
| **Campos diferenciadores** | N/A | Mapeo directo a stored procedure con formato de fechas específico |
| **Errores/Excepciones** | MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Manejo de errores desde stored procedure (PN_CODIGO_ERROR, PC_MENSAJE_ERROR) |
| **Timeouts/Retrys** | N/A | Sin reintentos configurados |
| **Dependencias internas** | ValidaServicioRegional_db | ValidaServicioRegional_db, consultaInformacionLaboralFPC_db |
| **Servicio Externo** | N/A | getEmploymentInformation12c (https://dynamoosbdev:8004) |
| **Package de BD** | N/A | WCONSULTAINFORMACIONLABORALFPC |
| **Credenciales** | N/A | OSB12AUTH |

## Sección por Región

### HN01 - Honduras Principal

#### Estado de Implementación
❌ **NO IMPLEMENTADO**

#### Configuración
- **Pipeline**: Default_ConsultaInformacionLaboral_request/response
- **Comportamiento**: Devuelve error inmediatamente
- **Código de Error**: MW-0008
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

#### Endpoints
- No tiene endpoints específicos implementados

#### Mapeos
- No aplica - servicio no implementado

#### Validaciones
- Solo validación regional básica

#### Políticas OSB
- Utiliza las políticas generales del proxy
- No tiene políticas específicas

#### Handlers
- Error handler genérico que devuelve el código MW-0008

---

### HN02 - Honduras FPC (Fondo de Pensiones y Cesantías)

#### Estado de Implementación
✅ **COMPLETAMENTE IMPLEMENTADO**

#### Configuración
- **Pipeline**: HNFPC_ConsultaInformacionLaboral_request/response
- **Condición de Enrutamiento**: `SourceBank = 'HN02'`
- **Mapeo de Región**: HN02 se mapea internamente a HN01 para el servicio externo

#### Endpoints
1. **Servicio Externo (Primario)**:
   - URL: `https://dynamoosbdev:8004/regional/pension/soap/getEmploymentInformation/v11g`
   - Protocolo: HTTPS/SOAP
   - Timeout: 70 segundos
   - Connection Timeout: 65 segundos

2. **Base de Datos (Alternativo)**:
   - Conexión: `eis/DB/ConnectionFicopen`
   - Tipo: JCA Database Adapter
   - Esquema: FO
   - Package: WCONSULTAINFORMACIONLABORALFPC
   - Stored Procedure: FO_WEB_SERVICE$DEME_HIS_INFO_

#### Mapeos de Entrada

**Transformación**: `consultaInformacionLaboralIn_HNFPC.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| CUSTOMER_ACCOUNT | Mapeo directo | PC_COD_CTA |
| FROM_DATE | local:format-date-FPC() - Convierte YYYYMMDD a YYYY-MM-DD | PD_FECHA_INICIO |
| TO_DATE | local:format-date-FPC() - Convierte YYYYMMDD a YYYY-MM-DD | PD_FECHA_FIN |

**Función de Transformación de Fecha**:
```xquery
declare function local:format-date-FPC($textdate as xs:string) as xs:string
{
    fn:concat(fn:substring($textdate,1,4),'-',fn:substring($textdate,5,2),'-',fn:substring($textdate,7,2))
};
```

#### Mapeos de Salida

**Transformación**: `consultaInformacionLaboralOut_HNFPC.xq`

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| COD_CUENTA_FO | Mapeo directo | CUSTOMER_ACCOUNT |
| ESTADO | Mapeo directo | STATUS |
| FEC_SALIDA | local:format-date-from-FPC() - Convierte timestamp a YYYYMMDDHHMMSS | END_DATE |
| NUM_PERIODO | Mapeo directo | PAYMENT_PERIOD |
| COD_PATRONO | Mapeo directo | EMPLOYER_CODE |
| NOM_PATRONO | Mapeo directo | EMPLOYER_NAME |
| RTN_PATRONO | Mapeo directo | EMPLOYER_RTN |
| TIP_INGRESO | Mapeo directo | BALANCE_TYPE |
| MONTO_PAGADO | Mapeo directo | PAYMENT_AMOUNT |
| SALARIO | Mapeo directo | SALARY_AMOUNT |
| OCUPACION | Mapeo directo | OCCUPATION_DESC |
| PUESTO | Mapeo directo | JOB_TITLE_DESC |

**Campos Vacíos en Respuesta**:
- START_DATE (siempre vacío)
- PAYMENT_CURRENCY (siempre vacío)
- SALARY_CURRENCY (siempre vacío)
- OCCUPATION_CODE (siempre vacío)
- JOB_TITLE_CODE (siempre vacío)

#### Validaciones
1. **Validación XSD**: Esquema `consultaInformacionLaboralTypes.xsd`
2. **Validación Regional**: Service ID "FICBCO0181"
3. **Validación de Fechas**: Formato y valores válidos

#### Políticas OSB
- **Autenticación**: Custom token authentication
- **Monitoreo**: Pipeline level habilitado
- **Logging**: Debug level
- **SLA Alerting**: Normal level
- **Throttling**: Deshabilitado

#### Handlers
1. **Error Handler Principal**: Manejo de errores con códigos específicos
2. **Error Handler de Request**: Resume en caso de error
3. **Transformación de Errores**: Utiliza `obtenerServiceErrorId` para mapear códigos

#### Reglas de Negocio Detectadas

1. **Mapeo de Región**: 
   - Ubicación: Pipeline HNFPC_ConsultaInformacionLaboral_request
   - Lógica: Si SourceBank = 'HN02', se mapea a 'HN01' para el servicio externo

2. **Manejo de Fechas Opcionales**:
   - Ubicación: consultaInformacionLaboralIn_HNFPC.xq
   - Lógica: Si FROM_DATE o TO_DATE están vacíos, se envían como elementos vacíos

3. **Formato de Fechas de Salida**:
   - Ubicación: consultaInformacionLaboralOut_HNFPC.xq
   - Lógica: Convierte timestamp de BD a formato YYYYMMDDHHMMSS

4. **Validación de Respuesta Exitosa**:
   - Ubicación: Pipeline response
   - Lógica: `upper-case($errorCode) = 'SUCCESS'`

#### Dependencias Externas
1. **Servicio de Validación Regional**
2. **Servicio getEmploymentInformation12c** (Dynamo)
3. **Base de datos FPC** (ConnectionFicopen)
4. **Servicio de Credenciales** (OSB12AUTH)

## Diferencias Principales entre Regiones

1. **Implementación**: HN02 está completamente implementado, HN01 no
2. **Arquitectura**: HN02 usa conexión directa a BD, HN01 no tiene implementación
3. **Transformaciones**: HN02 tiene transformaciones específicas para FPC
4. **Manejo de Errores**: HN02 maneja errores de BD, HN01 solo error genérico
5. **Dependencias**: HN02 tiene múltiples dependencias, HN01 ninguna específica