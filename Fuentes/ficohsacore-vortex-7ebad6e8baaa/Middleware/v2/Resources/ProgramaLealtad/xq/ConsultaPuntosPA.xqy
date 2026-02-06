xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:identity" location="../../../BusinessServices/Mastercard/Common/xsd/CommonResponses.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/ConsultaPuntosPA/";
declare namespace ns0 = "http://common.ws.mcrewards.mastercard.com/";

declare function xf:ConsultaPuntosPA($IdentidadClientePA as xs:string,
    $InstitutionNamePA as xs:string)
as element(ns0:identity) {
    <ns0:identity>
            <ns0:appID>{ $IdentidadClientePA }</ns0:appID>
            <ns0:institutionName>{ $InstitutionNamePA }</ns0:institutionName>
        </ns0:identity>
};

declare variable $IdentidadClientePA as xs:string external;
declare variable $InstitutionNamePA as xs:string external;

xf:ConsultaPuntosPA($IdentidadClientePA,$InstitutionNamePA)