xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:PointsAdjustmentInquiryRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/pointsAdjustmentInquiryIn/";

declare function xf:pointsAdjustmentInquiryIn($org as xs:string,
    $accountNumber as xs:string,
    $scheme as xs:string)
    as element(ns0:PointsAdjustmentInquiryRequest) {
        <ns0:PointsAdjustmentInquiryRequest>
            <GPXAII-ORG>{ data($org) }</GPXAII-ORG>
            <GPXAII-ACCT-NBR>{ $accountNumber }</GPXAII-ACCT-NBR>
            <GPXAII-SCHEME>{ $scheme }</GPXAII-SCHEME>
            <GPXAII-RESV-CODE-1/>
            <GPXAII-RESV-CODE-2/>
            <GPXAII-RESV-CODE-3/>
            <GPXAII-RESV-CODE-4/>
            <GPXAII-RESV-CODE-5/>
            <GPXAII-RESV-DATE-1>0</GPXAII-RESV-DATE-1>
            <GPXAII-RESV-DATE-2>0</GPXAII-RESV-DATE-2>
            <GPXAII-RESV-DATE-3>0</GPXAII-RESV-DATE-3>
            <GPXAII-RESV-DATE-4>0</GPXAII-RESV-DATE-4>
            <GPXAII-RESV-DATE-5>0</GPXAII-RESV-DATE-5>
            <GPXAII-RESV-AMT-1>0</GPXAII-RESV-AMT-1>
            <GPXAII-RESV-AMT-2>0</GPXAII-RESV-AMT-2>
            <GPXAII-RESV-AMT-3>0</GPXAII-RESV-AMT-3>
            <GPXAII-RESV-AMT-4>0</GPXAII-RESV-AMT-4>
            <GPXAII-RESV-AMT-5>0</GPXAII-RESV-AMT-5>
        </ns0:PointsAdjustmentInquiryRequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $scheme as xs:string external;

xf:pointsAdjustmentInquiryIn($org,
    $accountNumber,
    $scheme)