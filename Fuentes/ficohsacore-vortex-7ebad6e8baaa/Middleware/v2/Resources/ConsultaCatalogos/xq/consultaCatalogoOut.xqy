xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCatalogos" element="ns0:consultaCatalogos" location="../xsd/consultaCatalogosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/Remesas/consultaCatalogos/xsd/consultaCatalogo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCatalogosResponse" location="../xsd/consultaCatalogosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCatalogo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCatalogos/xq/consultaCatalogoOut/";

declare function xf:consultaCatalogoOut($consultaCatalogos as element(ns0:consultaCatalogos),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaCatalogosResponse) {
        <ns0:consultaCatalogosResponse>
	        {
	        	let $FILTERS := $consultaCatalogos/ns0:FILTERS/ns0:FILTER
                for $i in (1 to count($FILTERS))
                let $FILTER := $consultaCatalogos/ns0:FILTERS/ns0:FILTER[$i]
                return
		        <ns0:catalogsList id = '{data($FILTER)}'>
	                {
	                    for $PT_CATALOGOS_ITEM in $outputParameters/ns1:PT_CATALOGOS/ns1:PT_CATALOGOS_ITEM[ns1:CATALOG = $FILTER]
	                    return
	                    if($FILTER = $PT_CATALOGOS_ITEM/ns1:CATALOG) then(
	                    	<ns0:catalogItem>
	                            {
	                                for $CODE in $PT_CATALOGOS_ITEM/ns1:CODE
	                                return
	                                    <ns0:CODE>{ data($CODE) }</ns0:CODE>
	                            }
	                            {
	                                for $DESCRIPTION in $PT_CATALOGOS_ITEM/ns1:DESCRIPTION
	                                return
	                                    <ns0:DESCRIPTION>{ data($DESCRIPTION) }</ns0:DESCRIPTION>
	                            }
	                        </ns0:catalogItem>
	                    )else()
	                }
	            </ns0:catalogsList>
	        }
            
        </ns0:consultaCatalogosResponse>
};

declare variable $consultaCatalogos as element(ns0:consultaCatalogos) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaCatalogoOut($consultaCatalogos,
    $outputParameters)