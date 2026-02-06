xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$onlinePaymentV4Response1" element="ns1:OnlinePaymentV4Response" location="../../../BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:registraPagoTCResponse" location="../xsd/RegistraPagoTC.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns1 = "http://www.procesa.com/fdcs/ot";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/Tx_RegistraPagoTC_Response/";

declare function xf:Tx_RegistraPagoTC_Response($onlinePaymentV4Response1 as element(ns1:OnlinePaymentV4Response),
	    $ORG as xs:string,
        $sequenceValue as xs:string)
    as element(ns0:registraPagoTCResponse) {
        <ns0:registraPagoTCResponse>
            <SECUENCIAL_NUMBER>{$sequenceValue}</SECUENCIAL_NUMBER>
            <AUTHORIZATION_CODE>{ data($onlinePaymentV4Response1/AuthorizationCode) }</AUTHORIZATION_CODE>
            <ORG>{$ORG}</ORG>
        </ns0:registraPagoTCResponse>
};

declare variable $onlinePaymentV4Response1 as element(ns1:OnlinePaymentV4Response) external;
declare variable $ORG as xs:string external;
declare variable $sequenceValue as xs:string external;

xf:Tx_RegistraPagoTC_Response($onlinePaymentV4Response1,$ORG,$sequenceValue)