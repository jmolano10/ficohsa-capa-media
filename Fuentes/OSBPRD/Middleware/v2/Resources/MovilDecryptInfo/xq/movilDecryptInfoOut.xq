(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MovilDecryptInfo/xsd/movilDecryptInfo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:movilDecryptInfoResponse" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilDecryptInfo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilDecryptInfo/xq/movilDecryptInfoOut/";

declare function xf:movilDecryptInfoOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:movilDecryptInfoResponse) {
        <ns1:movilDecryptInfoResponse>
            {
                for $PV_DECRYPTEDPAYLOAD in $outputParameters/ns0:PV_DECRYPTEDPAYLOAD
                return
                    <DECRYPTED_PAYLOAD>{ data($PV_DECRYPTEDPAYLOAD) }</DECRYPTED_PAYLOAD>
            }
            {
                for $PV_SUCCESSINDICATOR in $outputParameters/ns0:PV_SUCCESSINDICATOR
                return
                    <SUCCESS_INDICATOR>{ data($PV_SUCCESSINDICATOR) }</SUCCESS_INDICATOR>
            }
            <ERROR_DESCRIPTION>{ data($outputParameters/ns0:PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
        </ns1:movilDecryptInfoResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:movilDecryptInfoOut($outputParameters)