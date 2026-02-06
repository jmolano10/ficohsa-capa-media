# Ejemplos y Mapeos - PA01 (Panamá)

## Nota Importante

La implementación de PA01 es **idéntica** a GT01 en estructura y flujo. Las únicas diferencias son:

1. **SourceBank:** PA01 en lugar de GT01
2. **Transformaciones XQuery:** Archivos con sufijo PA en lugar de GT
3. **Country Code en Bitácora:** "PA01" en lugar de "GT01"

## Request OSB (Ejemplo SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_PA_001</UserName>
            <Password>P@ssw0rd123</Password>
         </Authentication>
         <Region>
            <SourceBank>PA01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>TXN-PA-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>CORPPA12345</CUSTOMER_ID>
         <USERNAME>usuario.panama</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>LOTE-PA-2024-001</CUSTOMER_BATCH_ID>
               <TYPE>1</TYPE>
               <CONCEPT_BATCH>Pago de Nómina Panamá</CONCEPT_BATCH>
               <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
               <DATA_STRUCTURE>
                  <VALIDATIONS>
                     <DEBIT_ACCT_BALANCE>YES</DEBIT_ACCT_BALANCE>
                     <DEBIT_ACCT_STATUS>YES</DEBIT_ACCT_STATUS>
                     <NUMBER_OF_TRANSACTIONS>2</NUMBER_OF_TRANSACTIONS>
                     <TOTAL_AMOUNT>30000.00</TOTAL_AMOUNT>
                  </VALIDATIONS>
                  <FIELDS>
                     <FIELD>DEBIT_ACCOUNT</FIELD>
                     <FIELD>CREDIT_ACCOUNT</FIELD>
                     <FIELD>AMOUNT</FIELD>
                     <FIELD>BENEFICIARY</FIELD>
                  </FIELDS>
                  <DELIMITER>|</DELIMITER>
               </DATA_STRUCTURE>
               <TRANSACTIONS>
                  <TRANSACTION>PA1234567890|PA9876543210|18000.00|Empleado PA 1</TRANSACTION>
                  <TRANSACTION>PA1234567890|PA9876543211|12000.00|Empleado PA 2</TRANSACTION>
               </TRANSACTIONS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivos>
   </soapenv:Body>
</soapenv:Envelope>
```

## Servicios y Conexiones

### Idénticos a GT01

- **Bitácora:** registraBitacoraPagosMasivosRG_db (PMSV)
- **Validación Acceso:** validaAccesoPMS (MTR Web Service)
- **Cargador de Lotes:** cargadorArchivoLote (MTR Web Service)
- **Mapeo de Errores:** MapeoErrores.proxy

## Transformaciones XQuery

### Archivos Específicos PA01

- `pagosMasivosInternoPAIn.xq`: Mapeo OSB → MTR
- `pagosMasivosInternoPAOut.xq`: Mapeo MTR → OSB
- `pagosMasivosInternoPAHeaderOut.xq`: Construcción de header

### Mapeo Idéntico a GT01

Todos los mapeos son idénticos a GT01, solo cambian los nombres de archivo.

## Diferencia Menor Detectada

**Variable de Validación:**
```xquery
-- PA01 usa:
$validationMessage  (con espacio al final)

-- GT01 usa:
$validationMessage (sin espacio)
```

Esta es una inconsistencia menor sin impacto funcional.

## Flujo de Datos PA01

Idéntico a GT01:

```
Cliente → PagosMasivos.proxy
  ↓
  Enrutamiento → PA01
  ↓
PagosMasivosInternoPA.proxy
  ↓
  Bitácora Request (BD Regional con countryCode=PA01)
  ↓
  Validación Acceso (MTR)
  ↓
  Transformación Request
  ↓
  Validación WSDL
  ↓
  Invocación cargadorArchivoLote (MTR)
  ↓
  Transformación Response
  ↓
  Bitácora Response (BD Regional)
  ↓
Cliente ← Response SOAP
```

## Recomendación

GT01 y PA01 deberían unificarse en un solo proxy parametrizado por región para:
- Reducir duplicación de código
- Facilitar mantenimiento
- Garantizar consistencia
- Simplificar testing
