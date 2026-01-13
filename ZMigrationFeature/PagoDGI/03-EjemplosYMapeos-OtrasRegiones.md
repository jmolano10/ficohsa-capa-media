# Ejemplos de Request/Response y Mapeo de Datos - Otras Regiones (Default)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_REGION</UserName>
        <Password>PASSWORD_REGION</Password>
      </Authentication>
      <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>HN01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <pag:pagoDGIRequest xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoDGITypes">
      <RUC>0801198000001</RUC>
      <BILL_NUMBER>FAC-2024-001234</BILL_NUMBER>
      <TOTAL_AMOUNT>25000.00</TOTAL_AMOUNT>
      <PAYMENT_AMOUNT>25000.00</PAYMENT_AMOUNT>
      <ACCOUNT_NUMBER>9876543210987654</ACCOUNT_NUMBER>
      <TAX_VALUE>20000.00</TAX_VALUE>
      <EXCH_RATE_FEE>200.00</EXCH_RATE_FEE>
      <LATE_FEE>800.00</LATE_FEE>
      <PENALTY_FEE>4000.00</PENALTY_FEE>
      <DUE_DATE>2024-04-30</DUE_DATE>
      <TAX_DESCRIPTION>Impuesto al Valor Agregado</TAX_DESCRIPTION>
      <ACCOUNT_CODE>9876543210</ACCOUNT_CODE>
    </pag:pagoDGIRequest>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>ERROR</successIndicator>
      <messages>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <soap:Fault>
      <faultcode>MW-0008</faultcode>
      <faultstring>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</faultstring>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
```

## Flujo de Procesamiento para Otras Regiones

### Validaciones Ejecutadas

#### 1. Validación XSD (12 Campos Obligatorios)
```xml
<!-- Validación exitosa contra pagoDGITypes.xsd -->
<con:validate>
  <con:schema ref="Middleware/v2/Resources/PagoDGI/xsd/pagoDGITypes"/>
  <con:schemaElement>pag:pagoDGIRequest</con:schemaElement>
  <con:varName>body</con:varName>
</con:validate>
```

**Campos validados**:
- RUC: string
- BILL_NUMBER: string
- TOTAL_AMOUNT: decimal
- PAYMENT_AMOUNT: decimal
- ACCOUNT_NUMBER: string
- TAX_VALUE: decimal
- EXCH_RATE_FEE: decimal
- LATE_FEE: decimal
- PENALTY_FEE: decimal
- DUE_DATE: date
- TAX_DESCRIPTION: string
- ACCOUNT_CODE: string

#### 2. Validación de Servicio Regional
```xml
<!-- Validación exitosa para FICBCO0257 -->
<con:wsCallout>
  <con:service ref="Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db"/>
  <con:operation>ValidaServicioRegional</con:operation>
</con:wsCallout>
```

### Request a ValidaServicioRegional

```xml
<val:ValidaServicioRegional xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_SERVICE_ID>FICBCO0257</val:PV_SERVICE_ID>
  <val:PV_SOURCE_BANK>HN01</val:PV_SOURCE_BANK>
  <val:PV_DESTINATION_BANK>HN01</val:PV_DESTINATION_BANK>
</val:ValidaServicioRegional>
```

### Response de ValidaServicioRegional

```xml
<val:ValidaServicioRegionalResponse xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_CODIGO_ERROR>SUCCESS</val:PV_CODIGO_ERROR>
  <val:PV_MENSAJE_ERROR></val:PV_MENSAJE_ERROR>
</val:ValidaServicioRegionalResponse>
```

## Enrutamiento Regional

### Lógica de Enrutamiento
```xml
<con:branch-table variable="header">
  <con:xpath>./aut:RequestHeader/Region/SourceBank</con:xpath>
  <con:branch name="NIBanco">
    <con:operator>equals</con:operator>
    <con:value>'NI01'</con:value>
    <!-- Flujo implementado -->
  </con:branch>
  <con:default-branch>
    <!-- Flujo Default - Error MW-0008 -->
  </con:default-branch>
</con:branch-table>
```

### Regiones que Ejecutan Default
- **HN01**: Honduras
- **HN02**: Honduras FPC
- **GT01**: Guatemala
- **PA01**: Panamá
- **Cualquier otra región no especificada**

## Pipeline Default - Request

### Etapa: FlujoEntrada
```xml
<con:stage name="FlujoEntrada">
  <con:context/>
  <!-- Sin acciones - Pipeline vacío -->
</con:stage>
```

**Características:**
- No hay procesamiento de pagos
- No hay transformaciones
- No hay llamadas a servicios externos
- No hay parametrización
- Pipeline completamente vacío

## Pipeline Default - Response

### Etapa: FlujoSalida
```xml
<con:stage name="FlujoSalida">
  <con:context>
    <con:varNsDecl namespace="http://www.ficohsa.com.hn/middleware.services/autType" prefix="aut"/>
  </con:context>
  <con:actions>
    <con:Error>
      <con:errCode>MW-0008</con:errCode>
      <con:message>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</con:message>
    </con:Error>
  </con:actions>
