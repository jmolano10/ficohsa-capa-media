# Ejemplos y Mapeos - HN01

## Request OSB Ejemplo
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:ser="http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Region><SourceBank>HN01</SourceBank></Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <ser:modificaClienteDesembolsoLineaCredito>
         <ser:CUSTOMERS>
            <ser:CUSTOMER>
               <ser:GENERAL_INFO>
                  <ser:BASIC>
                     <ser:ID>12345</ser:ID>
                     <ser:BRANCH_CODE>001</ser:BRANCH_CODE>
                     <ser:EXPIRATION_DAY>15</ser:EXPIRATION_DAY>
                     <ser:AUTHORIZATION_USER>ADMIN01</ser:AUTHORIZATION_USER>
                  </ser:BASIC>
                  <ser:FINANCIAL>
                     <ser:FINANCIAL_STMT_DATE>2024-01-01</ser:FINANCIAL_STMT_DATE>
                     <ser:NEXT_FINANCIAL_STMT_DATE>2025-01-01</ser:NEXT_FINANCIAL_STMT_DATE>
                  </ser:FINANCIAL>
                  <ser:CONTACT>
                     <ser:EMAILS>
                        <ser:EMAIL>
                           <ser:ID_OLD>old@example.com</ser:ID_OLD>
                           <ser:ID_NEW>new@example.com</ser:ID_NEW>
                        </ser:EMAIL>
                     </ser:EMAILS>
                  </ser:CONTACT>
               </ser:GENERAL_INFO>
               <ser:PRODUCT_INFO>
                  <ser:ACTIVE>YES</ser:ACTIVE>
                  <ser:LOAN_LIMITS>
                     <ser:LOAN_LIMIT>
                        <ser:CURRENCY>HNL</ser:CURRENCY>
                        <ser:MAX_AMOUNT>1000000</ser:MAX_AMOUNT>
                        <ser:ENABLED>YES</ser:ENABLED>
                     </ser:LOAN_LIMIT>
                  </ser:LOAN_LIMITS>
                  <ser:DESTINATION_PRODUCTS>
                     <ser:PRODUCT>
                        <ser:ID>1234567890123456</ser:ID>
                        <ser:CURRENCY>HNL</ser:CURRENCY>
                        <ser:TYPE>SAVE</ser:TYPE>
                        <ser:ACTION>ADD</ser:ACTION>
                     </ser:PRODUCT>
                  </ser:DESTINATION_PRODUCTS>
                  <ser:REPAYMENT_DETAILS>
                     <ser:AUTO_DEBIT>YES</ser:AUTO_DEBIT>
                     <ser:DEBIT_ACCOUNTS>
                        <ser:ACCOUNT>
                           <ser:ID>9876543210123456</ser:ID>
                           <ser:CURRENCY>HNL</ser:CURRENCY>
                           <ser:TYPE>CHK</ser:TYPE>
                           <ser:ACTION>ADD</ser:ACTION>
                        </ser:ACCOUNT>
                     </ser:DEBIT_ACCOUNTS>
                  </ser:REPAYMENT_DETAILS>
                  <ser:CREDIT_LINES>
                     <ser:CREDIT_LINE>
                        <ser:ID>CL001</ser:ID>
                        <ser:ECONOMIC_ACTIVITY_CODE>5200</ser:ECONOMIC_ACTIVITY_CODE>
                        <ser:EXPIRY_DATE>2025-12-31</ser:EXPIRY_DATE>
                        <ser:INVESTMENT_CODE>100</ser:INVESTMENT_CODE>
                        <ser:INVESTMENT_SUBCODE>10</ser:INVESTMENT_SUBCODE>
                        <ser:DESTINATION_CODE>200</ser:DESTINATION_CODE>
                        <ser:APPROVAL_CODE>A001</ser:APPROVAL_CODE>
                        <ser:OFFICER>OFF001</ser:OFFICER>
                        <ser:OFFICER_BRANCH_CODE>1</ser:OFFICER_BRANCH_CODE>
                        <ser:SUB_ORIGIN>1</ser:SUB_ORIGIN>
                        <ser:REVISION_RATE_TYPE>1</ser:REVISION_RATE_TYPE>
                        <ser:MONTHLY_SETTLEMENT>1</ser:MONTHLY_SETTLEMENT>
                        <ser:YEARLY_SETTLEMENT>12</ser:YEARLY_SETTLEMENT>
                        <ser:GRACE_PERIOD>3</ser:GRACE_PERIOD>
                        <ser:MAX_PAYMENT_PERIOD>60</ser:MAX_PAYMENT_PERIOD>
                        <ser:LOAN_PRODUCT_DETAILS>
                           <ser:LOAN_PRODUCT>
                              <ser:ID>1</ser:ID>
                              <ser:CURRENCY>HNL</ser:CURRENCY>
                              <ser:OBLIGATION_TYPE>DIRECT</ser:OBLIGATION_TYPE>
                              <ser:OBLIGATION_DESCRIPTION>Obligacion Directa</ser:OBLIGATION_DESCRIPTION>
                              <ser:GUARANTEE_TYPE>HI</ser:GUARANTEE_TYPE>
                              <ser:GUARANTEE_DESCRIPTION>Hipotecaria</ser:GUARANTEE_DESCRIPTION>
                              <ser:REPAYMENT_TYPES>
                                 <ser:REPAYMENT_TYPE>
                                    <ser:CODE>01</ser:CODE>
                                    <ser:DESCRIPTION>Mensual</ser:DESCRIPTION>
                                    <ser:FREQUENCY>12</ser:FREQUENCY>
                                    <ser:MAX_PAYMENT_TERM>360</ser:MAX_PAYMENT_TERM>
                                    <ser:ACTION>ADD</ser:ACTION>
                                 </ser:REPAYMENT_TYPE>
                              </ser:REPAYMENT_TYPES>
                              <ser:RATES>
                                 <ser:RATE>
                                    <ser:CLASS>A</ser:CLASS>
                                    <ser:GROUP>1</ser:GROUP>
                                    <ser:TERM_IN_MONTHS>12</ser:TERM_IN_MONTHS>
                                    <ser:LOAN_RATE>15.5</ser:LOAN_RATE>
                                    <ser:ACTION>ADD</ser:ACTION>
                                 </ser:RATE>
                              </ser:RATES>
                              <ser:CHARGES>
                                 <ser:CHARGE>
                                    <ser:NAME>Comision Apertura</ser:NAME>
                                    <ser:TYPE>FIXED</ser:TYPE>
                                    <ser:VALUE>500</ser:VALUE>
                                    <ser:ACTION>ADD</ser:ACTION>
                                 </ser:CHARGE>
                              </ser:CHARGES>
                           </ser:LOAN_PRODUCT>
                        </ser:LOAN_PRODUCT_DETAILS>
                     </ser:CREDIT_LINE>
                  </ser:CREDIT_LINES>
               </ser:PRODUCT_INFO>
            </ser:CUSTOMER>
         </ser:CUSTOMERS>
      </ser:modificaClienteDesembolsoLineaCredito>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB Exitoso
