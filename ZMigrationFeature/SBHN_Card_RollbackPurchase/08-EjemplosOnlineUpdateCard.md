# 08 - Ejemplos de Request y Response - OnlineUpdateCard

## Funcionalidad: SBHN_Card_RollbackPurchase - Operación OnlineUpdateCard

Este documento contiene ejemplos de mensajes SOAP para la operación **OnlineUpdateCard** del servicio **OnlineTransactions_v4** (Vision+).

---

## 1. Definición de la Operación

### 1.1 Endpoint
```
URL: http://SRVMSBROCKER:7802/OTWS/v4
Operación: OnlineUpdateCard
Namespace: http://www.procesa.com/fdcs/ot
```

### 1.2 Estructura del Request (t_OnlineUpdateCardRequest)

| Campo | Tipo | Obligatorio | Descripción |
|-------|------|-------------|-------------|
| RequestType | string (enum) | Sí | Tipo de actualización: "B" (Block) o "M" (Modify/Unblock) |
| CardNumber | string | Sí | Número de tarjeta de crédito |
| OrgId | int | Sí | Identificador de la organización |
| MerchantNumber | int | Sí | Número del comercio |
| UpdateValue | string | Sí | Valor de actualización (depende del RequestType) |

### 1.3 Estructura del Response (t_OnlineUpdateCardResponse)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| UpdateResponseCode | int | Código numérico de respuesta (0 = éxito) |
| UpdateResponseDescription | string | Descripción textual del resultado |

---

## 2. Ejemplos de Request

### 2.1 Request con RequestType = "B" (Block - Bloquear)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardRequest>
         <RequestType>B</RequestType>
         <CardNumber>4111111111111111</CardNumber>
         <OrgId>1</OrgId>
         <MerchantNumber>123456</MerchantNumber>
         <UpdateValue>BLOCK_CARD</UpdateValue>
      </ot:OnlineUpdateCardRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

**Descripción**: Solicitud para bloquear una tarjeta de crédito.

**Campos Clave**:
- `RequestType`: "B" indica operación de bloqueo
- `CardNumber`: Número de tarjeta a bloquear
- `UpdateValue`: Valor que indica el tipo de bloqueo (ej: "BLOCK_CARD", "BLOCK_FUNDS")

---

### 2.2 Request con RequestType = "M" (Modify/Unblock - Modificar/Desbloquear)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardRequest>
         <RequestType>M</RequestType>
         <CardNumber>4111111111111111</CardNumber>
         <OrgId>1</OrgId>
         <MerchantNumber>123456</MerchantNumber>
         <UpdateValue>UNBLOCK_CARD</UpdateValue>
      </ot:OnlineUpdateCardRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

**Descripción**: Solicitud para desbloquear o modificar el estado de una tarjeta de crédito.

**Campos Clave**:
- `RequestType`: "M" indica operación de modificación/desbloqueo
- `UpdateValue`: Valor que indica el tipo de modificación (ej: "UNBLOCK_CARD", "MODIFY_LIMIT")

---

### 2.3 Request para Reversa de Transacción (Uso en RollbackPurchase)

⚠️ **Nota**: Este es el uso actual en el servicio RollbackPurchase, aunque presenta inconsistencias.

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardRequest>
         <RequestType>M</RequestType>
         <CardNumber>4111111111111111</CardNumber>
         <OrgId>1</OrgId>
         <MerchantNumber>123456</MerchantNumber>
         <UpdateValue>REVERSE_TRANSACTION</UpdateValue>
      </ot:OnlineUpdateCardRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

**Descripción**: Solicitud para reversar una transacción (liberando fondos bloqueados).

**Observación**: El servicio RollbackPurchase debería usar `OnlinePaymentV4` con RequestType="R" en lugar de OnlineUpdateCard para reversas de transacciones.

---

## 3. Ejemplos de Response

### 3.1 Response Exitoso (Operación Aprobada)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardResponse>
         <UpdateResponseCode>0</UpdateResponseCode>
         <UpdateResponseDescription>APPROVED</UpdateResponseDescription>
      </ot:OnlineUpdateCardResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

**Interpretación**:
- `UpdateResponseCode = 0`: Operación exitosa
- `UpdateResponseDescription = "APPROVED"`: Actualización aprobada
- **Código HTTP Equivalente**: 200 OK

---

