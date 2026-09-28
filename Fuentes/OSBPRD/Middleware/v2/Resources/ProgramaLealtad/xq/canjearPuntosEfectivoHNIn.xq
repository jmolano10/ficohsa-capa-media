(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/canjearPuntosEfectivo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoHNIn/";

declare function xf:canjearPuntosEfectivoHNIn($logo as xs:string,
    $merchantNumber as xs:string,
    $merchantType as xs:string,
    $terminalId as xs:string,
    $conversionType as xs:string,
    $conversionAmount as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_LOGO>{ data($logo) }</ns0:PN_LOGO>
            <ns0:PV_CODIGOCOMERCIO>{ $merchantNumber }</ns0:PV_CODIGOCOMERCIO>
            <ns0:PV_GRUPOCOMERCIO>{ $merchantType }</ns0:PV_GRUPOCOMERCIO>
            <ns0:PV_CODIGOTERMINAL>{ $terminalId }</ns0:PV_CODIGOTERMINAL>
            <ns0:PN_TIPOCONVERSION>{ data($conversionType) }</ns0:PN_TIPOCONVERSION>
            <ns0:PN_VALORENTRADA>{ data($conversionAmount) }</ns0:PN_VALORENTRADA>
        </ns0:InputParameters>
};

declare variable $logo as xs:string external;
declare variable $merchantNumber as xs:string external;
declare variable $merchantType as xs:string external;
declare variable $terminalId as xs:string external;
declare variable $conversionType as xs:string external;
declare variable $conversionAmount as xs:string external;

xf:canjearPuntosEfectivoHNIn($logo,
    $merchantNumber,
    $merchantType,
    $terminalId,
    $conversionType,
    $conversionAmount)