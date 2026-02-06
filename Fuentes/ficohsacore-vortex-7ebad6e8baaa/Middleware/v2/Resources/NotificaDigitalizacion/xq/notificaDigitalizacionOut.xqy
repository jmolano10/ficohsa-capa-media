xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/NotificaDigitalizacion/xsd/notificaDigitalizacion_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaDigitalizacionResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaDigitalizacion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDigitalizacion/xq/notificaDigitalizacionOut/";

declare function xf:notificaDigitalizacionOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:notificaDigitalizacionResponse) {
        <ns1:notificaDigitalizacionResponse>
            {
                for $PV_REQUESTIDOUT in $outputParameters/ns0:PV_REQUESTIDOUT
                return
                    <REQUEST_ID>{ data($PV_REQUESTIDOUT) }</REQUEST_ID>
            }
            {
                for $PV_PROCESSIDOUT in $outputParameters/ns0:PV_PROCESSIDOUT
                return
                    <PROCESS_ID>{ data($PV_PROCESSIDOUT) }</PROCESS_ID>
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
        </ns1:notificaDigitalizacionResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:notificaDigitalizacionOut($outputParameters)