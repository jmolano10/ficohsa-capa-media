<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/consultaContratosCliente/xsd/consultaContratosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaContratosClienteResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaContratosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaContratosCliente/consultaContratosClienteOut/";

declare function xf:consultaContratosClienteOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaContratosClienteResponse) {
        <ns0:consultaContratosClienteResponse>
            <CUSTOMER_ID>{ data($outputParameters/ns1:PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            <AGREEMENTS>
            	{
	            	let $contractId := $outputParameters/ns1:PT_NUMEROCONTRATO/ns1:PT_NUMEROCONTRATO_ITEM
	            	let $description := $outputParameters/ns1:PT_DESCRIPCION/ns1:PT_DESCRIPCION_ITEM
	      			for $i in 1 to count($contractId)
	            	return
		                <AGREEMENT>
		                 	<CONTRACT_ID>{ data($contractId[$i]) }</CONTRACT_ID>
			                <DESCRIPTION>{ data($description[$i]) }</DESCRIPTION>
		                </AGREEMENT>
                 }
            </AGREEMENTS>
            
        </ns0:consultaContratosClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaContratosClienteOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABK/consultaContratosCliente/xsd/consultaContratosCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultaContratosCliente/xsd/consultaContratosCliente_sp"/>
    </con:dependency>
    <con:dependency location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CobranzasElectronicas/xsd/cobranzasElectronicasTypes"/>
    </con:dependency>
</con:xqueryEntry>