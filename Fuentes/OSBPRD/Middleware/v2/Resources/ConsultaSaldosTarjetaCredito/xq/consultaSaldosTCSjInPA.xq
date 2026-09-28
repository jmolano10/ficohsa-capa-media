(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoPA" element="ns0:consultaSaldosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaSaldosTC" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCSjInPA/";

declare function xf:consultaSaldosTCSjInPA($consultaSaldosTarjetaCreditoPA as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns1:sjConsultaSaldosTC) {
        <ns1:sjConsultaSaldosTC>
            <CARD_NUMBER>{ data($consultaSaldosTarjetaCreditoPA/CARD_NUMBER) }</CARD_NUMBER>
        </ns1:sjConsultaSaldosTC>
};

declare variable $consultaSaldosTarjetaCreditoPA as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTCSjInPA($consultaSaldosTarjetaCreditoPA)