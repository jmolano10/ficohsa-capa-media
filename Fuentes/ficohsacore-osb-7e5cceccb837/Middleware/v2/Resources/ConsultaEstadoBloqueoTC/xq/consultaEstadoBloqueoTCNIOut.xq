(:: pragma bea:global-element-return element="ns0:consultaEstadoBloqueoTCResponse" location="../xsd/consultaEstadoBloqueoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoBloqueoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoBloqueoTC/xq/consultaEstadoBloqueoTCNIOut/";

declare function xf:consultaEstadoBloqueoTCNIOut($estadoTC as xs:string,
    $tipoBloqueo as xs:string)
    as element(ns0:consultaEstadoBloqueoTCResponse) {
        <ns0:consultaEstadoBloqueoTCResponse>
            {
            	if ($estadoTC = '0') then
            		<ns0:ACCOUNT_STATUS>ACTIVE</ns0:ACCOUNT_STATUS>
            	else
            		<ns0:ACCOUNT_STATUS>INACTIVE</ns0:ACCOUNT_STATUS>
            }
            <ns0:BLOCK_TYPE>{ $tipoBloqueo }</ns0:BLOCK_TYPE>
        </ns0:consultaEstadoBloqueoTCResponse>
};

declare variable $estadoTC as xs:string external;
declare variable $tipoBloqueo as xs:string external;

xf:consultaEstadoBloqueoTCNIOut($estadoTC,
    $tipoBloqueo)
