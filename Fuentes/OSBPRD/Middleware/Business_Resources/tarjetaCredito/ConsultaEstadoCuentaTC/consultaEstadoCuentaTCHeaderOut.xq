(:: pragma bea:global-element-parameter parameter="$consultarUltimoECResponse1" element="ns0:ConsultarUltimoECResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCHeaderOut/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};

declare function xf:consultaEstadoCuentaTCHeaderOut($consultarUltimoECResponse1 as element(ns0:ConsultarUltimoECResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
        		if (fn:empty(data($consultarUltimoECResponse1/ns0:ConsultarUltimoECResult/ns0:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarUltimoECResponse1/ns0:ConsultarUltimoECResult/ns0:estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($consultarUltimoECResponse1/ns0:ConsultarUltimoECResult/ns0:estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($consultarUltimoECResponse1/ns0:ConsultarUltimoECResult/ns0:mensajeConfirmacion) }</messages>
        		)
        	}
            	
        </ns1:ResponseHeader>
};

declare variable $consultarUltimoECResponse1 as element(ns0:ConsultarUltimoECResponse) external;

xf:consultaEstadoCuentaTCHeaderOut($consultarUltimoECResponse1)