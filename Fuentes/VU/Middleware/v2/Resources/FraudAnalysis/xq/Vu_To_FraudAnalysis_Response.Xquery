<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/FraudAnalysisTypes";
(:: import schema at "../xsd/FraudAnalysisTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $vuResponse as element() (:: schema-element(ns1:fraudAnalysisResponseVU) ::) external;

declare function xq:Vu_To_FraudAnalysis_Response($vuResponse as element() (:: schema-element(ns1:fraudAnalysisResponseVU) ::)) as element() (:: schema-element(ns1:FraudAnalysisResponse) ::) {
    <ns1:FraudAnalysisResponse>
        <ns1:FraudAnalysisRecordType>
            <ns1:ACTION>{
            if(fn:data($vuResponse/ns1:result)=1)
            then 'ALLOW'
            else
            if(fn:data($vuResponse/ns1:result)=3)
            then 'DENY'
            else
            if(fn:data($vuResponse/ns1:result)=2)
            then 'AUTHENTICATE'
            else
            if(fn:data($vuResponse/ns1:result)=5)
            then 'BLOCK'
            else
            if(fn:data($vuResponse/ns1:result)=4)
            then 'CHECK_OPERATION'
            else
            if(fn:data($vuResponse/ns1:result)=6)
            then 'CHECK_BY_AGENT'
            else ()            
            }</ns1:ACTION>
            <ns1:SCORERISK>{fn:data($vuResponse/ns1:score)}</ns1:SCORERISK>
            <ns1:TRIGGEREDRULENAME>{fn:data($vuResponse/ns1:triggeredRules)}</ns1:TRIGGEREDRULENAME>
            <ns1:EVENTID>{fn:data($vuResponse/ns1:eventId)}</ns1:EVENTID>
        </ns1:FraudAnalysisRecordType>
    </ns1:FraudAnalysisResponse>
};

xq:Vu_To_FraudAnalysis_Response($vuResponse)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/FraudAnalysisTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/FraudAnalysis/xsd/FraudAnalysisTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>