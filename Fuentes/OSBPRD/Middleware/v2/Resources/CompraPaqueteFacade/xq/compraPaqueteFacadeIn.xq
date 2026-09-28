xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:compraPaquete" location="../../CompraPaquete/xsd/compraPaqueteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaqueteFacade/compraPaqueteFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/compraPaqueteTypes";

declare function xf:compraPaqueteFacadeIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest))
    as element(ns1:compraPaquete) {
        <ns1:compraPaquete>
        {
        let $messageListPipe := fn:tokenize(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048),"\|\|")
        return(
			<PHONE_CARRIER>{ $messageListPipe[1] }</PHONE_CARRIER>,
			<PHONE_NUMBER>{ $messageListPipe[2] }</PHONE_NUMBER>,
			<PACK_CODE>{ $messageListPipe[3] }</PACK_CODE>,
			<AMOUNT>{ (xs:decimal(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AmountTransaction_004)) div 100) }</AMOUNT>,
			<DEBIT_ACCOUNT>{ $messageListPipe[4] }</DEBIT_ACCOUNT>,
			<CHANNEL_CODE/>
			  
        )
        }
        </ns1:compraPaquete>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;

xf:compraPaqueteFacadeIn($procesaMensajeGenericoSwitchFacadeRequest)