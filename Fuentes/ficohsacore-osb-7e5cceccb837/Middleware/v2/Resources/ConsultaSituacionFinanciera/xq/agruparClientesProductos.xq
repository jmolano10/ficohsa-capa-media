(:: pragma bea:global-element-parameter parameter="$consultaSituacionFinancieraInterno" element="ns0:consultaSituacionFinancieraInterno" location="../xsd/consultaSituacionFinancieraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaSituacionFinancieraInterno" location="../xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSituacionFinancieraTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSituacionFinanciera/xq/agruparClientesProductos/";

declare function xf:agruparClientesProductos($consultaSituacionFinancieraInterno as element(ns0:consultaSituacionFinancieraInterno),
    $cantidadClientePorGrupos as xs:int,
    $cantidadProductoPorGrupos as xs:int)
    as element(ns1:sjConsultaSituacionFinancieraInterno) {
        <ns1:sjConsultaSituacionFinancieraInterno>
            <UUID>{ data($consultaSituacionFinancieraInterno/UUID) }</UUID>
            <GROUPS>
            	{
	            	let $numeroClientes := count($consultaSituacionFinancieraInterno/REGION/CUSTOMERS/CUSTOMER)
	            	let $tamanioGrupoClientes := if ($cantidadClientePorGrupos > 0) then (
													$cantidadClientePorGrupos
	            								) else if ($numeroClientes > 0) then (
	            									$numeroClientes
	            								) else (
	            									1
	            								)
		    		let $numeroGruposPorCliente := fn:ceiling($numeroClientes div $tamanioGrupoClientes) cast as xs:integer
				    let $numeroProductos := count($consultaSituacionFinancieraInterno/REGION/PRODUCTS/PRODUCT)
				    let $tamanioGrupoProductos := if ($cantidadProductoPorGrupos > 0) then (
				    								$cantidadProductoPorGrupos
				    							) else if ($numeroProductos > 0) then (
				    								$numeroProductos
				    							) else (
				    								1	
				    							)
				    let $numeroGruposPorProducto := fn:ceiling($numeroProductos div $tamanioGrupoProductos) cast as xs:integer
				    
		    		for $idx in 1 to max(($numeroGruposPorCliente, $numeroGruposPorProducto))
						
						let $startPosClient := ($idx - 1) * $tamanioGrupoClientes + 1 
						let $endPosClient := $idx * $tamanioGrupoClientes
						let $startPosProduct := ($idx - 1) * $tamanioGrupoProductos + 1 
						let $endPosProduct := $idx * $tamanioGrupoProductos
						
						return
			                <GROUP>
			                	<CUSTOMERS>
				                	{
										$consultaSituacionFinancieraInterno/REGION/CUSTOMERS/*[fn:position() = ($startPosClient to $endPosClient)]
							    	}
						    	</CUSTOMERS>
						    	<PRODUCTS>
				                	{
										$consultaSituacionFinancieraInterno/REGION/PRODUCTS/*[fn:position() = ($startPosProduct to $endPosProduct)]
							    	}
						    	</PRODUCTS>
			                </GROUP>
            	}
            </GROUPS>
            
        </ns1:sjConsultaSituacionFinancieraInterno>
};

declare variable $consultaSituacionFinancieraInterno as element(ns0:consultaSituacionFinancieraInterno) external;
declare variable $cantidadClientePorGrupos as xs:int external;
declare variable $cantidadProductoPorGrupos as xs:int external;

xf:agruparClientesProductos($consultaSituacionFinancieraInterno,
    $cantidadClientePorGrupos,
    $cantidadProductoPorGrupos)
