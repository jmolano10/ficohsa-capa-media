(:: pragma bea:global-element-return element="ns0:Status" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)

declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosMora/xq/VerificarServiciosCreditForceIn/";

declare function xf:VerificarServiciosCreditForceIn($token as xs:string)
    as element(ns0:Status) {
        <ns0:Status>
            <ns0:apikey>{ $token }</ns0:apikey>
        </ns0:Status>
};

declare variable $token as xs:string external;

xf:VerificarServiciosCreditForceIn($token)