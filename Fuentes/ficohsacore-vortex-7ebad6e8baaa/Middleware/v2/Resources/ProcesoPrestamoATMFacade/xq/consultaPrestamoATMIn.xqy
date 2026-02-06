xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest1" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPrestamoATMRequest" location="../../ConsultaPrestamoATM/xsd/consultaPrestamoATMTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPrestamoATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesoPrestamoATMFacade/xq/consultaPrestamoATMIn/";

declare function xf:consultaPrestamoATMIn($procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:consultaPrestamoATMRequest) {
        <ns1:consultaPrestamoATMRequest>
            <PRODUCT_TYPE>DEBIT_CARD</PRODUCT_TYPE>
            <PRODUCT_VALUE>{ data($procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/PrimaryAccountNumber_002) }</PRODUCT_VALUE>
        </ns1:consultaPrestamoATMRequest>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:consultaPrestamoATMIn($procesaMensajeGenericoSwitchFacadeRequest1)