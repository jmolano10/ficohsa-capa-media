(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ServiciosEmpresariales/consultaTargetTipoPrestamo/xsd/consultaTargetTipoPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTargetTipoPrestamoResponse" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTargetTipoPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTargetTipoPrestamo/xq/consultaTargetTipoPrestamoHNOut/";

declare function xf:consultaTargetTipoPrestamoHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaTargetTipoPrestamoResponse) {
        <ns0:consultaTargetTipoPrestamoResponse>
        
            <TARGETS>
            	{
            	let $ID :=  $outputParameters/ns1:P_TARGET_ID/ns1:P_TARGET_ID_ITEM
            	let $DESCRIPTION :=  $outputParameters/ns1:P_TARGET_DESC/ns1:P_TARGET_DESC_ITEM
            	let $LOAN_TYPE_ID :=  $outputParameters/ns1:P_LOAN_TYPE_ID/ns1:P_LOAN_TYPE_ID_ITEM
            	let $LOAN_TYPE_DESC :=  $outputParameters/ns1:P_LOAN_TYPE_DESC/ns1:P_TARGET_DESC_ITEM
            	for $i in 1 to count($ID)
            	return(
                <TARGET>
                    	<ID>{ data($ID[$i]) }</ID>
   						<DESCRIPTION>{ data($DESCRIPTION[$i]) }</DESCRIPTION>  				
                    	<LOAN_TYPE_ID>{ data($LOAN_TYPE_ID[$i]) }</LOAN_TYPE_ID>
   						<LOAN_TYPE_DESC>{ data($LOAN_TYPE_DESC[$i]) }</LOAN_TYPE_DESC>  				                    
                </TARGET>
                )
                }
            </TARGETS>
        </ns0:consultaTargetTipoPrestamoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaTargetTipoPrestamoHNOut($outputParameters)