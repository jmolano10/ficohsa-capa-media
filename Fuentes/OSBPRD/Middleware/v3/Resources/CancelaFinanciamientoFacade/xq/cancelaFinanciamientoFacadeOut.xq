(:: pragma bea:global-element-parameter parameter="$cancelaFinanciamientoResponse" element="ns1:cancelaFinanciamientoResponse" location="../../CancelaFinanciamiento/xsd/cancelaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CancelaFinanciamientoFacade/xq/cancelaFinanciamientoFacadeOut/";

declare function xf:cancelaFinanciamientoFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $cancelaFinanciamientoResponse as element(ns1:cancelaFinanciamientoResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(
            
            <MESSAGE>{ 
            	concat(
            		'Success||',
					$cancelaFinanciamientoResponse/ORG,
					'@FM',
					$cancelaFinanciamientoResponse/ALTERN_ORG,
					'@FM',
					$cancelaFinanciamientoResponse/LOGO,
					'@FM',
					$cancelaFinanciamientoResponse/ACCOUNT_NUMBER,
					'@FM',
					$cancelaFinanciamientoResponse/PLAN_SECUENCE,
					'@FM',
					$cancelaFinanciamientoResponse/CARD_NUMBER,
					'@FM',
					fn-bea:trim($cancelaFinanciamientoResponse/REFERENCE_NUMBER),
					'@FM',
					$cancelaFinanciamientoResponse/CANCELLATION_INDICATOR,
					'@FM',
					$cancelaFinanciamientoResponse/ORIGINAL_LOAN_TERM,
					'@FM',
					$cancelaFinanciamientoResponse/PENDING_LOAN_TERM,
					'@FM',
					$cancelaFinanciamientoResponse/PLAN_DATE,
					'@FM',
					$cancelaFinanciamientoResponse/BILL_FIRST_DATE,
					'@FM',
					$cancelaFinanciamientoResponse/EXPIRATION_LOAN_DATE,
					'@FM',
					$cancelaFinanciamientoResponse/EARLY_CANCELLATION_DATE,
					'@FM',
					$cancelaFinanciamientoResponse/TOTAL_LOAN_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/BILLED_INTEREST_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/BILLED_INSURANCE_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/PENALTY_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/PRINCIPAL_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/UNBILLED_DISBURSEMENT_COMMISSION,
					'@FM',
					$cancelaFinanciamientoResponse/DISBURSEMENT_COMMISSION_TERM,
					'@FM',
					$cancelaFinanciamientoResponse/ACCRUED_INTEREST_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/UNBILLED_LOAN_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/CANCELLATION_LOAN_AMOUNT,
					'@FM',
					$cancelaFinanciamientoResponse/ITBMS,
					'@FM',
					$cancelaFinanciamientoResponse/SETTLEMENT_TYPE,
					'@FM',
					$cancelaFinanciamientoResponse/METHOD_PAYMENT,
					'@FM',
					$cancelaFinanciamientoResponse/NEW_TERM,
					'@FM',
					$cancelaFinanciamientoResponse/NEW_FIXED_PMT_AMD
					) 
				}
				</MESSAGE>
            )else if(upper-case($errorCode) = "NO RECORDS")then(
			     	<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
			     )else(
			     	<MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
			     )
		 }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $cancelaFinanciamientoResponse as element(ns1:cancelaFinanciamientoResponse) external;

xf:cancelaFinanciamientoFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $cancelaFinanciamientoResponse)