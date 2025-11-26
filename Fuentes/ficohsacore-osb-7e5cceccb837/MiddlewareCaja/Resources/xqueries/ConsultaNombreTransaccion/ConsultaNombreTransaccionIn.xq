(:: pragma bea:global-element-parameter parameter="$consultaNombreTransaccion" element="ns0:consultaNombreTransaccion" location="../../xsds/ConsultaNombreTransaccion/ConsultaNombreTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/ConsultaNombreTransaccion/consultarNombreTransaccionT24/MIDDLEWARE_OSB_CONSULTAR_TRANSACCION_MISC.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/OSB_CONSULTAR_TRANSACCION_MISC/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaNombreTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaNombreTransaccion/consultaNombreTransaccionIn/";

declare function xf:consultaNombreTransaccionIn($consultaNombreTransaccion as element(ns0:consultaNombreTransaccion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $TRANSACTION_ID in $consultaNombreTransaccion/TRANSACTION_ID
                return
                    <ns1:ID_TRANSACCION_CONS>{ data($TRANSACTION_ID) }</ns1:ID_TRANSACCION_CONS>
            }
        </ns1:InputParameters>
};

declare variable $consultaNombreTransaccion as element(ns0:consultaNombreTransaccion) external;

xf:consultaNombreTransaccionIn($consultaNombreTransaccion)