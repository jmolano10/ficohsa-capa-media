xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/PaymentRecordCreditCard";
(:: import schema at "../../../../../MWBanking/CreditCards/RequestorServices/XSD/paymentRecordCreditCardTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $PaymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $transactionType as xs:string external;
declare variable $ORG as xs:string external;
declare variable $paymentTypeValue as xs:string external;
declare variable $contractName as xs:string external;

declare function local:func($PaymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $transactionType as xs:string, 
                            $ORG as xs:string, 
                            $paymentTypeValue as xs:string,
                            $contractName as xs:string) 
                            as element() (:: schema-element(ns2:PaymentRecordCreditCardRequest) ::) {
    <ns2:PaymentRecordCreditCardRequest>
        {
            if ($PaymentCollectionRequest/ns1:GeneralInfo)
            then 
                <ns2:GeneralInfo>
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:SourceBank)
                        then <com:SourceBank>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:SourceBank)}</com:SourceBank>
                        else ()
                    }
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:DestinationBank)
                        then <com:DestinationBank>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:DestinationBank)}</com:DestinationBank>
                        else ()
                    }
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:GlobalId)
                        then <com:GlobalId>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:GlobalId)}</com:GlobalId>
                        else ()
                    }
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:ApplicationId)
                        then <com:ApplicationId>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:ApplicationId)}</com:ApplicationId>
                        else ()
                    }
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:ApplicationUser)
                        then <com:ApplicationUser>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:ApplicationUser)}</com:ApplicationUser>
                        else ()
                    }
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:BranchId)
                        then <com:BranchId>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:BranchId)}</com:BranchId>
                        else ()
                    }
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:TransactionDate)
                        then <com:TransactionDate>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:TransactionDate)}</com:TransactionDate>
                        else ()
                    }
                    {
                        if ($PaymentCollectionRequest/ns1:GeneralInfo/com:Language)
                        then <com:Language>{fn:data($PaymentCollectionRequest/ns1:GeneralInfo/com:Language)}</com:Language>
                        else ()
                    }
                </ns2:GeneralInfo>
            else ()
        }
        <ns2:CreditCard>{fn:data($PaymentCollectionRequest/ns1:PaymentInformation/ns1:CreditCardNumber)}</ns2:CreditCard>
        <ns2:ExpirationDate>{fn:data($PaymentCollectionRequest/ns1:PaymentInformation/ns1:ExpirationDate)}</ns2:ExpirationDate>
        {
            if(fn:data($PaymentCollectionRequest/ns1:Description)='' or fn:count(fn:data($PaymentCollectionRequest/ns1:Description))=0)then(
                <ns2:Description>{ fn:data($contractName) }</ns2:Description>
            )else(
                <ns2:Description>{ fn:data($PaymentCollectionRequest/ns1:Description) }</ns2:Description>
            )
        }
        <ns2:TransactionType>{fn:data($transactionType)}</ns2:TransactionType>
        <ns2:PaymentAmount>{fn:data($PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount)}</ns2:PaymentAmount>
        <ns2:Currency>{fn:data($PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency)}</ns2:Currency>
        <ns2:Org>{fn:data($ORG)}</ns2:Org>
        <ns2:PaymentType>{fn:data($paymentTypeValue)}</ns2:PaymentType>
    </ns2:PaymentRecordCreditCardRequest>
};

local:func($PaymentCollectionRequest, $transactionType, $ORG, $paymentTypeValue, $contractName)