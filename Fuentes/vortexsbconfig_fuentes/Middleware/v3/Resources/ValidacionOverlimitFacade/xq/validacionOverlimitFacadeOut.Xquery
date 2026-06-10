<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionOverlimitResponse" element="ns1:validacionOverlimitResponse" location="../../ValidacionOverlimit/xsd/ValidacionOverlimitTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ValidacionOverlimitTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionOverlimitFacade/xq/validacionOverlimitFacadeOut/";

declare function xf:validacionOverlimitFacadeOut($transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string,
    $validacionOverlimitResponse as element(ns1:validacionOverlimitResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(	
            	
		            	<MESSAGE>{ 
		            	concat(
		            		'SUCCESS||MESSAGES',
		            		'@FM',
		            		$validacionOverlimitResponse/ORG , 
		            		'@FM',
		            		$validacionOverlimitResponse/CURRENT_BALANCE ,
		            		'@FM',
		            		$validacionOverlimitResponse/CLIENT_ID  
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
declare variable $validacionOverlimitResponse as element(ns1:validacionOverlimitResponse) external;

xf:validacionOverlimitFacadeOut($transactionId,
    $sessionId,
    $errorCode,
    $validationMessage,
    $validacionOverlimitResponse)]]></con:xquery>
    <con:dependency location="../../ValidacionOverlimit/xsd/ValidacionOverlimitTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ValidacionOverlimit/xsd/ValidacionOverlimitTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
</con:xqueryEntry>