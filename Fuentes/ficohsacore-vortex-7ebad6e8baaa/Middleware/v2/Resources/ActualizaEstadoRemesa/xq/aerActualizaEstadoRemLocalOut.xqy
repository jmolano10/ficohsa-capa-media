xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaEstadoRemesaRequest1" element="ns1:actualizaEstadoRemesaRequest" location="../xsd/actualizaEstadoRemesa.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/CNV/actualizaEstadoRemesaLocal/xsd/actualizaEstadoRemesaLocal_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizaEstadoRemesaResponse" location="../xsd/actualizaEstadoRemesa.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoRemesaTypes/v2";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaEstadoRemesaLocal";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/aerActualizaEstadoRemLocalOut/";

declare function xf:aerActualizaEstadoRemLocalOut($actualizaEstadoRemesaRequest1 as element(ns1:actualizaEstadoRemesaRequest),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:actualizaEstadoRemesaResponse) {
    	if (fn:string($outputParameters1/ns0:PN_ERROR/text()) = "0") then (
	        <ns1:actualizaEstadoRemesaResponse>
	            <REMITTANCE_ID>{ data($actualizaEstadoRemesaRequest1/REMITTANCE_ID) }</REMITTANCE_ID>
	            <REMITTER_ID>{ data($actualizaEstadoRemesaRequest1/REMITTER_ID) }</REMITTER_ID>
	            <PREVIOUS_STATUS>PAID</PREVIOUS_STATUS>
	            <NEW_STATUS>{ data($actualizaEstadoRemesaRequest1/NEW_STATUS) }</NEW_STATUS>
	        </ns1:actualizaEstadoRemesaResponse>
	    ) else (
	    	<ns1:actualizaEstadoRemesaResponse/>
	    )
};

declare variable $actualizaEstadoRemesaRequest1 as element(ns1:actualizaEstadoRemesaRequest) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:aerActualizaEstadoRemLocalOut($actualizaEstadoRemesaRequest1,
    $outputParameters1)