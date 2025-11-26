(:: pragma bea:global-element-parameter parameter="$ficocelTransaccionesServiceResponse" element="ns0:FicocelTransaccionesServiceResponse" location="../Resources/XMLSchema_770518505.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeFicocelResponse" location="procesaMensajeFicocelTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeFicocelTypes";
declare namespace ns0 = "http://hn.com.ficohsa.ficoceltransacciones.service/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelTransacciones/ProcesaMensajeFicocel/procesaMensajeFicocelOut/";

declare function xf:procesaMensajeFicocelOut($ficocelTransaccionesServiceResponse as element(ns0:FicocelTransaccionesServiceResponse))
    as element(ns1:procesaMensajeFicocelResponse) {
        <ns1:procesaMensajeFicocelResponse>
            {
                for $shortMessage in $ficocelTransaccionesServiceResponse/return/shortMessage
                return
                    <SHORT_MESSAGE>{ data($shortMessage) }</SHORT_MESSAGE>
            }
            {
                for $mobileNumber in $ficocelTransaccionesServiceResponse/return/mobileNumber
                return
                    <MOBILE_NUMBER>{ data($mobileNumber) }</MOBILE_NUMBER>
            }
        </ns1:procesaMensajeFicocelResponse>
};

declare variable $ficocelTransaccionesServiceResponse as element(ns0:FicocelTransaccionesServiceResponse) external;

xf:procesaMensajeFicocelOut($ficocelTransaccionesServiceResponse)