(:: pragma bea:global-element-parameter parameter="$bloqueodepasivosResponse" element="ns0:BloqueodepasivosResponse" location="../Resoruces/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns1:bloqueoFondosCuentaResponse" location="bloqueoFondosCuentaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bloqueoFondosCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/bloqueoPasivos/BloqueoFondosCuenta/bloqueoFondosCuentaOut/";

declare function xf:bloqueoFondosCuentaOut($bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse))
    as element(ns1:bloqueoFondosCuentaResponse) {
        <ns1:bloqueoFondosCuentaResponse>
        	{
        		let $DATETIME := fn:string($bloqueodepasivosResponse/ACLOCKEDEVENTSType/gDATETIME/DATETIME[1]/text())
        		return
        			if($DATETIME != "") then (
        				<TRANSACTION_DATE>{ concat("20",$DATETIME) }</TRANSACTION_DATE>
        			) else ()
            }
        </ns1:bloqueoFondosCuentaResponse>
};

declare variable $bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse) external;

xf:bloqueoFondosCuentaOut($bloqueodepasivosResponse)