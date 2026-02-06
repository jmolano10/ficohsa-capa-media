xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest1" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reversaCuponATM" location="../xsd/reversaCuponATMTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversaCuponATMTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaCuponATM/xq/reversarATMConCupon/";

declare function xf:reversarATMConCupon($procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:reversaCuponATM) {
        <ns1:reversaCuponATM>
            <RETRIEVAL_REFERENCE>{ $procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037/@* , $procesaMensajeGenericoSwitchFacadeRequest1/ISO8583/ISO8583_XML_CONTENT/RetrievalReferenceNumber_037/node() }</RETRIEVAL_REFERENCE>
        </ns1:reversaCuponATM>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest1 as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:reversarATMConCupon($procesaMensajeGenericoSwitchFacadeRequest1)