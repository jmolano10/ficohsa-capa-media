<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
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
    $Moneda)]]></con:xquery>
    <con:dependency location="../xsd/pagoBancaSatTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/PagoBancaSat/xsd/pagoBancaSatTypes"/>
    </con:dependency>
</con:xqueryEntry>