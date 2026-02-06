xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaRemesa" element="ns1:creaRemesa" location="../xsd/creaRemesaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Remesas/creacionRemesaLocal/xsd/creacionRemesaLocal_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaRemesaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/creacionRemesaLocal";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaRemesa/xq/creacionRemesaLocalIn/";

declare function xf:creacionRemesaLocalIn($creaRemesa as element(ns1:creaRemesa),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REMESAID>{ data($creaRemesa/REMITTANCE_INFO/ID) }</ns0:PV_REMESAID>
            <ns0:PD_FECHA_ENVIO>{ fn-bea:date-to-string-with-format("dd-MM-yyyy",data($creaRemesa/REMITTANCE_INFO/DATE)) }</ns0:PD_FECHA_ENVIO>
            <ns0:PD_FECHA_EMISION>{ fn-bea:date-to-string-with-format("dd-MM-yyyy",data($creaRemesa/REMITTANCE_INFO/DATE_OF_ISSUE)) }</ns0:PD_FECHA_EMISION>
            <ns0:PV_MONEDA_PAGO>{ data($creaRemesa/REMITTANCE_INFO/CURRENCY) }</ns0:PV_MONEDA_PAGO>
            <ns0:PV_MONTO_PAGO>{ data($creaRemesa/REMITTANCE_INFO/AMOUNT) }</ns0:PV_MONTO_PAGO>
            <ns0:PV_MONEDA_ORIGINAL>{ data($creaRemesa/REMITTANCE_INFO/REF_CURRENCY) }</ns0:PV_MONEDA_ORIGINAL>
            <ns0:PV_MONTO_ORIGINAL>{ data($creaRemesa/REMITTANCE_INFO/REF_AMOUNT) }</ns0:PV_MONTO_ORIGINAL>
            <ns0:PV_NOMBRE_BENEFICIARIO>{ data($creaRemesa/BENEFICIARY_INFO/NAME) }</ns0:PV_NOMBRE_BENEFICIARIO>
            {
                for $COUNTRY in $creaRemesa/BENEFICIARY_INFO/COUNTRY
                return
                    <ns0:PV_PAIS_BENEFICIARIO>{ data($COUNTRY) }</ns0:PV_PAIS_BENEFICIARIO>
            }
            {
                for $STATE in $creaRemesa/BENEFICIARY_INFO/STATE
                return
                    <ns0:PV_ESTADO_BENEFICIARIO>{ data($STATE) }</ns0:PV_ESTADO_BENEFICIARIO>
            }
            {
                for $NAME in $creaRemesa/REMITTER_INFO/NAME
                return
                    <ns0:PV_NOMBRE_REMITENTE>{ data($NAME) }</ns0:PV_NOMBRE_REMITENTE>
            }
            {
                for $ADDRESS in $creaRemesa/REMITTER_INFO/ADDRESS
                return
                    <ns0:PV_DIRECCION_REMITENTE>{ data($ADDRESS) }</ns0:PV_DIRECCION_REMITENTE>
            }
            {
                for $PHONE_NUMBER in $creaRemesa/REMITTER_INFO/PHONE_NUMBER
                return
                    <ns0:PV_TELEFONO_REMITENTE>{ data($PHONE_NUMBER) }</ns0:PV_TELEFONO_REMITENTE>
            }
            <ns0:PV_TASA_CAMBIO>{ data($creaRemesa/REMITTANCE_INFO/EXCHANGE_RATE) }</ns0:PV_TASA_CAMBIO>
            {
                for $COUNTRY in $creaRemesa/REMITTER_INFO/COUNTRY
                return
                    <ns0:PV_PAIS_REMITENTE>{ data($COUNTRY) }</ns0:PV_PAIS_REMITENTE>
            }
            {
                for $STATE in $creaRemesa/REMITTER_INFO/STATE
                return
                    <ns0:PV_ESTADO_REMITENTE>{ data($STATE) }</ns0:PV_ESTADO_REMITENTE>
            }
            {
                for $CITY in $creaRemesa/REMITTER_INFO/CITY
                return
                    <ns0:PV_CIUDAD_REMITENTE>{ data($CITY) }</ns0:PV_CIUDAD_REMITENTE>
            }
            <ns0:PV_USUARIO>{ $userName }</ns0:PV_USUARIO>
            <ns0:PV_SECUENCIA>{ data($creaRemesa/REMITTANCE_INFO/SEQUENCE) }</ns0:PV_SECUENCIA>
        </ns0:InputParameters>
};

declare variable $creaRemesa as element(ns1:creaRemesa) external;
declare variable $userName as xs:string external;

xf:creacionRemesaLocalIn($creaRemesa,
    $userName)