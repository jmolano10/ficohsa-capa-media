# Contratos de Business Services - RollbackPurchaseRestPS

## Honduras (SBHN)

### 1. DBGetStatusTicketAdapter

**Ruta:** SBHN_Card_RollbackPurchase/BS/DBGetStatusTicketAdapter  
**Tipo:** JCA Database Adapter  
**Conexión:** jca://eis/DB/ConnectionPagosWSTC  
**Stored Procedure:** PAGOSWSTC.OSB_K_RECAUDO_BROKER_HN.OSB_CONS_BROKER_RECAUDO_TICKET

> **Nota:** Este servicio consulta el estado y detalles de un ticket de compra previamente registrado en la base de datos para poder ejecutar el reverso.

#### Input Parameters
| Campo | Tipo | DB Type | Requerido | Descripción |
|-------|------|---------|-----------|-------------|
| PV_TICKET | string | VARCHAR2 | Sí | Número de ticket a consultar |

#### Output Parameters
| Campo | Tipo | DB Type | Descripción |
|-------|------|---------|-------------|
| PV_ESTADO_TICKET | string | VARCHAR2 | Estado del ticket |
| PN_AGENCIAORIGEN | decimal | NUMBER | Agencia origen |
| PV_MERCHANTNUMBER | string | VARCHAR2 | Número de comercio |
| PV_NUMEROTARJETA | string | VARCHAR2 | Número de tarjeta |
| PV_TIPOOPERACION | string | VARCHAR2 | Tipo de operación |
| PN_TIPOMONEDA | decimal | NUMBER | Tipo de moneda |
| PN_ORGANIZACION | decimal | NUMBER | Organización |
| PV_MONEDATRANSACCION | string | VARCHAR2 | Moneda de transacción |
| PN_TASACAMBIO | decimal | NUMBER | Tasa de cambio |
| PN_TIPOTRANSACCION | decimal | NUMBER | Tipo de transacción |
| PV_CODIGOUSUARIO | string | VARCHAR2 | Código de usuario |
| PV_SECUENCIAMOVIMIENTO | string | VARCHAR2 | Secuencia del movimiento |
| PV_SECUENCIAORIGEN | string | VARCHAR2 | Secuencia original |
| PN_VALOREFECTIVO | decimal | NUMBER | Valor efectivo |
| PN_VALORCHEQUES | decimal | NUMBER | Valor de cheques |
| PN_NUMERODOCUMENTO | decimal | NUMBER | Número de documento |
| PD_FECHAVALIDA | string | VARCHAR2 | Fecha válida |
| PN_TIPOCHEQUE | decimal | NUMBER | Tipo de cheque |
| PV_BANCOORIGEN | string | VARCHAR2 | Banco origen |
| PV_BANCODESTINO | string | VARCHAR2 | Banco destino |
| PV_DESCRIPCIONTRANSACCION | string | VARCHAR2 | Descripción de transacción |
| PV_CANAL | string | VARCHAR2 | Canal |
| PV_NUMEROAUTORIZACION | string | VARCHAR2 | Número de autorización |
| PV_APLICADO | string | VARCHAR2 | Aplicado |
| PV_APLICARENLINEA | string | VARCHAR2 | Aplicar en línea |
| PV_FECHAEXPTC | string | VARCHAR2 | Fecha expiración TC |
| PV_SUCCESSINDICATOR | string | VARCHAR2 | SUCCESS=éxito, otro=error |
| PV_MESSAGES | string | VARCHAR2 | Mensaje descriptivo |

---

### 2. onlineTransactions_v4

**Ruta:** SBHN_Card_RollbackPurchase/BS/onlineTransactions_v4  
**Tipo:** SOAP Service  
**Endpoint:** http://[ENDPOINT_VISION_PLUS_HN]:7802/OTWS/v4  
**Operación:** OnlineUpdateCard  
**Timeout:** 70 segundos  
**Connection Timeout:** 65 segundos

> **Nota:** Este servicio ejecuta el reverso de la transacción en Vision+. Honduras usa la operación OnlineUpdateCard mientras que Guatemala usa OnlinePaymentV4. La operación OnlinePaymentV4 también se usa en PurchaseCreditCard, pero OnlineUpdateCard es específica de RollbackPurchase en Honduras.

