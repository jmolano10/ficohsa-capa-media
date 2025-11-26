(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito" element="ns0:consultaSaldosTarjetaCredito" location="../../xsds/ConsultaSaldosTarjetaCredito/ConsultaSaldosTarjetaCredito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../Middleware/v2/BusinessServices/OSB/consultaSaldosTarjetaCredito_v2/xsd/XMLSchema_222393921.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns0:consultaSaldosTarjetaCredito) {
        <ns0:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ data($consultaSaldosTarjetaCredito/CARD_NUMBER) }</CARD_NUMBER>
        </ns0:consultaSaldosTarjetaCredito>
};

declare variable $consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldosTarjetaCreditoIn($consultaSaldosTarjetaCredito)
