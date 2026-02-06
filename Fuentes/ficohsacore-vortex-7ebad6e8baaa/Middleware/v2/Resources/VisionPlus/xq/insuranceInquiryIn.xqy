xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSeguros1" element="ns1:consultaSeguros" location="../../ConsultaSeguros/xsd/consultaSegurosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InsuranceInquiryRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSegurosTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/insuranceInquiryIn/";

declare function xf:insuranceInquiryIn($consultaSeguros1 as element(ns1:consultaSeguros))
    as element(ns0:InsuranceInquiryRequest) {
        <ns0:InsuranceInquiryRequest>
            <ARXIII-ORG>{ data($consultaSeguros1/ORG) }</ARXIII-ORG>
            <ARXIII-CARD-ACCT>{ data($consultaSeguros1/ACCOUNT_NUMBER) }</ARXIII-CARD-ACCT>
            <ARXIII-DUAL-IND>{ data($consultaSeguros1/DUAL_IND) }</ARXIII-DUAL-IND>
        </ns0:InsuranceInquiryRequest>
};

declare variable $consultaSeguros1 as element(ns1:consultaSeguros) external;

xf:insuranceInquiryIn($consultaSeguros1)