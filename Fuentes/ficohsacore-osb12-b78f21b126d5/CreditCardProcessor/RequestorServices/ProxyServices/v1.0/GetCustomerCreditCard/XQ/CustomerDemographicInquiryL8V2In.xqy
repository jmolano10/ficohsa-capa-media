xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare variable $org as xs:string external;
declare variable $orgType as xs:string external;
declare variable $searchValue as xs:string external;
declare variable $searchCriteria as xs:string external;

declare function local:func($org as xs:string, 
                            $orgType as xs:string, 
                            $searchValue as xs:string, 
                            $searchCriteria as xs:string) 
                            as element() (:: schema-element(ns1:CustomerDemographicInquiryL8V2Request) ::) {
     <ns1:CustomerDemographicInquiryL8V2Request>
            <AZXNDI-ORG>{ $org }</AZXNDI-ORG>
            <AZXNDI-CUST-ACCT-CARD-NBR>{ $searchValue }</AZXNDI-CUST-ACCT-CARD-NBR>
            <AZXNDI-NBR-TYPE>{ $searchCriteria }</AZXNDI-NBR-TYPE>
	   		{                                       	   				
	   			if( $orgType = 'Base')then( 
					<AZXNDI-FOREIGN-USE>{ 1 }</AZXNDI-FOREIGN-USE>
                )
                else(
                	<AZXNDI-FOREIGN-USE>{ 0 }</AZXNDI-FOREIGN-USE>
                )	                    		                    					
	   		} 
        </ns1:CustomerDemographicInquiryL8V2Request>
};

local:func($org, $orgType, $searchValue, $searchCriteria)