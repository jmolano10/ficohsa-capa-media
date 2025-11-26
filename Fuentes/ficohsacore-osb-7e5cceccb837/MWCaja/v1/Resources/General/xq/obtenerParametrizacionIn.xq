(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Middleware/ObtenerParametros/xsd/obtenerParametrizacion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerParametrizacion";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/General/xq/obtenerParametrizacionIn/";

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

declare variable $nombreParametros as xs:string external;

xf:obtenerParametrizacionIn($nombreParametros)