```xml
<soapenv:Envelope>
  <soapenv:Header>
    <aut:ResponseHeader>
      <successIndicator>Success</successIndicator>
    </aut:ResponseHeader>
  </soapenv:Header>
  <soapenv:Body>
    <ser:modificaClienteDesembolsoLineaCreditoResponse/>
  </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB Error
```xml
<soapenv:Envelope>
  <soapenv:Header>
    <aut:ResponseHeader>
      <successIndicator>ERROR</successIndicator>
      <messages>Cliente no encontrado</messages>
    </aut:ResponseHeader>
  </soapenv:Header>
  <soapenv:Body>
    <ser:modificaClienteDesembolsoLineaCreditoResponse/>
  </soapenv:Body>
</soapenv:Envelope>
```

## Cadenas de Conexión

### Base de Datos
- **JNDI**: eis/DB/ConnectionDLC
- **Schema**: DLC
- **SP**: DLC_P_MODIFICAR_CLIENTE
- **Package**: N/A (standalone)

### Servicio ConsultaCliente
- **Ref**: Middleware/v3/ProxyServices/ConsultaCliente
- **Op**: consultaCliente

### Servicio ValidaServicioRegional
- **Ref**: Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db
- **Op**: ValidaServicioRegional

## Mapeo Entrada - ConsultaCliente

**XQuery**: consultaClienteHNIn.xq

| Campo Origen OSB | Transformación | Campo Destino |
|-----------------|----------------|---------------|
| CUSTOMERS/CUSTOMER/GENERAL_INFO/BASIC/ID | data() | CUSTOMER_ID_VALUE |
| Constante | "CUSTOMER_ID" | CUSTOMER_ID_TYPE |

## Mapeo Salida - ConsultaCliente

| Campo Origen | Transformación | Variable Destino |
|-------------|----------------|------------------|
| SHORT_NAME | data() | P_CUSTOMER_NAME |
| IDENTIFICATION_INFO/LEGAL_IDENTIFICATION_ITEM[1]/LEGAL_ID | data() | P_LEGAL_ID |
| TARGET | data() | P_TARGET_ID |
| TARGET_DESCRIPTION | data() | P_TARGET_DESCRIPTION |
| ResponseHeader/successIndicator | fn:string() | errorCode |
| ResponseHeader/messages | fn:string() | validationMessage |

## Mapeo Entrada - SP Modificación

**XQuery**: modificaClienteSolEmprendedorHNIn.xq

### Campos Básicos
| Campo Origen | Campo Destino SP |
|-------------|------------------|
| BASIC/ID | P_CUSTOMER_ID |
| consultaClienteResponse/SHORT_NAME | P_CUSTOMER_NAME |
| consultaClienteResponse/LEGAL_ID | P_LEGAL_ID |
| consultaClienteResponse/TARGET | P_TARGET_ID |
| consultaClienteResponse/TARGET_DESCRIPTION | P_TARGET_DESCRIPTION |
| BASIC/BRANCH_CODE | P_BRANCH_CODE |
| BASIC/EXPIRATION_DAY | P_EXPIRATION_DAY |
| FINANCIAL/FINANCIAL_STMT_DATE | P_FINANCIAL_STMT_DATE |
| FINANCIAL/NEXT_FINANCIAL_STMT_DATE | P_NEXT_FINANCIAL_STMT_DATE |
| PRODUCT_INFO/ACTIVE | P_ACTIVE |
| REPAYMENT_DETAILS/AUTO_DEBIT | P_AUTO_DEBIT |

### Arrays
| Array Origen | Array Destino SP |
|-------------|------------------|
| EMAILS/EMAIL/ID_OLD | P_EMAILS_OLD |
| EMAILS/EMAIL/ID_NEW | P_EMAILS_NEW |
| LOAN_LIMITS/LOAN_LIMIT | P_LOAN_LIMITS |
| DESTINATION_PRODUCTS/PRODUCT | P_DESTINATION_PRODUCTS |
| DEBIT_ACCOUNTS/ACCOUNT | P_DEBIT_ACCOUNTS |
| CREDIT_LINES/CREDIT_LINE | P_CREDIT_LINES |

## Mapeo Salida - SP Modificación

| Campo Origen SP | Transformación | Variable Destino |
|----------------|----------------|------------------|
| P_SUCCESSINDICATOR | fn:string() | errorCode |
| P_MESSAGES | fn:string() | validationMessage |

## Reglas de Negocio

### RN-001: Validación Cliente Existente
- **Ubicación**: ModificaClienteDesembolsoLineaCreditoHN.proxy, Stage ConsultaCliente
- **Código**: `if(upper-case($errorCode) = 'SUCCESS') then '' else string(messages)`
- **Acción**: Si falla consulta, no ejecuta modificación

### RN-002: Ejecución Condicional
- **Ubicación**: ModificaClienteDesembolsoLineaCreditoHN.proxy, Stage ModificaClienteDLC
- **Código**: `$validationMessage=''`
- **Acción**: Solo modifica si validationMessage vacío

### RN-003: Datos de Consulta
- **Descripción**: NAME, LEGAL_ID, TARGET vienen de ConsultaCliente
- **Ubicación**: modificaClienteSolEmprendedorHNIn.xq
- **Razón**: Garantizar consistencia con datos maestros

### RN-004: Campo ACTION
- **Descripción**: Arrays con ACTION (ADD/DEL/UPD)
- **Aplica**: PRODUCTS, ACCOUNTS, RATES, CHARGES, REPAYMENT_TYPES
- **Ubicación**: Stored Procedure DLC_P_MODIFICAR_CLIENTE

### RN-005: Actualización Emails
- **Descripción**: Emails con pares OLD/NEW
- **Ubicación**: modificaClienteSolEmprendedorHNIn.xq
- **Mapeo**: ID_OLD → P_EMAILS_OLD_ITEM, ID_NEW → P_EMAILS_OLD_ITEM

### RN-006: Validación Regional
- **Descripción**: Servicio habilitado para región
- **Ubicación**: ValidacionServicioRegional stage
- **ServiceID**: FICBCO0364
- **Acción**: Si falla, detiene procesamiento

### RN-007: Construcción Response
- **Ubicación**: ModificaClienteDesembolsoLineaCreditoHN.proxy, Stage FlujoSalida
- **Código**: `if ($validationMessage = '') then Success else errorCode + messages`
