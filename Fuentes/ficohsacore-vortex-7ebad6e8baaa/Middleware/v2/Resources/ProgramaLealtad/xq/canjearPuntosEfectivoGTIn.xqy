xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:schema-type-parameter parameter="$cashRedemptionType" type="ns1:cashRedemptionType" location="../xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoGTIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/canjearPuntosEfectivo";

declare function xf:canjearPuntosEfectivoGTIn($cashRedemptionType as element(),
    $montoConversion as xs:string,
    $tipoConversion as xs:string,
    $logo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:PN_LOGO>{ $logo }</ns0:PN_LOGO>
            <ns0:PV_CODIGOCOMERCIO>{ data($cashRedemptionType/MERCHANT_ID) }</ns0:PV_CODIGOCOMERCIO>
            <ns0:PV_GRUPOCOMERCIO>{ data($cashRedemptionType/MERCHANT_TYPE) }</ns0:PV_GRUPOCOMERCIO>
            <ns0:PV_CODIGOTERMINAL>{ data($cashRedemptionType/TERMINAL_ID) }</ns0:PV_CODIGOTERMINAL>
            <ns0:PN_TIPOCONVERSION>{ $tipoConversion }</ns0:PN_TIPOCONVERSION>
            <ns0:PN_VALORENTRADA>{ $montoConversion }</ns0:PN_VALORENTRADA>
        </ns0:InputParameters>
};

declare variable $cashRedemptionType as element() external;
declare variable $montoConversion as xs:string external;
declare variable $tipoConversion as xs:string external;
declare variable $logo as xs:string external;
xf:canjearPuntosEfectivoGTIn($cashRedemptionType,
    $montoConversion,
    $tipoConversion,
    $logo)