xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$desbloqueodefondosdepasivosResponse" element="ns0:DesbloqueodefondosdepasivosResponse" location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns1:desbloqueoFondosCuentaResponse" location="../xsd/desbloqueoFondosCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DesbloqueoFondosCuenta/xq/desbloqueoFondosCuentaOut1/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/desbloqueoFondosCuentaTypes";

declare function xf:desbloqueoFondosCuentaOut1($desbloqueodefondosdepasivosResponse as element(ns0:DesbloqueodefondosdepasivosResponse))
    as element(ns1:desbloqueoFondosCuentaResponse) {
        <ns1:desbloqueoFondosCuentaResponse>
        	{
        		let $DATETIME := fn:string($desbloqueodefondosdepasivosResponse/ACLOCKEDEVENTSType/gDATETIME/DATETIME[1]/text())
        		return
        			if($DATETIME != "") then (
        				<TRANSACTION_DATE>{ concat("20",$DATETIME) }</TRANSACTION_DATE>
        			) else ()
            }        
        </ns1:desbloqueoFondosCuentaResponse>
};

declare variable $desbloqueodefondosdepasivosResponse as element(ns0:DesbloqueodefondosdepasivosResponse) external;

xf:desbloqueoFondosCuentaOut1($desbloqueodefondosdepasivosResponse)