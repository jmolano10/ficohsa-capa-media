xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetParameters";
(:: import schema at "../../../../ProviderServices/XSD/GetParameters/GetParameters_sp.xsd" ::)

declare variable $nombreParametros as xs:string external;

declare function local:func($nombreParametros as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
          <ns1:PARAMETRIZACIONES>
                {
                    for $nombre in fn:tokenize($nombreParametros, '\|\|')
                    return
                    	if(normalize-space(($nombre)) != "") then (
                        	<ns1:NOMBRE>{ $nombre }</ns1:NOMBRE>
                        ) else()
                }
            </ns1:PARAMETRIZACIONES>
    </ns1:InputParameters>
};

local:func($nombreParametros)