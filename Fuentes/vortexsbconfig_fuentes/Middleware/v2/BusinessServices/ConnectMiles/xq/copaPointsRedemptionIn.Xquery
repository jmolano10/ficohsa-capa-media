<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:copaPointsRedemptionRequest" location="../xsd/copaPointsRedemptionTypes.xsd" ::)

declare namespace ns1 = "http://copa.com/osb/redemption";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ConnectMiles/xq/copaPointsRedemptionIn/";

declare function xf:copaPointsRedemptionIn(
    $companyCode as xs:string,
    $frequentFlyerId as xs:string,
    $copaLanguage as xs:string,
    $copaChannelId as xs:string,
    $authorization as xs:string,
    $ocpApimSubscriptionKey as xs:string,
    $firstName as xs:string,
    $surName as xs:string,
    $awardMiles as xs:string,
    $activityDate as xs:string,
    $explanation as xs:string,
    $activityClassification as xs:string,
    $transactionPartnerId as xs:string)
    as element(ns1:copaPointsRedemptionRequest) {
        <ns1:copaPointsRedemptionRequest>
            <ns1:COMPANY_CODE>{ $companyCode }</ns1:COMPANY_CODE>
            <ns1:FREQUENT_FLYER_ID>{ $frequentFlyerId }</ns1:FREQUENT_FLYER_ID>
            <ns1:COPA_LANGUAGE>{ $copaLanguage }</ns1:COPA_LANGUAGE>
            <ns1:COPA_CHANNEL_ID>{ $copaChannelId }</ns1:COPA_CHANNEL_ID>
            <ns1:AUTHORIZATION>{ $authorization }</ns1:AUTHORIZATION>
            <ns1:OCP_APIM_SUBSCRIPTION_KEY>{ $ocpApimSubscriptionKey }</ns1:OCP_APIM_SUBSCRIPTION_KEY>
            <ns1:FIRST_NAME>{ $firstName }</ns1:FIRST_NAME>
            <ns1:SUR_NAME>{ $surName }</ns1:SUR_NAME>
            <ns1:AWARD_MILES>
				{
				  if (normalize-space($awardMiles) != "")
				  then xs:string(xs:decimal($awardMiles) div 2)
				  else "0"
				}
			</ns1:AWARD_MILES>
            <ns1:ACTIVITY_DATE>{ $activityDate }</ns1:ACTIVITY_DATE>
            <ns1:EXPLANATION>{ $explanation }</ns1:EXPLANATION>
            <ns1:ACTIVITY_CLASSIFICATION>{ $activityClassification }</ns1:ACTIVITY_CLASSIFICATION>
            <ns1:TRANSACTION_PARTNER_ID>{ $transactionPartnerId }</ns1:TRANSACTION_PARTNER_ID>
        </ns1:copaPointsRedemptionRequest>
};

declare variable $companyCode as xs:string external;
declare variable $frequentFlyerId as xs:string external;
declare variable $copaLanguage as xs:string external;
declare variable $copaChannelId as xs:string external;
declare variable $authorization as xs:string external;
declare variable $ocpApimSubscriptionKey as xs:string external;
declare variable $firstName as xs:string external;
declare variable $surName as xs:string external;
declare variable $awardMiles as xs:string external;
declare variable $activityDate as xs:string external;
declare variable $explanation as xs:string external;
declare variable $activityClassification as xs:string external;
declare variable $transactionPartnerId as xs:string external;

xf:copaPointsRedemptionIn(
    $companyCode,
    $frequentFlyerId,
    $copaLanguage,
    $copaChannelId,
    $authorization,
    $ocpApimSubscriptionKey,
    $firstName,
    $surName,
    $awardMiles,
    $activityDate,
    $explanation,
    $activityClassification,
    $transactionPartnerId)]]></con:xquery>
    <con:dependency location="../xsd/copaPointsRedemptionTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ConnectMiles/xsd/copaPointsRedemptionTypes"/>
    </con:dependency>
</con:xqueryEntry>