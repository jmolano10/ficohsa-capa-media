<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes";
(:: import schema at "../Schemas/ConsultaInformacionLaboralTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetEmploymentInformationTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns1:consultaInformacionLaboralRequest) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;

declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns1:consultaInformacionLaboralRequest) ::), 
                            $sourceBank as xs:string, 
                            $destinationBank as xs:string, 
                            $userName as xs:string) as element() (:: schema-element(ns2:getEmploymentInformation) ::) {
    <ns2:getEmploymentInformation>
     <GeneralInfo>
          <SourceBank>{fn:data($sourceBank)}</SourceBank>
          <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
          <ApplicationId>{fn:data($userName)}</ApplicationId>
          <ApplicationUser>{fn:data($userName)}</ApplicationUser>
       </GeneralInfo>
        <AccountCode>{fn:data($request11g/ns1:CUSTOMER_ACCOUNT)}</AccountCode>
        <StartDate>{fn:data($request11g/ns1:FROM_DATE)}</StartDate>
        <DateEnd>{fn:data($request11g/ns1:TO_DATE)}</DateEnd>
    </ns2:getEmploymentInformation>
};

local:funcVirtual11gToRegional($request11g, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaInformacionLaboralTypes.xsd">
            <con:schema ref="SBRG_Pension_GetEmploymentInformation/Schemas/ConsultaInformacionLaboralTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetEmploymentInformationTypes.xsd">
            <con:schema ref="SBRG_Pension_GetEmploymentInformation/Schemas/GetEmploymentInformationTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>