xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCoreCatalogsTypes";
(:: import schema at "../../../../../../MWBanking/Services/RequestorServices/XSD/getCoreCatalogsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCoreCatalogs";
(:: import schema at "../../../../../ProviderServices/XSD/GetCoreCatalogs/GetCoreCatalogs_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getCoreCatalogsRequest as element() (:: schema-element(ns1:getCoreCatalogsRequest) ::) external;

declare function local:func($getCoreCatalogsRequest as element() (:: schema-element(ns1:getCoreCatalogsRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            for $PV_CORE in $getCoreCatalogsRequest/ns1:Core
            return
            <ns2:PV_CORE>{fn:data($PV_CORE)}</ns2:PV_CORE>
        }
        <ns2:PT_CATALOG>
        {
            for $PT_CATALOG_ITEM in $getCoreCatalogsRequest/ns1:CatalogName/ns1:Catalog
            return(
                <ns2:PT_CATALOG_ITEM>{fn:data($PT_CATALOG_ITEM)}</ns2:PT_CATALOG_ITEM>
            )
        }
        </ns2:PT_CATALOG>
        {
            for $PV_REGION in $getCoreCatalogsRequest/ns1:GeneralInfo/com:SourceBank
            return
            <ns2:PV_REGION>{fn:data($PV_REGION)}</ns2:PV_REGION>
        }
    </ns2:InputParameters>
};

local:func($getCoreCatalogsRequest)