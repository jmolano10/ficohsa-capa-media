xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/remittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/remittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getCatalogRemittances";
(:: import schema at "../../../../ProviderServices/XSD/GetCatalogRemittances/getCatalogRemittances_sp.xsd" ::)

declare variable $GetCatalogRemittancesRequest as element() (:: schema-element(ns1:getCatalogRemittancesRequest) ::) external;

declare function local:func($GetCatalogRemittancesRequest as element() (:: schema-element(ns1:getCatalogRemittancesRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
    {
                let $FILTERS := $GetCatalogRemittancesRequest/ns1:Filters
                return
                    <ns2:PT_NOMBRES_CATALOGOS>
                        {
                            for $FILTER in $FILTERS/ns1:Filter
                            return
                                <ns2:PT_NOMBRES_CATALOGOS_ITEM>{ data($FILTER) }</ns2:PT_NOMBRES_CATALOGOS_ITEM>
                        }
                    </ns2:PT_NOMBRES_CATALOGOS>
            }
            {
                for $REMITTER_ID in $GetCatalogRemittancesRequest/ns1:RemitterId
                return
                    <ns2:PV_ID_CONTRATO_T24>{ data($REMITTER_ID) }</ns2:PV_ID_CONTRATO_T24>
            }
    </ns2:InputParameters>
};

local:func($GetCatalogRemittancesRequest)