#### Input Parameters (OnlineUpdateCardRequest)
| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| POSUserData | string | Sí | Datos de usuario POS |
| RRN37 | string | No | Número de referencia (default: ' ') |
| VPrespCode | string | No | Código de respuesta VP (default: ' ') |
| NumberOfInstallments | int | No | Número de cuotas (default: 0) |
| PaymentTypeIndicator | string | No | Indicador tipo de pago (default: ' ') |
| MCCType | string | No | Tipo MCC (default: ' ') |
| RequestType | string | Sí | Tipo de request: **'R'** (Reverso) |
| CardNumber | string | Sí | Número de tarjeta |
| OrgId | int | Sí | ID de organización |
| MerchantNumber | int | Sí | Número de comercio |
| CardExpirationDate | int | Sí | Fecha de expiración |
| TotalSalesAmount | decimal | Sí | Monto total a reversar |
| Track2Length | int | Sí | Longitud de Track2 |
| Track2Data | string | Sí | Datos de Track2 |
| CardValidationValue | int | Sí | Valor de validación |
| SequenceValue | string | Sí | Secuencia del movimiento original |

#### Output Parameters (OnlineUpdateCardResponse)
| Campo | Tipo | Descripción |
|-------|------|-------------|
| POSUserData | string | Datos de usuario POS |
| RRN37 | string | Número de referencia |
| VPrespCode | string | Código de respuesta VP |
| SystemAction | string | Acción del sistema (A/D) |
| ReasonActionCode | int | Código de razón |
| ActionDescription | string | Descripción: **APPROVED**/DECLINED |
| CardValidationResult | string | Resultado de validación |
| AuthorizationCode | string | Código de autorización |

---

### 3. DBActTicketAdapter

**Ruta:** SBHN_Card_RollbackPurchase/BS/DBActTicketAdapter  
**Tipo:** JCA Database Adapter  
**Conexión:** jca://eis/DB/ConnectionPagosWSTC  
**Stored Procedure:** PAGOSWSTC.OSB_K_RECAUDO_BROKER_HN.OSB_ACT_BROKER_RECAUDO_TICKET

> **Nota:** Este servicio actualiza el estado del ticket a 'R' (Reversado) después de un reverso exitoso. Honduras tiene 2 parámetros de entrada, Guatemala tiene 3 (incluye numeroAutorizacion).

#### Input Parameters
| Campo | Tipo | DB Type | Requerido | Descripción |
|-------|------|---------|-----------|-------------|
| PV_TICKET | string | VARCHAR2 | Sí | Número de ticket |
| PV_ESTADO_TICKET | string | VARCHAR2 | Sí | Estado del ticket: **'R'** (Reversado) |

#### Output Parameters
| Campo | Tipo | DB Type | Descripción |
|-------|------|---------|-------------|
| PV_SUCCESSINDICATOR | string | VARCHAR2 | SUCCESS=éxito, otro=error |
| PV_MESSAGES | string | VARCHAR2 | Mensaje descriptivo |

---

## Guatemala (SBGT)

### 1. DBGetStatusTicketAdapter

**Ruta:** SBGT_Card_RollbackPurchase/BS/DBGetStatusTicketAdapter  
**Tipo:** JCA Database Adapter  
**Conexión:** jca://eis/DB/ConnectionPagosWSTC  
**Stored Procedure:** PAGOSWSTC.OSB_K_RECAUDO_BROKER_GT.OSB_CONS_BROKER_RECAUDO_TICKET

> **Nota:** Este servicio consulta el estado y detalles de un ticket de compra previamente registrado en la base de datos para poder ejecutar el reverso.

#### Input Parameters
| Campo | Tipo | DB Type | Requerido | Descripción |
|-------|------|---------|-----------|-------------|
| PV_TICKET | string | VARCHAR2 | Sí | Número de ticket a consultar |

