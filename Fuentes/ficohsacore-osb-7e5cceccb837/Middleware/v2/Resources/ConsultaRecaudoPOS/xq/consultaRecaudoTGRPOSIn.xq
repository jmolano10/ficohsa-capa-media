xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:Consulta" location="../../../BusinessServices/RecaudoPOSws/xsd/svcTGR1_GD.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoPOS/xq/consultaRecaudoPOSIn/";
declare namespace ns0 = "http://tempuri.org/";

declare function xf:consultaRecaudoPOSIn($codigoTGR as xs:string)
    as element(ns0:Consulta) {
        <ns0:Consulta>
  			<ns0:codigoTGR>{$codigoTGR}</ns0:codigoTGR>
        </ns0:Consulta>
};

declare variable $codigoTGR as xs:string external;

xf:consultaRecaudoPOSIn($codigoTGR)
