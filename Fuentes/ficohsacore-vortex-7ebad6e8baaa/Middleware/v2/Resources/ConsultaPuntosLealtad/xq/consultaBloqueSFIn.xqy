xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaBloqueoTcSalesForceRequest" location="../../ConsultaBloqueoTcSalesForce/xsd/consultaBloqueoTcSalesForceTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBloqueoTcSalesForceTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaBloqueSFIn/";

declare function xf:consultaBloqueSFIn($string as xs:string)
    as element(ns0:consultaBloqueoTcSalesForceRequest) {
        <ns0:consultaBloqueoTcSalesForceRequest>
            <LEGAL_ID>{ $string }</LEGAL_ID>
        </ns0:consultaBloqueoTcSalesForceRequest>
};

declare variable $string as xs:string external;

xf:consultaBloqueSFIn($string)