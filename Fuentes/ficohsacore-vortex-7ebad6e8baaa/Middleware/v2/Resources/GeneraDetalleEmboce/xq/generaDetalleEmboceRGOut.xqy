xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaDetalleEmboceResponse" element="ns1:generaDetalleEmboceResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:generaDetalleEmboceResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/generaDetalleEmboceRGOut/";

declare function xf:guardaDetalleEmboceOut($generaDetalleEmboceResponse as element(ns1:generaDetalleEmboceResponse))
    as element(ns0:generaDetalleEmboceResponse) {
        <ns0:generaDetalleEmboceResponse>
            <CARD_DETAILS>
                {
                    for $cardItemResponse in $generaDetalleEmboceResponse/cardDetailsResponse/cardItemResponse
                    return
                        <CARD_ITEM>
                            <CARD_NUMBER>{ data($cardItemResponse/cardNumber) }</CARD_NUMBER>
                            <NAME_ON_CARD>{ data($cardItemResponse/nameOnCard) }</NAME_ON_CARD>
                            <INSTRUCTION_DETAILS>
                                {
                                    for $generationItem in $cardItemResponse/instructionDetails/generationItem
                                    return
                                        <GENERATION_ITEM>
                                            <GENERATED_INSTRUCTION>{ data($generationItem/generatedInstruction) }</GENERATED_INSTRUCTION>
                                            <GENERATED_VALUE_STATUS>{ data($generationItem/generatedValueStatus) }</GENERATED_VALUE_STATUS>
                                            <GENERATED_VALUE_MESSAGE>{ data($generationItem/generatedValueMessage) }</GENERATED_VALUE_MESSAGE>
                                        </GENERATION_ITEM>
                                }
                            </INSTRUCTION_DETAILS>
                        </CARD_ITEM>
                }
            </CARD_DETAILS>
        </ns0:generaDetalleEmboceResponse>
};

declare variable $generaDetalleEmboceResponse as element(ns1:generaDetalleEmboceResponse) external;

xf:guardaDetalleEmboceOut($generaDetalleEmboceResponse)