### 3.2 Response con Error de Validación (Tarjeta Inválida)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardResponse>
         <UpdateResponseCode>100</UpdateResponseCode>
         <UpdateResponseDescription>INVALID_CARD</UpdateResponseDescription>
      </ot:OnlineUpdateCardResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

**Interpretación**:
- `UpdateResponseCode = 100`: Error de validación de tarjeta
- `UpdateResponseDescription = "INVALID_CARD"`: Número de tarjeta inválido
- **Código HTTP Equivalente**: 400 Bad Request

---

### 3.3 Response con Error de Negocio (Tarjeta Bloqueada)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardResponse>
         <UpdateResponseCode>102</UpdateResponseCode>
         <UpdateResponseDescription>CARD_BLOCKED</UpdateResponseDescription>
      </ot:OnlineUpdateCardResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

**Interpretación**:
- `UpdateResponseCode = 102`: Tarjeta bloqueada
- `UpdateResponseDescription = "CARD_BLOCKED"`: No se puede procesar porque la tarjeta está bloqueada
- **Código HTTP Equivalente**: 403 Forbidden

---

### 3.4 Response con Error de Conflicto (Ya Reversada)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardResponse>
         <UpdateResponseCode>301</UpdateResponseCode>
         <UpdateResponseDescription>ALREADY_REVERSED</UpdateResponseDescription>
      </ot:OnlineUpdateCardResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

**Interpretación**:
- `UpdateResponseCode = 301`: Conflicto de estado
- `UpdateResponseDescription = "ALREADY_REVERSED"`: La transacción ya fue reversada previamente
- **Código HTTP Equivalente**: 409 Conflict

---

### 3.5 Response con Error de Sistema (Vision+)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardResponse>
         <UpdateResponseCode>500</UpdateResponseCode>
         <UpdateResponseDescription>SYSTEM_ERROR</UpdateResponseDescription>
      </ot:OnlineUpdateCardResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

**Interpretación**:
- `UpdateResponseCode = 500`: Error interno del sistema
- `UpdateResponseDescription = "SYSTEM_ERROR"`: Error en Vision+
- **Código HTTP Equivalente**: 502 Bad Gateway

---

### 3.6 Response con Timeout

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardResponse>
         <UpdateResponseCode>502</UpdateResponseCode>
         <UpdateResponseDescription>TIMEOUT</UpdateResponseDescription>
      </ot:OnlineUpdateCardResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

**Interpretación**:
- `UpdateResponseCode = 502`: Timeout en procesamiento
- `UpdateResponseDescription = "TIMEOUT"`: La operación excedió el tiempo límite
- **Código HTTP Equivalente**: 504 Gateway Timeout

---

## 4. Ejemplo Completo de Flujo en RollbackPurchase

### 4.1 Contexto
El servicio RollbackPurchase necesita reversar una compra, liberando los fondos bloqueados en la tarjeta.

### 4.2 Request Generado por RollbackPurchaseToOnlinePayment.xqy

**Código XQuery Actual** (con error):
```xquery
<ns2:OnlinePaymentV4Request>
    <POSUserData>ATX</POSUserData>
    <RRN37>4001123456789</RRN37>
    <NumberOfInstallments>00</NumberOfInstallments>
    <MCCType>6010</MCCType>
    <RequestType>R</RequestType>  <!-- INCORRECTO para OnlineUpdateCard -->
    <CardNumber>4111111111111111</CardNumber>
    <OrgId>1</OrgId>
    <MerchantNumber>123456</MerchantNumber>
    <CardExpirationDate>1225</CardExpirationDate>
    <TotalSalesAmount>100.00</TotalSalesAmount>
    <Track2Length>0000</Track2Length>
    <Track2Data>0000</Track2Data>
    <CardValidationValue>000</CardValidationValue>
</ns2:OnlinePaymentV4Request>
```

⚠️ **Problema**: Se está generando un request de tipo `OnlinePaymentV4Request` pero se invoca la operación `OnlineUpdateCard` que espera `OnlineUpdateCardRequest`.

### 4.3 Request Correcto para OnlineUpdateCard

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardRequest>
         <RequestType>M</RequestType>
         <CardNumber>4111111111111111</CardNumber>
         <OrgId>1</OrgId>
         <MerchantNumber>123456</MerchantNumber>
         <UpdateValue>REVERSE_MEMO_DEBIT:100.00:4001123456789</UpdateValue>
      </ot:OnlineUpdateCardRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

