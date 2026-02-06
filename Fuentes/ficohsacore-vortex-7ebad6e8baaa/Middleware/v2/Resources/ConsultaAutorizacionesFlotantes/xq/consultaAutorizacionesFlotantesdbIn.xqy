xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaFlotanteTC/xsd/consultaAutorizacionesFlotantes_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAutorizacionesFlotantes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAutorizacionesFlotantes/xq/consultaAutorizacionesFlotantesdbIn/";

declare function xf:consultaAutorizacionesFlotantesdbIn($accountNumber as xs:string,
    $requestHeader as element(ns0:RequestHeader),
    $startDate as xs:string,
    $endtDate as xs:string,
    $logo as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns1:PV_CODIGO_PAIS>
            <ns1:PV_NUMERO_CUENTA>{ $accountNumber }</ns1:PV_NUMERO_CUENTA>
            <ns1:PV_START_DATE>{ $startDate }</ns1:PV_START_DATE>
            <ns1:PV_END_DATE>{ $endtDate }</ns1:PV_END_DATE>
            <ns1:LOGO1>{ $logo }</ns1:LOGO1>
        </ns1:InputParameters>
};

declare variable $accountNumber as xs:string external;
declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $startDate as xs:string external;
declare variable $endtDate as xs:string external;
declare variable $logo as xs:string external;

xf:consultaAutorizacionesFlotantesdbIn($accountNumber,
    $requestHeader,
    $startDate,
    $endtDate,
    $logo)