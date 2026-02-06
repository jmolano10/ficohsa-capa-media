xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTransferenciasACHResponse" element="ns0:consultaTransferenciasACHResponse" location="../../ConsultaTransferenciasACH/xsd/consultaTransferenciasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransferenciasACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaTransferenciaACHOut/";

declare function xf:consultaTransferenciaACHOut($consultaTransferenciasACHResponse as element(ns0:consultaTransferenciasACHResponse),
    $TRANSACTION_ID as xs:string,
    $SESSION_ID as xs:string,
    $MESSAGES as xs:string,
    $SUCCESINDICATOR as xs:string)
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $TRANSACTION_ID }</TRANSACTION_ID>
            <SESSION_ID>{ $SESSION_ID }</SESSION_ID>
            <MESSAGE>
            { 
	            if($SUCCESINDICATOR = "SUCCESS") then (
	            	 concat(
		             $SUCCESINDICATOR ,"|",
		             $MESSAGES , "|",
		             $consultaTransferenciasACHResponse/TRANSACTION_RECORD/STATUS , "|",
		             $consultaTransferenciasACHResponse/IDENTIFICATION , "|",
		             $consultaTransferenciasACHResponse/MESSAGE_TYPE , "|",
		             $consultaTransferenciasACHResponse/RESULT_MESSAGE , "|",
		             $consultaTransferenciasACHResponse/ORIGINAL_MESSAGE_ID , "|",
		             $consultaTransferenciasACHResponse/PROCESSED_DATE ,"|",
		             $consultaTransferenciasACHResponse/RECEIVING_BANK_ID ,"|",
		             $consultaTransferenciasACHResponse/USERNAME , "|",
		             $consultaTransferenciasACHResponse/REASON_CODE) )
	            else(
	            	 concat(
		             $SUCCESINDICATOR ,"|",
		             $MESSAGES , "|")
	            )

	        }
            </MESSAGE>
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $consultaTransferenciasACHResponse as element(ns0:consultaTransferenciasACHResponse) external;
declare variable $TRANSACTION_ID as xs:string external;
declare variable $SESSION_ID as xs:string external;
declare variable $MESSAGES as xs:string external;
declare variable $SUCCESINDICATOR as xs:string external;

xf:consultaTransferenciaACHOut($consultaTransferenciasACHResponse,
    $TRANSACTION_ID,
    $SESSION_ID,
    $MESSAGES,
    $SUCCESINDICATOR)