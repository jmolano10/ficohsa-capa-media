(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteResponse" element="ns1:consultaPasivosClienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosClienteFacade/xq/consultaPasivosClienteFacadeOut/";

declare function xf:consultaPasivosClienteFacadeOut($consultaPasivosClienteResponse as element(ns1:consultaPasivosClienteResponse),
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
		             	let $consultaPasivosClienteTCreditoResponse := $consultaPasivosClienteResponse/ns1:consultaPasivosClienteTCreditoResponseType/ns1:consultaPasivosClienteResponseRecordType	
			           	let $consultaPasivosClientePrestamosResponse := $consultaPasivosClienteResponse/ns1:consultaPasivosClientePrestamosResponseType/ns1:consultaPasivosClienteResponseRecordType
		           		let $pasivosClientePrestamos := concat(
			           		for $i in 1 to count( $consultaPasivosClientePrestamosResponse)
								return(
				            		data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_TYPE),
						            '@FM',
						            data( $consultaPasivosClientePrestamosResponse[$i]/LIABILITY_NUMBER),		
						            '@FM',
						            data( $consultaPasivosClientePrestamosResponse[$i]/LIABILITY_CUST_NAME),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_CURRENCY_1),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_PRINCIPAL_AMT_1),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_INT_COM_AMT_1),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_TOTAL_AMT_1),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_CURRENCY_2),
						            '@FM',
						            data( $consultaPasivosClientePrestamosResponse[$i]/LIABILITY_PRINCIPAL_AMT_2),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_INT_COM_AMT_2),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_TOTAL_AMT_2),
						            '@FM',
						            data($consultaPasivosClientePrestamosResponse[$i]/LIABILITY_TOTAL_AMT),
					            	if($consultaPasivosClientePrestamosResponse[$i+1] != "" or $consultaPasivosClienteTCreditoResponse != "")then(
						            	'@VM'
						            )else()
						         )
				         	)
				            let $pasivosClienteTCredito := concat(
				            	for $i in 1 to count($consultaPasivosClienteTCreditoResponse)
									return(
					            		data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_TYPE),
							            '@FM',
							          	 data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_NUMBER),
							          	'@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_CUST_NAME),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_CURRENCY_1),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_PRINCIPAL_AMT_1),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_INT_COM_AMT_1),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_TOTAL_AMT_1),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_CURRENCY_2),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_PRINCIPAL_AMT_2),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_INT_COM_AMT_2),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_TOTAL_AMT_2),
							            '@FM',
							            data($consultaPasivosClienteTCreditoResponse[$i]/LIABILITY_TOTAL_AMT),
							          	if($consultaPasivosClienteTCreditoResponse[$i + 1] != "")then(
							            	'@VM'
							            )else()
						       		 ) 
						    )
							return(
				      			concat(
					            		'Success||',
							            $pasivosClientePrestamos,
							            $pasivosClienteTCredito	
							         )
							    
				      			
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

declare variable $consultaPasivosClienteResponse as element(ns1:consultaPasivosClienteResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:consultaPasivosClienteFacadeOut($consultaPasivosClienteResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $message)
