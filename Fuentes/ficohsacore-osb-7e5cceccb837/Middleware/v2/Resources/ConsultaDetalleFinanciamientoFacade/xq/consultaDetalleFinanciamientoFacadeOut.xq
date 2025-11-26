(:: pragma bea:global-element-parameter parameter="$consultaDetalleFinanciamientoResponse" element="ns1:consultaDetalleFinanciamientoResponse" location="../../ConsultaDetalleFinanciamiento/xsd/consultaDetalleFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleFinanciamientoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleFinanciamientoFacade/xq/consultaDetalleFinanciamientoFacadeOut/";

declare function xf:consultaDetalleFinanciamientoFacadeOut($consultaDetalleFinanciamientoResponse as element(ns1:consultaDetalleFinanciamientoResponse),
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS") then (
            		<MESSAGE>{ 
		            	concat( 'Success||'
		            	    ,data($consultaDetalleFinanciamientoResponse/ORG) 
		            	    ,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/ALTERN_ORG)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/LOGO)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/ACCOUNT_NUMBER)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/CARD_NUMBER)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/ACCOUNT_PAYOFF_DATE)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/ACCOUNT_PAYOFF_AMOUNT)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/PLAN_REFERENCE)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/PLAN_TYPE)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/PLAN_DESCRIPTION)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/QUOTE_TYPE)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/PLAN_PAYOFF_DATE)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/PLAN_PAYOFF_AMOUNT)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/PAYMENT_TYPE)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/METHOD_PAYMENT)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/NEW_TERM)
			            	,'@FM'
			            	,data($consultaDetalleFinanciamientoResponse/PLAN-DATA/PLAN-ENTRY/NEW_PAYMENT_AMOUNT)
	            		) }
	            	</MESSAGE>
            	)else if(upper-case($errorCode) = "NO RECORDS") then (
            		<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
            	)else(
            		<MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
            	)
            }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $consultaDetalleFinanciamientoResponse as element(ns1:consultaDetalleFinanciamientoResponse) external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:consultaDetalleFinanciamientoFacadeOut($consultaDetalleFinanciamientoResponse,
    $errorCode,
    $validationMessage,
    $transactionId,
    $sessionId)