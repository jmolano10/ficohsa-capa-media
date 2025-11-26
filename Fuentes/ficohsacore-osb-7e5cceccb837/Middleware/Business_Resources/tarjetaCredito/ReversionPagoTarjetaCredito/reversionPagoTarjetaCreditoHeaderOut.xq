(:: pragma bea:global-element-parameter parameter="$reversarPagoResponse" element="ns0:reversarPagoResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ReversionPagoTarjetaCredito/reversionPagoTarjetaCreditoHeaderOut/";

declare function local:getSuccessIndicator($p as xs:string?)
	as xs:string?
{
	if ($p = ("00", "0")) 
		then "SUCCESS" 
	else 
		"ERROR"
};

declare function xf:reversionPagoTarjetaCreditoHeaderOut($reversarPagoResponse as element(ns0:reversarPagoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
        		if (fn:empty(data($reversarPagoResponse/ns0:reversarPagoResult/ns0:estatusConfirmacion))) then (
        			 <successIndicator>ERROR</successIndicator>,
        			  <messages>NO DATA FOUND</messages>
        		)
        		else (
        			 <messageId>{ data($reversarPagoResponse/ns0:reversarPagoResult/ns0:estatusConfirmacion) }</messageId>,
        			 <successIndicator>{ local:getSuccessIndicator(data($reversarPagoResponse/ns0:reversarPagoResult/ns0:estatusConfirmacion)) }</successIndicator>,
        			 <messages>{ data($reversarPagoResponse/ns0:reversarPagoResult/ns0:mensajeConfirmacion) }</messages>
        		)
        	}	
        </ns1:ResponseHeader>
};

declare variable $reversarPagoResponse as element(ns0:reversarPagoResponse) external;

xf:reversionPagoTarjetaCreditoHeaderOut($reversarPagoResponse)