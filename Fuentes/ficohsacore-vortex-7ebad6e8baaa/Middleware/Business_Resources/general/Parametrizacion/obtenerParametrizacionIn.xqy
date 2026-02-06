xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/ObtenerParametrizacion/obtenerParametrizacionIn/";

(: Se envía los nombres de las parametrizaciones que se deseen consultar. Para enviar varios se deben separar por el caracter "||" :)
declare function xf:obtenerParametrizacionIn($nombreParametros as xs:string)
    as element(ns0:InputParameters) {
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

declare variable $nombreParametros as xs:string* external;

xf:obtenerParametrizacionIn($nombreParametros)