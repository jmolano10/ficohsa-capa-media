xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCertificadoDeposito1" element="ns1:consultaCertificadoDeposito" location="../../../../Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaCertificadoDeposito/xsd/ConsultaCertificadoDeposito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCertificadoDeposito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaCertificadoDeposito/xq/consultaCertificadoDepositoIn/";

declare function xf:consultaCertificadoDepositoIn($consultaCertificadoDeposito1 as element(ns1:consultaCertificadoDeposito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:DEPOSIT_NUMBER>{ data($consultaCertificadoDeposito1/DEPOSIT_NUMBER) }</ns0:DEPOSIT_NUMBER>
        </ns0:InputParameters>
};

declare variable $consultaCertificadoDeposito1 as element(ns1:consultaCertificadoDeposito) external;

xf:consultaCertificadoDepositoIn($consultaCertificadoDeposito1)