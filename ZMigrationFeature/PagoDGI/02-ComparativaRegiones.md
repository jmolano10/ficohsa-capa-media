# Comparación entre Regiones - PagoDGI

## Tabla de Comparación Regional

| Aspecto | NI01 (Nicaragua) | Otras Regiones (Default) |
|---------|------------------|---------------------------|
| **Endpoint OSB** | CTS COBIS Impuestos | No implementado |
| **Nombre de Base de Datos** | COBIS CTS | N/A |
| **Esquemas** | COBIS Impuestos Schema | N/A |
| **Store Procedure** | OpPagoDGI | N/A |
| **Nombre de Conexión** | CTS impuesto | N/A |
| **Transformaciones clave** | pagoDGIIn.xq | N/A |
| **Campos diferenciadores** | contextoTransaccional + datosPagN900 | Error MW-0008 |
| **Errores/Excepciones** | COBIS Error Structure | SERVICE NOT IMPLEMENTED |
| **Timeouts/Retrys** | timeout=0, retry=0 | N/A |
| **Dependencias internas** | Parametrización OSB (4 parámetros) | N/A |
| **Parametrización externa** | Sí (CAJADGI, FORMAPAGODGI, CODIGOBANCODGI, TIPOIMPUESTODGI) | No |
| **Validación esquema** | services.xsd (CTS) | pagoDGITypes.xsd |
| **Contexto COBIS** | Obligatorio | N/A |
| **Transaccionalidad** | Sí (pago real) | N/A |
| **Campos de entrada** | 12 campos obligatorios | 12 campos (validación XSD) |
| **Campos de salida** | 8 campos + SIF_CODE + transactionId | Response vacía |

## Detalles por Región

### NI01 (Nicaragua - Pago DGI)

**Características específicas:**
- Utiliza servicio CTS COBIS Impuestos como backend
- Requiere parametrización externa obligatoria (4 parámetros)
- Implementa contexto transaccional específico de COBIS
- Procesa pagos reales de impuestos con generación de SIF
- Cálculo automático de indicador de pago (completo/parcial)
- Generación automática de fecha/hora de pago

**Endpoint de conexión:**
- Business Service: `Middleware/v2/BusinessServices/CTS/impuesto/biz/impuesto`
- Operación: `OpPagoDGI`
- Endpoint: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`

**Parametrización requerida:**
- `FICBCO0257.CAJADGI`: Código de caja DGI
- `FICBCO0257.FORMAPAGODGI`: Forma de pago DGI
- `FICBCO0256.CODIGOBANCODGI`: Código del banco para DGI
- `FICBCO0257.TIPOIMPUESTODGI`: Tipo de impuesto DGI

**Validaciones específicas:**
- Validación de parametrización antes del procesamiento
- Validación de esquema CTS antes del envío
- Validación XSD de entrada obligatoria (12 campos)

**Estructura de request específica:**
```xml
<contextoTransaccional>
    <codCanalOriginador>1</codCanalOriginador>
</contextoTransaccional>
<datosPagN900>
    <bit>{BILL_NUMBER}</bit>
    <valMontoPago>{PAYMENT_AMOUNT}</valMontoPago>
    <fechaPago>{fecha actual}</fechaPago>
    <horaPago>{hora actual}</horaPago>
    <indicadorPago>{calculado: 1 o 2}</indicadorPago>
    <formaPago>{parámetro}</formaPago>
    <codigoBanco>{parámetro}</codigoBanco>
    <caja>{parámetro}</caja>
    <!-- + 9 campos fiscales más -->
