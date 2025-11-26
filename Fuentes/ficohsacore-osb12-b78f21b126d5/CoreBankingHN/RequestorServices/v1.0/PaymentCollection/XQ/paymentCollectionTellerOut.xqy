xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetUser/v1.0/Core.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../../GetCollection/XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";


declare variable $uuid as xs:string external;
declare variable $authorizationCode as xs:string external;
declare variable $tellerType as element() external;
declare variable $getCollectionContractDetailsResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::) external;
declare variable $getUserResponse as element() (:: schema-element(ns2:ConsultadeusuariosdelsistemaResponse) ::) external;

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
                            $authorizationCode as xs:string, 
                            $tellerType as element(), 
                            $getCollectionContractDetailsResponse as element() (:: schema-element(ns1:CollectionContractDetailResponse) ::), 
                            $getUserResponse as element() (:: schema-element(ns2:ConsultadeusuariosdelsistemaResponse) ::)) 
                            as element() (:: schema-element(ns3:paymentCollectionResponse) ::) {
    <ns3:paymentCollectionResponse>
      <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>Prueba5</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
      </ns3:StatusInfo>
      <ns3:paymentCollectionResponse>
            {
                for $CONTRACT_NAME in $getCollectionContractDetailsResponse/ns1:CollectionContractDetailResponseType/ns1:CollectionContractDetailResponseRecordType/ns1:ContractName

                return
                    <ns3:ContractName>{ data($CONTRACT_NAME) }</ns3:ContractName>
            }
            {
                let $result :=
                    for $LRTAXPAYNAME in $tellerType/gLRTAXPAYNAME/LRTAXPAYNAME
                    return
                        <ns3:DebtorName>{ data($LRTAXPAYNAME) }</ns3:DebtorName>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $INPUTTER in $tellerType/gINPUTTER/INPUTTER
                    return
                        <ns3:Inputter>{ fn:tokenize(data($INPUTTER), "_")[2] }</ns3:Inputter>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $tellerType/gDATETIME/DATETIME
                    return
                        <ns3:DateTime>{ concat("20",$DATETIME) }</ns3:DateTime>
                return
                    $result[1]
            }
            {
                for $BRANCHNAME in $getUserResponse/WSUSERType[1]/gWSUSERDetailType/mWSUSERDetailType[1]/BRANCHNAME
                return
                    <ns3:BranchName>{ data($BRANCHNAME) }</ns3:BranchName>
            }
            <ns3:PaymentInformation>
                <ns3:PaymentMethod>{ data($tellerType/LRPAYTYPE) }</ns3:PaymentMethod>
                <ns3:PaymentCurrency>{ data($tellerType/CURRENCY1) }</ns3:PaymentCurrency>
                {
                    let $CURRENCY1 := fn:string($tellerType/CURRENCY1/text())
                    return
                    	if ( $CURRENCY1 = "HNL") then (
                    		<ns3:PaymentAmount>{ data($tellerType/gACCOUNT1/mACCOUNT1/AMOUNTLOCAL1) }</ns3:PaymentAmount>
                    	) else (
                    		<ns3:PaymentAmount>{ data($tellerType/gACCOUNT1/mACCOUNT1/AMOUNTFCY1) }</ns3:PaymentAmount>
                    	)
                        
                }
                {
                    for $CHEQUEACCTNO in $tellerType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUEACCTNO
                    return
                        <ns3:DebitAccount>{ data($CHEQUEACCTNO) }</ns3:DebitAccount>
                }
                {
                    for $CHEQUENUMBER in $tellerType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUENUMBER
                    return
                        <ns3:ChequeNumber>{ data($CHEQUENUMBER) }</ns3:ChequeNumber>
                }
                {
                    for $CHEQUEBANKCDE in $tellerType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUEBANKCDE
                    return
                        <ns3:BankCode>{ data($CHEQUEBANKCDE) }</ns3:BankCode>

                }               
            </ns3:PaymentInformation>
			{
				for $LRBLBATCH at $i in $tellerType/gLRBLBATCH/mLRBLBATCH/LRBLBATCH
				return
					if($LRBLBATCH = "dealslip") then (
						<ns3:BillDetail>{ local:replace-multi($tellerType/gLRBLREGNO/mLRBLREGNO[$i]/LRBLREGNO, ('&amp;#61', '&amp;#44'), ('=',',')) }</ns3:BillDetail>
					) else ()
        	}
            { if($authorizationCode!='')
             then 
             <ns3:ReferenceId>{$authorizationCode}</ns3:ReferenceId>
             else
             <ns3:ReferenceId></ns3:ReferenceId>
            }	
            </ns3:paymentCollectionResponse>
    </ns3:paymentCollectionResponse>
};

local:func($uuid, $authorizationCode, $tellerType, $getCollectionContractDetailsResponse, $getUserResponse)