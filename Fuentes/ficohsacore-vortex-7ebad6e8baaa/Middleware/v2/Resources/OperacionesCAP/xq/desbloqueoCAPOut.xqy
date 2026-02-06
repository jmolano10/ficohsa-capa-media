xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$desbloqueodecuentasAOPResponse" element="ns0:DesbloqueodecuentasAOPResponse" location="../../../BusinessServices/T24/svcAhorroProgramado/xsd/svcAhorroProgramado.xsd" ::)
(:: pragma bea:global-element-return element="ns1:desbloqueoCAPResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/desbloqueoCAPOut/";

declare function xf:desbloqueoCAPOut($desbloqueodecuentasAOPResponse as element(ns0:DesbloqueodecuentasAOPResponse))
    as element(ns1:desbloqueoCAPResponse) {
        <ns1:desbloqueoCAPResponse>
            <SALDO_DISPONIBLE>{
            	let $workingBalanceNode := $desbloqueodecuentasAOPResponse/ACCOUNTType/WORKINGBALANCE
            	return
            		if(fn:exists($workingBalanceNode) and $workingBalanceNode/text() != '') then
            			xs:decimal($workingBalanceNode)
            		else 
            			0.00
            }</SALDO_DISPONIBLE>
        </ns1:desbloqueoCAPResponse>
};

declare variable $desbloqueodecuentasAOPResponse as element(ns0:DesbloqueodecuentasAOPResponse) external;

xf:desbloqueoCAPOut($desbloqueodecuentasAOPResponse)