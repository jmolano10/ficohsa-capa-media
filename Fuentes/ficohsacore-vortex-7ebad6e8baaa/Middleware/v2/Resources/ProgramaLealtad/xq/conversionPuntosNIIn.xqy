xquery version "2004-draft";
(:: pragma bea:schema-type-parameter parameter="$cashRedemptionType1" type="ns0:cashRedemptionType" location="../xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PXYNIC/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/canjearPuntosEfectivo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosNIIn/";

declare function xf:conversionPuntosNIIn($cashRedemptionType1 as element(),
    $montoConversion as xs:string,
    $tipoConversion as xs:string,
    $logo as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:PN_LOGO>{ $logo }</ns1:PN_LOGO>
            <ns1:PV_CODIGOCOMERCIO>{ data($cashRedemptionType1/MERCHANT_ID) }</ns1:PV_CODIGOCOMERCIO>
            <ns1:PV_GRUPOCOMERCIO>{ data($cashRedemptionType1/MERCHANT_TYPE) }</ns1:PV_GRUPOCOMERCIO>
            <ns1:PV_CODIGOTERMINAL>{ data($cashRedemptionType1/TERMINAL_ID) }</ns1:PV_CODIGOTERMINAL>
            <ns1:PN_TIPOCONVERSION>{ $tipoConversion }</ns1:PN_TIPOCONVERSION>
            <ns1:PN_VALORENTRADA>{ $montoConversion }</ns1:PN_VALORENTRADA>
        </ns1:InputParameters>
};

declare variable $cashRedemptionType1 as element() external;
declare variable $montoConversion as xs:string external;
declare variable $tipoConversion as xs:string external;
declare variable $logo as xs:string external;

xf:conversionPuntosNIIn($cashRedemptionType1,
    $montoConversion,
    $tipoConversion,
    $logo)