xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/PaymentRecordCreditCard";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/paymentRecordCreditCardTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/OsbConOrgSequence";
(:: import schema at "../../../../../ProviderServices/XSD/OsbConOrgSequence/OsbConOrgSequence_sp.xsd" ::)

declare variable $PaymentRecordCreditCardRequest as element() (:: schema-element(ns1:PaymentRecordCreditCardRequest) ::) external;

declare function local:func($PaymentRecordCreditCardRequest as element() (:: schema-element(ns1:PaymentRecordCreditCardRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CURRENCY>{fn:data($PaymentRecordCreditCardRequest/ns1:Currency)}</ns2:CURRENCY>
        <ns2:CREDIT_CARD>{fn:data($PaymentRecordCreditCardRequest/ns1:CreditCard)}</ns2:CREDIT_CARD>
    </ns2:InputParameters>
};

local:func($PaymentRecordCreditCardRequest)