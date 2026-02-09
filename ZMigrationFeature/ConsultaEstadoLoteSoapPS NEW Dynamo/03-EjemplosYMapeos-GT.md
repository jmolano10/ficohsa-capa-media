# Ejemplos de Request/Response y Mapeo de Datos - Guatemala (GT01)

## Nota Importante

Según el análisis del código fuente, **Guatemala (GT01) comparte exactamente la misma lógica, transformaciones y mapeos que Honduras (HN01)**.

La única diferencia es el valor del campo `SourceBank` en el header del request, que debe ser `GT01` o cualquier valor que contenga `GT`.

---

## 1. Request OSB Virtual 11g (Entrada del Cliente)

### 1.1. Ejemplo Request SOAP Completo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_guatemala</UserName>
            <Password>password123</Password>
         </Authentication>
         <Region>
            <SourceBank>GT01</SourceBank>
            <DestinationBank>GT01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLote>
         <CUSTOMER_ID>12345</CUSTOMER_ID>
         <BANK_BATCH_ID>98765</BANK_BATCH_ID>
         <UPLOAD_DATE>2024-01-15</UPLOAD_DATE>
      </pag:consultaEstadoLote>
   </soapenv:Body>
</soapenv:Envelope>
```

**Endpoint:** `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v11g`

---

## 2. Diferencias Específicas de Guatemala

### 2.1. Campo SourceBank
- **Valor:** `GT01` (en lugar de `HN01`)
- **Validación:** Debe contener `GT` para ser reconocido como Guatemala

### 2.2. Moneda Principal
- **Moneda:** GTQ (Quetzal Guatemalteco)
- **Ejemplo en Response:**
```xml
<CURRENCY>GTQ</CURRENCY>
```

### 2.3. URL del Servicio Country
- **URL Base:** `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2`
- **URL Específica:** Obtenida dinámicamente del servicio de regionalización según `DestinationBank=GT01`

---

## 3. Mapeos y Transformaciones

**Todas las transformaciones son idénticas a Honduras:**

- **Input:** `Virtual11gToGetBatchStatus.xqy`
- **Output Header:** `GetBatchStatusToVirtual11gHeaderHN.xqy`
- **Output Body:** `GetBatchStatusToVirtual11gBodyHN.xqy`

**Referencia:** Ver [03-EjemplosYMapeos-HN.md](03-EjemplosYMapeos-HN.md) para detalles completos de mapeos.

---

## 4. Ejemplo de Response Específico de Guatemala

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messageId></messageId>
         <messages></messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLoteResponse>
         <BANK_BATCH_ID>98765</BANK_BATCH_ID>
         <CUSTOMER_ID>12345</CUSTOMER_ID>
         <CUSTOMER_NAME>Empresa XYZ Guatemala S.A.</CUSTOMER_NAME>
         <STATUS>PROCESSED</STATUS>
         <STATUS_DESC>Procesado correctamente</STATUS_DESC>
         <OPTIMISTIC>YES</OPTIMISTIC>
         <ACCOUNTS>
            <ACCOUNT>
               <DEBIT_ACCOUNT>1234567890</DEBIT_ACCOUNT>
               <AMOUNT>50000.00</AMOUNT>
               <CURRENCY>GTQ</CURRENCY>
            </ACCOUNT>
         </ACCOUNTS>
         <PAYMENTS>
            <PAYMENT>
               <CURRENCY>GTQ</CURRENCY>
               <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>1.00</EXCHANGE_RATE>
            </PAYMENT>
         </PAYMENTS>
         <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
         <TOTAL_AMOUNT_ERROR>500.00</TOTAL_AMOUNT_ERROR>
         <NUMBER_OF_TRANSACTIONS>100</NUMBER_OF_TRANSACTIONS>
         <NUMBER_OF_TRANSACTIONS_SUCCESS>98</NUMBER_OF_TRANSACTIONS_SUCCESS>
         <NUMBER_OF_TRANSACTIONS_ERROR>2</NUMBER_OF_TRANSACTIONS_ERROR>
         <APPLICATION_DATE>2024-01-15T10:30:00</APPLICATION_DATE>
         <PROCESS_INFO>Lote procesado correctamente en Guatemala</PROCESS_INFO>
      </pag:consultaEstadoLoteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## 5. Reglas de Negocio Específicas

Las reglas de negocio son idénticas a Honduras, con las siguientes consideraciones:

1. **Región por Defecto:** Si no se especifica `SourceBank`, se asume `HN01` (no `GT01`)
2. **Validación de Región:** El código debe contener `GT` para ser reconocido como Guatemala
3. **Enrutamiento:** El servicio de regionalización determina la URL específica del servicio Country de Guatemala

---

## 6. Notas Adicionales para Guatemala

1. **Moneda Principal:** GTQ (Quetzal Guatemalteco)
2. **Código de País:** GT01
3. **Zona Horaria:** GMT-6 (Central Standard Time)
4. **Formato de Cuenta:** Depende de la implementación del servicio Country de Guatemala
5. **Diferencias Reales:** Las diferencias específicas de Guatemala están en la capa Country (v2), no en Virtual 11g o Regional v2

---

## Referencia Completa

Para detalles completos de mapeos, transformaciones y reglas de negocio, consultar:
- [03-EjemplosYMapeos-HN.md](03-EjemplosYMapeos-HN.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)
