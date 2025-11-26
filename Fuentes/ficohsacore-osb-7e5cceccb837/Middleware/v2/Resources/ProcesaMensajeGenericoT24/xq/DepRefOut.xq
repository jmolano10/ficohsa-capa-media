(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ITB/validarDepositoRef/xsd/validarDepositoRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarDepositoRef";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/DepRefOut/";

declare function xf:DepRefOut($outputParameters1 as element(ns1:OutputParameters),
    $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
            <ns0:procesaMensajeGenericoT24Response>
	            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
	            <SESSION_ID>{ $sessionId }</SESSION_ID>
	            {
	           		if (fn:string($outputParameters1/ns1:PV_CODMSJ/text()) = "SUCCESS") then (
	           			<MESSAGE>{ fn:concat("0|SUCCESS|",data($outputParameters1/ns1:PV_MENSAJE)) }</MESSAGE>
	           		) else (
	           			<MESSAGE></MESSAGE>
	           		)
	            }
	        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:DepRefOut($outputParameters1,
    $transactionId,
    $sessionId)