**Campos Explicados**:
- `RequestType`: "M" para modificar/liberar fondos
- `UpdateValue`: Formato compuesto con tipo de operación, monto y secuencia

### 4.4 Response Esperado (Éxito)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardResponse>
         <UpdateResponseCode>0</UpdateResponseCode>
         <UpdateResponseDescription>APPROVED</UpdateResponseDescription>
      </ot:OnlineUpdateCardResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### 4.5 Procesamiento en RollbackPurchasePP.pipeline

**Código Actual** (incorrecto):
```xml
<con1:replace varName="ActionDescription">
    <con1:expr>
        <con2:xqueryText>
            fn:string($responseOnlinePayment/ActionDescription/text())
        </con2:xqueryText>
    </con1:expr>
</con1:replace>
```

**Código Correcto** (recomendado):
```xml
<con1:replace varName="UpdateResponseCode">
    <con1:expr>
        <con2:xqueryText>
            fn:string($responseOnlinePayment/UpdateResponseCode/text())
        </con2:xqueryText>
    </con1:expr>
</con1:replace>
<con1:replace varName="UpdateResponseDescription">
    <con1:expr>
        <con2:xqueryText>
            fn:string($responseOnlinePayment/UpdateResponseDescription/text())
        </con2:xqueryText>
    </con1:expr>
</con1:replace>
```

**Validación de Éxito** (recomendado):
```xml
<con1:condition>
    <con2:xqueryText>
        fn:string($UpdateResponseCode) = '0' and 
        fn-bea:trim($UpdateResponseDescription) = 'APPROVED'
    </con2:xqueryText>
</con1:condition>
```

---

## 5. Casos de Prueba Recomendados

### 5.1 Caso de Prueba 1: Reversa Exitosa

**Request**:
```xml
<RequestType>M</RequestType>
<CardNumber>4111111111111111</CardNumber>
<OrgId>1</OrgId>
<MerchantNumber>123456</MerchantNumber>
<UpdateValue>REVERSE_MEMO_DEBIT:50.00:4001123456789</UpdateValue>
```

**Response Esperado**:
```xml
<UpdateResponseCode>0</UpdateResponseCode>
<UpdateResponseDescription>APPROVED</UpdateResponseDescription>
```

**Resultado**: ✅ Reversa exitosa, fondos liberados

---

### 5.2 Caso de Prueba 2: Tarjeta No Encontrada

**Request**:
```xml
<RequestType>M</RequestType>
<CardNumber>9999999999999999</CardNumber>
<OrgId>1</OrgId>
<MerchantNumber>123456</MerchantNumber>
<UpdateValue>REVERSE_MEMO_DEBIT:50.00:4001123456789</UpdateValue>
```

**Response Esperado**:
```xml
<UpdateResponseCode>103</UpdateResponseCode>
<UpdateResponseDescription>CARD_NOT_FOUND</UpdateResponseDescription>
```

**Resultado**: ❌ Error 404 - Tarjeta no existe en el sistema

---

### 5.3 Caso de Prueba 3: Transacción Ya Reversada

**Request**:
```xml
<RequestType>M</RequestType>
<CardNumber>4111111111111111</CardNumber>
<OrgId>1</OrgId>
<MerchantNumber>123456</MerchantNumber>
<UpdateValue>REVERSE_MEMO_DEBIT:50.00:4001123456789</UpdateValue>
```

**Response Esperado**:
```xml
<UpdateResponseCode>301</UpdateResponseCode>
<UpdateResponseDescription>ALREADY_REVERSED</UpdateResponseDescription>
```

**Resultado**: ❌ Error 409 - Conflicto, transacción ya reversada

---

### 5.4 Caso de Prueba 4: Tarjeta Bloqueada

**Request**:
```xml
<RequestType>M</RequestType>
<CardNumber>4111111111111111</CardNumber>
<OrgId>1</OrgId>
<MerchantNumber>123456</MerchantNumber>
<UpdateValue>REVERSE_MEMO_DEBIT:50.00:4001123456789</UpdateValue>
```

**Response Esperado**:
```xml
<UpdateResponseCode>102</UpdateResponseCode>
<UpdateResponseDescription>CARD_BLOCKED</UpdateResponseDescription>
```

**Resultado**: ❌ Error 403 - Tarjeta bloqueada, no se puede procesar

---

### 5.5 Caso de Prueba 5: Error de Sistema

