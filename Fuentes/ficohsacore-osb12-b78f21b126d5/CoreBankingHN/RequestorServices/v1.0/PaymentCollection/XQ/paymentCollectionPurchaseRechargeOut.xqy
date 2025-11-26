xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Recharges/XMLSchema_-1504397414.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../../GetCollection/XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";


declare function local:if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;
declare function local:replace-multi 
  ( $arg as xs:string? ,
    $changeFrom as xs:string* ,
    $changeTo as xs:string* )  as xs:string? {
       
   if (count($changeFrom) > 0)
   then local:replace-multi(
          replace($arg, $changeFrom[1],
                     local:if-absent($changeTo[1],'')),
          $changeFrom[position() > 1],
          $changeTo[position() > 1])
   else $arg
 } ;

declare variable $uuid as xs:string external;
declare variable $branchName as xs:string external;
declare variable $paymentCollectionContractDetailResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::) external;
declare variable $purchaseRechargeResponse as element() (:: schema-element(ns2:CompraderecargacondbctaResponse) ::) external;

declare function local:func($uuid as xs:string, $branchName as xs:string, $paymentCollectionContractDetailResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::), 
                            $purchaseRechargeResponse as element() (:: schema-element(ns2:CompraderecargacondbctaResponse) ::)) 
                            as element() (:: schema-element(ns3:paymentCollectionResponse) ::) {
    <ns3:paymentCollectionResponse>
    <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>Prueba4</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
      </ns3:StatusInfo>
    <ns3:paymentCollectionResponse>
          {
                for $CONTRACT_NAME in $paymentCollectionContractDetailResponse/ns1:CollectionContractDetailResponseType/ns1:CollectionContractDetailResponseRecordType/ns1:ContractName
                return
                    <ns3:ContractName>{ data($CONTRACT_NAME) }</ns3:ContractName>
            }
            {
                for $DEBTOR_NAME in $purchaseRechargeResponse/FUNDSTRANSFERType/gLR.TAX.PAY.NAME/LRTAXPAYNAME
                return
                    <ns3:DebtorName>{ data($DEBTOR_NAME) }</ns3:DebtorName>
            }
            {
                for $INPUTTER in $purchaseRechargeResponse/FUNDSTRANSFERType/gINPUTTER/INPUTTER
                return
                    <ns3:Inputter>{ data($INPUTTER) }</ns3:Inputter>
            }
            {
                for $DATE_TIME in $purchaseRechargeResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                return
                    <ns3:DateTime>{ data($DATE_TIME) }</ns3:DateTime>
            }
            {
                for $BRANCH_NAME in $branchName
                return
                    <ns3:BranchName>{ data($BRANCH_NAME) }</ns3:BranchName>
            }
            <ns3:PaymentInformation>
                <ns3:Paymentmethod>ACCT_DEBIT</ns3:Paymentmethod>
                <ns3:PaymentCurrency>{ data($purchaseRechargeResponse/FUNDSTRANSFERType/DEBITCURRENCY) }</ns3:PaymentCurrency>
                {
                    for $PAYMENT_AMOUNT in $purchaseRechargeResponse/FUNDSTRANSFERType/DEBITAMOUNT
                    return
                        <ns3:PaymentAmount>{ data($PAYMENT_AMOUNT) }</ns3:PaymentAmount>
                }
                {
                    for $DEBIT_ACCOUNT in $purchaseRechargeResponse/FUNDSTRANSFERType/DEBITACCTNO
                    return
                        <ns3:DebitAccount>{ data($DEBIT_ACCOUNT) }</ns3:DebitAccount>
                }
            </ns3:PaymentInformation>
            {
                for $LRBLBATCH at $i in $purchaseRechargeResponse/FUNDSTRANSFERType/gLR.BL.BATCH/mLR.BL.BATCH/LRBLBATCH
                return
                    if($LRBLBATCH = "dealslip") then (
                        <ns3:BillDetail>{ local:replace-multi($purchaseRechargeResponse/FUNDSTRANSFERType/gLR.BL.REG.NO/mLR.BL.REG.NO[$i]/LRBLREGNO, ('&amp;#61', '&amp;#44'), ('=',',')) }</ns3:BillDetail>
                    ) else()
            }
            </ns3:paymentCollectionResponse>
    </ns3:paymentCollectionResponse>
};

local:func($uuid, $branchName, $paymentCollectionContractDetailResponse, $purchaseRechargeResponse)