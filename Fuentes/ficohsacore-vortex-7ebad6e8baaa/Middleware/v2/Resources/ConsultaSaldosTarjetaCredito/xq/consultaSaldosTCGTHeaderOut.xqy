xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarSaldosVasaResponse1" element="ns1:ConsultarSaldosVasaResponse" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoHeaderOut/";
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


declare function xf:consultaSaldosTarjetaCreditoHeaderOut($consultarSaldosVasaResponse1 as element(ns1:ConsultarSaldosVasaResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{	
        		if (fn:empty(data($consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($consultarSaldosVasaResponse1/ns1:ConsultarSaldosVasaResult/ns1:mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns0:ResponseHeader>
};

declare variable $consultarSaldosVasaResponse1 as element(ns1:ConsultarSaldosVasaResponse) external;

xf:consultaSaldosTarjetaCreditoHeaderOut($consultarSaldosVasaResponse1)