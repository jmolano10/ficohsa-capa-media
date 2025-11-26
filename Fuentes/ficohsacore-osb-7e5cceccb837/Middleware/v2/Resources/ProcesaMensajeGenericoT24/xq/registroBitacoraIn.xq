(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns1:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/registrarBitacoraMsjT24/xsd/registrarBitacoraMsjT24_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacoraMsjT24";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/registroBitacoraIn/";

declare function xf:registroBitacoraIn($requestHeader1 as element(ns2:RequestHeader),
    $procesaMensajeGenericoT241 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:PN_IDTRANSACCION>{ data($procesaMensajeGenericoT241/TRANSACTION_ID) }</ns0:PN_IDTRANSACCION>
            <ns0:PV_IDSESION>{ data($procesaMensajeGenericoT241/SESSION_ID) }</ns0:PV_IDSESION>
            <ns0:PV_USUARIO>{ data($requestHeader1/Authentication/UserName) }</ns0:PV_USUARIO>
            <ns0:PV_BANCOORIGEN>{ data($requestHeader1/Region/SourceBank) }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ data($requestHeader1/Region/DestinationBank) }</ns0:PV_BANCODESTINO>
            <ns0:PV_TIPOMENSAJE>E</ns0:PV_TIPOMENSAJE>
            <ns0:PV_MENSAJE>{ data($procesaMensajeGenericoT241/MESSAGE) }</ns0:PV_MENSAJE>
            <ns0:PV_CODIGOERRORIN></ns0:PV_CODIGOERRORIN>
            <ns0:PV_MENSAJEERRORIN></ns0:PV_MENSAJEERRORIN>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $procesaMensajeGenericoT241 as element(ns1:procesaMensajeGenericoT24) external;

xf:registroBitacoraIn($requestHeader1,
    $procesaMensajeGenericoT241)