(:: pragma bea:global-element-parameter parameter="$consultaPuntosLealtadResponse" element="ns0:consultaPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtadFacade/xq/consultaPuntosLealtadFacadeOut/";

declare function xf:consultaPuntosLealtadFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $consultaPuntosLealtadResponse as element(ns0:consultaPuntosLealtadResponse))
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(
            
            <MESSAGE>{ 
            	concat(
            		'Success||',
            		$consultaPuntosLealtadResponse/LEGAL_ID , 
            		'@FM',
            		$consultaPuntosLealtadResponse/CUSTOMER_NAME ,
            		'@FM',
            		$consultaPuntosLealtadResponse/BALANCE ,
            		'@FM',
            		$consultaPuntosLealtadResponse/CASH_EQUIVALENT ,
            		'@FM',
            		 $consultaPuntosLealtadResponse/CASH_CURRENCY
            	) 
            }
            </MESSAGE>
            )else if(upper-case($errorCode) = "NO RECORDS")then(
			     	<MESSAGE>ERROR|No se encontraron registros</MESSAGE>
			     )else(
			     	<MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
			     )
           }
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;
declare variable $consultaPuntosLealtadResponse as element(ns0:consultaPuntosLealtadResponse) external;

xf:consultaPuntosLealtadFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $consultaPuntosLealtadResponse)