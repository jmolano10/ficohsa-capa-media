(:: pragma bea:global-element-parameter parameter="$consultaDetalleFinanciamiento1" element="ns1:consultaDetalleFinanciamiento" location="../xsd/consultaDetalleFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SettlementQuoteInquiryL8V2Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleFinanciamiento/xq/settlementQuoteInquiryL8V2HNIn/";

declare function xf:settlementQuoteInquiryL8V2HNIn($consultaDetalleFinanciamiento1 as element(ns1:consultaDetalleFinanciamiento))
    as element(ns0:SettlementQuoteInquiryL8V2Request) {
        <ns0:SettlementQuoteInquiryL8V2Request>
            <ARXQII-ORG>{ data($consultaDetalleFinanciamiento1/ORG) }</ARXQII-ORG>
            <ARXQII-ACCT>{ data($consultaDetalleFinanciamiento1/ACCOUNT_NUMBER) }</ARXQII-ACCT>
            <ARXQII-PLAN>{ data($consultaDetalleFinanciamiento1/PLAN_NUMBER) }</ARXQII-PLAN>
            <ARXQII-PLAN-SEQ>{ data($consultaDetalleFinanciamiento1/SECUENCE_NUMBER) }</ARXQII-PLAN-SEQ>
            <ARXQII-SVC-FUNC-CODE>N</ARXQII-SVC-FUNC-CODE>
            <ARXQII-SVC-START-SEQ-NBR>01</ARXQII-SVC-START-SEQ-NBR>
            <ARXQII-PAYOFF-BY-DATE>{ fn-bea:date-to-string-with-format('yyyy-MM-dd', data($consultaDetalleFinanciamiento1/CANCELLATION_DATE)) }</ARXQII-PAYOFF-BY-DATE>
            <ARXQII-STTL-QUOTE-TYPE>P</ARXQII-STTL-QUOTE-TYPE>
            {
                for $PAYMENT_AMOUNT in $consultaDetalleFinanciamiento1/PAYMENT_AMOUNT
                return
                    <ARXQII-PARTIAL-SETL-AMT>{ data($PAYMENT_AMOUNT) }</ARXQII-PARTIAL-SETL-AMT>
            }
            {
            	for $PAYMENT_TYPE in $consultaDetalleFinanciamiento1/PAYMENT_TYPE
            	return
            	 <ARXQII-PS-TYPE>{ data($PAYMENT_TYPE ) }</ARXQII-PS-TYPE>
            }    
        </ns0:SettlementQuoteInquiryL8V2Request>
};

declare variable $consultaDetalleFinanciamiento1 as element(ns1:consultaDetalleFinanciamiento) external;

xf:settlementQuoteInquiryL8V2HNIn($consultaDetalleFinanciamiento1)