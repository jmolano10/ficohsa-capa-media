xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTCResponsePA" element="ns0:sjConsultaSaldosTCResponse" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoHeaderOutPA/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare function local:getSuccessIndicator($Indicator as xs:string?)
	as xs:string?
{
	if ($Indicator eq "00") 
		then "SUCCESS" 
	else 
		"ERROR"
};
declare function xf:consultaSaldosTarjetaCreditoHeaderOutPA($sjConsultaSaldosTCResponsePA as element(ns0:sjConsultaSaldosTCResponse))
    as element(ns1:ResponseHeader) {
          <ns1:ResponseHeader>
        	{	
        		if (fn:empty(data($sjConsultaSaldosTCResponsePA/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($sjConsultaSaldosTCResponsePA/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($sjConsultaSaldosTCResponsePA/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($sjConsultaSaldosTCResponsePA/consultarSaldosResponse/consultarSaldosResult/mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns1:ResponseHeader>
};

declare variable $sjConsultaSaldosTCResponsePA as element(ns0:sjConsultaSaldosTCResponse) external;

xf:consultaSaldosTarjetaCreditoHeaderOutPA($sjConsultaSaldosTCResponsePA)