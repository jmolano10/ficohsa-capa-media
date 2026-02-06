xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/confirmarReversarAdhesionContrato/xsd/confirmarReversarAdhesionContrato_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/confirmarReversarAdhesionContrato";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmarReversarAdhesionContratoDEI/xq/confirmarReversarAdhesionContratoDEIHeaderOut/";

declare function xf:confirmarAdhesionContratoDEIHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	let $successIndicator := fn:string($outputParameters/ns0:PV_CODIGOMENSAJE/text())
            	let $message := fn:string($outputParameters/ns0:PV_DESCRIPCIONMENSAJE/text())
            	return 
	            	if ($successIndicator  = "SUCCESS") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:confirmarAdhesionContratoDEIHeaderOut($outputParameters)