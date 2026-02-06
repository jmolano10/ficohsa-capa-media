xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/AutorizarDevolucionTSP/xsd/autorizarDevolucionTSP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/autorizarDevolucionTSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/autorizarDevolucionTSPOUT/";

declare function xf:autorizarDevolucionTSPOUT($outputParameters1 as element(ns0:OutputParameters),
    $sessionID as xs:string,
    $txnID as xs:string)
    as element(ns1:procesaMensajeGenericoT24Response) {      
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $txnID }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionID }</SESSION_ID>
			{            
            if  (fn:upper-case(fn:string($outputParameters1/ns0:PV_COD_RSPTA/text())) = "SUCCESS") then
        	(
	            <MESSAGE>
	            { 
		            fn:concat(fn:string($outputParameters1/ns0:PV_COD_RSPTA/text()), "@FM", fn:string($outputParameters1/ns0:PV_DES_RSPTA/text()))
		        }
	             </MESSAGE>
	        ) else (
	             <MESSAGE></MESSAGE>
	             )
             }            
        </ns1:procesaMensajeGenericoT24Response>        
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $sessionID as xs:string external;
declare variable $txnID as xs:string external;

xf:autorizarDevolucionTSPOUT($outputParameters1,
    $sessionID,
    $txnID)