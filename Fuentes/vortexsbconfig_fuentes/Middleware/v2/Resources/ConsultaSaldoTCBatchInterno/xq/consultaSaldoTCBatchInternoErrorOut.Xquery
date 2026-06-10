<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoTCBatchInterno" element="ns0:ConsultaSaldoTCBatchInterno" location="../xsd/consultaSaldoTCBatchInternoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaSaldoTCBatchInternoResponse" location="../xsd/consultaSaldoTCBatchInternoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaSaldoTCBatchInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoTCBatchInterno/xq/consultaSaldoTCBatchInternoErrorOut/";

declare function xf:consultaSaldoTCBatchInternoErrorOut($consultaSaldoTCBatchInterno as element(ns0:ConsultaSaldoTCBatchInterno),
    $successIndicator as xs:string,
    $errorMessage as xs:string)
    as element(ns0:ConsultaSaldoTCBatchInternoResponse) {
        <ns0:ConsultaSaldoTCBatchInternoResponse>
            <CARDS>
                {
                    for $CARD in $consultaSaldoTCBatchInterno/CARDS/CARD
                    return
                        <CARD>
                            <ID>{ data($CARD/ID) }</ID>
                            <SOURCE_BANK>{ data($CARD/PRODUCT_REGION) }</SOURCE_BANK>
                            <SUCCESS_INDICATOR>{ $successIndicator }</SUCCESS_INDICATOR>
                            <ERROR_MESSAGE>{ $errorMessage }</ERROR_MESSAGE>
                        </CARD>
                }
            </CARDS>
        </ns0:ConsultaSaldoTCBatchInternoResponse>
};

declare variable $consultaSaldoTCBatchInterno as element(ns0:ConsultaSaldoTCBatchInterno) external;
declare variable $successIndicator as xs:string external;
declare variable $errorMessage as xs:string external;

xf:consultaSaldoTCBatchInternoErrorOut($consultaSaldoTCBatchInterno,
    $successIndicator,
    $errorMessage)]]></con:xquery>
    <con:dependency location="../xsd/consultaSaldoTCBatchInternoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSaldoTCBatchInterno/xsd/consultaSaldoTCBatchInternoTypes"/>
    </con:dependency>
</con:xqueryEntry>