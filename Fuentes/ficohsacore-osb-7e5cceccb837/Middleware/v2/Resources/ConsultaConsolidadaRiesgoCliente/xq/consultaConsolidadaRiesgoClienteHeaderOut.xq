xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConsolidadRiesgoCliente";

declare function xf:consultaConsolidadaRiesgoClienteHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
    
        <ns0:ResponseHeader>
        {
		   	let $rowOne := $outputParameters/ns1:RowSet[1]
				return(
					if(count($rowOne/*) > 0)then(
			   			<successIndicator>Success</successIndicator>
					)else(
		   				 <successIndicator>NO RECORS</successIndicator>,
						 <messages>NO RECORDS FOUND</messages>
					)
				)
		}
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaConsolidadaRiesgoClienteHeaderOut($outputParameters)
