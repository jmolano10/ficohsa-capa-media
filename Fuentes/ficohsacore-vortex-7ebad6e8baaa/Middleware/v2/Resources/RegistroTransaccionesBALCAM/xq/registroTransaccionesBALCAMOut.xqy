xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/RegistroTransaccionesBALCAM/xsd/registroTransaccionesBalcam_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroTransaccionesBalcam";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistroTransaccionesBALCAM/xq/registroTransaccionesBALCAMOut/";

declare function xf:registroTransaccionesBALCAMOut($transactionId as xs:string,
    $sessionId as xs:string,
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ data($transactionId) }</TRANSACTION_ID>
            <SESSION_ID>{ data($sessionId) }</SESSION_ID>
            {
                if(upper-case(data($outputParameters1/ns0:PV_CODIGO_MENSAJE)) = "ERROR") then (
            	let $message := concat(
            		data($outputParameters1/ns0:PV_CODIGO_MENSAJE), 
	            	'@FM',
	            	data($outputParameters1/ns0:PV_DETALLE_MENSAJE),
	            	'@FM',
	            	data($outputParameters1/ns0:PV_TRAMA_TRANS_ERR)
	            )
	            return
            	<MESSAGE>{ $message }</MESSAGE>
            	)  else (
            		<MESSAGE>SUCCESS</MESSAGE>
            	)
            }
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:registroTransaccionesBALCAMOut($transactionId,
    $sessionId,
    $outputParameters1)