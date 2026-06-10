<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaExterna" location="../../ValidacionCuentaExterna/xsd/validacionCuentaExternaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaExternaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/validacionCuentaIn/";

declare function xf:validacionCuentaIn($transferenciasACHRequest1 as element(ns0:transferenciasACHRequest),
    $tipo as xs:string)
    as element(ns1:validacionCuentaExterna) {
        <ns1:validacionCuentaExterna>
            <ACCOUNT_NUMBER>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</ACCOUNT_NUMBER>
            <ACCOUNT_CURRENCY>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</ACCOUNT_CURRENCY>
            <PRODUCT_TYPE>{ $tipo }</PRODUCT_TYPE>
            <ACCOUNT_NAME>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</ACCOUNT_NAME>
            <CHECK_CANCELLED_YES_NO></CHECK_CANCELLED_YES_NO>
            <BANK_DETAILS>
                <BANK>
                	<CODE_TYPE>ACH</CODE_TYPE>
                    <BANK_CODE>{ data($transferenciasACHRequest1/DESTINATION_BANK) }</BANK_CODE>
                </BANK>
            </BANK_DETAILS>
        </ns1:validacionCuentaExterna>
};

declare variable $transferenciasACHRequest1 as element(ns0:transferenciasACHRequest) external;
declare variable $tipo as xs:string external;

xf:validacionCuentaIn($transferenciasACHRequest1,
    $tipo)]]></con:xquery>
    <con:dependency location="../xsd/transferenciasACHType.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciasACH/xsd/transferenciasACHType"/>
    </con:dependency>
    <con:dependency location="../../ValidacionCuentaExterna/xsd/validacionCuentaExternaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidacionCuentaExterna/xsd/validacionCuentaExternaTypes"/>
    </con:dependency>
</con:xqueryEntry>