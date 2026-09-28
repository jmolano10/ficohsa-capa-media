xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarMovsRecientesResponse1" element="ns0:ConsultarMovsRecientesResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://tempuri.org/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};


declare function xf:consultaMovimientosRecientesTCHeaderOut($consultarMovsRecientesResponse1 as element(ns0:ConsultarMovsRecientesResponse))
    as element(ns1:ResponseHeader) {
         <ns1:ResponseHeader>
        	{
        		if (fn:empty(data($consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:estatusConfirmacion) }</messageId>,
        			 <successIndicator>
        			 { 
        			 	if(data($consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:estatusConfirmacion) = "97") then
        			 		"NO RECORDS"
        			 	else
        			 		local:getSuccessIndicator(data($consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:estatusConfirmacion)) 
        			 }
        			 </successIndicator>,
        			 <messages>{ data($consultarMovsRecientesResponse1/ns0:ConsultarMovsRecientesResult/ns0:mensajeConfirmacion) }</messages>
        		)
        	}
            	
        </ns1:ResponseHeader>
};

declare variable $consultarMovsRecientesResponse1 as element(ns0:ConsultarMovsRecientesResponse) external;

xf:consultaMovimientosRecientesTCHeaderOut($consultarMovsRecientesResponse1)