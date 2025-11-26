(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTDSwitchFacade/xq/actualizaEstadoTDSwitchFacadeOut/";

declare function xf:actualizaEstadoTDSwitchFacadeOut($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24),
    $errorCode as xs:string,
    $validationMessage as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ data($procesaMensajeGenericoT24/TRANSACTION_ID) }</TRANSACTION_ID>
            <SESSION_ID>{ data($procesaMensajeGenericoT24/SESSION_ID) }</SESSION_ID>
            <MESSAGE>
            	{ 
            		if(upper-case($errorCode) = 'SUCCESS')then(
			        	$errorCode
			       	)else(
						concat(	
			    			$errorCode,
			    			'|',
			    			$validationMessage
			    		)
					) 
            	} 
            </MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:actualizaEstadoTDSwitchFacadeOut($procesaMensajeGenericoT24,
    $errorCode,
    $validationMessage)