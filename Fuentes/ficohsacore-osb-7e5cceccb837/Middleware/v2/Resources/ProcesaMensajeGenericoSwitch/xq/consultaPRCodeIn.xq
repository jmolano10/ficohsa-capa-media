(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchRequest" element="ns2:procesaMensajeGenericoSwitchRequest" location="../xsd/procesaMensajeGenericoSwitchTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/consultaPRCode/xsd/consultaPRCode_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPRCode";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xq/consultaPRCodeIn/";

declare function xf:consultaPRCodeIn($procesaMensajeGenericoSwitchRequest as element(ns2:procesaMensajeGenericoSwitchRequest),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_CODIGOPR>{ data($procesaMensajeGenericoSwitchRequest/PROCESSING_CODE) }</ns1:PN_CODIGOPR>
            <ns1:PN_CODIGOINSTEMISOR>{ data($procesaMensajeGenericoSwitchRequest/FWD_INST_ID_CODE) }</ns1:PN_CODIGOINSTEMISOR>
            <ns1:PV_CODIGOPAIS>{ data($requestHeader/Region/SourceBank) }</ns1:PV_CODIGOPAIS>
        </ns1:InputParameters>
};

declare variable $procesaMensajeGenericoSwitchRequest as element(ns2:procesaMensajeGenericoSwitchRequest) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:consultaPRCodeIn($procesaMensajeGenericoSwitchRequest,
    $requestHeader)
