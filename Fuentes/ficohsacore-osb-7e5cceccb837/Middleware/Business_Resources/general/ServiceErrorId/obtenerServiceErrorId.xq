(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/ServiceErrorId/obtenerServiceErrorId/";


declare function xf:obtenerServiceErrorId($string1 as xs:string,
    $string2 as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>ERROR</successIndicator>
            <messages>{ 
            let $DATE := fn:current-date()
            let $ERROR_MESSAGE := fn:tokenize($string2,":")
            let $ERROR_ID := fn:string-join( 
            for $i in (1 to 4)
            return
            	if ($i > 2) then (
            		concat(fn:substring(fn:string($DATE),6+$i,1),fn:substring($string1,$i,1))
            	) else (
            		concat(fn:substring(fn:string($DATE),5+$i,1),fn:substring($string1,$i,1))
            	)
            ,'')
			return
				if ($ERROR_MESSAGE[3] != "") then (
					concat($ERROR_ID,fn:string-join(($ERROR_MESSAGE[1],$ERROR_MESSAGE[3]),": "))
				) else (
					concat($ERROR_ID,fn:string-join(($ERROR_MESSAGE[1],$ERROR_MESSAGE[2]),": "))
				)            	 
            }</messages>
        </ns0:ResponseHeader>
};

declare variable $string1 as xs:string external;
declare variable $string2 as xs:string external;

xf:obtenerServiceErrorId($string1,
    $string2)