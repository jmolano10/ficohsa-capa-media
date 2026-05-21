<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
(:: import schema at "../Schemas/ConsultaFinancierasACHTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFinancialACHTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns1:consultaFinancierasACH) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;

declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns1:consultaFinancierasACH) ::),
                                                $sourceBank as xs:string, 
                                                $destinationBank as xs:string, 
                                                $userName as xs:string) as element() (:: schema-element(ns2:getFinancialACH) ::) {
    <ns2:getFinancialACH>
       <GeneralInfo>
          <SourceBank>{fn:data($sourceBank)}</SourceBank>
          <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
          <ApplicationId>{fn:data($userName)}</ApplicationId>
          <ApplicationUser>{fn:data($userName)}</ApplicationUser>
       </GeneralInfo>
      </ns2:getFinancialACH>
};

local:funcVirtual11gToRegional($request11g, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaFinancierasACHTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFinancialACH/Schemas/ConsultaFinancierasACHTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFinancialACHTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFinancialACH/Schemas/GetFinancialACHTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>