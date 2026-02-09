# Ejemplos y Mapeos - PA01 (Panamá)

## Nota Importante
La implementación de PA01 es **idéntica** a GT01, con las siguientes diferencias:

1. **SourceBank**: `PA01` en lugar de `GT01`
2. **Country Code en Bitácora**: `PA01` en lugar de `GT01`
3. **XQuery Files**: Usa archivos específicos de PA (`pagosMasivosInternoPAIn.xqy`, `pagosMasivosInternoPAOut.xqy`, `pagosMasivosInternoPAHeaderOut.xqy`)

## Request OSB - Operación pagosMasivos

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_PA</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>PA01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>GLB-PA-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>PA1234567890</CUSTOMER_ID>
         <USERNAME>USUARIO_PA</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>BATCH-PA-001</CUSTOMER_BATCH_ID>
               <TYPE>1</TYPE>
               <CONCEPT_BATCH>Pago de Servicios</CONCEPT_BATCH>
               <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
               <DATA_STRUCTURE>
                  <VALIDATIONS>
                     <DEBIT_ACCT_BALANCE>NO</DEBIT_ACCT_BALANCE>
                     <DEBIT_ACCT_STATUS>NO</DEBIT_ACCT_STATUS>
                     <NUMBER_OF_TRANSACTIONS>2</NUMBER_OF_TRANSACTIONS>
                     <TOTAL_AMOUNT>8000.00</TOTAL_AMOUNT>
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
                  <TRANSACTION>PA1234567890|PA9876543210|4000.00|Servicio A</TRANSACTION>
                  <TRANSACTION>PA1234567890|PA9876543211|4000.00|Servicio B</TRANSACTION>
               </TRANSACTIONS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivos>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB - Operación pagosMasivos

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Lote procesado exitosamente</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivosResponse>
         <GLOBAL_ID>GLB-PA-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>PA1234567890</CUSTOMER_ID>
         <BATCHES>
            <BATCH>
               <BANK_BATCH_ID>PA100001</BANK_BATCH_ID>
               <CUSTOMER_BATCH_ID>BATCH-PA-001</CUSTOMER_BATCH_ID>
               <STATUS>PROCESSED</STATUS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivosResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Servicios Dependientes

Los servicios dependientes son **idénticos** a GT01:

1. **ValidaServicioRegional** (Base de Datos)
2. **validaAccesoPMS** (Servicio MTR)
3. **cargadorArchivoLote** (Servicio MTR)
4. **registraBitacoraPagosMasivosRG_db** (Base de Datos)

Ver detalles en [03-EjemplosYMapeos-GT01.md](./03-EjemplosYMapeos-GT01.md)

## Tablas de Mapeo

Las tablas de mapeo son **idénticas** a GT01, con la única diferencia en:

### Mapeo de Country Code en Bitácora

| Campo Origen | Transformación/Script | Campo Destino |
|--------------|----------------------|---------------|
| `$header/aut:RequestHeader/Region/SourceBank` | `string(text())` | `PV_COUNTRY_CODE` = **PA01** |

**XQuery Files**:
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAIn.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAOut.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAHeaderOut.xqy`

## Reglas de Negocio

Las reglas de negocio son **idénticas** a GT01. Ver [03-EjemplosYMapeos-GT01.md](./03-EjemplosYMapeos-GT01.md)

## Cadenas de Conexión

Las cadenas de conexión son **idénticas** a GT01. Ver [03-EjemplosYMapeos-GT01.md](./03-EjemplosYMapeos-GT01.md)

## Diferencias con GT01

**Ninguna diferencia funcional**. Solo cambian:
- Identificadores de región (PA01 vs GT01)
- Nombres de archivos XQuery (PA vs GT)
- Valores de ejemplo en requests/responses

## Diferencias con HN01

Idénticas a las diferencias de GT01 con HN01. Ver [03-EjemplosYMapeos-GT01.md](./03-EjemplosYMapeos-GT01.md)
