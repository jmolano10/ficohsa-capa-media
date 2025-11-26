xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetLoanStatus_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetLoanStatus/GetLoanStatus_BS_sp.xsd" ::)

declare variable $paramType as xs:string external;
declare variable $queryParam as xs:string external;

declare function local:func($paramType as xs:string, 
                            $queryParam as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {                           
    <ns1:InputParameters>
      {
        if($paramType = 'LOAN') then (
        
          <ns1:LOAN_ID>{ $queryParam }</ns1:LOAN_ID>
          
        ) else if ($paramType = 'ID') then (
        
          <ns1:GLOBAL_ID>{ $queryParam }</ns1:GLOBAL_ID>
        ) else ()
      }
    </ns1:InputParameters>
};

local:func($paramType, $queryParam)