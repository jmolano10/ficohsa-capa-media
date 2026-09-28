(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/TSP/registrarCobroTSP/xsd/registroCobroSP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroCobroSP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/registroCobroTSPBodyOut/";

declare function xf:registroCobroTSPBodyOut($outputParameters1 as element(ns1:OutputParameters),
    $TxnID as xs:string,
    $SessionID as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $TxnID }</TRANSACTION_ID>
            <SESSION_ID>{ $SessionID }</SESSION_ID>
            {
	            if (fn:upper-case(fn:string($outputParameters1/ns1:PV_COD_RSPTA/text())) = "SUCCESS" ) then (
	            <MESSAGE>{ fn:concat("0|SUCCESS|", fn:string($outputParameters1/ns1:PV_DES_RSPTA/text())) }</MESSAGE>
	            )
	            else ( 
	            <MESSAGE>{fn:concat("1|ERROR|", fn:string($outputParameters1/ns1:PV_DES_RSPTA/text()))}</MESSAGE>
	            )
            }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $TxnID as xs:string external;
declare variable $SessionID as xs:string external;

xf:registroCobroTSPBodyOut($outputParameters1,
    $TxnID,
    $SessionID)