(:: pragma bea:global-element-parameter parameter="$consultaDatoAplicacion" element="ns0:consultaDatoAplicacion" location="../xsd/consultaDatoAplicacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatoCreditScore";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatoAplicacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatoAplicacion/xq/consultaDatoCreditScoreHNIn/";

declare function xf:consultaDatoCreditScoreHNIn($consultaDatoAplicacion as element(ns0:consultaDatoAplicacion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_DATA_IDENTIFIER>{ data($consultaDatoAplicacion/ns0:DATA_IDENTIFIER) }</ns1:P_DATA_IDENTIFIER>
        </ns1:InputParameters>
};

declare variable $consultaDatoAplicacion as element(ns0:consultaDatoAplicacion) external;

xf:consultaDatoCreditScoreHNIn($consultaDatoAplicacion)
