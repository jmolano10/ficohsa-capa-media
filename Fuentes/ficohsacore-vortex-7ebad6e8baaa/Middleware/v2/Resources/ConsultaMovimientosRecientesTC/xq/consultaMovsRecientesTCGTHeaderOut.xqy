xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$movimientosRecientesResponse1" element="ns1:MovimientosRecientesResponse" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultarMovimientosRecientesTC/xq/consultaMovimientosRecientesTCHeaderOut/";
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

declare function xf:consultaMovimientosRecientesTCHeaderOut($movimientosRecientesResponse1 as element(ns1:MovimientosRecientesResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
        		if (fn:empty(data($movimientosRecientesResponse1/ns1:MovimientosRecientesResult/ns1:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($movimientosRecientesResponse1/ns1:MovimientosRecientesResult/ns1:estatusConfirmacion) }</messageId>,
        			 <successIndicator>
        			 { if (data($movimientosRecientesResponse1/ns1:MovimientosRecientesResult/ns1:estatusConfirmacion) = "97") then
        			 		"NO RECORDS"
           			   else
        			    local:getSuccessIndicator(data($movimientosRecientesResponse1/ns1:MovimientosRecientesResult/ns1:estatusConfirmacion))
        			 }
        			 </successIndicator>,
        			 <messages>{ data($movimientosRecientesResponse1/ns1:MovimientosRecientesResult/ns1:mensajeConfirmacion) }</messages>
        		)
        	}
            	
        </ns0:ResponseHeader>
};

declare variable $movimientosRecientesResponse1 as element(ns1:MovimientosRecientesResponse) external;

xf:consultaMovimientosRecientesTCHeaderOut($movimientosRecientesResponse1)