</con:stage>
```

**Características:**
- Genera error inmediato MW-0008
- Mensaje estándar de servicio no implementado
- No hay procesamiento de pagos
- Termina ejecución con fault
- No hay generación de SIF ni transactionId

## Manejo de Errores para Otras Regiones

### Error MW-0008
- **Código**: MW-0008
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- **Tipo**: Error de implementación
- **Comportamiento**: Termina procesamiento inmediatamente
- **Impacto**: No se procesa ningún pago

### Flujo de Error
1. **Validaciones**: Pasan correctamente (XSD + Regional)
2. **Enrutamiento**: Dirige a Default
3. **Pipeline Request**: Vacío (sin procesamiento)
4. **Pipeline Response**: Genera error MW-0008
5. **Cliente**: Recibe SOAP Fault

## Mapeo de Errores

### Error Handler General
Si ocurre cualquier error técnico durante las validaciones:

```xml
<con:pipeline type="error" name="_onErrorHandler">
  <con:stage name="ManejoError">
    <con:actions>
      <con:assign varName="errorCode">
        <con:expr>fn:string($fault/ctx:errorCode/text())</con:expr>
      </con:assign>
      <con:assign varName="errorMessage">
        <con:expr>fn:string($fault/ctx:reason/text())</con:expr>
      </con:assign>
      <con:wsCallout>
        <con:service ref="Middleware/v2/ProxyServices/MapeoErrores"/>
        <con:operation>mapeoErrores</con:operation>
      </con:wsCallout>
    </con:actions>
  </con:stage>
</con:pipeline>
```

### Request a MapeoErrores

```xml
<mapeoErrores>
  <CODIGO_ERROR>{errorCode}</CODIGO_ERROR>
  <MENSAJE_ERROR>FICBCO0257$#${errorMessage}</MENSAJE_ERROR>
</mapeoErrores>
```

## Validaciones Aplicadas a Todas las Regiones

### 1. Validación XSD de Entrada (12 Campos)
**Esquema**: `Middleware/v2/Resources/PagoDGI/xsd/pagoDGITypes.xsd`
**Elemento**: `pagoDGIRequest`
**Campos validados**: Todos los 12 campos obligatorios del pago

### 2. Validación de Servicio Regional
**Service ID**: FICBCO0257
**Business Service**: `ValidaServicioRegional_db`
**Validación**: Disponibilidad del servicio por región

### 3. Aplicación de Valores por Defecto
**Transformación**: `aplicarValoresPorDefectoRegion.xq`
**Propósito**: Normalizar headers de región

## Diferencias con NI01

| Aspecto | NI01 | Otras Regiones |
|---------|------|----------------|
| **Procesamiento** | Pago completo | Solo validaciones |
| **Servicios externos** | CTS COBIS + Parametrización | Ninguno |
| **Transformaciones** | 3 archivos XQuery + cálculos | Ninguna |
| **Response** | Datos pago + SIF + transactionId | Error MW-0008 |
| **Complejidad** | Alta (lógica negocio) | Mínima |
| **Dependencias** | Múltiples (4 parámetros) | Solo validaciones |
| **Transaccionalidad** | Sí (pago real) | No |
| **Riesgo** | Alto (transacciones financieras) | Bajo |

## Consideraciones para Implementación Futura

### Para implementar PagoDGI en otras regiones se requeriría:

1. **Identificar sistema fiscal local**:
   - Honduras: SAR (Servicio de Administración de Rentas)
   - Guatemala: SAT (Superintendencia de Administración Tributaria)
   - Panamá: DGI (Dirección General de Ingresos)

2. **Crear business services específicos**:
   - Conexiones a APIs de pago fiscales locales
   - Adaptadores de base de datos si aplica
   - Configuraciones de timeout y retry para transacciones

3. **Desarrollar transformaciones con lógica de negocio**:
   - XQuery de entrada con cálculos específicos por región
   - XQuery de salida con mapeo de comprobantes locales
   - Funciones de cálculo de indicadores regionales

4. **Configurar parámetros regionales (mínimo 4)**:
   - Códigos de caja por región
   - Formas de pago por región
   - Códigos de banco por región
   - Tipos de impuesto por región

5. **Implementar manejo de transacciones**:
   - Códigos de error locales
   - Generación de comprobantes locales
   - Manejo de reversas si aplica
   - Auditoría de transacciones

6. **Adaptar validaciones específicas**:
   - Esquemas fiscales locales
   - Validaciones de montos y fechas
   - Reglas de negocio específicas

### Patrón de implementación sugerido:
```xml
<con:branch name="HN01">
  <con:operator>equals</con:operator>
  <con:value>'HN01'</con:value>
  <con:flow>
    <con:pipeline-node name="HN01_PagoDGI">
      <con:request>HN01_PagoDGI_request</con:request>
      <con:response>HN01_PagoDGI_response</con:response>
    </con:pipeline-node>
  </con:flow>
</con:branch>
```

### Consideraciones adicionales para pagos:

1. **Seguridad**: Autenticación reforzada para transacciones
2. **Auditoría**: Logging completo de todas las transacciones
3. **Reversas**: Mecanismo de reversa en caso de error
4. **Conciliación**: Procesos de conciliación con entidades fiscales
5. **Comprobantes**: Generación de comprobantes válidos localmente
6. **Monitoreo**: Alertas en tiempo real para transacciones fallidas