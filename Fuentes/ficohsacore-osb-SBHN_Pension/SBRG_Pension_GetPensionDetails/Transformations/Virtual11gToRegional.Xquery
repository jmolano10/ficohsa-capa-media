<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con="http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/Virtual/consultaFICOPENTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/PensionInquiryTypes.xsd" ::)

declare variable $requestVirtual as element() (:: schema-element(con:consultaFICOPEN) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;

declare function local:func($requestVirtual as element() (:: schema-element(con:consultaFICOPEN) ::), 
                            $sourceBank as xs:string, 
                            $destinationBank as xs:string, 
                            $userName as xs:string) 
                            as element() (:: schema-element(ns2:getPensionDetails) ::) {
    <ns2:getPensionDetails>
        <GeneralInfo>
            <SourceBank>{fn:data($sourceBank)}</SourceBank>
            <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
            <GlobalId></GlobalId>
            <ApplicationId>{fn:data($userName)}</ApplicationId>
            <ApplicationUser>{fn:data($userName)}</ApplicationUser>
            <BranchId></BranchId>
            <TransactionDate></TransactionDate>
            <Language></Language>
        </GeneralInfo>
        <InvestmentCode>{fn:data($requestVirtual/INVESTMENT_CODE)}</InvestmentCode>
        <StartDate>{(concat(substring(data($requestVirtual/START_DATE), 1, 4), '-', substring(data($requestVirtual/START_DATE), 5, 2),
        '-', substring(data($requestVirtual/START_DATE), 7, 2)))}</StartDate>
        <EndDate>{(concat(substring(data($requestVirtual/END_DATE), 1, 4), '-', substring(data($requestVirtual/END_DATE), 5, 2),
        '-', substring(data($requestVirtual/END_DATE), 7, 2)))}</EndDate>
    </ns2:getPensionDetails>
};

local:func($requestVirtual, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/Virtual/consultaFICOPENTypes.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/Virtual/consultaFICOPENTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/PensionInquiryTypes.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/PensionInquiryTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>