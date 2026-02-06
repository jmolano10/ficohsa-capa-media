xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFinanciamientosClienteResponse" element="ns1:consultaFinanciamientosClienteResponse" location="../../ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosClienteFacadeT24/xq/consultaFinanciamientosClienteFacadeT24Out/";

declare function xf:consultaFinanciamientosClienteFacadeT24Out($consultaFinanciamientosClienteResponse as element(ns1:consultaFinanciamientosClienteResponse),
    $transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $message as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
	          	if(upper-case($errorCode) = "SUCCESS")then(
		            <MESSAGE>{	
		             	let $consultaFinanciamientosCliente := $consultaFinanciamientosClienteResponse/consultaFinanciamientosClienteResponseRecordType				           	
		           		let $responseMessage := concat(
			           		for $i in 1 to count( $consultaFinanciamientosCliente)
								return(
									'@VM',
				            		data($consultaFinanciamientosCliente[$i]/PRODUCT_TYPE),
						            '@FM',
						            data( $consultaFinanciamientosCliente[$i]/ORG),		
						            '@FM',
						            data( $consultaFinanciamientosCliente[$i]/CURRENCY),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/PLAN_CODE),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/PLAN_SEQUENCE),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/FINANCING_REFERENCE),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/PRODUCT_NUMBER),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/DISBURSEMENT_DATE),
						            '@FM',
						            data( $consultaFinanciamientosCliente[$i]/MATURITY_DATE),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/PRINCIPAL_INICIAL_AMOUNT),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/PRINCIPAL_DUE_AMOUNT),
						            '@FM',
						            data($consultaFinanciamientosCliente[$i]/INTEREST_RATE),
									'@FM',
									data($consultaFinanciamientosCliente[$i]/INTEREST_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/INSURANCE_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/PENDING_INSURANCE_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/COMMISION_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/PENDING_COMMISION_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/PENALTY_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/MONTHLY_PAYMENT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/INITIAL_LOAN_TERM),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/REMAINING_LOAN_TERM),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/CURRENT_LOAN_TERM),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/TOTAL_DEBT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/MIN_PAYMENT_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/CHARGE_CYCLE_DAY),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/PENDING_PRINCIPAL_AMOUNT),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/CARD_NUMBER),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/LOAN_INDICATOR),
						            '@FM',
									data($consultaFinanciamientosCliente[$i]/PLAN_DESCRIPTION)						            													            	
						         )
				         	)				            
							return(
				      			concat('Success||',$responseMessage)				            									            					      			
			      			)
			     	}</MESSAGE>
			     		
			     )else if(upper-case($errorCode) = "NO RECORDS")then(
			     	<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
			     )else(
			     	<MESSAGE>{concat('ERROR|', $message)}</MESSAGE>
			     )
	     	}
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $consultaFinanciamientosClienteResponse as element(ns1:consultaFinanciamientosClienteResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:consultaFinanciamientosClienteFacadeT24Out($consultaFinanciamientosClienteResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $message)