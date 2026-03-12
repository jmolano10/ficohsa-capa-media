xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
(:: import schema at "../../Schemas/v2/consultaEquivalenciasCatalogos_sp.xsd" ::)

declare function local:consultarEquivalenciasCatalogosIn($catalogos as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_CATALOGOS>
                {
                    for $catalogo in fn:tokenize($catalogos, '\|\|')
                    return
                    	if(normalize-space(($catalogo)) != "" and fn:string(fn:number($catalogo)) != "NaN") then (
                        	<ns0:CATALOGO>{ $catalogo }</ns0:CATALOGO>
                        ) else()
                }
            </ns0:PT_CATALOGOS>
        </ns0:InputParameters>
};

declare variable $catalogos as xs:string external;

local:consultarEquivalenciasCatalogosIn($catalogos)