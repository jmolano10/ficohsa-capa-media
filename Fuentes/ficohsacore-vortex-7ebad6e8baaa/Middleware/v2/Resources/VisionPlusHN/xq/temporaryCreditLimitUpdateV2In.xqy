xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizacionTmpLimiteCTA" element="ns1:actualizacionTmpLimiteCTA" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:TemporaryCreditLimitUpdateV2Request" location="../../../BusinessServices/VisionPlusHN/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusHN/xq/temporaryCreditLimitUpdateV2In/";

declare function xf:temporaryCreditLimitUpdateV2In($actualizacionTmpLimiteCTA as element(ns1:actualizacionTmpLimiteCTA),
    $org as xs:string)
    as element(ns0:TemporaryCreditLimitUpdateV2Request) {
        <ns0:TemporaryCreditLimitUpdateV2Request>
            <OrgNumber>{ data($org) }</OrgNumber>
            <AccountNumber>{ data($actualizacionTmpLimiteCTA/ACCOUNT_NUMBER) }</AccountNumber>
            <ForeignUse>
                {
                    if (data($actualizacionTmpLimiteCTA/ORG_IND) = 'BASE') then
                        ('0')
                    else 
                        '1'
                }
			</ForeignUse>
            <TempCreditLimit>{ data($actualizacionTmpLimiteCTA/NEW_LIMIT) }</TempCreditLimit>
            <TempCreditLimitExpDate>{ data($actualizacionTmpLimiteCTA/LIMIT_EXPIRATION_DATE) }</TempCreditLimitExpDate>
            <CurrentTempCreditLimit>{ data($actualizacionTmpLimiteCTA/CURRENT_LIMIT) }</CurrentTempCreditLimit>
        </ns0:TemporaryCreditLimitUpdateV2Request>
};

declare variable $actualizacionTmpLimiteCTA as element(ns1:actualizacionTmpLimiteCTA) external;
declare variable $org as xs:string external;

xf:temporaryCreditLimitUpdateV2In($actualizacionTmpLimiteCTA,
    $org)