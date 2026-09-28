xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaOrigenesResponse" element="ns0:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaOrigenes/xsd/consultaOrigenes_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaOrigenesResponse" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOrigenes/xq/consultaOrigenesHNOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOrigenes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";

declare function xf:consultaOrigenesHNOut($consultaOrigenesResponse as element(ns0:OutputParameters))
    as element(ns1:consultaOrigenesResponse) {
    	let $origins := $consultaOrigenesResponse/ns0:P_ORIGIN/ns0:P_ORIGIN_ITEM
    	return
    		if (count($origins) < 1) then (
        		<ns1:consultaOrigenesResponse/>
			) else (
				<ns1:consultaOrigenesResponse>
					<ORIGINS>
					{
						for $i in (1 to count($origins))
						return
							let $code := $origins[$i]/ns0:ORIGIN_CODE
							let $description := $origins[$i]/ns0:ORIGIN_DESCRIPTION
							let $subOrigins := $origins[$i]/ns0:SUBORIGIN/ns0:SUBORIGIN_ITEM
							return
								<ORIGIN>
									<CODE>{ data($code) }</CODE>
									<DESCRIPTION>{ data($description) }</DESCRIPTION>
									{
										if (count($subOrigins) > 0) then (
											<SUBORIGINS>
												{
													for $i in (1 to count($subOrigins))
													return
														let $subOriginCode := $subOrigins[$i]/ns0:SUBORIGIN_CODE
														let $subOriginDescription := $subOrigins[$i]/ns0:SUBORIGIN_DESCRIPTION
														return
															<SUBORIGIN>
																<CODE>{ data($subOriginCode) }</CODE>
																<DESCRIPTION>{ data($subOriginDescription) }</DESCRIPTION>
															</SUBORIGIN>
												}
											</SUBORIGINS>	
										) else ()									
									}
								</ORIGIN>
					} 
					</ORIGINS>
				</ns1:consultaOrigenesResponse>
			)
};

declare variable $consultaOrigenesResponse as element(ns0:OutputParameters) external;

xf:consultaOrigenesHNOut($consultaOrigenesResponse)