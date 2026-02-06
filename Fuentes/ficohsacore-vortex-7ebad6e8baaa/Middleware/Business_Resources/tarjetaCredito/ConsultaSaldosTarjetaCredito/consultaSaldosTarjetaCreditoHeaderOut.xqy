xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarSaldosResponse1" element="ns0:consultarSaldosResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoHeaderOut/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};


declare function xf:consultaSaldosTarjetaCreditoHeaderOut($consultarSaldosResponse1 as element(ns0:consultarSaldosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{	
        		if (fn:empty(data($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns1:ResponseHeader>
};

declare variable $consultarSaldosResponse1 as element(ns0:consultarSaldosResponse) external;

xf:consultaSaldosTarjetaCreditoHeaderOut($consultarSaldosResponse1)