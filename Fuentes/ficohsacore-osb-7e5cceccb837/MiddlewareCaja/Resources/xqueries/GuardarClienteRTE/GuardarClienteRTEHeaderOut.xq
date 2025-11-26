(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../xsds/GuardarClienteRTE/GuardarClienteRTE/FLINK_OSB_GUARDAR_CLIENTE_RTE.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_GUARDAR_CLIENTE_RTE/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/GuardarClienteRTE/GuardarClienteRTEHeaderOut/";

declare function xf:GuardarClienteRTEHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $CODIGO_ERROR in $outputParameters/ns0:CODIGO_ERROR
                return
                    <successIndicator>{ data($CODIGO_ERROR) }</successIndicator>
            }
            {
                for $MENSAJE_ERROR in $outputParameters/ns0:MENSAJE_ERROR
                return
                    <messages>{ data($MENSAJE_ERROR) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:GuardarClienteRTEHeaderOut($outputParameters)