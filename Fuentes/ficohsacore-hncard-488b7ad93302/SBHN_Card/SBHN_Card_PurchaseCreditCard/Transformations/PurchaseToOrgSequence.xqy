xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
(:: import schema at "../Schemas/osbConOrgSequence_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $input as element() (:: schema-element(ns1:purchaseCreditCard) ::) external;

declare function local:funcPurchaseToOrgSequence($input as element() (:: schema-element(ns1:purchaseCreditCard) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CURRENCY>{fn:data($input/TransactionCurrency)}</ns2:CURRENCY>
        <ns2:CREDIT_CARD>{fn:data($input/CreditCard)}</ns2:CREDIT_CARD>
    </ns2:InputParameters>
};

local:funcPurchaseToOrgSequence($input)