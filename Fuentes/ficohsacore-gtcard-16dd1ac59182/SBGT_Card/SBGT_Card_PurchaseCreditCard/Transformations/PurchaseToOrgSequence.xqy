xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
(:: import schema at "../Schemas/osbConOrgSequence_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $Purchase as element() (:: schema-element(ns1:purchaseCreditCard) ::) external;

declare function local:funcPurchaseToOrgSequence($Purchase as element() (:: schema-element(ns1:purchaseCreditCard) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <CURRENCY>{fn:data($Purchase/TransactionCurrency)}</CURRENCY>
        <CREDIT_CARD>{fn:data($Purchase/CreditCard)}</CREDIT_CARD>
    </ns2:InputParameters>
};

local:funcPurchaseToOrgSequence($Purchase)