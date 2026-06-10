<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCertificadoDeposito1" element="ns1:consultaCertificadoDeposito" location="../../../../Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaCertificadoDeposito/xsd/ConsultaCertificadoDeposito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCertificadoDeposito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaCertificadoDeposito/xq/consultaCertificadoDepositoIn/";

declare function xf:consultaCertificadoDepositoIn($consultaCertificadoDeposito1 as element(ns1:consultaCertificadoDeposito))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:DEPOSIT_NUMBER>{ data($consultaCertificadoDeposito1/DEPOSIT_NUMBER) }&lt;/ns0:DEPOSIT_NUMBER>
        &lt;/ns0:InputParameters>
};

declare variable $consultaCertificadoDeposito1 as element(ns1:consultaCertificadoDeposito) external;

xf:consultaCertificadoDepositoIn($consultaCertificadoDeposito1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaCertificadoDeposito/xsd/ConsultaCertificadoDeposito_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaCertificadoDeposito/xsd/ConsultaCertificadoDeposito_sp"/>
    </con:dependency>
</con:xqueryEntry>