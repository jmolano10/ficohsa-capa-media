(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/NotificaCicloVidaTarjetas/xsd/notificaCicloVidaTarjetas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaCicloVidaTarjetasResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaCicloVidaTarjetas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaCicloVidaTarjetas/xq/notificaCicloVidaTarjetasOut/";

declare function xf:notificaCicloVidaTarjetasOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:notificaCicloVidaTarjetasResponse) {
        <ns1:notificaCicloVidaTarjetasResponse>
            {
                for $PV_REQUESTIDOUT in $outputParameters/ns0:PV_REQUESTIDOUT
                return
                    <REQUEST_ID>{ data($PV_REQUESTIDOUT) }</REQUEST_ID>
            }
            {
                for $PV_RETURNCODE in $outputParameters/ns0:PV_RETURNCODE
                return
                    <RETURN_CODE>{ data($PV_RETURNCODE) }</RETURN_CODE>
            }
            {
                for $PV_ERRORDESCRIPTION in $outputParameters/ns0:PV_ERRORDESCRIPTION
                return
                    <ERROR_DESCRIPTION>{ data($PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
            }
        </ns1:notificaCicloVidaTarjetasResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:notificaCicloVidaTarjetasOut($outputParameters)