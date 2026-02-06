xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaPINResponse" element="ns1:validaPINResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:validaPINResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaPIN/xq/validaPINOut/";

declare function xf:validaPINOut($validaPINResponse as element(ns1:validaPINResponse))
    as element(ns0:validaPINResponse) {
        <ns0:validaPINResponse>
            <VALIDATION_DETAILS>
                {
                    for $cardItem in $validaPINResponse/cardDetails/cardItem
                    return
                        <CARD_ITEM>
                            <CARD_NUMBER>{ data($cardItem/cardNumber) }</CARD_NUMBER>
                            <PIN_STATUS>{ data($cardItem/pinStatus) }</PIN_STATUS>
                            <ERROR_CODE>{ data($cardItem/responseCode) }</ERROR_CODE>
                            <MESSAGE>{ data($cardItem/message) }</MESSAGE>
                        </CARD_ITEM>
                }
            </VALIDATION_DETAILS>
        </ns0:validaPINResponse>
};

declare variable $validaPINResponse as element(ns1:validaPINResponse) external;

xf:validaPINOut($validaPINResponse)