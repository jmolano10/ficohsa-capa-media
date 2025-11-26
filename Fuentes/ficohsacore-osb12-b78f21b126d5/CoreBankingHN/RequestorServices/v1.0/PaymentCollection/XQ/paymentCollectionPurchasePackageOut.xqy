xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/MobilePackages/XMLSchema_-578407725.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../../GetCollection/XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getCollectionContractDetailResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::) external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns2:paymentCollectionRequest) ::) external;
declare variable $mobilePackagesResponse as element() (:: schema-element(ns3:PagoDePaquetesMovilesFTResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $transactionId as xs:string external;

declare function local:func($getCollectionContractDetailResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::), 
                            $paymentCollectionRequest as element() (:: schema-element(ns2:paymentCollectionRequest) ::), 
                            $mobilePackagesResponse as element() (:: schema-element(ns3:PagoDePaquetesMovilesFTResponse) ::), 
                            $uuid as xs:string,
                            $transactionId as xs:string) 
                            as element() (:: schema-element(ns2:paymentCollectionResponse) ::) {
    <ns2:paymentCollectionResponse>
      <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>{fn:data($transactionId)}</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
     </ns2:StatusInfo>
      <ns2:paymentCollectionResponse>
     {
                for $CONTRACT_NAME in $getCollectionContractDetailResponse/ns1:CollectionContractDetailResponseType/ns1:CollectionContractDetailResponseRecordType/ns1:ContractName
                return
                    <ns2:ContractName>{ data($CONTRACT_NAME) }</ns2:ContractName>
            }
            {
                for $DEBTOR_NAME in $paymentCollectionRequest/*:DebtorName
                return
                    <ns2:DebtorName>{ data($DEBTOR_NAME) }</ns2:DebtorName>
            }
            {
                for $INPUTTER in $mobilePackagesResponse/*:FUNDSTRANSFERType/*:gINPUTTER/*:INPUTTER
                return
                    <ns2:Inputter>{ data($INPUTTER) }</ns2:Inputter>
            }
            {
                for $DATE_TIME in $mobilePackagesResponse/*:FUNDSTRANSFERType/*:gDATETIME/*:DATETIME
                return
                    <ns2:DateTime>{ data($DATE_TIME) }</ns2:DateTime>
            }
            {
                for $BRANCH_NAME in $mobilePackagesResponse/*:FUNDSTRANSFERType/*:LROTHEROFFCER
                return
                    <ns2:BranchName>{ data($BRANCH_NAME) }</ns2:BranchName>
            }
            <ns2:PaymentInformation>
                <ns2:PaymentMethod>{ data($paymentCollectionRequest/*:PaymentInformation/*:PaymentMethod) }</ns2:PaymentMethod>
                <ns2:PaymentCurrency>{ data($paymentCollectionRequest/*:PaymentInformation/*:PaymentCurrency) }</ns2:PaymentCurrency>
                {
                    for $PAYMENT_AMOUNT in $paymentCollectionRequest/*:PaymentInformation/*:PaymentAmount
                    return
                        <ns2:PaymentAmount>{ data($PAYMENT_AMOUNT) }</ns2:PaymentAmount>
                }
                {
                    for $DEBIT_ACCOUNT in $paymentCollectionRequest/*:PaymentInformation/*:DebitAccount
                    return
                        <ns2:DebitAccount>{ data($DEBIT_ACCOUNT) }</ns2:DebitAccount>
                }
            </ns2:PaymentInformation>
            </ns2:paymentCollectionResponse>
    </ns2:paymentCollectionResponse>
};

local:func($getCollectionContractDetailResponse, $paymentCollectionRequest, $mobilePackagesResponse, $uuid, $transactionId)