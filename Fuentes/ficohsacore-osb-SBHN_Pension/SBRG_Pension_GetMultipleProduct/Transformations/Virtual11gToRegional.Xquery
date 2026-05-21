<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaMultiplesProductosTypes";
(:: import schema at "../Schemas/ConsultaMultiplesProductosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetMultipleProductTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns1:consultaMultiplesProductosRequest) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;

declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns1:consultaMultiplesProductosRequest) ::),
                                                $sourceBank as xs:string, 
                                                $destinationBank as xs:string, 
                                                $userName as xs:string) as element() (:: schema-element(ns2:getMultipleProduct) ::) {
    <ns2:getMultipleProduct>
       <GeneralInfo>
          <SourceBank>{fn:data($sourceBank)}</SourceBank>
          <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
          <ApplicationId>{fn:data($userName)}</ApplicationId>
          <ApplicationUser>{fn:data($userName)}</ApplicationUser>
       </GeneralInfo>
       {
          for $product in $request11g/PRODUCTS/PRODUCT[TYPE='FPC'][1]
          return(
            <CodeTypeIdentificationAffiliate>{fn:data($product/TYPE)}</CodeTypeIdentificationAffiliate>,
            <NumberIdentificationAffiliate>{fn:data($product/PRODUCT_ID)}</NumberIdentificationAffiliate>
          )
       }
    </ns2:getMultipleProduct>
};

local:funcVirtual11gToRegional($request11g, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaMultiplesProductosTypes.xsd">
            <con:schema ref="SBRG_Pension_GetMultipleProduct/Schemas/ConsultaMultiplesProductosTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetMultipleProductTypes.xsd">
            <con:schema ref="SBRG_Pension_GetMultipleProduct/Schemas/GetMultipleProductTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>