xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposPrestamos/xsd/consultaTiposPrestamos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTiposPrestamosResponse" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposPrestamos/xq/consultaTiposPrestamosHNOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposPrestamos";

declare function xf:consultaTiposPrestamosHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaTiposPrestamosResponse) {
	<ns0:consultaTiposPrestamosResponse>
    	<LOAN_TYPES>                
        {
        	let $TYPE_CODE :=  $outputParameters/ns1:P_TYPE_CODE/ns1:P_TYPE_CODE_ITEM
            let $TYPE_DESCRIPTION :=  $outputParameters/ns1:P_TYPE_DESC/ns1:P_TYPE_DESC_ITEM
            for $i in 1 to count($TYPE_CODE)
            return(                 
                <LOAN_TYPE>
                    <CODE>{ data($TYPE_CODE[$i]) }</CODE>
   					<DESCRIPTION>{ data($TYPE_DESCRIPTION[$i]) }</DESCRIPTION>  
                </LOAN_TYPE>
           	)
		}                               
    	</LOAN_TYPES>
	</ns0:consultaTiposPrestamosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaTiposPrestamosHNOut($outputParameters)