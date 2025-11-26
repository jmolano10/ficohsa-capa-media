xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/remittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/remittancesTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getCatalogRemittances";
(:: import schema at "../../../../ProviderServices/XSD/GetCatalogRemittances/getCatalogRemittances_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $GetCatalogsResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $GetCatalogRemittancesRequest as element() (:: schema-element(ns2:getCatalogRemittancesRequest) ::) external;

declare function local:func($uuid as xs:string, 
                            $GetCatalogsResponse as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $GetCatalogRemittancesRequest as element() (:: schema-element(ns2:getCatalogRemittancesRequest) ::)) 
                            as element() (:: schema-element(ns2:getCatalogRemittancesResponse) ::) {
    <ns2:getCatalogRemittancesResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
          {
              for $FILTER in $GetCatalogRemittancesRequest/ns2:Filters/ns2:Filter
              return(
                  <ns2:CatalogsList id="{ data($FILTER) }">
                  {
                      for $PT_CATALOGOS_ITEM in $GetCatalogsResponse/ns1:PT_CATALOGOS/ns1:PT_CATALOGOS_ITEM[ns1:CATALOG = $FILTER]
                      return(
                          <ns2:CatalogItem>
                          {
                              for $CODE in $PT_CATALOGOS_ITEM/ns1:CODE
                              return
                              <ns2:Code>{ data($CODE) }</ns2:Code>
                          }
                          {
                              for $DESCRIPTION in $PT_CATALOGOS_ITEM/ns1:DESCRIPTION
                              return
                              <ns2:Description>{ data($DESCRIPTION) }</ns2:Description>
                          }
                          </ns2:CatalogItem>
                      )
                  }
                  </ns2:CatalogsList>
              )
          }
    </ns2:getCatalogRemittancesResponse>
};

local:func($uuid, $GetCatalogsResponse, $GetCatalogRemittancesRequest)