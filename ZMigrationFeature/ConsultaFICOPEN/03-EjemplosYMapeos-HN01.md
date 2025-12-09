# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_osb</UserName>
            <Password>password_osb</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaFICOPEN>
         <INVESTMENT_CODE>12345678</INVESTMENT_CODE>
         <START_DATE>20240101</START_DATE>
         <END_DATE>20241231</END_DATE>
      </con:consultaFICOPEN>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages/>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaFICOPENResponse>
         <CUSTOMER_LEGAL_ID>0801199012345</CUSTOMER_LEGAL_ID>
         <CUSTOMER_NAME>JUAN PEREZ LOPEZ</CUSTOMER_NAME>
         <ACCOUNT_NUMBER>1234567890</ACCOUNT_NUMBER>
         <ACCOUNT_CURRENCY>HNL</ACCOUNT_CURRENCY>
         <CONTRACT_NUMBER>CONT-2024-001</CONTRACT_NUMBER>
         <CONTRACT_TYPE>FICOPEN</CONTRACT_TYPE>
         <COMPANY>FICOHSA</COMPANY>
         <START_DATE>20200101</START_DATE>
         <consultaFICOPENResponseType>
            <consultaFICOPENResponseRecordType>
               <BALANCE_TYPE>OBLIGATORIO</BALANCE_TYPE>
               <PREVIOUS_BALANCE>50000.00</PREVIOUS_BALANCE>
               <GROSS_CONTRIBUTIONS_AMOUNT>5000.00</GROSS_CONTRIBUTIONS_AMOUNT>
               <INTEREST_AMOUNT>250.00</INTEREST_AMOUNT>
               <WITHDRAWALS_AMOUNT>0.00</WITHDRAWALS_AMOUNT>
               <FEE_AMOUNT>50.00</FEE_AMOUNT>
               <INSURANCE_AMOUNT>25.00</INSURANCE_AMOUNT>
               <CURRENT_BALANCE>55175.00</CURRENT_BALANCE>
            </consultaFICOPENResponseRecordType>
         </consultaFICOPENResponseType>
      </con:consultaFICOPENResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Cadenas de Conexión

### Base de Datos - ValidaServicioRegional
- **JNDI**: eis/DB/ConnectionMiddleware
- **SP**: MW_P_VALIDA_SERVICIO_REGIONAL
- **Parámetros IN**: PV_SERVICIO='FICBCO0110', PV_ORIGEN='HN01', PV_DESTINO='HN01'
- **Parámetros OUT**: PV_CODIGO_ERROR, PV_MENSAJE_ERROR

### Servicio FPC
- **Endpoint**: https://dynamoosbdev:8004/regional/pension/soap/getFICOPEN/v11g
- **Operación**: consultaFICOPEN
- **Credenciales**: OSB12AUTH (desde Middleware/Security/)
- **Timeout**: 70s

## Mapeo Request OSB → FPC

| Campo OSB | Transformación | Campo FPC |
|-----------|---------------|-----------|
| INVESTMENT_CODE | Directo | INVESTMENT_CODE |
| START_DATE | Directo | START_DATE |
| END_DATE | Directo | END_DATE |

## Mapeo Response FPC → OSB

| Campo FPC | Transformación | Campo OSB |
|-----------|---------------|-----------|
| CUSTOMER_LEGAL_ID | Directo | CUSTOMER_LEGAL_ID |
| CUSTOMER_NAME | Directo | CUSTOMER_NAME |
| ACCOUNT_NUMBER | Directo | ACCOUNT_NUMBER |
| ACCOUNT_CURRENCY | Directo | ACCOUNT_CURRENCY |
| CONTRACT_NUMBER | Directo | CONTRACT_NUMBER |
| CONTRACT_TYPE | Directo | CONTRACT_TYPE |
| COMPANY | Directo | COMPANY |
| START_DATE | Directo | START_DATE |
| Array de balances | Iteración for-each | Array de balances |

## Reglas de Negocio

1. **Validación Regional**: Valida que servicio FICBCO0110 esté habilitado para HN01
2. **DestinationBank**: Si vacío, usa SourceBank
3. **Credenciales**: Obtiene de Security/OSB12AUTH con fallback
4. **Mapeo Errores**: Si error, invoca MapeoErrores con prefijo FICBCO0110
