xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ADQ/ConsultaCuentaClienteUnico/xsd/consultaCuentaClienteUnico_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:obtenerInfoUsuarioAPPResponse" location="../xsd/obtenerInfoUsuarioAPPTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuentaClienteUnico";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/obtenerInfoUsuarioAPPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerInfoUsuarioAPP/xq/consultaCuentaClienteUnicoOut/";

declare function xf:consultaCuentaClienteUnicoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:obtenerInfoUsuarioAPPResponse) {
        <ns0:obtenerInfoUsuarioAPPResponse>
        	{
        	for $Row in $outputParameters/ns1:RowSet[1]/ns1:Row
            	return
	            <USER_INFORMATION>
	                <NAME>CUENTA</NAME>
	                <VALUE>{ data($Row/ns1:Column[@name="CuentaUnica"]) }</VALUE>
	            </USER_INFORMATION>
            }
        </ns0:obtenerInfoUsuarioAPPResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaCuentaClienteUnicoOut($outputParameters)