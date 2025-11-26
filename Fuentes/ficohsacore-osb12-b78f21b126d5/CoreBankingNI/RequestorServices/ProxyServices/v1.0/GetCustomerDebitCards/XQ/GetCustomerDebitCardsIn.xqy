xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDebitCards";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerDebitCards/GetCustomerDebitCards_sp.xsd" ::)
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";


declare variable $customerId as xs:string external;
declare variable $account as xs:string external;
declare variable $cardStatus as xs:string external;
 
 
declare function xq:getCardStatus($cardStatus as xs:string) as xs:string {
	if ($cardStatus = "ACTIVE") then ("1")
        else if ($cardStatus = "CANCELLED") then ("9")
        else if ($cardStatus = "ISSUED") then ("0")
        else if ($cardStatus = "HOT") then ("2")
        else if ($cardStatus = "WARM") then ("4")
        else("")
};


declare function local:func($customerId as xs:string,
                            $account as xs:string,
                            $cardStatus as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
      <i_CUSTOMER_ID>{fn:data($customerId)}</i_CUSTOMER_ID>
        {
          if (data($cardStatus)!= "" ) then 
               (
                  if (data($cardStatus)!= "All" ) then
                    (
                      <i_CARD_STATUS>{xq:getCardStatus(data($cardStatus))}</i_CARD_STATUS> 
                    )else (
                      <i_CARD_STATUS>{fn:data($cardStatus)}</i_CARD_STATUS>)
                )else ()
        }
      
        {
          if (data($account)!="" ) then 
              (    
                <i_ACCOUNT_NUMBER>{fn:data($account)}</i_ACCOUNT_NUMBER> 
              )else ()
        }
    </ns1:InputParameters>
};

local:func($customerId, $account, $cardStatus)