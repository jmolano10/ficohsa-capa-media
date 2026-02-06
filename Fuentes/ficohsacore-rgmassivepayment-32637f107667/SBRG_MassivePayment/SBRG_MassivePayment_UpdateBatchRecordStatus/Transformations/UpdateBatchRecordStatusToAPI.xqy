xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/UpdateBatchRecordStatusTypes.xsd" ::)

declare variable $updateBatchRecordStatus as element() (:: schema-element(ns1:updateBatchRecordStatus) ::) external;

declare function local:func(
    $updateBatchRecordStatus as element() (:: schema-element(ns1:updateBatchRecordStatus) ::)
    ) as element() (:: schema-element(ns2:EditarEstadoRegistroLote) ::) {
    <ns2:EditarEstadoRegistroLote>
        <requestHeader>
            <sourceBank>{fn:data($updateBatchRecordStatus/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($updateBatchRecordStatus/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($updateBatchRecordStatus/CustomerId)}</customerId>
            <userName>{fn:data($updateBatchRecordStatus/GeneralInfo/ApplicationId)}</userName>
            <userId>{fn:data($updateBatchRecordStatus/UserId)}</userId>
        </requestHeader>
        <queryType>{fn:data($updateBatchRecordStatus/QueryType)}</queryType>
        <queryValue>{fn:data($updateBatchRecordStatus/QueryValue)}</queryValue>
        {
            for $Transactions in $updateBatchRecordStatus/Transactions
            return 
            <transactions>{fn:data($Transactions)}</transactions>
        }
        <status>{fn:data($updateBatchRecordStatus/Status)}</status>
    </ns2:EditarEstadoRegistroLote>
};

local:func($updateBatchRecordStatus)