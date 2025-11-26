xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
(:: import schema at "../XSD/GetCustomerAssetsPA_SJ.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetTermDepositsList/GetTermDepositsList_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sjGetTermDepositsListIn";

declare variable $sjGetTermDepositsListREQ as element() (:: schema-element(ns2:InputParameters) ::) external;

declare function ns1:sjGetTermDepositsListIn($sjGetTermDepositsListREQ as element() (:: schema-element(ns2:InputParameters) ::)) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            if ($sjGetTermDepositsListREQ/ns2:PV_CUSTOMER_ID)
            then <ns3:CUSTOMER_ID>{fn:data($sjGetTermDepositsListREQ/ns2:PV_CUSTOMER_ID)}</ns3:CUSTOMER_ID>
            else ()
        }
        {
            if ($sjGetTermDepositsListREQ/ns2:PV_ASSET_TYPE)
            then <ns3:ASSET_TYPE>DEP</ns3:ASSET_TYPE>
            else ()
        }
    </ns3:InputParameters>
};

ns1:sjGetTermDepositsListIn($sjGetTermDepositsListREQ)