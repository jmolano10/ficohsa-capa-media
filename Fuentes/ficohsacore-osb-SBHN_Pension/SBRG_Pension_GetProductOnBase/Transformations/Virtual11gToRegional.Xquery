<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
(:: import schema at "../Schemas/ConsultaProductoOnBaseTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetProductOnBaseTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns1:consultaProductoOnBase) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;


declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns1:consultaProductoOnBase) ::),
                                                $sourceBank as xs:string, 
                                                $destinationBank as xs:string, 
                                                $userName as xs:string) as element() (:: schema-element(ns2:getProductOnBase) ::) {
    <ns2:getProductOnBase>
      <GeneralInfo>
          <SourceBank>{fn:data($sourceBank)}</SourceBank>
          <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
          <ApplicationId>{fn:data($userName)}</ApplicationId>
          <ApplicationUser>{fn:data($userName)}</ApplicationUser>
       </GeneralInfo>
        <AccountCode>{fn:data($request11g/PRODUCT_NUMBER)}</AccountCode>
        <IdentificationTypeCode></IdentificationTypeCode>
        <IdentificationNumber></IdentificationNumber>

    </ns2:getProductOnBase>
};

local:funcVirtual11gToRegional($request11g, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaProductoOnBaseTypes.xsd">
            <con:schema ref="SBRG_Pension_GetProductOnBase/Schemas/ConsultaProductoOnBaseTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetProductOnBaseTypes.xsd">
            <con:schema ref="SBRG_Pension_GetProductOnBase/Schemas/GetProductOnBaseTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>