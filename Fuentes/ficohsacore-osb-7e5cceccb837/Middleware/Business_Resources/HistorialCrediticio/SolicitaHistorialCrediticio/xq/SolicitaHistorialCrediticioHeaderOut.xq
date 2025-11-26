(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/HistorialCrediticio/SolicitaHistorialCrediticio/xq/xhis/";

declare function xf:xhis($descMens as xs:string,
    $codMens as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
           {
	            	if (data($codMens)  = "1") then (
	            		<successIndicator>SUCCESS</successIndicator>
	            	) else (
	            		<successIndicator>ERROR</successIndicator>,
	            		<messages>{ data($descMens) }</messages>
	            	) 
            }
        </ns0:ResponseHeader>
};

declare variable $descMens as xs:string external;
declare variable $codMens as xs:string external;

xf:xhis($descMens,
    $codMens)