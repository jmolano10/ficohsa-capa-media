xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleFinanciamiento1" element="ns1:consultaDetalleFinanciamiento" location="../xsd/consultaDetalleFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SettlementQuoteInquiryL8V1Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleFinanciamiento/xq/settlementQuoteInquiryL8V1PAIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleFinanciamientoTypes";

declare function xf:settlementQuoteInquiryL8V1PAIn($consultaDetalleFinanciamiento1 as element(ns1:consultaDetalleFinanciamiento))
    as element(ns0:SettlementQuoteInquiryL8V1Request) {
        <ns0:SettlementQuoteInquiryL8V1Request>
            <ARXQII-ORG>{ data($consultaDetalleFinanciamiento1/ORG) }</ARXQII-ORG>
            <ARXQII-ACCT>{ data($consultaDetalleFinanciamiento1/ACCOUNT_NUMBER) }</ARXQII-ACCT>
            <ARXQII-PLAN>{ data($consultaDetalleFinanciamiento1/PLAN_NUMBER) }</ARXQII-PLAN>
            <ARXQII-PLAN-SEQ>{ data($consultaDetalleFinanciamiento1/SECUENCE_NUMBER) }</ARXQII-PLAN-SEQ>
            <ARXQII-SVC-FUNC-CODE>N</ARXQII-SVC-FUNC-CODE>
            <ARXQII-SVC-START-SEQ-NBR>01</ARXQII-SVC-START-SEQ-NBR>
            <ARXQII-PAYOFF-BY-DATE>{ fn-bea:date-to-string-with-format('yyyy-MM-dd', data($consultaDetalleFinanciamiento1/CANCELLATION_DATE)) }</ARXQII-PAYOFF-BY-DATE>
            <ARXQII-STTL-QUOTE-TYPE>P</ARXQII-STTL-QUOTE-TYPE>
        </ns0:SettlementQuoteInquiryL8V1Request>
};

declare variable $consultaDetalleFinanciamiento1 as element(ns1:consultaDetalleFinanciamiento) external;

xf:settlementQuoteInquiryL8V1PAIn($consultaDetalleFinanciamiento1)
