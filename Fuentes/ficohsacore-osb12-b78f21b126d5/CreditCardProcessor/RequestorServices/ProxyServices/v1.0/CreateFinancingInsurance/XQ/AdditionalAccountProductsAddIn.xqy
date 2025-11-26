xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/createFinancingInsuranceTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/createFinancingInsuranceTypes.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare variable $CreateFinancingInsuranceRequest as element() (:: schema-element(ns1:createFinancingInsuranceRequest) ::) external;

declare function local:func($CreateFinancingInsuranceRequest as element() (:: schema-element(ns1:createFinancingInsuranceRequest) ::)) as element() (:: schema-element(ns2:AdditionalAccountProductsAddRequest) ::) {
    <ns2:AdditionalAccountProductsAddRequest>
        <ARXINI-ORG>{fn:data($CreateFinancingInsuranceRequest/ORG)}</ARXINI-ORG>
        <ARXINI-ACCT-NBR>{fn:data($CreateFinancingInsuranceRequest/PRODUCT_NUMBER)}</ARXINI-ACCT-NBR>
        <ARXINI-DUAL-IND>{fn:data($CreateFinancingInsuranceRequest/CURRENCY_INDICATOR)}</ARXINI-DUAL-IND>
        <ARXINI-INS-PROD-CODE>{fn:data($CreateFinancingInsuranceRequest/INSURANCE_TYPE_CODE)}</ARXINI-INS-PROD-CODE>
        <ARXINI-INS-STATUS-CODE>F</ARXINI-INS-STATUS-CODE>
        <ARXINI-EFFECTIVE-DATE>{fn:adjust-date-to-timezone(current-date(),())}</ARXINI-EFFECTIVE-DATE>
        <ARXINI-ENROLL-ID/>
        <ARXINI-INS-CUST-NBR/>
        <ARXINI-INS-PARTY>0</ARXINI-INS-PARTY>
        <ARXINI-PREM-RATE-1>000000000</ARXINI-PREM-RATE-1>
        <ARXINI-FICHE-NBR/>
        <ARXINI-SOURCE/>
        <ARXINI-THIRD-PARTY-CARD-NBR/>
        <ARXINI-FORCE-REISSUE>0</ARXINI-FORCE-REISSUE>
    </ns2:AdditionalAccountProductsAddRequest>
};

local:func($CreateFinancingInsuranceRequest)