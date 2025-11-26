(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/TSP/consultaBatchTSP/xsd/consultaBatchTSP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaBatchTSP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaBatchTSPOUT/";

declare function xf:consultaBatchTSPOUT($outputParameters1 as element(ns1:OutputParameters),
    $sessionID as xs:string,
    $txnID as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $txnID }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionID }</SESSION_ID>
            {            
            if (fn:string($outputParameters1/ns1:PV_DESC/text()) != "SUCCESS") then (
        	
	           <MESSAGE>Error </MESSAGE>
	            
	        ) else (
	            <MESSAGE>
	            { 
		            fn:concat(fn:string($outputParameters1/ns1:PV_REF_COB/text()), "@FM", fn:string($outputParameters1/ns1:PV_FECHA_RET/text())
		             ,"@FM", fn:string($outputParameters1/ns1:PV_ACCT_CRED/text()), "@FM", fn:string($outputParameters1/ns1:PV_CURR_CRED/text())
		             ,"@FM", fn:string($outputParameters1/ns1:PV_MONT_DEV/text()) ,"@FM", fn:string($outputParameters1/ns1:PV_DETALLE/text())
		             ,"@FM", fn:string($outputParameters1/ns1:PV_TYP_REF/text()) ,"@FM", fn:string($outputParameters1/ns1:PV_DESC/text()))
		             }
	             </MESSAGE>
	        )
             }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $sessionID as xs:string external;
declare variable $txnID as xs:string external;

xf:consultaBatchTSPOUT($outputParameters1,
    $sessionID,
    $txnID)