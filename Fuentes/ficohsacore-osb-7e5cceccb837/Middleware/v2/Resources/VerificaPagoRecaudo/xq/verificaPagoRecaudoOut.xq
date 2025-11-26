(:: pragma  parameter="$parametersOut" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:verificaPagoRecaudoResponse" location="../xsd/verificaPagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/verificaPagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaPagoRecaudo/xq/verificaPagoRecaudoOut/";

declare function xf:verificaPagoRecaudoOut($parametersOut as element(*),
$contractId as xs:string,
$coreSuccessInd as xs:string)
    as element(ns0:verificaPagoRecaudoResponse) {
        <ns0:verificaPagoRecaudoResponse>
            <TRANSACTION_ID>{ fn:string($parametersOut/moreParameters/data[@fieldName="paymentOperationNumber"]/text()) }</TRANSACTION_ID>
            <CONTRACT_ID>{ $contractId }</CONTRACT_ID>
            <DEBTOR_CODE>{ fn:string($parametersOut/primaryKey/text()) }</DEBTOR_CODE>
            <TRANSACTION_DATE>{ fn:substring(fn:string($parametersOut/coreRunningDate/text()),1,8) }</TRANSACTION_DATE>
            <CORE_STATUS>{ fn:upper-case($coreSuccessInd) }</CORE_STATUS>
            <AGREEMENTS_STATUS>
            { 
				let $successIndicator := fn:string($parametersOut/errorCode/text())
				let $paidStatus := fn:string($parametersOut/moreParameters/data[@fieldName="paidIndicator"]/text())
				return
					if ($successIndicator = "0") then (
						if ($paidStatus = "S") then (
							"SUCCESS"
						) else (
							"UNPAID"
						)
					) else (
						"ERROR"
					)
            }
            </AGREEMENTS_STATUS>
            <THIRDPARTY_STATUS>            
            { 
				let $successIndicator := fn:string($parametersOut/errorCode/text())
				let $paidStatus := fn:string($parametersOut/moreParameters/data[@fieldName="paidIndicator"]/text())
				return
					if ($successIndicator = "0") then (
						if ($paidStatus = "S") then (
							"SUCCESS"
						) else (
							"UNPAID"
						)
					) else (
						"ERROR"
					)
			}
			</THIRDPARTY_STATUS>
            <DEALSLIP>{ fn:string($parametersOut/moreParameters/data[@fieldName="dealslip"]/text()) }</DEALSLIP>
        </ns0:verificaPagoRecaudoResponse>
};

declare variable $parametersOut as element(*) external;
declare variable $contractId as xs:string external;
declare variable $coreSuccessInd as xs:string external;

xf:verificaPagoRecaudoOut($parametersOut,
$contractId,
$coreSuccessInd)