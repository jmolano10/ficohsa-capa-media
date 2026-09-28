(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resoruces/ObtenerCodigoError/xsd/MIDDLEWARE_CONSULTAR_CODIGO_ERROR.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/CONSULTAR_CODIGO_ERROR/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/obtenerCodigoErrorOut/";

declare function xf:obtenerCodigoErrorOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $VA_CODIGO_ERROR in $outputParameters/ns0:VA_CODIGO_ERROR
                return
                    <successIndicator>{ data($VA_CODIGO_ERROR) }</successIndicator>
            }
            {
                for $VA_MENSAJE_RETORNO in $outputParameters/ns0:VA_MENSAJE_RETORNO
                return
                    <messages>{ data($VA_MENSAJE_RETORNO) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:obtenerCodigoErrorOut($outputParameters)