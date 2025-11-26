xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTCResponseGT" element="ns0:sjConsultaSaldosTCResponse" location="../../../BusinessServices/SJS/consultaSaldosTC/xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoHeaderOutGT/";
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
declare function xf:consultaSaldosTarjetaCreditoHeaderOutGT($sjConsultaSaldosTCResponseGT as element(ns0:sjConsultaSaldosTCResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{	
        		if (fn:empty(data($sjConsultaSaldosTCResponseGT/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($sjConsultaSaldosTCResponseGT/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($sjConsultaSaldosTCResponseGT/consultarSaldosResponse/consultarSaldosResult/estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($sjConsultaSaldosTCResponseGT/consultarSaldosResponse/consultarSaldosResult/mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns1:ResponseHeader>
};

declare variable $sjConsultaSaldosTCResponseGT as element(ns0:sjConsultaSaldosTCResponse) external;

xf:consultaSaldosTarjetaCreditoHeaderOutGT($sjConsultaSaldosTCResponseGT)