#### Output Parameters
| Campo | Tipo | DB Type | Descripción |
|-------|------|---------|-------------|
| PV_ESTADO_TICKET | string | VARCHAR2 | Estado del ticket |
| PN_AGENCIAORIGEN | decimal | NUMBER | Agencia origen |
| PV_MERCHANTNUMBER | string | VARCHAR2 | Número de comercio |
| PV_NUMEROTARJETA | string | VARCHAR2 | Número de tarjeta |
| PV_TIPOOPERACION | string | VARCHAR2 | Tipo de operación |
| PN_TIPOMONEDA | decimal | NUMBER | Tipo de moneda |
| PN_ORGANIZACION | decimal | NUMBER | Organización |
| PV_MONEDATRANSACCION | string | VARCHAR2 | Moneda de transacción |
| PN_TASACAMBIO | decimal | NUMBER | Tasa de cambio |
| PN_TIPOTRANSACCION | decimal | NUMBER | Tipo de transacción |
| PV_CODIGOUSUARIO | string | VARCHAR2 | Código de usuario |
| PV_SECUENCIAMOVIMIENTO | string | VARCHAR2 | Secuencia del movimiento |
| PV_SECUENCIAORIGEN | string | VARCHAR2 | Secuencia original |
| PN_VALOREFECTIVO | decimal | NUMBER | Valor efectivo |
| PN_VALORCHEQUES | decimal | NUMBER | Valor de cheques |
| PN_NUMERODOCUMENTO | decimal | NUMBER | Número de documento |
| PD_FECHAVALIDA | string | VARCHAR2 | Fecha válida |
| PN_TIPOCHEQUE | decimal | NUMBER | Tipo de cheque |
| PV_BANCOORIGEN | string | VARCHAR2 | Banco origen |
| PV_BANCODESTINO | string | VARCHAR2 | Banco destino |
| PV_DESCRIPCIONTRANSACCION | string | VARCHAR2 | Descripción de transacción |
| PV_CANAL | string | VARCHAR2 | Canal |
| PV_NUMEROAUTORIZACION | string | VARCHAR2 | Número de autorización |
| PV_APLICADO | string | VARCHAR2 | Aplicado |
| PV_APLICARENLINEA | string | VARCHAR2 | Aplicar en línea |
| PV_FECHAEXPTC | string | VARCHAR2 | Fecha expiración TC |
| PV_SUCCESSINDICATOR | string | VARCHAR2 | SUCCESS=éxito, otro=error |
| PV_MESSAGES | string | VARCHAR2 | Mensaje descriptivo |

---

### 2. onlineTransactions_v4

**Ruta:** SBGT_Card_RollbackPurchase/BS/onlineTransactions_v4  
**Tipo:** SOAP Service  
**Endpoint:** http://[ENDPOINT_VISION_PLUS_GT]:7802/OTWS/v4  
**Operación:** OnlinePaymentV4  
**Timeout:** 70 segundos  
**Connection Timeout:** 65 segundos

> **Nota:** Guatemala usa la operación OnlinePaymentV4 (diferente a Honduras que usa OnlineUpdateCard). El contrato de entrada es el mismo. La operación OnlinePaymentV4 también se usa en PurchaseCreditCard de Guatemala.

#### Input Parameters (OnlinePaymentV4Request)
| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| POSUserData | string | Sí | Datos de usuario POS |
| RRN37 | string | No | Número de referencia (default: ' ') |
| VPrespCode | string | No | Código de respuesta VP (default: ' ') |
| NumberOfInstallments | int | No | Número de cuotas (default: 0) |
| PaymentTypeIndicator | string | No | Indicador tipo de pago (default: ' ') |
| MCCType | string | No | Tipo MCC (default: ' ') |
| RequestType | string | Sí | Tipo de request: **'R'** (Reverso) |
| CardNumber | string | Sí | Número de tarjeta |
| OrgId | int | Sí | ID de organización |
| MerchantNumber | int | Sí | Número de comercio |
| CardExpirationDate | int | Sí | Fecha de expiración |
| TotalSalesAmount | decimal | Sí | Monto total a reversar |
| Track2Length | int | Sí | Longitud de Track2 |
| Track2Data | string | Sí | Datos de Track2 |
| CardValidationValue | int | Sí | Valor de validación |
| SequenceValue | string | Sí | Secuencia del movimiento original |

