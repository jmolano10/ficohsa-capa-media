# Comparativa entre Regiones - Depositoenefectivofase11

## Tabla de Comparación

| Aspecto | HN01 (Honduras) |
|---------|-----------------|
| **Endpoint OSB** | /MiddlewareCaja/PagoPrestamoCaja |
| **Nombre de Base de Datos** | ORA_BANK |
| **Esquemas** | OSB_K_PAGO_PRESTAMO |
| **Store Procedure** | pagoPrestamo |
| **Nombre de Conexión a Base de datos** | ORA_BANK/OSB_K_PAGO_PRESTAMO/TOPLEVEL-24OSB_PAG_PRESTAMO_CAJ |
| **Transformaciones clave** | DepositoEfectivoMonedaLocalIn.xq |
| **Campos diferenciadores** | CASHCURRENCY: HNL, DepositAmount, CreditAccount |
| **Errores/Excepciones** | CURRENCY LOAN NOT SUPPORTED, ERROR IN T24 OPERATION |
| **Timeouts/Retrys** | 30s T24, 15s DB, Sin reintentos |
| **Dependencias internas** | T24 Core Banking, Oracle Database |
| **Moneda Soportada** | HNL (Lempira Hondureña) |
| **Cuenta Contable** | T24T043.HNLCREDITAACCTNO |
| **Tipo Transacción T24** | TELLERFICOLCYCASHINType |
| **Validaciones Regulatorias** | Límites locales BCH |

## Detalles por Región

### HN01 - Honduras

#### Endpoints y Configuración
- **URL Base**: `/MiddlewareCaja/PagoPrestamoCaja`
- **Operación SOAP**: `pagoPrestamo`
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/pagoPrestamoPS/`

#### Mapeos y Validaciones
- **Validación de Moneda**: Solo acepta préstamos en HNL
- **Tipo de Pago**: Exclusivamente "CASH"
- **Cuenta Destino**: Obtenida del parámetro T24T043.HNLCREDITAACCTNO

#### Políticas OSB
- **Logging**: Habilitado (nivel debug)
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado (nivel normal)
- **Pipeline Alerting**: Habilitado (nivel normal)

#### Handlers y Procesamiento
- **Error Handler**: Manejo centralizado de errores con códigos MW-xxxx
- **Validation Handler**: Validación de préstamos migrados
- **Transaction Handler**: Registro en base de datos local

#### Configuración de Base de Datos
- **Servidor**: ORA_BANK
- **Esquema Principal**: OSB_K_PAGO_PRESTAMO
- **Stored Procedures**:
  - `consultarPtmoMigrado`: Validación de préstamos
  - `pagoPrestamo`: Registro de transacciones
  - `obtenerParametrizacion`: Configuración de parámetros

#### Transformaciones XQuery
- **Input**: `DepositoEfectivoMonedaLocalIn.xq`
- **Output**: `PagoPrestamoCajaOut.xq`
- **Header**: `PagoPrestamoCajaHeaderOut.xq`
- **Validation**: `PagoPrestamoCajaValidacionIn.xq`

#### Servicios T24 Específicos
- **Operación**: `Depositoefecenmonedalocal`
- **Tipo**: `TELLERFICOLCYCASHINType`
- **Campos Clave**:
  - `DepositAmount`: Monto en HNL
  - `CreditAccount`: Cuenta contable destino
  - `LRFICODEPOSIT`: "PAGO DE PRESTAMO"
  - `Narrative`: "PTM-{LOAN_NUMBER}"

#### Manejo de Errores Específicos
```xml
<!-- Estructura de error para HN01 -->
<aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messages>CURRENCY LOAN NOT SUPPORTED</messages>
</aut:ResponseHeader>
```

#### Códigos de Error Regionales
- **MW-HN01-001**: Error específico de validación HNL
- **MW-HN01-002**: Cuenta contable HNL no configurada
- **MW-HN01-003**: Límite de efectivo HNL excedido

#### Dependencias Externas
1. **T24 Core Banking Honduras**
   - Host: t24hn.ficohsa.com
   - Puerto: 9089
   - Timeout: 30 segundos

2. **Oracle Database Honduras**
   - TNS: ORABANK_HN
   - Esquema: OSB_K_PAGO_PRESTAMO
   - Timeout: 15 segundos

3. **Servicios de Configuración**
   - Parámetros centralizados
   - Cuentas contables T24
   - Límites operacionales

## Diferencias Clave Identificadas

### Configuración Específica HN01
- Moneda exclusiva: HNL
- Cuenta contable específica para lempiras
- Validaciones regulatorias BCH
- Límites de efectivo locales

### Particularidades Técnicas
- Sin conversión de moneda requerida
- Validación directa con T24 Honduras
- Registro local en base de datos OSB
- Manejo de formularios RTE opcionales

## Consideraciones de Migración

### Aspectos Críticos
1. **Configuración de Cuentas**: Verificar parámetro T24T043.HNLCREDITAACCTNO
2. **Conectividad T24**: Asegurar disponibilidad del core banking
3. **Base de Datos**: Migrar esquemas y stored procedures
4. **Validaciones**: Mantener lógica de negocio específica

### Riesgos Identificados
- Dependencia crítica de parámetros de configuración
- Sin mecanismo de reintento automático
- Manejo de errores centralizado puede generar cuellos de botella