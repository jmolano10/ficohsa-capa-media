<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MovilGetCardsList/xsd/movilGetListCards_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:movilGetListCardsResponse" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetListCards";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetListCards/xq/movilGetListCardsOut/";

declare function xf:movilGetListCardsOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:movilGetListCardsResponse) {
        <ns1:movilGetListCardsResponse>
            {
                for $PV_BILLINGADDRESS in $outputParameters/ns0:PV_BILLINGADDRESS
                return
                    <BILLING_ADDRESS>{ data($PV_BILLINGADDRESS) }</BILLING_ADDRESS>
            }
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
                                    {
                                        for $EXPIRATIONDATE in $PT_LISTATARJETAS_ITEM/ns0:EXPIRATIONDATE
                                        return
                                            <EXPIRATION_DATE>{ data($EXPIRATIONDATE) }</EXPIRATION_DATE>
                                    }
                                    {
                                        for $COUNTRYCODE in $PT_LISTATARJETAS_ITEM/ns0:COUNTRYCODE
                                        return
                                            <COUNTRY_CODE>{ data($COUNTRYCODE) }</COUNTRY_CODE>
                                    }
                                </CARD>
                        }
                    </CARDS>
            }
        </ns1:movilGetListCardsResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:movilGetListCardsOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MovilGetCardsList/xsd/movilGetListCards_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilGetCardsList/xsd/movilGetListCards_sp"/>
    </con:dependency>
    <con:dependency location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MovilDigitizationCards/xsd/movilDigitizationCardsTypes"/>
    </con:dependency>
</con:xqueryEntry>