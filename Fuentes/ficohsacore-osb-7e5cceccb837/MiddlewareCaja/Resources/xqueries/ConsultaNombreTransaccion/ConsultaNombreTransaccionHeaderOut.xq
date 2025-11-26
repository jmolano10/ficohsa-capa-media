(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../xsds/ConsultaNombreTransaccion/consultarNombreTransaccionT24/MIDDLEWARE_OSB_CONSULTAR_TRANSACCION_MISC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/OSB_CONSULTAR_TRANSACCION_MISC/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaNombreTransaccion/ConsultaNombreTransaccionHeaderOut/";

declare function xf:ConsultaNombreTransaccionHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $CODIGO_ERROR in $outputParameters/ns0:CODIGO_ERROR
                return
                    <successIndicator>{ data($CODIGO_ERROR) }</successIndicator>
            }
            {
                for $DESCRIPCION_ERROR in $outputParameters/ns0:DESCRIPCION_ERROR
                return
                    <messages>{ data($DESCRIPCION_ERROR) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:ConsultaNombreTransaccionHeaderOut($outputParameters)