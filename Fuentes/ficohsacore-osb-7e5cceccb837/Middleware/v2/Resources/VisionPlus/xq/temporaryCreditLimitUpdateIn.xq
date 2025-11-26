(:: pragma bea:global-element-return element="ns0:TemporaryCreditLimitUpdateRequest" location="../../../BusinessServices/VisionPlus/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/temporaryCreditLimitUpdateIn/";

declare function xf:temporaryCreditLimitUpdateIn($org as xs:string,
    $foreignUse as xs:string,
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
				if( $foreignUse = 'BASE' ) then (
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
declare variable $foreignUse as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $tempCreditLimit as xs:string external;
declare variable $tempCreditLimitExpDate as xs:string external;
declare variable $currentTempCreditLimit as xs:string external;

xf:temporaryCreditLimitUpdateIn($org,
    $foreignUse,
    $accountNumber,
    $tempCreditLimit,
    $tempCreditLimitExpDate,
    $currentTempCreditLimit)