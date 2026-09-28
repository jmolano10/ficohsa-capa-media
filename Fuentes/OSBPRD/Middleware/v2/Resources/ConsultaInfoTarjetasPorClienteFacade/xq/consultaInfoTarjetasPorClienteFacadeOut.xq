(:: pragma bea:global-element-parameter parameter="$consultaInfoTarjetasPorClienteResponse" element="ns1:consultaInfoTarjetasPorClienteResponse" location="../../ConsultaInfoTarjetasPorCliente/xsd/consultaInfoTarjetasPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaInfoTarjetasPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInfoTarjetasPorCliente/xq/consultaInfoTarjetasPorClienteFacadeOut/";

declare function xf:consultaInfoTarjetasPorClienteFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $consultaInfoTarjetasPorClienteResponse as element(ns1:consultaInfoTarjetasPorClienteResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            if(upper-case($errorCode) = "SUCCESS")then(
            <MESSAGE>
            	{
            		let $customerId := fn:concat('Success||',data($consultaInfoTarjetasPorClienteResponse/CUSTOMER_ID)) 
            		let $account_info := 
            			
            			for $ACCOUNT_INFO in $consultaInfoTarjetasPorClienteResponse/ns1:ACCOUNT_INFO
            			return
	            			concat(
	            				 '@GM',
			            		 $ACCOUNT_INFO/ACCOUNT_NUMBER,
			            		 for $CARD_INFO in $ACCOUNT_INFO/ns1:CARD_INFO
			            		 return
				            		 fn:concat(
				            		 	'@VM',
				            		 	$CARD_INFO/CARD_NUMBER, '@FM',
				            		 	$CARD_INFO/CARD_HOLDER_NAME, '@FM',
				            		 	$CARD_INFO/CARD_TYPE_CODE, '@FM',
				            		 	$CARD_INFO/CARD_TYPE_DESCRIPTION, '@FM',
				            		 	$CARD_INFO/LOGO, '@FM',
				            		 	$CARD_INFO/PRODUCT_TYPE_DESCRIPTION, '@FM',
				            		 	$CARD_INFO/CARD_STATUS_CODE, '@FM',
				            		 	$CARD_INFO/CARD_STATUS_DESCRIPTION, '@FM',
				            		 	$CARD_INFO/BLOCK_CODE_1, '@FM',
				            		 	$CARD_INFO/BLOCK_CODE_2, '@FM',
				            		 	$CARD_INFO/CUTOFF_DATE,
				            		 	for $BALANCE_INFO in $CARD_INFO/ns1:BALANCE_INFO
					            		return
					            		 	fn:concat(
					            		 		'@CM',
					            		 	    $BALANCE_INFO/ORG, '@FM',
							            		$BALANCE_INFO/ORG_TYPE, '@FM',
							            		$BALANCE_INFO/CURRENCY, '@FM',
							            		$BALANCE_INFO/CREDIT_LIMIT, '@FM',
							            		$BALANCE_INFO/CURRENT_BALANCE, '@FM',
							            		$BALANCE_INFO/CUTOFF_BALANCE, '@FM',
							            		$BALANCE_INFO/PURCHASE_AVAILABLE_AMOUNT, '@FM',
							            		$BALANCE_INFO/AVAILABLE_WITHDRAWAL, '@FM',
							            		$BALANCE_INFO/MIN_PAYMENT
					            		 	)    
				            		 )
		            		 )
		          	return fn:concat($customerId, string-join($account_info , ""))
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
declare variable $consultaInfoTarjetasPorClienteResponse as element(ns1:consultaInfoTarjetasPorClienteResponse) external;

xf:consultaInfoTarjetasPorClienteFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $consultaInfoTarjetasPorClienteResponse)