<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$afiliacionCAPResponse" element="ns1:afiliacionCAPResponse" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionCAPFacade/xq/afiliacionCAPFacadeOut/";

declare function xf:afiliacionCAPFacadeOut($afiliacionCAPResponse as element(ns1:afiliacionCAPResponse),
    $transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(
            
            <MESSAGE>{ 
            	concat(
            		'Success||',
					$afiliacionCAPResponse/ID_CAP
					) 
				}
			</MESSAGE>
            )else(			     
			     <MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
			     )
		 }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $afiliacionCAPResponse as element(ns1:afiliacionCAPResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:afiliacionCAPFacadeOut($afiliacionCAPResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $validationMessage)]]></con:xquery>
    <con:dependency location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCAP/xsd/operacionesCAPTypes"/>
    </con:dependency>
    <con:dependency location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
</con:xqueryEntry>