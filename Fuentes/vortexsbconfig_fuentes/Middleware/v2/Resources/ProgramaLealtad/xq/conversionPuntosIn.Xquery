<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:local-element-parameter parameter="$cASH_REDEMPTION1" type="ns0:redencionPuntosLealtad/CASH_REDEMPTION" location="../xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/canjearPuntosEfectivo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosIn/";

declare function xf:conversionPuntosIn($cASH_REDEMPTION1 as element(),
    $tipoConversion as xs:string,
    $montoConversion as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_NUMERO_BIN>{ fn:substring(data($cASH_REDEMPTION1/CARD_NUMBER),1,6) }</ns1:PN_NUMERO_BIN>
            <ns1:PV_CODIGO_COMERCIO>{ data($cASH_REDEMPTION1/MERCHANT_ID) }</ns1:PV_CODIGO_COMERCIO>
            <ns1:PV_GRUPO_COMERCIO>{ data($cASH_REDEMPTION1/MERCHANT_TYPE) }</ns1:PV_GRUPO_COMERCIO>
            <ns1:PV_CODIGO_TERMINAL>{ data($cASH_REDEMPTION1/TERMINAL_ID) }</ns1:PV_CODIGO_TERMINAL>
            <ns1:PN_TIPO_CONVERSION>{ $tipoConversion }</ns1:PN_TIPO_CONVERSION>
            <ns1:PN_VALOR_ENTRADA>{ $montoConversion }</ns1:PN_VALOR_ENTRADA>
        </ns1:InputParameters>
};

declare variable $cASH_REDEMPTION1 as element() external;
declare variable $tipoConversion as xs:string external;
declare variable $montoConversion as xs:string external;

xf:conversionPuntosIn($cASH_REDEMPTION1,
    $tipoConversion,
    $montoConversion)]]></con:xquery>
    <con:dependency location="../xsd/programaLealtadTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ProgramaLealtad/xsd/programaLealtadTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MDW/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp"/>
    </con:dependency>
</con:xqueryEntry>