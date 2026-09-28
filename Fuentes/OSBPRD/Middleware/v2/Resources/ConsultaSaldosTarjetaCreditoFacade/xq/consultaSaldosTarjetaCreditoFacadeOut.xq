(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCreditoFacade/xq/consultaSaldosTarjetaCreditoFacadeOut/";

declare function xf:consultaSaldosTarjetaCreditoFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse),
    $orgBase as xs:string,
    $orgAlt as xs:string)
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
                if(upper-case($errorCode) = "SUCCESS") then (
            	let $message := concat(
            		'Success||',
            		data($consultaSaldosTarjetaCreditoResponse/CARD_NUMBER), 
	            	'@FM',
            		data($consultaSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME), 
	            	'@FM', 
	            	data($consultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT), 
	            	'@FM', 
	            	data($consultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT),
			'@FM',
	            	data($consultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT),
	            	'@FM',
	            	data($consultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT),
	            	'@FM',
	            	data($consultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT),
	            	'@FM',
	            	data($consultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY),
	            	'@FM', 
	            	data($consultaSaldosTarjetaCreditoResponse/POINTS_EARNED),
	            	'@FM',
	            	data($consultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE),
	            	'@FM',
	            	data($consultaSaldosTarjetaCreditoResponse/LAST_CUTOFF_DATE)
	            )
	            let $localRecord := $consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[CURRENCY = 'HNL']
	            let $foreignRecord := $consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[CURRENCY = 'USD']
            	return
            	<MESSAGE>{ 
            		concat(
            			$message,
            			'@FM', 
            			$localRecord/CURRENCY, 
            			'@FM', 
            			$orgBase,
            			'@FM',
            			$localRecord/OVERDUE_BALANCE, 
            			'@FM', 
            			$localRecord/FLOATING_BALANCE,
            			'@FM', 
            			$localRecord/CURRENT_BALANCE,
            			'@FM', 
            			$localRecord/PURCHASES_LIMIT,
            			'@FM', 
            			$localRecord/WITHDRAWAL_LIMIT,
            			'@FM', 
            			$localRecord/PAYMENTS_TODAY,
            			'@FM', 
            			$localRecord/AVAILABLE_EXTRA,
            			'@FM', 
            			$localRecord/AVAILABLE_INTRA,
            			'@FM', 
            			$foreignRecord/CURRENCY, 
            			'@FM', 
            			$orgAlt,
            			'@FM',
            			$foreignRecord/OVERDUE_BALANCE,
            			'@FM', 
            			$foreignRecord/FLOATING_BALANCE,
            			'@FM', 
            			$foreignRecord/CURRENT_BALANCE,
            			'@FM', 
            			$foreignRecord/PURCHASES_LIMIT, 
            			'@FM',
            			$foreignRecord/WITHDRAWAL_LIMIT, 
            			'@FM', 
            			$foreignRecord/PAYMENTS_TODAY,
            			'@FM', 
            			$foreignRecord/AVAILABLE_EXTRA,
            			'@FM', 
            			$foreignRecord/AVAILABLE_INTRA
            		) 
            	}</MESSAGE>
            	) else if(upper-case($errorCode) = "NO RECORDS") then (
            		<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
            	) else (
            		<MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
            	)
            }
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse) external;
declare variable $orgBase as xs:string external;
declare variable $orgAlt as xs:string external;

xf:consultaSaldosTarjetaCreditoFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $consultaSaldosTarjetaCreditoResponse,
    $orgBase,
    $orgAlt)