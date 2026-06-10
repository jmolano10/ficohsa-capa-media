<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$desbloqueodecuentasAOPResponse" element="ns0:DesbloqueodecuentasAOPResponse" location="../../../BusinessServices/T24/svcAhorroProgramado/xsd/svcAhorroProgramado.xsd" ::)
(:: pragma bea:global-element-return element="ns1:desbloqueoCAPResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/desbloqueoCAPOut/";

declare function xf:desbloqueoCAPOut($desbloqueodecuentasAOPResponse as element(ns0:DesbloqueodecuentasAOPResponse))
    as element(ns1:desbloqueoCAPResponse) {
        &lt;ns1:desbloqueoCAPResponse>
            &lt;SALDO_DISPONIBLE>{
            	let $workingBalanceNode := $desbloqueodecuentasAOPResponse/ACCOUNTType/WORKINGBALANCE
            	return
            		if(fn:exists($workingBalanceNode) and $workingBalanceNode/text() != '') then
            			xs:decimal($workingBalanceNode)
            		else 
            			0.00
            }&lt;/SALDO_DISPONIBLE>
        &lt;/ns1:desbloqueoCAPResponse>
};

declare variable $desbloqueodecuentasAOPResponse as element(ns0:DesbloqueodecuentasAOPResponse) external;

xf:desbloqueoCAPOut($desbloqueodecuentasAOPResponse)</con:xquery>
    <con:dependency location="../../../BusinessServices/T24/svcAhorroProgramado/xsd/svcAhorroProgramado.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/svcAhorroProgramado/xsd/svcAhorroProgramado"/>
    </con:dependency>
    <con:dependency location="../xsd/operacionesCAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCAP/xsd/operacionesCAPTypes"/>
    </con:dependency>
</con:xqueryEntry>