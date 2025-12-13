# Comparativa entre Regiones - ConsultaFondoPensiones

## Tabla de Comparación

| Aspecto | HN02 (Honduras FPC) | Otras Regiones |
|---------|---------------------|----------------|
| **Endpoint OSB** | `/Middleware/ReferenceData/BusinessPartner/ConsultaFondoPensiones` | `/Middleware/ReferenceData/BusinessPartner/ConsultaFondoPensiones` |
| **Nombre de Base de Datos** | No utiliza BD directa | No implementado |
| **Esquemas** | N/A | N/A |
| **Store Procedure** | N/A | N/A |
| **Nombre de Conexión a Base de datos u OSB** | N/A | N/A |
| **Transformaciones clave** | getPensionFundIn.xq, consultaFondoPensionesHNOut.xq, getPensionFundHeaderIn.xq | N/A |
| **Campos diferenciadores** | Mapeo completo de datos de pensiones | N/A |
| **Errores/Excepciones** | Evaluación de Status del servicio externo | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY |
| **Timeouts/Retrys** | 70s timeout, sin reintentos | N/A |
| **Dependencias internas** | getPensionFund12c (servicio externo) | Ninguna |
| **Servicio Externo** | https://dynamoosbdev:8004/regional/pension/soap/getPensionFund11g/v1 | N/A |
| **Credenciales** | OSB12AUTH | N/A |
| **Protocolo** | SOAP/HTTPS | N/A |
| **Validación Regional** | No implementada | No implementada |

## Sección por Región

### HN02 - Honduras FPC (Fondo de Pensiones y Cesantías)

#### Estado de Implementación
✅ **COMPLETAMENTE IMPLEMENTADO**

#### Configuración
- **Pipeline**: FPCHN_ConsultaFondoPensiones_request/response
- **Condición de Enrutamiento**: `SourceBank = 'HN02'`
- **Protocolo**: SOAP con HTTPS habilitado

#### Endpoints
**Servicio Externo (Único)**:
- URL: `https://dynamoosbdev:8004/regional/pension/soap/getPensionFund11g/v1`
- Protocolo: HTTPS/SOAP
- Timeout: 70 segundos
- Connection Timeout: 65 segundos
- Operación: getPensionFund

#### Mapeos de Entrada

**Transformación Header**: `getPensionFundHeaderIn.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio Externo) |
|-------------------|----------------------|----------------------------------|
| Constante 'OSB12AUTH' | getUsername($serviceAccountName) | Authentication/UserName |
| Constante 'OSB12AUTH' | getPassword($serviceAccountName) | Authentication/Password |
| header/aut:RequestHeader/Region/SourceBank | Mapeo directo | Region/SourceBank |
| header/aut:RequestHeader/Region/DestinationBank | Mapeo directo | Region/DestinationBank |

**Transformación Body**: `getPensionFundIn.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio Externo) |
|-------------------|----------------------|----------------------------------|
| ACCOUNT_NUMBER | Mapeo directo | AccountCode |
| SourceBank (parámetro) | Mapeo directo | GeneralInfo/SourceBank |
| DestinationBank (parámetro) | Mapeo directo | GeneralInfo/DestinationBank |
| Constante 'es' | Valor fijo | GeneralInfo/Language |

#### Mapeos de Salida

**Transformación**: `consultaFondoPensionesHNOut.xq`

| Campo Origen (Servicio Externo) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| AccountNumber (parámetro) | Mapeo directo | ACCOUNT_NUMBER |
| Data/Account/CustomerCode | Mapeo directo | CUSTOMER_ID |
| Data/Account/CustomerName | Mapeo directo | CUSTOMER_NAME |
| Data/Account/CodeProductLine | Mapeo directo | PRODUCT_CODE |
| Data/Account/ProductName | Mapeo directo | PRODUCT_NAME |
| Data/Account/ProductCode | Mapeo directo | SUB_PRODUCT_CODE |
| Data/Account/OpeningDate | Mapeo directo | OPENING_DATE |
| Data/Account/FrequencyContribution | Mapeo directo | FREQUENCY |
| Data/Account/FormContribution | Mapeo directo | PAYMENT_METHOD |
| Data/Account/InsuredAmount | Mapeo condicional | INSURED_AMOUNT |
| Data/Account/AmountContribution | Mapeo directo | CONTRIBUTION_AMOUNT |
| Data/Account/LastContributionAmount | Mapeo condicional | LAST_CONTRIBUTION_AMOUNT |
| Data/Account/LastContribution | Mapeo directo | LAST_CONTRIBUTION_DATE |
| Data/Account/NextContribution | Mapeo directo | NEXT_CONTRIBUTION_DATE |
| Data/Account/LastContributionExtra | Mapeo directo | LAST_EXTRA_CONTRIBUTION_AMOUNT |

**Mapeo de Beneficiarios**:

| Campo Origen (Servicio Externo) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| Data/Account/Beneficiaries/NameBeneficiary | Mapeo directo | BENEFICIARY_INFO/BENEFICIARY_ITEM/FULL_NAME |
| Data/Account/Beneficiaries/RelationshipBeneficiary | Mapeo directo | BENEFICIARY_INFO/BENEFICIARY_ITEM/RELATIONSHIP |

