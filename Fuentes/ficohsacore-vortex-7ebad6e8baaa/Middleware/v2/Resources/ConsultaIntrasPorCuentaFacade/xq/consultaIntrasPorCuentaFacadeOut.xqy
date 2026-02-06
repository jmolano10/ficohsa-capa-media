xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaIntrasPorCuentaResponse" element="ns1:consultaIntrasPorCuentaResponse" location="../../ConsultaIntrasPorCuenta/xsd/consultaIntrasPorCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaIntrasPorCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaIntrasPorCuentaFacade/xq/consultaIntrasPorCuentaFacadeOut/";

declare function xf:consultaIntrasPorCuentaFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $consultaIntrasPorCuentaResponse as element(ns1:consultaIntrasPorCuentaResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
	          	if(upper-case($errorCode) = "SUCCESS")then(
		            <MESSAGE>{	
		             	let $consultaIntrasPorCuenta := $consultaIntrasPorCuentaResponse/PRODUCT_INFORMATION				           	
		           		let $responseMessage := concat(
			           		for $i in 1 to count( $consultaIntrasPorCuenta)
								return(
									'@VM',
				            		data($consultaIntrasPorCuenta[$i]/INTRAFINANCING_ID),
						            '@FM',
						            data( $consultaIntrasPorCuenta[$i]/COMMERCE_NAME),		
						            '@FM',
						            data( $consultaIntrasPorCuenta[$i]/TRANSACTION_DATE),
						            '@FM',
						            data($consultaIntrasPorCuenta[$i]/AMOUNT),
						            '@FM',
						            data($consultaIntrasPorCuenta[$i]/CURRENT_BALANCE),
						            '@FM',
						            data($consultaIntrasPorCuenta[$i]/FEE_AMOUNT),
						            '@FM',
						            data($consultaIntrasPorCuenta[$i]/INTEREST_RATE),
						            '@FM',
						            data($consultaIntrasPorCuenta[$i]/TERM),
						            '@FM',
						            data($consultaIntrasPorCuenta[$i]/CURRENT_FEE),
						            '@FM',
						            data($consultaIntrasPorCuenta[$i]/CURRENCY)						            													            	
						         )
				         	)				            
							return(
				      			concat('Success||',$responseMessage)				            									            					      			
			      			)
			     	}</MESSAGE>
			     		
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
declare variable $consultaIntrasPorCuentaResponse as element(ns1:consultaIntrasPorCuentaResponse) external;

xf:consultaIntrasPorCuentaFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $consultaIntrasPorCuentaResponse)