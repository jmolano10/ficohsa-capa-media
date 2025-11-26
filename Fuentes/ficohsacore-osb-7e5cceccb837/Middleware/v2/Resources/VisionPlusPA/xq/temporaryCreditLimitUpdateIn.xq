xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:TemporaryCreditLimitUpdateRequest" location="../../../BusinessServices/VisionPlusPA/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/temporaryCreditLimitUpdateIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:temporaryCreditLimitUpdateIn($org as xs:string,
    $foreingUse as xs:string,
    $accountNumber as xs:string,
    $tempCreditLimit as xs:string,
    $tempCreditLimitExpDate as xs:string,
    $currentTempCreditLimit as xs:string)
    as element(ns0:TemporaryCreditLimitUpdateRequest) {
        <ns0:TemporaryCreditLimitUpdateRequest>
        <OrgNumber>{ data($org) }</OrgNumber>
        <AccountNumber>{ data($accountNumber) }</AccountNumber>
        <ForeignUse>
            {
				if( $foreingUse = 'BASE' ) then (
					'0'
				) else ( 
					'1'
				)   
   			}
   		</ForeignUse>
   		<TempCreditLimit>{ data($tempCreditLimit) }</TempCreditLimit>
   		<TempCreditLimitExpDate>{ data($tempCreditLimitExpDate) }</TempCreditLimitExpDate>
   		<CurrentTempCreditLimit>{ data($currentTempCreditLimit) }</CurrentTempCreditLimit>
        </ns0:TemporaryCreditLimitUpdateRequest>
};
declare variable $org as xs:string external;
declare variable $foreingUse as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $tempCreditLimit as xs:string external;
declare variable $tempCreditLimitExpDate as xs:string external;
declare variable $currentTempCreditLimit as xs:string external;

xf:temporaryCreditLimitUpdateIn($org,
    $foreingUse,
    $accountNumber,
    $tempCreditLimit,
    $tempCreditLimitExpDate,
    $currentTempCreditLimit)