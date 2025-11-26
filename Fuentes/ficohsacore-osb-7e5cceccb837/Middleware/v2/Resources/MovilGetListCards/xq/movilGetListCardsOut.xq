(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MovilGetCardsList/xsd/movilGetListCards_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:movilGetListCardsResponse" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetListCards";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetListCards/xq/movilGetListCardsOut/";

declare function xf:movilGetListCardsOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:movilGetListCardsResponse) {
        <ns1:movilGetListCardsResponse>
            {
                for $PT_LISTATARJETAS in $outputParameters/ns0:PT_LISTATARJETAS
                return
                    <CARDS>
                        {
                            for $PT_LISTATARJETAS_ITEM in $PT_LISTATARJETAS/ns0:PT_LISTATARJETAS_ITEM
                            return
                                <CARD>
                                    <CARD_NUMBER>{ data($PT_LISTATARJETAS_ITEM/ns0:CARDID) }</CARD_NUMBER>
                                    <CARD_TYPE>{ data($PT_LISTATARJETAS_ITEM/ns0:CARDTYPE) }</CARD_TYPE>
                                    <CARD_HOLDER_NAME>{ data($PT_LISTATARJETAS_ITEM/ns0:CARDHOLDERNAME) }</CARD_HOLDER_NAME>
                                    <ENC_CARD>{ data($PT_LISTATARJETAS_ITEM/ns0:ENCCARD) }</ENC_CARD>
                                    <LAST_FOUR_DIGITS>{ data($PT_LISTATARJETAS_ITEM/ns0:LASTFOURDIGITS) }</LAST_FOUR_DIGITS>
                                    <PAYMENT_NETWORK>{ data($PT_LISTATARJETAS_ITEM/ns0:PV_PAYMENTNERWORK) }</PAYMENT_NETWORK>
                                    <INST_CODE>{ data($PT_LISTATARJETAS_ITEM/ns0:PV_INSTCODE) }</INST_CODE>
                                </CARD>
                        }
                    </CARDS>
            }
        </ns1:movilGetListCardsResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:movilGetListCardsOut($outputParameters)