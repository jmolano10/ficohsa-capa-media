xquery version "2004-draft";
(:: pragma  parameter="$anyType1" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/ValidacionRequest/";
declare namespace flt = "http://www.bea.com/wli/sb/context";
declare namespace flt2  = "http://www.bea.com/wli/sb/stages/transform/config";

declare function xf:ValidacionRequest($anyType1 as element(*))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>ERROR</successIndicator>
            <messages>
            {
            	let $fields := (
        		for $i in $anyType1/flt:details/flt2:ValidationFailureDetail/flt2:xmlLocation
        		return
        			fn:local-name($i/*)
        		)
        		return 
        		fn:concat("FIELDS WITH ERRORS: ",fn:string-join($fields,", "))
            }
            </messages>
        </ns0:ResponseHeader>
};

declare variable $anyType1 as element(*) external;

xf:ValidacionRequest($anyType1)