**Campos No Mapeados en Response**:
- ACCOUNT_TYPE, ACCOUNT_CURRENCY, ACCOUNT_STATUS
- REQUEST_ID, GROUP_CODE, CONTRACT_ID
- SUB_PRODUCT_NAME, EXPIRATION_DATE, CLOSING_DATE
- OFFICER_CODE, BRANCH_CODE, NOTIFICATION_TYPE
- APPLY_INSURANCE, FREQUENCY_DATE
- SALARY_AMOUNT, PREMIUM_AMOUNT, CONTRIBUTION_TYPE
- FIRST_CONTRIBUTION_AMOUNT/DATE, NEXT_CONTRIBUTION_AMOUNT
- LAST_EXTRA_CONTRIBUTION_DATE
- BALANCE_TYPE_INFO (estructura completa)
- Campos adicionales de beneficiarios (nombres separados, fecha nacimiento, género, porcentaje)

#### Validaciones
1. **Sin Validación Regional**: No implementa validación previa del servicio
2. **Validación de Respuesta**: Verifica campo `Status` de la respuesta externa
3. **Evaluación de Error**: `upper-case($successIndicator) = "SUCCESS"`

#### Políticas OSB
- **Autenticación**: Custom token authentication
- **Monitoreo**: Deshabilitado a nivel de servicio
- **Logging**: Debug level
- **SLA Alerting**: Normal level
- **HTTPS**: Habilitado para conexiones entrantes

#### Handlers
1. **Error Handler Principal**: Manejo de errores con concatenación de código y razón
2. **Respuesta de Error**: Construcción de response vacío en caso de error

#### Reglas de Negocio Detectadas

1. **Evaluación de Status de Respuesta**:
   - Ubicación: Pipeline FPCHN_ConsultaFondoPensiones_request
   - Lógica: 
   ```xquery
   let $successIndicator := fn:string($RSPgetPensionFund/StatusInfo/Status)
   return
   if(fn:upper-case($successIndicator) = "SUCCESS") then (
       $successIndicator
   ) else ('Error')
   ```

2. **Manejo de Mensaje de Validación**:
   - Ubicación: Pipeline FPCHN_ConsultaFondoPensiones_request
   - Lógica:
   ```xquery
   if(fn:not(fn:upper-case($errorCode) = "SUCCESS")) then (
       fn:data($RSPgetPensionFund/ErrorInfo/Description)
   ) else ('')
   ```

3. **Construcción Condicional de Response**:
   - Ubicación: Pipeline FPCHN_ConsultaFondoPensiones_response
   - Lógica: `$validationMessage = ""`
   - Descripción: Solo transforma datos si no hay mensaje de error

4. **Mapeo Condicional de Campos Opcionales**:
   - Ubicación: consultaFondoPensionesHNOut.xq
   - Lógica: Uso de `for` loops para campos que pueden estar ausentes
   - Campos: InsuredAmount, LastContributionAmount

5. **Obtención de Credenciales**:
   - Ubicación: getPensionFundHeaderIn.xq
   - Funciones: `getUsername()`, `getPassword()`
   - Descripción: Obtiene credenciales del almacén de seguridad OSB

#### Dependencias Externas
1. **Servicio Dynamo**: Endpoint principal para datos de pensiones
2. **Almacén de Credenciales**: OSB12AUTH para autenticación
3. **Certificados HTTPS**: Para conexiones seguras

---

### Otras Regiones (GT01, PA01, NI01, etc.)

#### Estado de Implementación
❌ **NO IMPLEMENTADO**

#### Configuración
- **Pipeline**: BranchDefault_request/response
- **Comportamiento**: Devuelve error inmediatamente
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

#### Endpoints
- No tiene endpoints específicos implementados

#### Mapeos
- No aplica - servicio no implementado

#### Validaciones
- No implementa validaciones específicas

#### Políticas OSB
- Utiliza las políticas generales del proxy
- No tiene políticas específicas

#### Handlers
- Error handler genérico que devuelve mensaje estándar

## Diferencias Principales entre Regiones

1. **Implementación**: Solo HN02 está implementado, todas las demás regiones no
2. **Arquitectura**: HN02 usa servicio externo HTTPS, otras regiones no tienen implementación
3. **Complejidad**: HN02 maneja estructuras de datos complejas, otras regiones solo error
4. **Dependencias**: HN02 depende de servicio externo, otras regiones no tienen dependencias
5. **Seguridad**: HN02 usa HTTPS y credenciales específicas, otras regiones no
6. **Transformaciones**: HN02 tiene múltiples transformaciones XQuery, otras regiones ninguna
7. **Validación**: HN02 valida respuesta del servicio externo, otras regiones no validan nada

## Consideraciones para Migración

### Para HN02
- **Dependencia Crítica**: Verificar disponibilidad del servicio Dynamo
- **Certificados**: Asegurar certificados HTTPS válidos
- **Credenciales**: Migrar credenciales OSB12AUTH
- **Timeouts**: Revisar configuración de timeouts para el nuevo entorno

### Para Otras Regiones
- **Implementación Requerida**: Necesario implementar la funcionalidad
- **Fuentes de Datos**: Identificar fuentes de datos de pensiones por región
- **Adaptaciones**: Posibles diferencias en estructura de datos por país