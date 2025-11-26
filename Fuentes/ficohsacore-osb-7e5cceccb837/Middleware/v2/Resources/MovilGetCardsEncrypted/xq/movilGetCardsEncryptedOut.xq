xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MovilGetCardsEncrypted/xsd/movilGetCardsEncrypted_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:movilGetCardsEncryptedResponse" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetCardsEncrypted/xq/movilGetCardsEncryptedOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetCardsEncrypted";

declare function xf:movilGetCardsEncryptedOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:movilGetCardsEncryptedResponse) {
        <ns1:movilGetCardsEncryptedResponse>
        	<ENCRYPTED_CARD>{ data($outputParameters/ns0:PV_ENCRYPTEDCARD) }</ENCRYPTED_CARD>
            <REQUEST_ID>{ data($outputParameters/ns0:PV_REQUESTID) }</REQUEST_ID>
            <RETURN_CODE>{ data($outputParameters/ns0:PV_RETURNCODE) }</RETURN_CODE>
            <ERROR_DESCRIPTION>{ data($outputParameters/ns0:PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
            <INSTITUTION_CODE>{ data($outputParameters/ns0:PV_INSTITUTIONCODE) }</INSTITUTION_CODE>
            <CARD_HOLDER_NAME>{ data($outputParameters/ns0:PV_CARDHOLDERNAME) }</CARD_HOLDER_NAME>
            <MARCA>{ data($outputParameters/ns0:PV_MARCA) }</MARCA>
        </ns1:movilGetCardsEncryptedResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:movilGetCardsEncryptedOut($outputParameters)