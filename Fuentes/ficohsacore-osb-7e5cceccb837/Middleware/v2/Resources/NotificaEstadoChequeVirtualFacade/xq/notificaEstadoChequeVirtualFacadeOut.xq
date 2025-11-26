xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoChequeVirtualFacade/xq/notificaEstadoVirtualFacadeOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";

declare function xf:notificaEstadoVirtualFacadeOut($TRANSACTION_ID as xs:string,
    $SESSION_ID as xs:string,
    $RSPHNotificaEstadoChequeVirtual as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $TRANSACTION_ID }</TRANSACTION_ID>
            <SESSION_ID>{ $SESSION_ID }</SESSION_ID>
 			{            
            if  (fn:upper-case($RSPHNotificaEstadoChequeVirtual) = "SUCCESS") then
        	(
	            <MESSAGE>
	            { 
		            "Success"
		        }
	             </MESSAGE>
	        ) else (
	             <MESSAGE>{  "Error"} </MESSAGE>
	             )
             }            
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $TRANSACTION_ID as xs:string external;
declare variable $SESSION_ID as xs:string external;
declare variable $RSPHNotificaEstadoChequeVirtual as xs:string external;

xf:notificaEstadoVirtualFacadeOut($TRANSACTION_ID,
    $SESSION_ID,
    $RSPHNotificaEstadoChequeVirtual)
