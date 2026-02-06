xquery version "2004-draft" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/requestEnrutador/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
};


declare function xf:requestEnrutador($user as xs:string,
    $contractId as xs:string,
    $primaryKey as xs:string,
    $remittSource as xs:string)
    as element(*) {
        <parametersIn>
			<channelCode>{ fn-bea:fail-over( getUsername($user), $user) }</channelCode>
			<subChannelCode></subChannelCode>
			<agreementContractID>{ $contractId }</agreementContractID>
			<userCode>{ fn-bea:fail-over( getUsername($user), $user) }</userCode>
			<bankCode>HN0010001</bankCode>
			<primaryKey>{ $primaryKey }</primaryKey>
			<operationCode>
			{
				if ($remittSource = "MONEYGRAM") then (
					"1.RREN"
				) else if ($remittSource = ("UNITELLER","BTS")) then (
					"1"
				) else if ($remittSource = "PACIFIC") then (
					"1.CNR"
			    ) else if ($remittSource = "RIA") then (
					"1"
				) else (
					""
				)
			}
			</operationCode>
			<totalAmount></totalAmount>
			{
				let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
				let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
				return (
					<coreRunningDate>{ $strDateTime }</coreRunningDate>,
					<transactionID>{ $strDateTime }</transactionID>
				)					
			}
			<moreParameters>
			{
				if ($remittSource = "MONEYGRAM") then (
					<data id="1" fieldName="branchCode">110000000000</data>,
					<data id="2" fieldName="validateStatus">Y</data>
				) else if ($remittSource = "UNITELLER") then (
					<data id="1" fieldName="paymentCurrency">HNL</data>,
					<data id="2" fieldName="branchCode">110000000000</data>
				) else if ($remittSource = ("BTS","PACIFIC", "RIA")) then (
					<data id="1" fieldName="branchCode">110000000000</data>
				) else (
					""
				)
			}				
			</moreParameters>
		</parametersIn>
};

declare variable $user as xs:string external;
declare variable $contractId as xs:string external;
declare variable $primaryKey as xs:string external;
declare variable $remittSource as xs:string external;

xf:requestEnrutador($user,
    $contractId,
    $primaryKey,
    $remittSource)