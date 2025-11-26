xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerLists";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersLists.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetListsPetitionStatus";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLists/GetListsPetitionStatus_sp.xsd" ::)

declare namespace Tx_GetListsPetitionStatus_To_Abanks="http://www.w3.org/2005/xquery-local-functions";

declare variable $request as element() (:: schema-element(ns1:getListsPetitionStatusRequest) ::) external;

declare function Tx_GetListsPetitionStatus_To_Abanks:func($request as element() (:: schema-element(ns1:getListsPetitionStatusRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($request/ns1:retVal)
            then <ns2:PV_RET_VAL>{fn:data($request/ns1:retVal)}</ns2:PV_RET_VAL>
            else ()
        }
        {
            if ($request/ns1:sequenceNumber)
            then <ns2:PN_NUMERO_SECUENCIA>{fn:data($request/ns1:sequenceNumber)}</ns2:PN_NUMERO_SECUENCIA>
            else ()
        }
    </ns2:InputParameters>
};

Tx_GetListsPetitionStatus_To_Abanks:func($request)