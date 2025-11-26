(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ConsultaClientePorNombre/xsd/ConsultaClientePorNombre_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClientePorNombreResponse" location="../xsd/consultaClientePorNombreTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaClientePorNombre";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientePorNombreTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClientePorNombre/xq/consultaClientePorNombreOut/";

declare function xf:consultaClientePorNombreOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaClientePorNombreResponse) {
        <ns1:consultaClientePorNombreResponse>
        	<PROFILES>
        	{
	        	for $LISTA_CLIENTE_ITEM in $outputParameters/ns0:PT_LISTA_CLIENTE/ns0:PT_LISTA_CLIENTE_ITEM
		        	return(
		        	
		        	 <PROFILE>
		                	<PROFILE_NUMBER>{ data($LISTA_CLIENTE_ITEM/ns0:CODIGO_CLIENTE) }</PROFILE_NUMBER>
		                    <NAME>{ data($LISTA_CLIENTE_ITEM/ns0:NOMBRE_COMPLETO) }</NAME>
		            </PROFILE>
	            )
            }
            </PROFILES>
        </ns1:consultaClientePorNombreResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaClientePorNombreOut($outputParameters)