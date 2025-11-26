xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaDebito/xq/ConsultaDatosTarjetaDebitoHeader/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:ConsultaDatosTarjetaDebitoHeader($codMens as xs:string,
    $descMens as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
	            	if (data($codMens)  = "SUCCESS" or data($codMens)  = "0" ) then (
	            		<successIndicator>SUCCESS</successIndicator>
	            	) else (
	            		if (data($codMens)  = "NOT FOUND" or data($codMens)  = "20653" ) then (
	            			<successIndicator>NOT FOUND</successIndicator>,
	            			<messages>{ data($descMens) }</messages>
	            		) else (
	            			<successIndicator>ERROR</successIndicator>,
	            			<messages>{ data($descMens) }</messages>
	            		) 
	            	) 
            }
        </ns0:ResponseHeader>
};

declare variable $codMens as xs:string external;
declare variable $descMens as xs:string external;

xf:ConsultaDatosTarjetaDebitoHeader($codMens,$descMens)