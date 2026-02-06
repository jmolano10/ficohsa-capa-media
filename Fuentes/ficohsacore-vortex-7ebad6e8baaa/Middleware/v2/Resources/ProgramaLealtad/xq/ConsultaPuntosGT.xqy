xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:identity" location="../../../BusinessServices/Mastercard/Common/xsd/CommonResponses.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/ConsultaPuntosGT/";
declare namespace ns0 = "http://common.ws.mcrewards.mastercard.com/";

declare function xf:ConsultaPuntosGT($IdentidadClienteGT as xs:string,
    $InstitutionNameGT as xs:string)
as element(ns0:identity) {
   <ns0:identity>
            <ns0:appID>{ $IdentidadClienteGT }</ns0:appID>
            <ns0:institutionName>{ $InstitutionNameGT }</ns0:institutionName>
        </ns0:identity>
};

declare variable $IdentidadClienteGT as xs:string external;
declare variable $InstitutionNameGT as xs:string external;

xf:ConsultaPuntosGT($IdentidadClienteGT,$InstitutionNameGT)