xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ConsultaAfiliacionesPorCliente/xsd/consultaAfiliacionesPorCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAfiliacionesPorClienteResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAfiliacionesPorCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaAfiliacionesPorClienteOut/";

declare function xf:consultaAfiliacionesPorClienteOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaAfiliacionesPorClienteResponse) {
        <ns0:consultaAfiliacionesPorClienteResponse>
            <LISTA_AFILIACIONES>
            {
            	for $Row in $outputParameters/ns1:PV_CUENTA_AP/ns1:Row
            	return(
                	   <AFILIACION>
					        <CUENTA_AP>{ data($Row/ns1:Column[@name='CUENTA_AP']) }</CUENTA_AP>
					        <ID_CLIENTE>{ data($Row/ns1:Column[@name='ID_CLIENTE']) }</ID_CLIENTE>
					        <MONEDA>{ data($Row/ns1:Column[@name='MONEDA']) }</MONEDA>
					        <FECHA_AFILIACION>{ data($Row/ns1:Column[@name='FECHA_AFILIACION']) }</FECHA_AFILIACION>
					        <MONTO>{ data($Row/ns1:Column[@name='MONTO']) }</MONTO>
					        <TIEMPO_AFILIACION>{ data($Row/ns1:Column[@name='TIEMPO_AFILIACION']) }</TIEMPO_AFILIACION>
    					</AFILIACION> 
                )
            }
            </LISTA_AFILIACIONES>
        </ns0:consultaAfiliacionesPorClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaAfiliacionesPorClienteOut($outputParameters)