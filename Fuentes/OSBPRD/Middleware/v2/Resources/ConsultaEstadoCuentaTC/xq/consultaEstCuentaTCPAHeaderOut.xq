xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarEstadosCuentaUltimoCorteResponse1" element="ns1:ConsultarEstadosCuentaUltimoCorteResponse" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaEstadoCuentaTC/xq/consultaEstadoCuentaTCHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};


declare function xf:consultaEstadoCuentaTCHeaderOut($consultarEstadosCuentaUltimoCorteResponse1 as element(ns1:ConsultarEstadosCuentaUltimoCorteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
        		if (fn:empty(data($consultarEstadosCuentaUltimoCorteResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarEstadosCuentaUltimoCorteResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($consultarEstadosCuentaUltimoCorteResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($consultarEstadosCuentaUltimoCorteResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:mensajeConfirmacion) }</messages>
        		)
        	}
            	
        </ns0:ResponseHeader>
};

declare variable $consultarEstadosCuentaUltimoCorteResponse1 as element(ns1:ConsultarEstadosCuentaUltimoCorteResponse) external;

xf:consultaEstadoCuentaTCHeaderOut($consultarEstadosCuentaUltimoCorteResponse1)