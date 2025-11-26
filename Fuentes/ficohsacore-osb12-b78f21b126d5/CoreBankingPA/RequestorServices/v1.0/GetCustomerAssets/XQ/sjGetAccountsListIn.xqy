xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
(:: import schema at "../XSD/GetCustomerAssetsPA_SJ.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountsList/GetAccountsList_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sjGetAccountsListIn";

declare variable $sjGetCustomerAssetsGTREQ as element() (:: schema-element(ns2:InputParameters) ::) external;

declare function ns1:sjGetAccountsListIn($sjGetCustomerAssetsGTREQ as element() (:: schema-element(ns2:InputParameters) ::)) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            if ($sjGetCustomerAssetsGTREQ/ns2:PV_CUSTOMER_ID)
            then <ns3:PV_CUSTOMER_ID>{fn:data($sjGetCustomerAssetsGTREQ/ns2:PV_CUSTOMER_ID)}</ns3:PV_CUSTOMER_ID>
            else ()
        }
        {
            if ($sjGetCustomerAssetsGTREQ/ns2:PV_ASSET_TYPE)
            then <ns3:PV_ASSET_TYPE>{fn:data($sjGetCustomerAssetsGTREQ/ns2:PV_ASSET_TYPE)}</ns3:PV_ASSET_TYPE>
            else ()
        }
    </ns3:InputParameters>
};

ns1:sjGetAccountsListIn($sjGetCustomerAssetsGTREQ)