**Request**:
```xml
<RequestType>M</RequestType>
<CardNumber>4111111111111111</CardNumber>
<OrgId>1</OrgId>
<MerchantNumber>123456</MerchantNumber>
<UpdateValue>REVERSE_MEMO_DEBIT:50.00:4001123456789</UpdateValue>
```

**Response Esperado**:
```xml
<UpdateResponseCode>500</UpdateResponseCode>
<UpdateResponseDescription>SYSTEM_ERROR</UpdateResponseDescription>
```

**Resultado**: ❌ Error 502 - Error en Vision+, reintentar

---

## 6. Diferencias entre OnlineUpdateCard y OnlinePaymentV4

### 6.1 Comparación de Estructuras

| Aspecto | OnlineUpdateCard | OnlinePaymentV4 |
|---------|------------------|-----------------|
| **Propósito** | Actualizar estado de tarjeta/fondos | Procesar pagos/reversas |
| **RequestType** | B, M | C, A, R, P |
| **Campos Request** | 5 campos básicos | 14 campos detallados |
| **Campos Response** | 2 campos | 8 campos |
| **Uso en Reversa** | Liberar fondos bloqueados | Reversar transacción completa |
| **Complejidad** | Baja | Alta |

### 6.2 Cuándo Usar Cada Operación

**OnlineUpdateCard**:
- ✅ Bloquear/desbloquear tarjeta
- ✅ Liberar fondos bloqueados (memo debit)
- ✅ Modificar límites temporales
- ✅ Operaciones de estado de tarjeta

**OnlinePaymentV4**:
- ✅ Procesar compras (RequestType=A)
- ✅ Reversar transacciones completas (RequestType=R)
- ✅ Consultar disponibilidad (RequestType=C)
- ✅ Pre-autorización (RequestType=P)

---

## 7. Recomendaciones de Implementación

### 7.1 Para el Servicio RollbackPurchase

1. **Evaluar el uso correcto de la operación**:
   - Si solo se necesita liberar fondos → Usar `OnlineUpdateCard`
   - Si se necesita reversar la transacción completa → Usar `OnlinePaymentV4` con RequestType="R"

2. **Corregir la transformación XQuery**:
   - Generar request correcto según la operación elegida
   - Usar campos correctos en el response

3. **Implementar validación robusta**:
   - Validar `UpdateResponseCode = 0` para éxito
   - Mapear códigos de error a HTTP status apropiados

### 7.2 Manejo de Errores

```xquery
let $responseCode := fn:string($responseOnlinePayment/UpdateResponseCode/text())
let $responseDesc := fn:string($responseOnlinePayment/UpdateResponseDescription/text())
return
  if ($responseCode = '0' and $responseDesc = 'APPROVED') then
    'SUCCESS'
  else if ($responseCode = '301') then
    'ALREADY_REVERSED'
  else if (fn:starts-with($responseCode, '1') or fn:starts-with($responseCode, '2') or fn:starts-with($responseCode, '4')) then
    'VALIDATION_ERROR'
  else if (fn:starts-with($responseCode, '3')) then
    'BUSINESS_ERROR'
  else if (fn:starts-with($responseCode, '5')) then
    'SYSTEM_ERROR'
  else
    'UNKNOWN_ERROR'
```

---

## 8. Herramientas de Prueba

### 8.1 SoapUI - Configuración

**Endpoint**: `http://SRVMSBROCKER:7802/OTWS/v4`

**Headers**:
```
Content-Type: text/xml;charset=UTF-8
SOAPAction: ""
```

### 8.2 Postman - Configuración

**Method**: POST  
**URL**: `http://SRVMSBROCKER:7802/OTWS/v4`

**Headers**:
```
Content-Type: text/xml
SOAPAction: ""
```

**Body** (raw XML):
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:ot="http://www.procesa.com/fdcs/ot">
   <soapenv:Header/>
   <soapenv:Body>
      <ot:OnlineUpdateCardRequest>
         <RequestType>M</RequestType>
         <CardNumber>{{cardNumber}}</CardNumber>
         <OrgId>{{orgId}}</OrgId>
         <MerchantNumber>{{merchantNumber}}</MerchantNumber>
         <UpdateValue>{{updateValue}}</UpdateValue>
      </ot:OnlineUpdateCardRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

---

**Última actualización**: 2024-01-15  
**Autor**: Análisis basado en OnlineTransactions_v4.wsdl  
**Versión**: 1.0
