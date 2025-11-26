xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../../GetCollection/XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";


declare variable $uuid as xs:string external;
declare variable $branchName as xs:string external;
declare variable $cuenta as xs:string external;
declare variable $authorizationCode as xs:string external;
declare variable $fundTransferType as element() external;
declare variable $getCollectionContractDetailResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::) external;
declare variable $transactionId as xs:string external;

(:: Equivalente a un NVL en Oracle:)
declare function local:if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;

(:: Realiza un replace multiple :)
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

declare function local:func($uuid as xs:string,
                            $branchName as xs:string, 
                            $cuenta as xs:string, 
                            $authorizationCode as xs:string, 
                            $fundTransferType as element(), 
                            $getCollectionContractDetailResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::),
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
                let $result :=
                    for $LRTAXPAYNAME in $fundTransferType/gLRTAXPAYNAME/LRTAXPAYNAME
                    return
                        <ns2:DebtorName>{ data($LRTAXPAYNAME) }</ns2:DebtorName>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $INPUTTER in $fundTransferType/gINPUTTER/INPUTTER
                    return
                        <ns2:Inputter>{ fn:tokenize(data($INPUTTER), "_")[2] }</ns2:Inputter>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $fundTransferType/gDATETIME/DATETIME
                    return
                        <ns2:DateTime>{ concat("20",$DATETIME) }</ns2:DateTime>
                return
                    $result[1]
            }
            <ns2:BranchName>{ $branchName }</ns2:BranchName>
            <ns2:PaymentInformation>
                <ns2:PaymentMethod>{ data($fundTransferType/LRPAYTYPE) }</ns2:PaymentMethod>
                <ns2:PaymentCurrency>{ data($fundTransferType/DEBITCURRENCY) }</ns2:PaymentCurrency>
                {
                    for $DEBITAMOUNT in $fundTransferType/DEBITAMOUNT
                    return
                        <ns2:PaymentAmount>{ data($DEBITAMOUNT) }</ns2:PaymentAmount>
                }
                {
                    let $DEBITACCTNO := fn:string($cuenta)
                    return
                    	if ( $DEBITACCTNO != "") then (
                        	<ns2:DebitAccount>{ $DEBITACCTNO }</ns2:DebitAccount>
                        ) else ()
                }
                {
                    for $CHEQUENUMBER in $fundTransferType/CHEQUENUMBER
                    return
                        <ns2:ChequeNumber>{ data($CHEQUENUMBER) }</ns2:ChequeNumber>
                }
            </ns2:PaymentInformation>
			{
				for $LRBLBATCH at $i in $fundTransferType/gLRBLBATCH/mLRBLBATCH/LRBLBATCH
				return
					if($LRBLBATCH = "dealslip") then (
						<ns2:BillDetail>{ local:replace-multi($fundTransferType/gLRBLREGNO/mLRBLREGNO[$i]/LRBLREGNO, ('&amp;#61', '&amp;#44'), ('=',',')) }</ns2:BillDetail>
					) else ()
        	}
        	{ if($authorizationCode!='')
             then 
             <ns2:ReferenceId>{$authorizationCode}</ns2:ReferenceId>
             else
             <ns2:ReferenceId></ns2:ReferenceId>
            }         
            </ns2:paymentCollectionResponse>
    </ns2:paymentCollectionResponse>
};

local:func($uuid, $branchName, $cuenta, $authorizationCode, $fundTransferType, $getCollectionContractDetailResponse, $transactionId)