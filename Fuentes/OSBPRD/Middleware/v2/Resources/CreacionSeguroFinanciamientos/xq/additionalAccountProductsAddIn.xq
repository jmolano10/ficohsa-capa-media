(:: pragma bea:global-element-parameter parameter="$creacionSeguroFinanciamientos" element="ns1:creacionSeguroFinanciamientos" location="../xsd/creacionSeguroFinanciamientosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AdditionalAccountProductsAddRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionSeguroFinanciamientosTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionSeguroFinanciamientos/xq/additionalAccountProductsAddIn/";

declare function xf:additionalAccountProductsAddIn($creacionSeguroFinanciamientos as element(ns1:creacionSeguroFinanciamientos))
    as element(ns0:AdditionalAccountProductsAddRequest) {
        <ns0:AdditionalAccountProductsAddRequest>
            <ARXINI-ORG>{ data($creacionSeguroFinanciamientos/ORG) }</ARXINI-ORG>
            <ARXINI-ACCT-NBR>{ data($creacionSeguroFinanciamientos/PRODUCT_NUMBER) }</ARXINI-ACCT-NBR>
            <ARXINI-DUAL-IND>{ data($creacionSeguroFinanciamientos/CURRENCY_INDICATOR) }</ARXINI-DUAL-IND>
            <ARXINI-INS-PROD-CODE>{ data($creacionSeguroFinanciamientos/INSURANCE_TYPE_CODE) }</ARXINI-INS-PROD-CODE>
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
        </ns0:AdditionalAccountProductsAddRequest>
};

declare variable $creacionSeguroFinanciamientos as element(ns1:creacionSeguroFinanciamientos) external;

xf:additionalAccountProductsAddIn($creacionSeguroFinanciamientos)