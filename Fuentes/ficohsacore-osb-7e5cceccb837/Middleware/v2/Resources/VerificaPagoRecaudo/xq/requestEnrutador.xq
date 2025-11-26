xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaPagoRecaudo/xq/requestEnrutador/";

declare function xf:requestEnrutador($contractId as xs:string,
    $primaryKey as xs:string,
    $userCode as xs:string,
    $bankCode as xs:string,
    $branchCode as xs:string,
    $rtn as xs:string)
    as element(*) {
        <parametersIn>
			<channelCode>{ $userCode }</channelCode>
			<subChannelCode></subChannelCode>
			<agreementContractID>{ $contractId }</agreementContractID>
			<userCode>{ $userCode }</userCode>
			<bankCode>HN0010001</bankCode>
			<primaryKey>{ $primaryKey }</primaryKey>
			<operationCode>1.VP</operationCode>
			<totalAmount/>
			<coreRunningDate>
			{
				let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
				return
					fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
			}
			</coreRunningDate>
			<transactionID>
			{
				let $currentDate := fn:current-dateTime()
				return concat(fn:substring($primaryKey,5,5),fn-bea:dateTime-to-string-with-format("ddHHmmssSSS",$currentDate))
			}
			</transactionID>
			<moreParameters>
			{
				<data id="1" fieldName="branchCode">{ $branchCode }</data>,
				<data id="4" fieldName="useAgrNonStandard">N</data>,
				<data id="5" fieldName="returnDealslip">S</data>,
				<data id="6" fieldName="rucImpoExpo">{ $rtn }</data>
			}				
			</moreParameters>
		</parametersIn>
};

declare variable $contractId as xs:string external;
declare variable $primaryKey as xs:string external;
declare variable $userCode as xs:string external;
declare variable $bankCode as xs:string external;
declare variable $branchCode as xs:string external;
declare variable $rtn as xs:string external;

xf:requestEnrutador($contractId,
    $primaryKey,
    $userCode,
    $bankCode,
    $branchCode,
    $rtn)