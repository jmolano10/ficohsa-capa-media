xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTCResponse1" element="ns0:sjConsultaSaldosTCResponse" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoHeaderOut/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};

declare function xf:consultaSaldosTarjetaCreditoHeaderOut($sjConsultaSaldosTCResponse1 as element(ns0:sjConsultaSaldosTCResponse))
    as element(ns1:ResponseHeader) {       
        <ns1:ResponseHeader>
        	{	
        		if (fn:empty(data($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($sjConsultaSaldosTCResponse1/consultarSaldosResponse/consultarSaldosResult/mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns1:ResponseHeader>	
};

declare variable $sjConsultaSaldosTCResponse1 as element(ns0:sjConsultaSaldosTCResponse) external;

xf:consultaSaldosTarjetaCreditoHeaderOut($sjConsultaSaldosTCResponse1)