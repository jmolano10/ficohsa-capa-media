xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/consultarEquivalenciasCatalogosIn/";

declare function xf:consultarEquivalenciasCatalogosIn($catalogos as xs:string)
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

xf:consultarEquivalenciasCatalogosIn($catalogos)