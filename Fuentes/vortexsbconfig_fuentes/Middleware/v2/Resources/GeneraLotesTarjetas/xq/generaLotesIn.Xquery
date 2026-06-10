<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaLotesTarjetas" element="ns1:generaLotesTarjetas" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEBITCARD/generaLotesAjuste/xsd/generaLotes_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generaLotes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraLotesTarjetas/xq/generaLotesIn/";

declare function xf:generaLotesIn($generaLotesTarjetas as element(ns1:generaLotesTarjetas),
    $channel as xs:string,
    $cardLifespan as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BIN>{ data($generaLotesTarjetas/BIN) }</ns0:PV_BIN>
            <ns0:PN_QUANTITY>{ data($generaLotesTarjetas/QUANTITY) }</ns0:PN_QUANTITY>
            <ns0:PN_CARDS_LIFESPAN>{ data($cardLifespan) }</ns0:PN_CARDS_LIFESPAN>
            <ns0:PV_CHANNEL>{ $channel }</ns0:PV_CHANNEL>
        </ns0:InputParameters>
};

declare variable $generaLotesTarjetas as element(ns1:generaLotesTarjetas) external;
declare variable $channel as xs:string external;
declare variable $cardLifespan as xs:string external;

xf:generaLotesIn($generaLotesTarjetas,
    $channel,
    $cardLifespan)]]></con:xquery>
    <con:dependency location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DEBITCARD/generaLotesAjuste/xsd/generaLotes_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEBITCARD/generaLotes/xsd/generaLotes_sp"/>
    </con:dependency>
</con:xqueryEntry>