(:: pragma bea:local-element-parameter parameter="$cASH_REDEMPTION1" type="ns0:redencionPuntosLealtad/CASH_REDEMPTION" location="../xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/canjearPuntosEfectivo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosIn/";

declare function xf:conversionPuntosIn($cASH_REDEMPTION1 as element(),
    $tipoConversion as xs:string,
    $montoConversion as xs:string,
    $logo as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_LOGO>{ data($logo) }</ns1:PN_LOGO>
            <ns1:PV_CODIGOCOMERCIO>{ data($cASH_REDEMPTION1/MERCHANT_ID) }</ns1:PV_CODIGOCOMERCIO>
            <ns1:PV_GRUPOCOMERCIO>{ data($cASH_REDEMPTION1/MERCHANT_TYPE) }</ns1:PV_GRUPOCOMERCIO>
            <ns1:PV_CODIGOTERMINAL>{ data($cASH_REDEMPTION1/TERMINAL_ID) }</ns1:PV_CODIGOTERMINAL>
            <ns1:PN_TIPOCONVERSION>{ data($tipoConversion) }</ns1:PN_TIPOCONVERSION>
            <ns1:PN_VALORENTRADA>{ data($montoConversion) }</ns1:PN_VALORENTRADA>
        </ns1:InputParameters>
};

declare variable $cASH_REDEMPTION1 as element() external;
declare variable $tipoConversion as xs:string external;
declare variable $montoConversion as xs:string external;
declare variable $logo as xs:string external;

xf:conversionPuntosIn($cASH_REDEMPTION1,
    $tipoConversion,
    $montoConversion,
    $logo)
