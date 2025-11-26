(:: pragma bea:global-element-parameter parameter="$ficocelTransaccionesServiceResponse" element="ns0:FicocelTransaccionesServiceResponse" location="../Resources/XMLSchema_770518505.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://hn.com.ficohsa.ficoceltransacciones.service/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelTransacciones/ProcesaMensajeFicocel/ProcesaMensajeFicocelHeaderOut/";

declare function xf:ProcesaMensajeFicocelHeaderOut($ficocelTransaccionesServiceResponse as element(ns0:FicocelTransaccionesServiceResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $ficocelTransaccionesServiceResponse/return/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $ficocelTransaccionesServiceResponse/return/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $valueDate in $ficocelTransaccionesServiceResponse/return/valueDate
                return
                    <valueDate>{ data($valueDate) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $ficocelTransaccionesServiceResponse as element(ns0:FicocelTransaccionesServiceResponse) external;

xf:ProcesaMensajeFicocelHeaderOut($ficocelTransaccionesServiceResponse)