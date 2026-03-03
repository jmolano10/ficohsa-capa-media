# Comparativa entre Regiones - Depositoenefectivofase12

## Tabla de Comparación

| Aspecto | HN01 (Honduras) |
|---------|-----------------|
| **Endpoint OSB** | /MiddlewareCaja/PagoPrestamoCaja |
| **Nombre de Base de Datos** | ORA_BANK |
| **Esquemas** | OSB_K_PAGO_PRESTAMO |
| **Store Procedure** | pagoPrestamo |
| **Nombre de Conexión a Base de datos** | ORA_BANK/OSB_K_PAGO_PRESTAMO/TOPLEVEL-24OSB_PAG_PRESTAMO_CAJ |
| **Transformaciones clave** | DepositoEfectivoMonedaExtranjeraIn.xq |
| **Campos diferenciadores** | CASHCURRENCY: USD, AMOUNTFOREING, ACCOUNT |
| **Errores/Excepciones** | CURRENCY LOAN NOT SUPPORTED, FCY LIMIT EXCEEDED |
| **Timeouts/Retrys** | 30s T24, 15s DB, Sin reintentos |
| **Dependencias internas** | T24 Core Banking, Oracle Database, Módulo FCY |
| **Moneda Soportada** | USD (Dólar Estadounidense) |
| **Cuenta Contable** | T24T044.USDCREDITAACCTNO |
| **Tipo Transacción T24** | TELLERFICOHNANYCASHINFCYType |
| **Validaciones Regulatorias** | Límites BCH, Control de divisas |

## Detalles por Región

### HN01 - Honduras

#### Endpoints y Configuración
- **URL Base**: `/MiddlewareCaja/PagoPrestamoCaja`
- **Operación SOAP**: `pagoPrestamo`
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/pagoPrestamoPS/`

#### Mapeos y Validaciones
- **Validación de Moneda**: Solo acepta préstamos en USD
- **Tipo de Pago**: Exclusivamente "CASH"
- **Cuenta Destino**: Obtenida del parámetro T24T044.USDCREDITAACCTNO
- **Validación FCY**: Control de límites de divisas

#### Políticas OSB
- **Logging**: Habilitado (nivel debug)
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado (nivel normal)
- **Pipeline Alerting**: Habilitado (nivel normal)

#### Handlers y Procesamiento
- **Error Handler**: Manejo centralizado de errores con códigos MW-xxxx
- **Validation Handler**: Validación de préstamos migrados + FCY
- **Transaction Handler**: Registro en base de datos local
- **FCY Handler**: Validaciones específicas de divisas

#### Configuración de Base de Datos
- **Servidor**: ORA_BANK
- **Esquema Principal**: OSB_K_PAGO_PRESTAMO
- **Stored Procedures**:
  - `consultarPtmoMigrado`: Validación de préstamos
  - `pagoPrestamo`: Registro de transacciones
  - `obtenerParametrizacion`: Configuración de parámetros
  - `validarLimitesFCY`: Validación límites divisas

#### Transformaciones XQuery
- **Input**: `DepositoEfectivoMonedaExtranjeraIn.xq`
- **Output**: `PagoPrestamoCajaOut.xq`
- **Header**: `PagoPrestamoCajaHeaderOut.xq`
- **Validation**: `PagoPrestamoCajaValidacionIn.xq`

#### Servicios T24 Específicos
- **Operación**: `Depositoefecenmonedaextranjera`
- **Tipo**: `TELLERFICOHNANYCASHINFCYType`
- **Campos Clave**:
  - `CASHCURRENCY`: "USD"
  - `AMOUNTFOREING`: Monto en USD
  - `ACCOUNT`: Cuenta contable destino
  - `LRFICODEPOSIT`: "PAGO DE PRESTAMO"
  - `NARRATIVE`: "PTM-{LOAN_NUMBER}"

#### Manejo de Errores Específicos
```xml
<!-- Estructura de error para HN01 FCY -->
<aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messages>FCY LIMIT EXCEEDED</messages>
</aut:ResponseHeader>
```

#### Códigos de Error Regionales
- **MW-HN01-004**: Error específico de validación USD
- **MW-HN01-005**: Cuenta contable USD no configurada
- **MW-HN01-006**: Límite de divisas excedido
- **MW-HN01-007**: Tasa de cambio no disponible

#### Dependencias Externas
1. **T24 Core Banking Honduras**
   - Host: t24hn.ficohsa.com
   - Puerto: 9089
   - Timeout: 30 segundos
   - Módulo FCY habilitado

2. **Oracle Database Honduras**
   - TNS: ORABANK_HN
   - Esquema: OSB_K_PAGO_PRESTAMO
   - Timeout: 15 segundos

3. **Servicios de Configuración**
   - Parámetros centralizados
   - Cuentas contables T24 USD
   - Límites operacionales FCY
   - Tasas de cambio

4. **Módulo de Divisas**
   - Validación límites BCH
   - Control posición FCY
   - Reportes regulatorios

## Diferencias Clave Identificadas

### Configuración Específica HN01
- Moneda exclusiva: USD
- Cuenta contable específica para dólares
- Validaciones regulatorias BCH para divisas
- Límites de efectivo en moneda extranjera
- Control de posición en divisas

### Particularidades Técnicas
- Validación de tasas de cambio
- Control de límites diarios FCY
- Validación con módulo de divisas T24
- Registro especial para operaciones FCY
- Manejo de formularios RTE obligatorios

### Validaciones Regulatorias Adicionales
- **Límites BCH**: Cumplimiento normativa divisas
- **Reporte Automático**: Transacciones > USD 10,000
- **Validación Cliente**: Límites individuales FCY
- **Control Diario**: Límites por sucursal/cajero

## Consideraciones de Migración

### Aspectos Críticos
1. **Configuración de Cuentas**: Verificar parámetro T24T044.USDCREDITAACCTNO
2. **Módulo FCY**: Asegurar disponibilidad del módulo de divisas
3. **Base de Datos**: Migrar esquemas y stored procedures FCY
4. **Validaciones**: Mantener lógica regulatoria específica
5. **Tasas de Cambio**: Configurar fuentes de tasas

### Riesgos Identificados
- Dependencia crítica del módulo FCY de T24
- Validaciones regulatorias complejas
- Sin mecanismo de reintento automático
- Manejo de errores debe considerar aspectos regulatorios
- Requerimientos de auditoría y trazabilidad

### Diferencias vs Moneda Local
- Mayor complejidad regulatoria
- Validaciones adicionales de límites
- Dependencia de tasas de cambio
- Reportes automáticos requeridos
- Controles de posición en divisas