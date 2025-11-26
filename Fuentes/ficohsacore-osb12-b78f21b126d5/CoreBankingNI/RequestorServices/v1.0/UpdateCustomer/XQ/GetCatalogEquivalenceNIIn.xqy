xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogEquivalence";
(:: import schema at "../../../../../CreditCardProcessor/ProviderServices/XSD/GetCatalogEquivalence/GetCatalogEquivalence_sp.xsd" ::)

declare variable $catalogos as xs:string external;
declare variable $catalogo as xs:string external;

declare function local:func($catalogos as xs:string, 
                            $catalogo as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
            <ns1:PT_CATALOGOS>
                {
                    for $catalogo in fn:tokenize($catalogos, '\|\|')
                    return
                    	if(normalize-space(($catalogo)) != "" and fn:string(fn:number($catalogo)) != "NaN") then (
                        	<ns1:PT_CATALOGOS_ITEM>{ $catalogo }</ns1:PT_CATALOGOS_ITEM>
                        ) else()
                }
            </ns1:PT_CATALOGOS>
        </ns1:InputParameters>
};

local:func($catalogos, $catalogo)