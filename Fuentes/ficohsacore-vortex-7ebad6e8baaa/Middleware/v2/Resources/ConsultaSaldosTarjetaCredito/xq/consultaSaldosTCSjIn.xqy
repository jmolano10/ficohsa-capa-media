xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns0:consultaSaldosTarjetaCredito" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaSaldosTC" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCSjIn/";

declare function xf:consultaSaldosTCSjIn($consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns1:sjConsultaSaldosTC) {
        <ns1:sjConsultaSaldosTC>
            <CARD_NUMBER>{ data($consultaSaldosTarjetaCredito1/CARD_NUMBER) }</CARD_NUMBER>
        </ns1:sjConsultaSaldosTC>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTCSjIn($consultaSaldosTarjetaCredito1)