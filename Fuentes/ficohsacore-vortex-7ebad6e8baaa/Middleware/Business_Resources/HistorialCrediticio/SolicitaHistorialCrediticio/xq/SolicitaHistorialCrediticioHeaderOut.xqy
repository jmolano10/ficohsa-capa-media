xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../xsd/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/HistorialCrediticio/SolicitaHistorialCrediticio/xq/SolicitaHistorialCrediticioHeaderOut/";

declare function xf:SolicitaHistorialCrediticioHeaderOut($codMens as xs:string, $descMens as xs:string)
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
	            	if (data($codMens)  = "1") then (
	            		<successIndicator>SUCCESS</successIndicator>
	            	) else (
	            		<successIndicator>ERROR</successIndicator>,
	            		<messages>{ data($descMens) }</messages>
	            	) 
            }
        </ns1:ResponseHeader>
};

declare variable $codMens as xs:string external;
declare variable $descMens as xs:string external;

xf:SolicitaHistorialCrediticioHeaderOut($codMens, $descMens)