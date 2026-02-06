xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse" element="ns1:consultaDatosTarjetaCreditoResponse" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCreditoFacade/xq/ConsultaDatosTarjetaCreditoFacadeOut/";

declare function xf:ConsultaDatosTarjetaCreditoFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
	$consultaDatosTarjetaCreditoResponse as element(ns1:consultaDatosTarjetaCreditoResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
        	<TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
	           if(upper-case($errorCode) = "SUCCESS")then(
	            	<MESSAGE>{ 
		            	concat( 'Success||'
    						,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/CARD_NUMBER) 
		            	    ,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_HOLDER_NAME)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/CARD_HOLDER_NAME)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/CARD_TYPE)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/CUSTOMER_ID)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/CARD_HOLDER_LEGAL_ID)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_HOLDER_LEGAL_ID)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_NUMBER)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/PRODUCT)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/AFINITY_GROUP)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_STATUS)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/CARD_STATUS)
			            	,'@FM'
			            	,data($consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType/CARD_EXPIRATION_DATE)
	            		) }
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
declare variable $consultaDatosTarjetaCreditoResponse as element(ns1:consultaDatosTarjetaCreditoResponse) external;

xf:ConsultaDatosTarjetaCreditoFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $consultaDatosTarjetaCreditoResponse)