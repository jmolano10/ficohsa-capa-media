(:: pragma bea:global-element-return element="ns0:CustomerDemographicInquiryL8V2Request" location="../../../BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/customerDemographicInquiryL8V2In/";

declare function xf:customerDemographicInquiryL8V2In($org as xs:string,
    $searchValue as xs:string,
    $searchCriteria as xs:string)
    as element(ns0:CustomerDemographicInquiryL8V2Request) {
        <ns0:CustomerDemographicInquiryL8V2Request>
        	<AZXNDI-ORG>{ $org }</AZXNDI-ORG>
            <AZXNDI-CUST-ACCT-CARD-NBR>{ $searchValue }</AZXNDI-CUST-ACCT-CARD-NBR>
            <AZXNDI-NBR-TYPE>{ $searchCriteria }</AZXNDI-NBR-TYPE>
        </ns0:CustomerDemographicInquiryL8V2Request>
};

declare variable $org as xs:string external;
declare variable $searchValue as xs:string external;
declare variable $searchCriteria as xs:string external;

xf:customerDemographicInquiryL8V2In($org,
    $searchValue,
    $searchCriteria)