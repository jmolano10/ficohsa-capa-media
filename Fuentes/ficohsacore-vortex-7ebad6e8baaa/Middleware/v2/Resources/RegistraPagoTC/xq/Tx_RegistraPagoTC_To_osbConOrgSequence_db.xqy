xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraPagoTCRequest1" element="ns0:registraPagoTCRequest" location="../xsd/RegistraPagoTC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataHN/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/Tx_RegistraPagoTC_To_osbConOrgSequence_db/";

declare function xf:Tx_RegistraPagoTC_To_osbConOrgSequence_db($registraPagoTCRequest1 as element(ns0:registraPagoTCRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CURRENCY>{ data($registraPagoTCRequest1/CURRENCY) }</ns1:CURRENCY>
            <ns1:CREDIT_CARD>{ data($registraPagoTCRequest1/CREDIT_CARD) }</ns1:CREDIT_CARD>
        </ns1:InputParameters>
};

declare variable $registraPagoTCRequest1 as element(ns0:registraPagoTCRequest) external;

xf:Tx_RegistraPagoTC_To_osbConOrgSequence_db($registraPagoTCRequest1)