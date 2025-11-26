xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjEvaluateAbanksAccountTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/sjEvaluateAbanksAccountTypes.xsd" ::)

declare variable $sjEvaluateAbanksAccountRequest as element() (:: schema-element(ns1:sjEvaluateAbanksAccountRequest) ::) external;
declare variable $counter as xs:string external;

declare function local:func($sjEvaluateAbanksAccountRequest as element() (:: schema-element(ns1:sjEvaluateAbanksAccountRequest) ::), 
                            $counter as xs:string) 
                            as xs:string {
    let $account := data($sjEvaluateAbanksAccountRequest/ns1:AccountId)
                return
                
                if (xs:integer($counter) = 1) then (		    	
		    	<ns1:AccountId>{ $account }</ns1:AccountId>
		    	)
		    	else if (xs:integer($counter) = 2) then (
		    	
		    	<ns1:AccountId>{ fn:concat('0', $account) }</ns1:AccountId>
		    	)
		    	else (
		    	
		    	<ns1:AccountId>{ fn:concat('00', $account) }</ns1:AccountId>
		    	)
};

local:func($sjEvaluateAbanksAccountRequest, $counter)