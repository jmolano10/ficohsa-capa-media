xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resoruces/ObtenerCodigoError/xsd/MIDDLEWARE_CONSULTAR_CODIGO_ERROR.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/CONSULTAR_CODIGO_ERROR/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/obtenerCodigoErrorVA_ERROR/";

declare function xf:obtenerCodigoErrorVA_ERROR($outputParameters as element(ns0:OutputParameters))
    as xs:string {
        data($outputParameters/ns0:VA_ERROR)
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:obtenerCodigoErrorVA_ERROR($outputParameters)