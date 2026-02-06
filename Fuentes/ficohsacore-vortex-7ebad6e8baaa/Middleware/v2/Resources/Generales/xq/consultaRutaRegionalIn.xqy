xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaRutaRegional/xsd/consultaRutaRegional_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/consultaRutaRegionalIn/";

declare function xf:consultaRutaRegionalIn($requestHeader as element(ns1:RequestHeader),
    $idServicio as xs:string,
    $operacion as xs:string,
    $version as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SERVICIO>{ $idServicio }</ns0:PV_SERVICIO>
            <ns0:PV_ORIGEN>{ data($requestHeader/Region/SourceBank) }</ns0:PV_ORIGEN>
            {
                for $destinationBank in $requestHeader/Region/DestinationBank
                return
                    <ns0:PV_DESTINO>{ data($destinationBank) }</ns0:PV_DESTINO>
            }
            <ns0:PV_OPERACION>{ $operacion }</ns0:PV_OPERACION>
            <ns0:PV_VERSION>{ $version }</ns0:PV_VERSION>
            <ns0:PV_USUARIO>{ upper-case($requestHeader/Authentication/UserName/text()) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $idServicio as xs:string external;
declare variable $operacion as xs:string external;
declare variable $version as xs:string external;

xf:consultaRutaRegionalIn($requestHeader,
    $idServicio,
    $operacion,
    $version)