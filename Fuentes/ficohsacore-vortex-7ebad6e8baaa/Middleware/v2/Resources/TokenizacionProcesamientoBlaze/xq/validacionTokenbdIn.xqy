xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/tokenizacionProcesamientoBlazedb";
(:: import schema at "../../../BusinessServices/MDW/tokenizacionProcesamientoBlaze/xsd/tokenizacionProcesamientoBlazedb_sp.xsd" ::)

declare variable $codigoAplicacion as xs:string external;
declare variable $accessToken as xs:string external;

declare function local:validacionTokenbdIn($codigoAplicacion as xs:string, 
                                           $accessToken as xs:string) 
                                           as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_CODIGO_APLICACION>{fn:data($codigoAplicacion)}</ns1:P_CODIGO_APLICACION>
        <ns1:P_TOKEN>{if (fn:empty($accessToken)) then () else $accessToken}</ns1:P_TOKEN>
    </ns1:InputParameters>
};

local:validacionTokenbdIn($codigoAplicacion, $accessToken)