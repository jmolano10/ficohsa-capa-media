xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24Response1" element="ns1:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/MDW/registrarBitacoraMsjT24/xsd/registrarBitacoraMsjT24_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacoraMsjT24";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/registroBitacoraOut/";

declare function xf:registroBitacoraOut($requestHeader1 as element(ns0:RequestHeader),
    $responseHeader1 as element(ns0:ResponseHeader),
    $procesaMensajeGenericoT24Response1 as element(ns1:procesaMensajeGenericoT24Response),
    $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
        	<ns2:PN_IDTRANSACCION>{ $transactionId }</ns2:PN_IDTRANSACCION>
            <ns2:PV_IDSESION>{ $sessionId }</ns2:PV_IDSESION>
            <ns2:PV_USUARIO>{ data($requestHeader1/Authentication/UserName) }</ns2:PV_USUARIO>
            <ns2:PV_BANCOORIGEN>{ data($requestHeader1/Region/SourceBank) }</ns2:PV_BANCOORIGEN>
            <ns2:PV_BANCODESTINO>{ data($requestHeader1/Region/DestinationBank) }</ns2:PV_BANCODESTINO>
            <ns2:PV_TIPOMENSAJE>S</ns2:PV_TIPOMENSAJE>
            <ns2:PV_MENSAJE>{ data($procesaMensajeGenericoT24Response1/MESSAGE) }</ns2:PV_MENSAJE>
            {
                for $successIndicator in $responseHeader1/successIndicator
                return
                    <ns2:PV_CODIGOERRORIN>{ data($successIndicator) }</ns2:PV_CODIGOERRORIN>
            }
            {
                let $result :=
                    for $messages in $responseHeader1/messages
                    return
                        <ns2:PV_MENSAJEERRORIN>{ data($messages) }</ns2:PV_MENSAJEERRORIN>
                return
                    $result[1]
            }
        </ns2:InputParameters>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $responseHeader1 as element(ns0:ResponseHeader) external;
declare variable $procesaMensajeGenericoT24Response1 as element(ns1:procesaMensajeGenericoT24Response) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:registroBitacoraOut($requestHeader1,
    $responseHeader1,
    $procesaMensajeGenericoT24Response1,
    $transactionId,
    $sessionId)