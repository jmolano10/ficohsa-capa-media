xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaAprobadoras/xsd/consultaAprobadoras_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaAprobadorasResponse" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAprobadoras/xq/consultaAprobadorasHNOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAprobadoras";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";

declare function xf:consultaAprobadorasHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaAprobadorasResponse) {
        <ns1:consultaAprobadorasResponse>
            <APPROVALS>
            {
            	let $CODE :=  $outputParameters/ns0:PT_APPROVAL_CODE/ns0:PT_APPROVAL_CODE_ITEM
            	let $DESCRIPTION :=  $outputParameters/ns0:PT_APPROVAL_DESC/ns0:PT_APPROVAL_DESC_ITEM
            	for $i in 1 to count($CODE)
            	return(                 
                <APPROVAL>
                    	<CODE>{ data($CODE[$i]) }</CODE>
   						<DESCRIPTION>{ data($DESCRIPTION[$i]) }</DESCRIPTION>  
                </APPROVAL>
                )
			}
            </APPROVALS>           
        </ns1:consultaAprobadorasResponse>
};
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaAprobadorasHNOut($outputParameters)