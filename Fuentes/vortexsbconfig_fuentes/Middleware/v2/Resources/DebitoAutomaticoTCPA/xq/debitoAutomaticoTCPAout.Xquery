<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.pa/regional/Vortex/DebitoAutomaticoTCPA";
(:: import schema at "../xsd/debitoAutomaticoTCPAtypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/debitoAutomaticoTC_db";
(:: import schema at "../../../BusinessServices/ABKPA/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTC_db_sp.xsd" ::)

declare variable $debitoAutomaticoTCResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:debitoAutomaticoTCPAout($debitoAutomaticoTCResponse as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:DebitoAutomaticoTCPAresponse) ::) {
    <ns2:DebitoAutomaticoTCPAresponse>
        <ns2:OPERATION_INFO>
            {
                if ($debitoAutomaticoTCResponse/ns1:P_ID)
                then <ns2:UniqueID>{fn:data($debitoAutomaticoTCResponse/ns1:P_ID)}</ns2:UniqueID>
                else ()
            }
            {
                if ($debitoAutomaticoTCResponse/ns1:P_FECHA1)
                then <ns2:DAY1>{fn:data($debitoAutomaticoTCResponse/ns1:P_FECHA1)}</ns2:DAY1>
                else ()
            }
            {
                if ($debitoAutomaticoTCResponse/ns1:P_FECHA2)
                then <ns2:DAY2>{fn:data($debitoAutomaticoTCResponse/ns1:P_FECHA2)}</ns2:DAY2>
                else ()
            }
            <ns2:PAY_TYPE>{fn:data($debitoAutomaticoTCResponse/ns1:P_TIPO_PAGO)}</ns2:PAY_TYPE>
            {
                if ($debitoAutomaticoTCResponse/ns1:P_ULTIMA_EJECUCION)
                then <ns2:LAST_EXECUTION>{fn:data($debitoAutomaticoTCResponse/ns1:P_ULTIMA_EJECUCION)}</ns2:LAST_EXECUTION>
                else ()
            }
            <ns2:CREDIT_CARD>{fn:data($debitoAutomaticoTCResponse/ns1:P_NUM_TC)}</ns2:CREDIT_CARD>
            <ns2:TC_ACOUNT_NUMBER>{fn:data($debitoAutomaticoTCResponse/ns1:P_NUM_CUENTA_TC)}</ns2:TC_ACOUNT_NUMBER>
            <ns2:TC_CUSTOMER_NAME>{fn:data($debitoAutomaticoTCResponse/ns1:P_TC_CUSTOMER_NAME)}</ns2:TC_CUSTOMER_NAME>
            <ns2:ACCOUNT_TYPE>{fn:data($debitoAutomaticoTCResponse/ns1:P_TIPO_CUENTA)}</ns2:ACCOUNT_TYPE>
            <ns2:ACCOUNT_NAME>{fn:data($debitoAutomaticoTCResponse/ns1:P_NOMBRE_CUENTA)}</ns2:ACCOUNT_NAME>
            <ns2:BRANCH_CODE>{fn:data($debitoAutomaticoTCResponse/ns1:P_CODIGO_AGENCIA)}</ns2:BRANCH_CODE>
            <ns2:SUB_APPLICATION>{fn:data($debitoAutomaticoTCResponse/ns1:P_CODIGO_SUB_APLICACION)}</ns2:SUB_APPLICATION>
            <ns2:ACCOUNT_NUMBER>{fn:data($debitoAutomaticoTCResponse/ns1:P_NUMERO_CUENTA)}</ns2:ACCOUNT_NUMBER>
            {
                if ($debitoAutomaticoTCResponse/ns1:P_ESTADO_ULTIMA_EJECUCION)
                then <ns2:LAST_EXECUTION_STATUS>{fn:data($debitoAutomaticoTCResponse/ns1:P_ESTADO_ULTIMA_EJECUCION)}</ns2:LAST_EXECUTION_STATUS>
                else ()
            }
            {
                if ($debitoAutomaticoTCResponse/ns1:P_ESTADO)
                then <ns2:STATUS>{fn:data($debitoAutomaticoTCResponse/ns1:P_ESTADO)}</ns2:STATUS>
                else ()
            }
            <ns2:OPERATION_TYPE></ns2:OPERATION_TYPE>
        </ns2:OPERATION_INFO>
        <ns2:KV_PAIRS>
            <ns2:PAIR>
                <ns2:KEY> </ns2:KEY>
                <ns2:VALUE> </ns2:VALUE>
            </ns2:PAIR>
        </ns2:KV_PAIRS>
    </ns2:DebitoAutomaticoTCPAresponse>
};

local:debitoAutomaticoTCPAout($debitoAutomaticoTCResponse)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/debitoAutomaticoTCPAtypes.xsd">
            <con:schema ref="Middleware/v2/Resources/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTCPAtypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/ABKPA/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTC_db_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/ABKPA/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTC_db_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>