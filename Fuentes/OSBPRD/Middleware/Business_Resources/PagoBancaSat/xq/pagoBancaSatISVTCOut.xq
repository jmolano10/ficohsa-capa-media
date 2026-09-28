(:: pragma bea:global-element-return element="ns0:pagoBancaSatResponse" location="../xsd/pagoBancaSatTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoBancaSatTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatISVTCOut/";

declare function xf:pagoBancaSatISVTCOut($TarjetaCredito as xs:string,
    $Monto as xs:decimal,
    $Moneda as xs:string)
    as element(ns0:pagoBancaSatResponse) {
        <ns0:pagoBancaSatResponse>
            <CREDIT_CARD>{ $TarjetaCredito }</CREDIT_CARD>
            <PAYMENT_AMOUNT>{ $Monto }</PAYMENT_AMOUNT>
            <CURRENCY>{ $Moneda }</CURRENCY>
        </ns0:pagoBancaSatResponse>
};

declare variable $TarjetaCredito as xs:string external;
declare variable $Monto as xs:decimal external;
declare variable $Moneda as xs:string external;

xf:pagoBancaSatISVTCOut($TarjetaCredito,
    $Monto,
    $Moneda)