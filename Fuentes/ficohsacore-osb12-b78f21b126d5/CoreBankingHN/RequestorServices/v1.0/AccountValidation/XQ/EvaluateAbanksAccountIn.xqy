xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjEvaluateAbanksAccountTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/sjEvaluateAbanksAccountTypes.xsd" ::)

declare variable $sjEvaluateAbanksAccountRequest as element() (:: schema-element(ns1:sjEvaluateAbanksAccountRequest) ::) external;
declare variable $counter as xs:string external;

declare function local:func($sjEvaluateAbanksAccountRequest as element() (:: schema-element(ns1:sjEvaluateAbanksAccountRequest) ::), 
                            $counter as xs:string) 
                            as xs:string {
    let $account := fn:data($sjEvaluateAbanksAccountRequest/ns1:AccountId)                       
        return    
          if (xs:integer($counter) = 1) then (
          $account
          )
          else if (xs:integer($counter) = 2) then (
          fn:concat('0', $account)
          )
          else (
          fn:concat('00', $account)
          )
};

local:func($sjEvaluateAbanksAccountRequest, $counter)