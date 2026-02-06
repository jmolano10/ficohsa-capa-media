xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetBatchDetailTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)

declare variable $getBatchDetailToAPI as element() (:: schema-element(ns1:getBatchDetail) ::) external;

declare function local:func(
    $getBatchDetailToAPI as element() (:: schema-element(ns1:getBatchDetail) ::)
    ) as element() (:: schema-element(ns2:ConsultarDetalleLote) ::) {
    <ns2:ConsultarDetalleLote>
        <requestHeader>
            <sourceBank>{fn:data($getBatchDetailToAPI/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($getBatchDetailToAPI/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($getBatchDetailToAPI/CustomerId)}</customerId>
            <userName>{fn:data($getBatchDetailToAPI/GeneralInfo/ApplicationId)}</userName>
        </requestHeader>
        <queryType>{fn:data($getBatchDetailToAPI/QueryType)}</queryType>
        <queryValue>{fn:data($getBatchDetailToAPI/QueryValue)}</queryValue>
        <paging>
            <initialRecord>{fn:data($getBatchDetailToAPI/PagingInfo/InitialRecord)}</initialRecord>
            {
                if ($getBatchDetailToAPI/PagingInfo/Page)
                then <page>{fn:data($getBatchDetailToAPI/PagingInfo/Page)}</page>
                else ()
            }
            <pageSize>{fn:data($getBatchDetailToAPI/PagingInfo/PageSize)}</pageSize>
        </paging>
        {
            for $TransactionFilters in $getBatchDetailToAPI/TransactionFilters
            return 
            <filters>
                {
                    if ($TransactionFilters/Field)
                    then <field>{fn:data($TransactionFilters/Field)}</field>
                    else ()
                }
                {
                    if ($TransactionFilters/Value)
                    then <value>{fn:data($TransactionFilters/Value)}</value>
                    else ()
                }
            </filters>
        }
    </ns2:ConsultarDetalleLote>
};

local:func($getBatchDetailToAPI)