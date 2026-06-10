<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.pa/regional/Vortex/DebitoAutomaticoTCPA";
(:: import schema at "../xsd/debitoAutomaticoTCPAtypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/debitoAutomaticoTC_db";
(:: import schema at "../../../BusinessServices/ABKPA/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTC_db_sp.xsd" ::)

declare variable $debitoAutomaticoRequest as element() (:: schema-element(ns1:DebitoAutomaticoTCPArequest) ::) external;

declare function local:debitoAutomaticoTCPAIn($debitoAutomaticoRequest as element() (:: schema-element(ns1:DebitoAutomaticoTCPArequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:OPERATION_TYPE>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_TYPE)}</ns2:OPERATION_TYPE>
        {
            if ($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:UniqueID)
            then <ns2:P_ID>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:UniqueID)}</ns2:P_ID>
            else ()
        }
        {
            if ($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:DAY1)
            then <ns2:P_FECHA1>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:DAY1)}</ns2:P_FECHA1>
            else ()
        }
        {
            if ($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:DAY2)
            then <ns2:P_FECHA2>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:DAY2)}</ns2:P_FECHA2>
            else ()
        }
        <ns2:P_TIPO_PAGO>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:PAY_TYPE)}</ns2:P_TIPO_PAGO>
        <ns2:P_TIPO_CUENTA>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:ACCOUNT_TYPE)}</ns2:P_TIPO_CUENTA>
        <ns2:P_NOMBRE_CUENTA>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:ACCOUNT_NAME)}</ns2:P_NOMBRE_CUENTA>
        {
            if ($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:LAST_EXECUTION_STATUS)
            then <ns2:P_ESTADO_ULTIMA_EJECUCION>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:LAST_EXECUTION_STATUS)}</ns2:P_ESTADO_ULTIMA_EJECUCION>
            else ()
        }
        {
            if ($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:LAST_EXECUTION)
            then <ns2:P_ULTIMA_EJECUCION>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:LAST_EXECUTION)}</ns2:P_ULTIMA_EJECUCION>
            else ()
        }
        <ns2:P_NUM_TC>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:CREDIT_CARD)}</ns2:P_NUM_TC>
        <ns2:P_NUM_CUENTA_TC>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:TC_ACOUNT_NUMBER)}</ns2:P_NUM_CUENTA_TC>
        <ns2:P_TC_CUSTOMER_NAME>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:TC_CUSTOMER_NAME)}</ns2:P_TC_CUSTOMER_NAME>
        <ns2:P_CODIGO_AGENCIA>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:BRANCH_CODE)}</ns2:P_CODIGO_AGENCIA>
        <ns2:P_CODIGO_SUB_APLICACION>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:SUB_APPLICATION)}</ns2:P_CODIGO_SUB_APLICACION>
        <ns2:P_NUMERO_CUENTA>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:ACCOUNT_NUMBER)}</ns2:P_NUMERO_CUENTA>
        {
            if ($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:STATUS)
            then <ns2:P_ESTADO>{fn:data($debitoAutomaticoRequest/ns1:OPERATION_INFO/ns1:STATUS)}</ns2:P_ESTADO>
            else ()
        }
    </ns2:InputParameters>
};

local:debitoAutomaticoTCPAIn($debitoAutomaticoRequest)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/debitoAutomaticoTCPAtypes.xsd">
            <con:schema ref="Middleware/v2/Resources/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTCPAtypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/ABKPA/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTC_db_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/ABKPA/DebitoAutomaticoTCPA/xsd/debitoAutomaticoTC_db_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>