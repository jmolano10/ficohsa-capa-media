xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarSaldosResponse1" element="ns1:consultarSaldosResponse" location="../../../BusinessServices/ABKGT/transaccionesTCOnline/wsdl/WSDL.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCGTOnlineHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://tempuri.org/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};

declare function xf:consultaSaldosTCGTOnlineHeaderOut($consultarSaldosResponse1 as element(ns1:consultarSaldosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{	
        		if (fn:empty(data($consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($consultarSaldosResponse1/ns1:consultarSaldosResult/ns1:mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns0:ResponseHeader>
};

declare variable $consultarSaldosResponse1 as element(ns1:consultarSaldosResponse) external;

xf:consultaSaldosTCGTOnlineHeaderOut($consultarSaldosResponse1)