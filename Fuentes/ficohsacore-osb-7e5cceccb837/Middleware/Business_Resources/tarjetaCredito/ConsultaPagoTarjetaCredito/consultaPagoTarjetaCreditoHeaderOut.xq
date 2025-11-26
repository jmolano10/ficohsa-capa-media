(:: pragma bea:global-element-parameter parameter="$consultarpagosResponse" element="ns0:ConsultarpagosResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaPagoTarjetaCredito/consultaPagoTarjetaCreditoHeaderOut/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p = ("00", "0")) 
		then "SUCCESS" 
	else 
		"ERROR"
};

declare function xf:consultaPagoTarjetaCreditoHeaderOut($consultarpagosResponse as element(ns0:ConsultarpagosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
        		if (fn:empty(data($consultarpagosResponse/ns0:ConsultarpagosResult/ns0:EstatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($consultarpagosResponse/ns0:ConsultarpagosResult/ns0:EstatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($consultarpagosResponse/ns0:ConsultarpagosResult/ns0:EstatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($consultarpagosResponse/ns0:ConsultarpagosResult/ns0:MensajeConfirmacion) }</messages>
        		)
        	}	
        </ns1:ResponseHeader>
};

declare variable $consultarpagosResponse as element(ns0:ConsultarpagosResponse) external;

xf:consultaPagoTarjetaCreditoHeaderOut($consultarpagosResponse)