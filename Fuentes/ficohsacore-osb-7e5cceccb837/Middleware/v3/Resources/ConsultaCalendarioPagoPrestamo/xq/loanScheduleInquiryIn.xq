(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamo" element="ns0:consultaCalendarioPagoPrestamo" location="../xsd/consultaCalendarioPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:LoanScheduleInquiryRequest" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCalendarioPagoPrestamo/xq/loanScheduleInquiryIn/";

declare function xf:loanScheduleInquiryIn($consultaCalendarioPagoPrestamo as element(ns0:consultaCalendarioPagoPrestamo))
    as element(ns1:LoanScheduleInquiryRequest) {
        <ns1:LoanScheduleInquiryRequest>
            <AZXLSI-CONTEXT>{ fn:string('') }</AZXLSI-CONTEXT>
            <AZXLSI-SIGNON-NAME>{ fn:string('') }</AZXLSI-SIGNON-NAME>
            <AZXLSI-ORG>{ data($consultaCalendarioPagoPrestamo/ORG) }</AZXLSI-ORG>
            <AZXLSI-ACCT>{ data($consultaCalendarioPagoPrestamo/PRODUCT_NUMBER) }</AZXLSI-ACCT>
            <AZXLSI-PLAN>{ data($consultaCalendarioPagoPrestamo/PLAN_CODE) }</AZXLSI-PLAN>
            <AZXLSI-PLAN-SEQ>{ data($consultaCalendarioPagoPrestamo/PLAN_SEQUENCE) }</AZXLSI-PLAN-SEQ>
        </ns1:LoanScheduleInquiryRequest>
};

declare variable $consultaCalendarioPagoPrestamo as element(ns0:consultaCalendarioPagoPrestamo) external;

xf:loanScheduleInquiryIn($consultaCalendarioPagoPrestamo)