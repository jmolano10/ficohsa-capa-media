<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta" element="ns1:pagoRemesaCreditoCuenta" location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:evaluaListasClienteRequest" location="../xsd/evaluaListasClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/evaluaListasClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClientePagoRemesaIn/";

declare function xf:evaluaListasClientePagoRemesaIn($pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:evaluaListasClienteRequest) {
        <ns2:evaluaListasClienteRequest>
            <TRANSACTION_ID>{ data($pagoRemesaCreditoCuenta/REMITTANCE_ID) }</TRANSACTION_ID>
            <NAME_TO_EVALUATE>{ data($pagoRemesaCreditoCuenta/REMITTER_NAME) }</NAME_TO_EVALUATE>
            <TYPE_OF_TRANSACTION>Deposito a Cuenta</TYPE_OF_TRANSACTION>
            <AMOUNT>{ data($pagoRemesaCreditoCuenta/AMOUNT) }</AMOUNT>
            <TRANSACTION_DATE>{ data($pagoRemesaCreditoCuenta/REMITTANCE_DATE) }</TRANSACTION_DATE>
            <COUNTRY>{ data($pagoRemesaCreditoCuenta/COUNTRY_OF_ORIGIN) }</COUNTRY>
            <CANAL>{ data($requestHeader/Authentication/UserName) }</CANAL>
        </ns2:evaluaListasClienteRequest>
};

declare variable $pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:evaluaListasClientePagoRemesaIn($pagoRemesaCreditoCuenta,
    $requestHeader)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../xsd/evaluaListasClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/EvaluaListasCliente/xsd/evaluaListasClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>