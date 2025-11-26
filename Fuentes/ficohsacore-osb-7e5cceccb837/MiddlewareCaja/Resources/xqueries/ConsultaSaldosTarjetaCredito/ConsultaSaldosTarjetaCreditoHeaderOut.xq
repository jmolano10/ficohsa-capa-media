xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarSaldosResponse" element="ns0:consultarSaldosResponse" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaSaldosTarjetaCredito/ConsultaSaldosTarjetaCreditoHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://tempuri.org/";

declare function getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};

declare function xf:ConsultaSaldosTarjetaCreditoHeaderOut($consultarSaldosResponse as element(ns0:consultarSaldosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{	
        		if (fn:empty(data($consultarSaldosResponse/ns0:consultarSaldosResult/ns0:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarSaldosResponse/ns0:consultarSaldosResult/ns0:estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ getSuccessIndicator(data($consultarSaldosResponse/ns0:consultarSaldosResult/ns0:estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($consultarSaldosResponse/ns0:consultarSaldosResult/ns0:mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns1:ResponseHeader>
};

declare variable $consultarSaldosResponse as element(ns0:consultarSaldosResponse) external;

xf:ConsultaSaldosTarjetaCreditoHeaderOut($consultarSaldosResponse)