(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaSaldosTCIn/";

declare function xf:consultaSaldosTCIn($productID as xs:string)
    as element(ns0:consultaSaldosTarjetaCredito) {
        <ns0:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ $productID }</CARD_NUMBER>
        </ns0:consultaSaldosTarjetaCredito>
};

declare variable $productID as xs:string external;

xf:consultaSaldosTCIn($productID)