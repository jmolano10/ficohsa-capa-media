xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos_v2/xsd/consultaEquivalenciasCatalogos_v2_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos_v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaClienteTarjetaCredito/xq/consultaEquivalenciasCatalogos/";

declare function xf:consultaEquivalenciasCatalogos($tipoProceso as xs:string, $criteriosConsulta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_EQ_PROCESO>{ data($tipoProceso) }</ns0:PV_TIPO_EQ_PROCESO>
            <ns0:PT_EQUIVALENCIAS_INGRESO>
            	{
	                    let $criterioConsulta := fn:tokenize($criteriosConsulta, '\|\|')
	                    for $i in 1 to count($criterioConsulta)
	                    return
               				 <ns0:PT_EQUIVALENCIAS_INGRESO_ITEM>
               				 {
	               				 let $campos := fn:tokenize($criterioConsulta[$i], ';') 
	               				 return(
		                        	<ns0:CATALOGO_ID>{ data($campos[1]) }</ns0:CATALOGO_ID>,
		                        	<ns0:VALOR_CATALOGO>{ data($campos[2]) }</ns0:VALOR_CATALOGO>,
		                        	<ns0:APLICACIONES>
		                        	{
		                        		for $j in 2 to count($campos)
	               				 		return(
	               				 			if(normalize-space($campos[$j+1]) != "") then (
												<ns0:APLICACIONES_ITEM>{data($campos[$j+1])}</ns0:APLICACIONES_ITEM>
											)else()
										)
									}
									</ns0:APLICACIONES>
		                        )
	                        }
			                </ns0:PT_EQUIVALENCIAS_INGRESO_ITEM>
		                 
                   }
		            </ns0:PT_EQUIVALENCIAS_INGRESO>
        </ns0:InputParameters>
};

declare variable $tipoProceso as xs:string external;
declare variable $criteriosConsulta as xs:string external;


xf:consultaEquivalenciasCatalogos($tipoProceso,
$criteriosConsulta)