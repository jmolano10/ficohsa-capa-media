(:: pragma bea:global-element-parameter parameter="$consultaRemesaPorNombreYMetodo" element="ns0:consultaRemesaPorNombreYMetodo" location="../xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/requestEnrutador/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
};

declare function xf:requestEnrutador($user as xs:string,
    $consultaRemesaPorNombreYMetodo as element(ns0:consultaRemesaPorNombreYMetodo))
    as element(*) {
        <parametersIn>
			<channelCode>{ fn-bea:fail-over( getUsername($user), $user) }</channelCode>
			{
				if (data($consultaRemesaPorNombreYMetodo/REMITTANCE_IDENTIFIER) = "PACIFIC") then (
					<subChannelCode>{ fn-bea:fail-over( getUsername($user), $user) }</subChannelCode>,
					<userCode>{ fn-bea:fail-over( getUsername($user), $user) }</userCode>
				) else ()
			}
			<agreementContractID>{ data($consultaRemesaPorNombreYMetodo/REMITTANCE_ID) }</agreementContractID>
			<primaryKey></primaryKey>
			<operationCode>{ data($consultaRemesaPorNombreYMetodo/OPERATION_CODE) }</operationCode>
			<totalAmount></totalAmount>
			{
				let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
				let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
				return (
					<coreRunningDate>{ $strDateTime }</coreRunningDate>,
					<transactionID>{ concat("OSB",$strDateTime) }</transactionID>
				)					
			}
			<moreParameters>
			{
				if (data($consultaRemesaPorNombreYMetodo/REMITTANCE_IDENTIFIER) = "MONEYGRAM") then (
					<data id="1" fieldName="branchCode">{ data($consultaRemesaPorNombreYMetodo/BRANCH_CODE) }</data>,
					<data fieldName="receiverFirstName" id="2">{ concat(data($consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTNAME), " ", data($consultaRemesaPorNombreYMetodo/BENEFICIARY_MIDDLENAME)) }</data>,
     				<data fieldName="receiverLastName" id="3">{ concat(data($consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTSURNAME), " ", data($consultaRemesaPorNombreYMetodo/BENEFICIARY_SECONDSURNAME)) }</data>,
      				<data fieldName="senderLastName" id="4">{ concat(data($consultaRemesaPorNombreYMetodo/REMITTER_FIRSTSURNAME), " ", data($consultaRemesaPorNombreYMetodo/REMITTER_SECONDSURNAME)) }</data>
				) else if (data($consultaRemesaPorNombreYMetodo/REMITTANCE_IDENTIFIER) = ("PACIFIC")) then (
					<data fieldName="beneficiaryLastName" id="1">{ concat(data($consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTSURNAME), " ", data($consultaRemesaPorNombreYMetodo/BENEFICIARY_SECONDSURNAME)) }</data>,
					<data fieldName="beneficiaryFirstName" id="2">{ concat(data($consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTNAME), " ", data($consultaRemesaPorNombreYMetodo/BENEFICIARY_MIDDLENAME)) }</data>,
     				<data fieldName="senderFirstName" id="3">{ concat(data($consultaRemesaPorNombreYMetodo/REMITTER_FIRSTNAME), " ", data($consultaRemesaPorNombreYMetodo/REMITTER_MIDDLENAME)) }</data>,
      				<data fieldName="senderLastName" id="4">{ concat(data($consultaRemesaPorNombreYMetodo/REMITTER_FIRSTSURNAME), " ", data($consultaRemesaPorNombreYMetodo/REMITTER_SECONDSURNAME)) }</data>,
					<data fieldName="branchCode" id="5">{ data($consultaRemesaPorNombreYMetodo/BRANCH_CODE) }</data>
				) else (
					""
				)
			}
			</moreParameters>
		</parametersIn>
};

declare variable $user as xs:string external;
declare variable $consultaRemesaPorNombreYMetodo as element(ns0:consultaRemesaPorNombreYMetodo) external;

xf:requestEnrutador($user,
    $consultaRemesaPorNombreYMetodo)