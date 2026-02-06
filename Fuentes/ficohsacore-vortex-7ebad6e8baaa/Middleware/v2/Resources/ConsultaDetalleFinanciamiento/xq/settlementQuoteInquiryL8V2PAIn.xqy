xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleFinanciamiento" element="ns1:consultaDetalleFinanciamiento" location="../xsd/consultaDetalleFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SettlementQuoteInquiryL8V2Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleFinanciamiento/xq/settlementQuoteInquiryL8V2PAIn/";

declare function xf:settlementQuoteInquiryL8V2PAIn($consultaDetalleFinanciamiento as element(ns1:consultaDetalleFinanciamiento))
    as element(ns0:SettlementQuoteInquiryL8V2Request) {
        <ns0:SettlementQuoteInquiryL8V2Request>
            <ARXQII-ORG>{ data($consultaDetalleFinanciamiento/ORG) }</ARXQII-ORG>
            <ARXQII-ACCT>{ data($consultaDetalleFinanciamiento/ACCOUNT_NUMBER) }</ARXQII-ACCT>
            <ARXQII-PLAN>{ data($consultaDetalleFinanciamiento/PLAN_NUMBER) }</ARXQII-PLAN>
            <ARXQII-PLAN-SEQ>{ data($consultaDetalleFinanciamiento/SECUENCE_NUMBER) }</ARXQII-PLAN-SEQ>
            <ARXQII-SVC-FUNC-CODE>N</ARXQII-SVC-FUNC-CODE>
             <ARXQII-SVC-START-SEQ-NBR>01</ARXQII-SVC-START-SEQ-NBR>            
            <ARXQII-PAYOFF-BY-DATE>{ fn-bea:date-to-string-with-format('yyyy-MM-dd', data($consultaDetalleFinanciamiento/CANCELLATION_DATE)) }</ARXQII-PAYOFF-BY-DATE>
            <ARXQII-STTL-QUOTE-TYPE>P</ARXQII-STTL-QUOTE-TYPE>
            {
                for $PAYMENT_AMOUNT in $consultaDetalleFinanciamiento/PAYMENT_AMOUNT
                return
                    <ARXQII-PARTIAL-SETL-AMT>{ data($PAYMENT_AMOUNT) }</ARXQII-PARTIAL-SETL-AMT>
            }
            {
            	for $PAYMENT_TYPE in $consultaDetalleFinanciamiento/PAYMENT_TYPE
            	return
            	 <ARXQII-PS-TYPE>{ data($PAYMENT_TYPE ) }</ARXQII-PS-TYPE>
            }           
        </ns0:SettlementQuoteInquiryL8V2Request>
};

declare variable $consultaDetalleFinanciamiento as element(ns1:consultaDetalleFinanciamiento) external;

xf:settlementQuoteInquiryL8V2PAIn($consultaDetalleFinanciamiento)