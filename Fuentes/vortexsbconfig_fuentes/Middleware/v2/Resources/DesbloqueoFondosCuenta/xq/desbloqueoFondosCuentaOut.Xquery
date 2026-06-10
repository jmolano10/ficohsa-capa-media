<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$desbloqueodefondosdepasivosResponse" element="ns0:DesbloqueodefondosdepasivosResponse" location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns1:desbloqueoFondosCuentaResponse" location="../xsd/desbloqueoFondosCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DesbloqueoFondosCuenta/xq/desbloqueoFondosCuentaOut1/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/desbloqueoFondosCuentaTypes";

declare function xf:desbloqueoFondosCuentaOut1($desbloqueodefondosdepasivosResponse as element(ns0:DesbloqueodefondosdepasivosResponse))
    as element(ns1:desbloqueoFondosCuentaResponse) {
        &lt;ns1:desbloqueoFondosCuentaResponse>
        	{
        		let $DATETIME := fn:string($desbloqueodefondosdepasivosResponse/ACLOCKEDEVENTSType/gDATETIME/DATETIME[1]/text())
        		return
        			if($DATETIME != "") then (
        				&lt;TRANSACTION_DATE>{ concat("20",$DATETIME) }&lt;/TRANSACTION_DATE>
        			) else ()
            }        
        &lt;/ns1:desbloqueoFondosCuentaResponse>
};

declare variable $desbloqueodefondosdepasivosResponse as element(ns0:DesbloqueodefondosdepasivosResponse) external;

xf:desbloqueoFondosCuentaOut1($desbloqueodefondosdepasivosResponse)</con:xquery>
    <con:dependency location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd">
        <con:schema ref="Middleware/Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592"/>
    </con:dependency>
    <con:dependency location="../xsd/desbloqueoFondosCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DesbloqueoFondosCuenta/xsd/desbloqueoFondosCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>