<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
(:: import schema at "../Schemas/ConsultaFICOPENTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFICOPENTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns1:consultaFICOPEN) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;

declare function local:format-date-FPC($fecha as xs:string) as xs:string {
  let $year := fn:substring($fecha, 1, 4)
  let $month := fn:substring($fecha, 5, 2)
  let $day := fn:substring($fecha, 7, 2)
  return fn:concat($day, '-', $month, '-',$year )
};

declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns1:consultaFICOPEN) ::), 
                            $sourceBank as xs:string, 
                            $destinationBank as xs:string, 
                            $userName as xs:string) as element() (:: schema-element(ns2:getFICOPEN) ::) {
    <ns2:getFICOPEN>
        <GeneralInfo>
          <SourceBank>{fn:data($sourceBank)}</SourceBank>
          <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
          <ApplicationId>{fn:data($userName)}</ApplicationId>
          <ApplicationUser> </ApplicationUser>
        </GeneralInfo>
          <CodeNumber>{fn:data($request11g/INVESTMENT_CODE)}</CodeNumber>
          <StartDate>{local:format-date-FPC(fn:data($request11g/START_DATE))}</StartDate>
          <EndDate>{local:format-date-FPC(fn:data($request11g/END_DATE))}</EndDate>       
  </ns2:getFICOPEN>
};

local:funcVirtual11gToRegional($request11g, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaFICOPENTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFICOPEN/Schemas/ConsultaFICOPENTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFICOPENTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFICOPEN/Schemas/GetFICOPENTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>