#### Output Parameters (OnlinePaymentV4Response)
| Campo | Tipo | Descripción |
|-------|------|-------------|
| POSUserData | string | Datos de usuario POS |
| RRN37 | string | Número de referencia |
| VPrespCode | string | Código de respuesta VP |
| SystemAction | string | Acción del sistema (A/D) |
| ReasonActionCode | int | Código de razón |
| ActionDescription | string | Descripción: **APPROVED**/DECLINED |
| CardValidationResult | string | Resultado de validación |
| AuthorizationCode | string | Código de autorización |

---

### 3. DBActTicketAdapter

**Ruta:** SBGT_Card_RollbackPurchase/BS/DBActTicketAdapter  
**Tipo:** JCA Database Adapter  
**Conexión:** jca://eis/DB/ConnectionPagosWSTC  
**Stored Procedure:** PAGOSWSTC.OSB_K_RECAUDO_BROKER_GT.OSB_ACT_BROKER_RECAUDO_TICKET

> **Nota:** Guatemala tiene un parámetro adicional (PV_NUMEROAUTORIZACION) comparado con Honduras que solo tiene 2 parámetros de entrada.

#### Input Parameters
| Campo | Tipo | DB Type | Requerido | Descripción |
|-------|------|---------|-----------|-------------|
| PV_TICKET | string | VARCHAR2 | Sí | Número de ticket |
| PV_ESTADO_TICKET | string | VARCHAR2 | Sí | Estado del ticket: **'R'** (Reversado) |
| PV_NUMEROAUTORIZACION | string | VARCHAR2 | Sí | Número de autorización de Vision+ |

#### Output Parameters
| Campo | Tipo | DB Type | Descripción |
|-------|------|---------|-------------|
| PV_SUCCESSINDICATOR | string | VARCHAR2 | SUCCESS=éxito, otro=error |
| PV_MESSAGES | string | VARCHAR2 | Mensaje descriptivo |

---

## Notas Importantes

> **Referencia:** Las secciones "Valores de Estado de Ticket" y "Códigos de Respuesta Comunes" son compartidas con PurchaseCreditCardRestPS ya que ambos servicios usan la misma infraestructura de tickets y Vision+.

### Diferencias entre Honduras y Guatemala

**Operación Vision+:**
- **Honduras:** OnlineUpdateCard
- **Guatemala:** OnlinePaymentV4

**DBActTicketAdapter:**
- **Honduras:** Solo recibe PV_TICKET y PV_ESTADO_TICKET (2 parámetros)
- **Guatemala:** Recibe PV_TICKET, PV_ESTADO_TICKET y PV_NUMEROAUTORIZACION (3 parámetros)

**Stored Procedures:**
- **Honduras:** OSB_K_RECAUDO_BROKER_HN
- **Guatemala:** OSB_K_RECAUDO_BROKER_GT

**Conexiones JCA:**
- Ambos países usan ConnectionPagosWSTC para los adaptadores de base de datos

### Valores de Estado de Ticket
- **P:** Pendiente (estado inicial al registrar)
- **A:** Aprobado (después de compra exitosa)
- **R:** Reversado (después de reverso exitoso)
- **E:** Error (después de operación rechazada)

### Códigos de Respuesta Comunes
- **SUCCESS:** Operación exitosa en base de datos
- **APPROVED:** Reverso aprobado en Vision+
- **DECLINED:** Reverso rechazado en Vision+

### RequestType en Vision+
- **C:** Compra (Purchase)
- **A:** Anulación (Void)
- **R:** Reverso (Reversal) - **Usado en este servicio**
- **P:** Pre-autorización

### Flujo de Datos

**Honduras:**
1. DBGetStatusTicketAdapter → Obtiene datos del ticket
2. onlineTransactions_v4 (OnlineUpdateCard) → Ejecuta reverso con RequestType='R'
3. DBActTicketAdapter → Actualiza estado a 'R'

**Guatemala:**
1. DBGetStatusTicketAdapter → Obtiene datos del ticket
2. onlineTransactions_v4 (OnlinePaymentV4) → Ejecuta reverso con RequestType='R'
3. DBActTicketAdapter → Actualiza estado a 'R' + numeroAutorizacion
