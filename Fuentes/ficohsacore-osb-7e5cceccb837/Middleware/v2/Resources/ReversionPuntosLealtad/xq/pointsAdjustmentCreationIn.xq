(:: pragma bea:global-element-return element="ns0:PointsAdjustmentCreationRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/pointsAdjustmentCreationIn/";

declare function xf:pointsAdjustmentCreationIn($org as xs:string,
    $accountNumber as xs:string,
    $schema as xs:string,
    $txnCode as xs:string,
    $txnAmount as xs:string,
    $description as xs:string,
    $groupCode as xs:string,
    $tableType as xs:string,
    $tablePriority as xs:string,
    $referenceNumber as xs:string)
    as element(ns0:PointsAdjustmentCreationRequest) {
        <ns0:PointsAdjustmentCreationRequest>
            <GPXPAI-ORG>{ data($org) }</GPXPAI-ORG>
            <GPXPAI-CARD-NBR/>
            <GPXPAI-ACCT-NBR>{ $accountNumber }</GPXPAI-ACCT-NBR>
            <GPXPAI-SCHEME-ID>{ $schema }</GPXPAI-SCHEME-ID>
            <GPXPAI-TXN-CODE>{ data($txnCode) }</GPXPAI-TXN-CODE>
            <GPXPAI-TRAN-AMT>{ xs:integer(fn:ceiling(xs:double($txnAmount))) * 1000 }</GPXPAI-TRAN-AMT>
            <GPXPAI-ACTUAL-VALUE>00000000000000000</GPXPAI-ACTUAL-VALUE>
            <GPXPAI-DESC>{ $description }</GPXPAI-DESC>
            <GPXPAI-GROUP-CODE>{ $groupCode }</GPXPAI-GROUP-CODE>
            <GPXPAI-TABLE-TYPE>{ $tableType }</GPXPAI-TABLE-TYPE>
            <GPXPAI-TABLE-PRI>{ data($tablePriority) }</GPXPAI-TABLE-PRI>
            <GPXPAI-REF-NBR>{ data($referenceNumber) }</GPXPAI-REF-NBR>
            <GPXPAI-REASON-CODE>0</GPXPAI-REASON-CODE>
            <GPXPAI-STORE-NBR>000000000</GPXPAI-STORE-NBR>
            <GPXPAI-RESV-CODE-1>00</GPXPAI-RESV-CODE-1>
            <GPXPAI-RESV-CODE-2>00</GPXPAI-RESV-CODE-2>
            <GPXPAI-RESV-CODE-3>00</GPXPAI-RESV-CODE-3>
            <GPXPAI-RESV-CODE-4>00</GPXPAI-RESV-CODE-4>
            <GPXPAI-RESV-CODE-5>00</GPXPAI-RESV-CODE-5>
            <GPXPAI-RESV-DATE-1>0000000</GPXPAI-RESV-DATE-1>
            <GPXPAI-RESV-DATE-2>0000000</GPXPAI-RESV-DATE-2>
            <GPXPAI-RESV-DATE-3>0000000</GPXPAI-RESV-DATE-3>
            <GPXPAI-RESV-DATE-4>0000000</GPXPAI-RESV-DATE-4>
            <GPXPAI-RESV-DATE-5>0000000</GPXPAI-RESV-DATE-5>
            <GPXPAI-RESV-AMT-1>00000000000000000</GPXPAI-RESV-AMT-1>
            <GPXPAI-RESV-AMT-2>00000000000000000</GPXPAI-RESV-AMT-2>
            <GPXPAI-RESV-AMT-3>00000000000000000</GPXPAI-RESV-AMT-3>
            <GPXPAI-RESV-AMT-4>00000000000000000</GPXPAI-RESV-AMT-4>
            <GPXPAI-RESV-AMT-5>00000000000000000</GPXPAI-RESV-AMT-5>
        </ns0:PointsAdjustmentCreationRequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $schema as xs:string external;
declare variable $txnCode as xs:string external;
declare variable $txnAmount as xs:string external;
declare variable $description as xs:string external;
declare variable $groupCode as xs:string external;
declare variable $tableType as xs:string external;
declare variable $tablePriority as xs:string external;
declare variable $referenceNumber as xs:string external;

xf:pointsAdjustmentCreationIn($org,
    $accountNumber,
    $schema,
    $txnCode,
    $txnAmount,
    $description,
    $groupCode,
    $tableType,
    $tablePriority,
    $referenceNumber)