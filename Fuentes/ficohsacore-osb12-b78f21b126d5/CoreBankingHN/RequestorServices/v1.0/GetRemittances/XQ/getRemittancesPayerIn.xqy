xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittances.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getRemittancesPayer";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesPayer/getRemittancesPayer_sp.xsd" ::)

declare variable $getRemittancesPayerRequest as element() (:: schema-element(ns1:getRemittancesRequest) ::) external;
declare variable $payer as xs:string external;

declare function local:func($getRemittancesPayerRequest as element() (:: schema-element(ns1:getRemittancesRequest) ::), 
                            $payer as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            for $RemittanceId in $getRemittancesPayerRequest/ns1:RemittanceId
            return
              <ns2:PV_REMESA>{fn:data($getRemittancesPayerRequest/ns1:RemittanceId)}</ns2:PV_REMESA>
        }
        <ns2:PV_PAGADOR_DEST>{fn:data($payer)}</ns2:PV_PAGADOR_DEST>
    </ns2:InputParameters>
};

local:func($getRemittancesPayerRequest, $payer)
