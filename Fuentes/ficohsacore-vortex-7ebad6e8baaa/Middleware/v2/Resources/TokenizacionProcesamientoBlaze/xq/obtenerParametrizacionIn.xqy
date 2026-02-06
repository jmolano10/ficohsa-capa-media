xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
(:: import schema at "../../../../Business_Resources/general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)

declare variable $nombreParametros as xs:string external;

declare function local:obtenerParametrizacionIn($nombreParametros as xs:string) as element() (:: schema-element(ns0:InputParameters) ::) {
     <ns0:InputParameters>
            <ns0:PARAMETRIZACIONES>
                {
                    for $nombre in fn:tokenize($nombreParametros, '\|\|')
                    return
                    	if(normalize-space(($nombre)) != "") then (
                        	<ns0:NOMBRE>{ $nombre }</ns0:NOMBRE>
                        ) else()
                }
            </ns0:PARAMETRIZACIONES>
        </ns0:InputParameters>
};

local:obtenerParametrizacionIn($nombreParametros)