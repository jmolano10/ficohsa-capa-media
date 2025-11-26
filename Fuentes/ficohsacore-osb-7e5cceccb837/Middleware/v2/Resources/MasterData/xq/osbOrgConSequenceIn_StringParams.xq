(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/MasterData/conOrgSequence/xq/osbOrgConSequenceIn_StringParams/";

declare function xf:osbOrgConSequenceIn_StringParams($currency as xs:string,
    $creditCard as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CURRENCY>{ $currency }</ns0:CURRENCY>
            <ns0:CREDIT_CARD>{ $creditCard }</ns0:CREDIT_CARD>
        </ns0:InputParameters>
};

declare variable $currency as xs:string external;
declare variable $creditCard as xs:string external;


xf:osbOrgConSequenceIn_StringParams($currency,
    $creditCard)