</datosPagN900>
```

**Lógica de negocio específica:**
1. **Cálculo de indicador de pago**:
   ```xquery
   if(($valTotal - $valPago) = 0) then '1' else '2'
   ```

2. **Generación de timestamp**:
   ```xquery
   fechaPago: fn:adjust-dateTime-to-timezone(current-dateTime(),())
   horaPago: fn-bea:dateTime-to-string-with-format("HH:mm:ss", current-dateTime())
   ```

3. **Redondeo de montos**:
   ```xquery
   BILL_AMOUNT: round-half-to-even(PAYMENT_AMOUNT, 2)
   ```

**Mapeo de datos completo:**
- **Entrada**: 12 campos OSB → estructura datosPagN900 CTS
- **Salida**: Combinación request original + respuesta CTS + SIF_CODE
- **Transformación especial**: Cálculos automáticos y timestamps

### Otras Regiones (Default)

**Características específicas:**
- No hay implementación funcional
- Retorna error estándar MW-0008
- Solo ejecuta validaciones generales
- Pipeline vacío sin procesamiento de pagos

**Comportamiento:**
- Validación XSD de entrada (12 campos)
- Validación de servicio regional
- Error inmediato: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

**Flujo simplificado:**
1. Validación XSD → OK
2. Validación regional → OK  
3. Enrutamiento → Default
4. Error MW-0008 → Cliente

## Diferencias Clave de Implementación

### Cobertura Funcional
- **NI01**: Implementación completa con CTS COBIS + lógica de negocio
- **Otras**: Solo mensaje de error

### Dependencias Externas
- **NI01**: CTS COBIS + Parametrización OSB (4 parámetros)
- **Otras**: Ninguna

### Complejidad de Procesamiento
- **NI01**: 
  - 2 etapas: Parametrización + Pago CTS
  - Validaciones múltiples
  - Transformaciones complejas con cálculos
  - Lógica de negocio específica
- **Otras**: 
  - 1 etapa: Error directo
  - Sin transformaciones

### Transaccionalidad
- **NI01**: 
  - Transacciones reales de pago
  - Generación de comprobantes (SIF)
  - Modificación de estado en DGI
- **Otras**: 
  - Sin transacciones
  - Sin impacto en sistemas externos

### Manejo de Errores
- **NI01**: 
  - Errores de parametrización
  - Errores CTS COBIS
  - Códigos específicos de DGI
  - TransactionId en caso de éxito
- **Otras**: 
  - Solo error MW-0008
  - Sin manejo específico

### Configuración Requerida
- **NI01**: 
  - 4 parámetros obligatorios
  - Configuración CTS
  - Esquemas COBIS
  - Validaciones de negocio
- **Otras**: 
  - Sin configuración específica
  - Solo validaciones generales

## Regiones Detectadas

Basándose en el análisis del código fuente, se identifican las siguientes regiones:

### Regiones Implementadas
- **NI01**: Nicaragua (implementación completa)

### Regiones No Implementadas
- **HN01**: Honduras (error MW-0008)
- **HN02**: Honduras FPC (error MW-0008)
- **GT01**: Guatemala (error MW-0008)  
- **PA01**: Panamá (error MW-0008)
- **Cualquier otra región**: Error MW-0008

## Patrón de Enrutamiento

El servicio utiliza un patrón de enrutamiento simple:

```xml
<con:branch-table variable="header">
  <con:xpath>./aut:RequestHeader/Region/SourceBank</con:xpath>
  <con:branch name="NIBanco">
    <con:operator>equals</con:operator>
    <con:value>'NI01'</con:value>
    <!-- Implementación completa -->
  </con:branch>
  <con:default-branch>
    <!-- Error MW-0008 -->
  </con:default-branch>
</con:branch-table>
```

## Consideraciones para Expansión

### Para implementar en otras regiones se requeriría:

1. **Backend específico**: Conexión a sistema fiscal local
2. **Parametrización**: Configuraciones por país (4+ parámetros)
3. **Transformaciones**: Mapeo de datos específico con lógica de negocio
4. **Validaciones**: Esquemas y reglas locales
5. **Manejo de errores**: Códigos específicos por región
6. **Transaccionalidad**: Manejo de pagos reales y comprobantes

### Patrón de implementación sugerido:
- Seguir el modelo NI01
- Crear business services específicos
- Implementar transformaciones XQuery con cálculos
- Configurar parámetros regionales (mínimo 4)
- Adaptar manejo de errores y transacciones
- Implementar generación de comprobantes locales

## Diferencias con ConsultaDGI

| Aspecto | ConsultaDGI | PagoDGI |
|---------|-------------|---------|
| **Propósito** | Consulta información | Procesa pagos |
| **Campos entrada** | 2 campos | 12 campos |
| **Parámetros config** | 2 parámetros | 4 parámetros |
| **Transaccionalidad** | Solo lectura | Transaccional |
| **Lógica negocio** | Mapeo directo | Cálculos + timestamps |
| **Campos salida** | 9 campos fiscales | 8 campos + SIF + transactionId |
| **Complejidad** | Media | Alta |
| **Riesgo** | Bajo | Alto (pagos reales) |

### Campos únicos de PagoDGI:
- **PAYMENT_AMOUNT**: Monto específico del pago
- **ACCOUNT_NUMBER**: Cuenta del pagador
- **SIF_CODE**: Código de comprobante DGI
- **transactionId**: ID de transacción (en header)