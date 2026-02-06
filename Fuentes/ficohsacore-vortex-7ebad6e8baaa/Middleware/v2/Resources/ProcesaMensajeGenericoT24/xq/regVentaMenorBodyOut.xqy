xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/regVentaMenorOut/";

declare function xf:regVentaMenorOut($codigoVenta as xs:string,
    $sessionId as xs:string,
    $mensaje as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $codigoVenta }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>          
            {
            	if  ($codigoVenta != '0') then
        		(
            		<MESSAGE>{fn:concat("0|SUCCESS|",fn:string($codigoVenta),"|",fn:string($mensaje))}</MESSAGE>
            	)
            	else
	            (
	            	<MESSAGE>{fn:concat("1|ERROR|",fn:string($codigoVenta),"|",fn:string($mensaje))}</MESSAGE>
	            )
            }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $codigoVenta as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $mensaje as xs:string external;

xf:regVentaMenorOut($codigoVenta,
    $sessionId,
    $mensaje)