(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns1:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SendCreditHNL" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/TransferenciasACH/xq/envioACHHNL/";

declare function xf:envioACHHNL($transferenciasACHRequest1 as element(ns1:transferenciasACHRequest),
    $FtTt as xs:string,
    $origAccountType as xs:string,
    $receivingBankId as xs:string,
    $originatorId as xs:string,
    $receivingId as xs:string,
    $originatorName as xs:string,
    $destAccountType as xs:string)
    as element(ns0:SendCreditHNL) {
        <ns0:SendCreditHNL>
            <ns0:vReceivingBankId>{ $receivingBankId }</ns0:vReceivingBankId>
            <ns0:vRemittanceArray>{ data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION) }</ns0:vRemittanceArray>
            <ns0:vInstruction>{ $FtTt }</ns0:vInstruction>
            <ns0:vOriginatorId>{ $originatorId }</ns0:vOriginatorId>
            <ns0:vOriginatorAccount>{ data($transferenciasACHRequest1/DEBIT_ACCOUNT) }</ns0:vOriginatorAccount>
            <ns0:vOriginatorAccountType>{ $origAccountType }</ns0:vOriginatorAccountType>
            <ns0:vOriginatorName>{ $originatorName }</ns0:vOriginatorName>
            <ns0:vReceivingId>{ $receivingId }</ns0:vReceivingId>
            <ns0:vDestinationAccount>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</ns0:vDestinationAccount>
            {
	            if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "Savings") then
	            (
	            	<ns0:vDestinationAccountType>2</ns0:vDestinationAccountType>
	            ) 
	            else if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "Checking") then
	            (   
	            	<ns0:vDestinationAccountType>1</ns0:vDestinationAccountType>
	            ) 
	            else if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "Loanpayment") then
	            (
	            	<ns0:vDestinationAccountType>3</ns0:vDestinationAccountType>
	            )
	            else if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "Creditca") then
	            (
	            	<ns0:vDestinationAccountType>4</ns0:vDestinationAccountType>
	            )  
	            else
	            (
	            	<ns0:vDestinationAccountType>99</ns0:vDestinationAccountType>
	            )
            } 
            <ns0:vRecipientName>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</ns0:vRecipientName>
            <ns0:vAmount>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</ns0:vAmount>
        </ns0:SendCreditHNL>
};

declare variable $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest) external;
declare variable $FtTt as xs:string external;
declare variable $origAccountType as xs:string external;
declare variable $receivingBankId as xs:string external;
declare variable $originatorId as xs:string external;
declare variable $receivingId as xs:string external;
declare variable $originatorName as xs:string external;
declare variable $destAccountType as xs:string external;

xf:envioACHHNL($transferenciasACHRequest1,
    $FtTt,
    $origAccountType,
    $receivingBankId,
    $originatorId,
    $receivingId,
    $originatorName,
    $destAccountType)
