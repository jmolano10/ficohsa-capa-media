xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/consultaProgramaLealtad/xsd/consultaProgramaLealtad_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaProgramaLealtad";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/consultaProgramaLealtadIn/";

declare function xf:consultaProgramaLealtadIn($logo as xs:string,
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_LOGO>{ $logo }</ns0:PN_LOGO>
            <ns0:PV_CODIGOPAIS>{ $codigoPais }</ns0:PV_CODIGOPAIS>
        </ns0:InputParameters>
};

declare variable $logo as xs:string external;
declare variable $codigoPais as xs:string external;

xf:consultaProgramaLealtadIn($logo,
    $codigoPais)