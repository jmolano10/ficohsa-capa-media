(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd" ::)
(:: pragma bea:schema-type-return type="ns0:serviceRequest" location="../../../BusinessServices/enrutadorConvenios/xsd/XMLSchema_-1423180259.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_ARMAR_MENSAJE/";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/enrrutadorConveniosIn/";

declare function xf:enrrutadorConveniosIn($outputParameters as element(ns1:OutputParameters))
    as element() {
        <ns0:serviceRequest>
            {
                for $MENSAJE in $outputParameters/ns1:MENSAJE
                return
                    <requestData>{ data($MENSAJE) }</requestData>
            }
        </ns0:serviceRequest>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:enrrutadorConveniosIn($outputParameters)