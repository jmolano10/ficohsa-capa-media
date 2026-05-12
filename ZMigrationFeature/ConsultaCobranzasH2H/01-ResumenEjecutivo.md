# Resumen Ejecutivo — ConsultaCobranzasH2H

## Índice de Documentos

- [02-ComparativaRegiones.md](./02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](./03-EjemplosYMapeos-HN01.md)
- [06-ListadoFicheros.md](./06-ListadoFicheros.md)
- [07-ListadoXQ.md](./07-ListadoXQ.md)

---

## Propósito de la Funcionalidad

**ConsultaCobranzasH2H** es un servicio SOAP expuesto a través de Oracle Service Bus (OSB) que permite a clientes Host-to-Host (H2H) consultar el estado de cobranzas (facturas/deudas) asociadas a servicios de recaudo. El servicio recibe un identificador de cliente y una lista de servicios con deudores, y retorna las facturas pendientes con sus montos, fechas y recibos.

El proxy es invocado internamente por el proxy padre **CobranzasH2H** (operación `consulta`), el cual actúa como fachada para las operaciones de consulta, pago y consulta de recibo.

## Entradas y Salidas Principales

### Entrada (Request)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `CUSTOMER_ID` | string (min 1) | Identificador del cliente H2H |
| `SERVICES/SERVICE/ID` | string (min 1) | ID del servicio de recaudo |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/CODE` | string (min 1) | Código del deudor |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/CURRENCY` | string | Moneda (opcional) |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/RETURN_TYPE` | enum (ALL/ONE) | Tipo de retorno |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/EXTENDED_COLLECTION` | enum (Y/N) | Cobranza extendida |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/TRACE` | string | Trazabilidad (opcional) |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/ADDITIONAL_INFO/INFO` | array | Info adicional (FIELD_NAME/FIELD_VALUE) |

### Salida (Response)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `SERVICES/SERVICE/SUCCESS_INDICATOR` | string | Indicador de éxito por servicio |
| `SERVICES/SERVICE/ERROR_MESSAGE` | string | Mensaje de error por servicio |
| `SERVICES/SERVICE/ID` | string | ID del servicio |
| `SERVICES/SERVICE/NAME` | string | Nombre del servicio |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/CODE` | string | Código del deudor |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/BILLS/BILL/ID` | string | ID de factura |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/BILLS/BILL/ISSUE_DATE` | date | Fecha emisión |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/BILLS/BILL/DUE_DATE` | date | Fecha vencimiento |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/BILLS/BILL/BALANCES/BALANCE` | complex | CURRENCY, AMOUNT, LATE_FEE, TOTAL |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/DEALSLIP` | string | Recibo/comprobante (HTML para serviceId=9) |

## Sistemas/Servicios OSB Involucrados

| Componente | Tipo | Función |
|------------|------|---------|
| `CobranzasH2H` | Proxy (padre) | Fachada: autenticación, bitácora, enrutamiento por operación |
| `ConsultaCobranzasH2H` | Proxy (hijo) | Lógica de consulta de cobranzas |
| `validaServicioRegional_db` | Business Service (DB) | Valida que el servicio esté habilitado para la región |
| `validaAccesoH2H_db` | Business Service (DB) | Valida acceso del usuario/cliente a operaciones H2H |
| `obtenerParametrizacion` | Business Service (DB) | Obtiene parámetro MAXAGREEMENTS por región |
| `consultaPeticionesDisponiblesH2H_db` | Business Service (DB) | Valida cuota de peticiones diarias del usuario |
| `consultaConveniosH2H_db` | Business Service (DB) | Obtiene convenios asociados a los servicios solicitados |
| `sjConsultaCobranzasH2H` | Business Service (Split-Join) | Ejecuta consulta masiva de cobranzas en paralelo |
| `actualizaPeticionesDisponiblesH2H_db` | Business Service (DB) | Actualiza contador de peticiones exitosas/erróneas |
| `mapeoErrores` | Business Service (OSB) | Mapea códigos de error internos a respuesta estándar |
| `registrarBitacoraH2H_db` | Business Service (DB) | Registra bitácora de request/response (en proxy padre) |

## Regiones Detectadas

| Código | País | Estado |
|--------|------|--------|
| HN01 | Honduras | **Implementado** |
| GT01 | Guatemala | Parcial (solo parametrización MAXAGREEMENTS.GT) |
| PA01 | Panamá | No implementado (default → error MW-0008) |
| NI01 | Nicaragua | No implementado (default → error MW-0008) |

## Riesgos/Limitaciones Conocidas

1. **Región única funcional**: Solo HN01 tiene implementación completa. GT01 tiene parametrización de MAXAGREEMENTS pero cae al default en el branch de regionalización del proxy hijo.
2. **Cuota de peticiones**: El sistema limita peticiones diarias por usuario. Si falla la actualización de peticiones, se hace `resume` (no bloquea la respuesta).
3. **Parametrización por defecto**: Si falla la obtención de MAXAGREEMENTS, se usa valor por defecto de 10.
4. **Transformación HTML**: Para serviceId=9, el DEALSLIP se transforma de formato con `[]@` a HTML (`<>"`).
5. **Proxy local**: ConsultaCobranzasH2H usa transporte `local` (no expuesto directamente), solo accesible desde CobranzasH2H.
6. **ServiceId hardcodeado**: El proxy usa `FICBCO0258` como identificador fijo para validaciones regionales y de acceso.

## Métricas o SLAs

- No se encontraron configuraciones explícitas de timeout o retry en el proxy.
- Monitoring está deshabilitado (`isEnabled="false"`).
- Logging habilitado en nivel `debug`.

## Proxies Dependientes

| Proxy | Ruta | Descripción |
|-------|------|-------------|
| CobranzasH2H | `MWHostToHost/v1/ProxyServices/CobranzasH2H.proxy` | Proxy padre (fachada) — ya analizado en este contexto |

> No se detectaron proxies externos adicionales que requieran análisis complementario.
