xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCoreCatalogsTypes";
(:: import schema at "../../../../../../MWBanking/Services/RequestorServices/XSD/getCoreCatalogsTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCoreCatalogs";
(:: import schema at "../../../../../ProviderServices/XSD/GetCoreCatalogs/GetCoreCatalogs_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $RSPGetCoreCatalogs as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($RSPGetCoreCatalogs as element() (:: schema-element(ns1:OutputParameters) ::),
    $uuid as xs:string) as element() (:: schema-element(ns2:getCoreCatalogsResponse) ::) {
    <ns2:getCoreCatalogsResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
            for $catalog in distinct-values($RSPGetCoreCatalogs/ns1:PT_CATALOG_ITEMS/ns1:PT_CATALOG_ITEMS_ITEM/ns1:CATALOG_NAME)
            return(
                <ns2:CatalogsInfo Id="{$catalog}">
                {
                    for $catalogItem in $RSPGetCoreCatalogs/ns1:PT_CATALOG_ITEMS/ns1:PT_CATALOG_ITEMS_ITEM[ns1:CATALOG_NAME = $catalog]
                    return(
                        <ns2:CatalogItem>
                            <ns2:Code>{fn:data($catalogItem/ns1:CATALOG_EQUIVALENCE)}</ns2:Code>
                            <ns2:Description>{fn:data($catalogItem/ns1:CATALOG_VALUE)}</ns2:Description>
                        </ns2:CatalogItem>
                    )
                }
                </ns2:CatalogsInfo>
            )
        }
    </ns2:getCoreCatalogsResponse>
};

local:func($RSPGetCoreCatalogs,$uuid)