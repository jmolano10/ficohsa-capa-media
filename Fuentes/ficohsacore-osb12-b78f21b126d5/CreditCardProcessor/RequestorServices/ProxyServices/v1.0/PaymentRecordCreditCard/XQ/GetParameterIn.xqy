xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetParameter";
(:: import schema at "../../../../../ProviderServices/XSD/GetParameter/GetParameter_sp.xsd" ::)

declare variable $ParametersName as xs:string external;

declare function local:func($ParametersName as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PARAMETRIZACIONES>
            {
                    for $nombre in fn:tokenize($ParametersName, '\|\|')
                    return
                    	if(normalize-space(($nombre)) != "") then (
                        	<ns1:PARAMETRIZACIONES_ITEM>{ $nombre }</ns1:PARAMETRIZACIONES_ITEM>
                        ) else()
                }
        </ns1:PARAMETRIZACIONES>
    </ns1:InputParameters>
};

local:func($ParametersName)