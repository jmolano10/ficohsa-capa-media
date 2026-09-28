(:: pragma bea:global-element-parameter parameter="$consultaExtrafinanciamientoDisponibleResponse" element="ns1:consultaExtrafinanciamientoDisponibleResponse" location="../../ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtrafinanciamientoDisponibleFacade/xq/consultaExtrafinanciamientoDisponibleFacadeOut/";

declare function xf:consultaExtrafinanciamientoDisponibleFacadeOut(
	$consultaExtrafinanciamientoDisponibleResponse as element(ns1:consultaExtrafinanciamientoDisponibleResponse),
    $transactionid as xs:string,
    $sessionid as xs:string,
    $errorCode as xs:string,
    $message as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionid }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionid }</SESSION_ID>{
            	if(upper-case($errorCode) = "SUCCESS") then(
	            	<MESSAGE>{ 
	            		concat(
		            		'Success||',
		            		 $consultaExtrafinanciamientoDisponibleResponse/CUSTOMER_ID,
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/ACCOUNT_NUMBER,
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/AVAILABLE_AMOUNT, 
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/FEE_AMOUNT,
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/INTEREST_RATE,
		            		 '@FM', 
		            		 $consultaExtrafinanciamientoDisponibleResponse/DUE_DATE,
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/AVAILABLE,
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/NUMBER_ID,
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/CUSTOMER_NAME,
		            		 '@FM',
		            		 $consultaExtrafinanciamientoDisponibleResponse/OFFER_TYPE,
		            		 	
		            		 	let $consultaExtrafinanciamientoDisponible := $consultaExtrafinanciamientoDisponibleResponse/TERMBREAKDOWN_INFORMATION				           	
		            		 	for $i in 1 to count( $consultaExtrafinanciamientoDisponible )
		            		 	return (
		            		 		'@VM',
		            		 		$consultaExtrafinanciamientoDisponible[$i]/AMOUNT,
		            		 		'@FM',
		            		 		$consultaExtrafinanciamientoDisponible[$i]/TERM
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

declare variable $consultaExtrafinanciamientoDisponibleResponse as element(ns1:consultaExtrafinanciamientoDisponibleResponse) external;
declare variable $transactionid as xs:string external;
declare variable $sessionid as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $message as xs:string external;

xf:consultaExtrafinanciamientoDisponibleFacadeOut($consultaExtrafinanciamientoDisponibleResponse,
    $transactionid,
    $sessionid,
    $errorCode,
    $message)