<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/FraudAnalysisTypes";
(:: import schema at "../xsd/FraudAnalysisTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $fraudAnalysis as element() (:: schema-element(ns1:FraudAnalysisRequest) ::) external;
declare variable $apiKey as xs:string external;

declare function xq:FraudAnalysis_To_VU($fraudAnalysis as element() (:: schema-element(ns1:FraudAnalysisRequest) ::), 
                                        $apiKey as xs:string) 
                                        as element() (:: schema-element(ns1:FraudAnalysisRequestVU) ::) {
    <ns1:FraudAnalysisRequestVU>
        <ns1:apiKey>{$apiKey}</ns1:apiKey>
        <ns1:idChannel>{
        if(fn:data($fraudAnalysis/ns1:channel)='INTERBANCA_WEB')
        then
        1
        else
        if(fn:data($fraudAnalysis/ns1:channel)='INTERBANCA_APP')
        then
        2
        else 
        if(fn:data($fraudAnalysis/ns1:channel)='ATM')
        then
        3
        else  
        if(fn:data($fraudAnalysis/ns1:channel)='IVR')
        then
        4
        else  
        ()
        }</ns1:idChannel>
        <ns1:idOperation>{fn:data($fraudAnalysis/ns1:idOperationType)}</ns1:idOperation>
        <ns1:userId>{fn:data($fraudAnalysis/ns1:user)}</ns1:userId>
        <ns1:eventDate>{fn:data($fraudAnalysis/ns1:dateTime)}</ns1:eventDate>
        <ns1:amount>{fn:data($fraudAnalysis/ns1:amount)}</ns1:amount>
        <ns1:debitAccount>{fn:data($fraudAnalysis/ns1:debitAccount)}</ns1:debitAccount>
        {
            if ($fraudAnalysis/ns1:creditAccount)
            then <ns1:creditAccount>{fn:data($fraudAnalysis/ns1:creditAccount)}</ns1:creditAccount>
            else ()
        }
        {
            for $entry in $fraudAnalysis/ns1:optionalParams/ns1:entry
            return 
            <ns1:optionalParams>
                {
                    if ($entry/ns1:key)
                    then <ns1:name>{fn:data($entry/ns1:key)}</ns1:name>
                    else ()
                }
                {
                    if ($entry/ns1:value)
                    then <ns1:value>{fn:data($entry/ns1:value)}</ns1:value>
                    else ()
                }
            </ns1:optionalParams>
        }
    </ns1:FraudAnalysisRequestVU>
};

xq:FraudAnalysis_To_VU($fraudAnalysis, $apiKey)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/FraudAnalysisTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/FraudAnalysis/xsd/FraudAnalysisTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>