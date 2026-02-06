xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFacturas" element="ns0:consultaFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/consultaFacturasCliente/xq/validaFechaPagadas/";

declare function xf:validaFechaPagadas($consultaFacturas as element(ns0:consultaFacturas))
    as xs:boolean {
    	if(fn:string(data($consultaFacturas/END_DATE)) != '' or fn:string(data($consultaFacturas/BEGIN_DATE)) != '') then
    		if((fn:string(data($consultaFacturas/BILL_STATUS/PGD)) = 'YES' or fn:string(data($consultaFacturas/BILL_STATUS/PPA)) = 'YES' or fn:string(data($consultaFacturas/BILL_STATUS/PEN)) = 'YES') and 
    		   (fn:string(data($consultaFacturas/BILL_STATUS/ANU)) = '' or fn:string(data($consultaFacturas/BILL_STATUS/ANU)) = 'NO' ) and 
    		   (fn:string(data($consultaFacturas/BILL_STATUS/ERR)) = '' or fn:string(data($consultaFacturas/BILL_STATUS/ERR)) = 'NO' ) and 
    		   (fn:string(data($consultaFacturas/BILL_STATUS/ELM)) = '' or fn:string(data($consultaFacturas/BILL_STATUS/ELM)) = 'NO' ) and 
    		   (fn:string(data($consultaFacturas/BILL_STATUS/PRE_ALT)) = '' or fn:string(data($consultaFacturas/BILL_STATUS/PRE_ALT)) = 'NO' ) and 
    		   (fn:string(data($consultaFacturas/BILL_STATUS/PRE_ELM)) = '' or fn:string(data($consultaFacturas/BILL_STATUS/PRE_ELM)) = 'NO' ) and 
    		   (fn:string(data($consultaFacturas/BILL_STATUS/PRE_ANU)) = '' or fn:string(data($consultaFacturas/BILL_STATUS/PRE_ANU)) = 'NO' ) ) then
    		    xs:boolean("1")
    		else
    			xs:boolean("0")
    	else
    		xs:boolean("1")
};

declare variable $consultaFacturas as element(ns0:consultaFacturas) external;

xf:validaFechaPagadas($consultaFacturas)