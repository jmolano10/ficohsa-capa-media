xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetBatchDetail/Schemas/GetBatchDetailTypes.xsd" ::)

declare variable $consultaDetalleLote as element() (:: schema-element(ns1:consultaDetalleLote) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $consultaDetalleLote as element() (:: schema-element(ns1:consultaDetalleLote) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:getBatchDetail) ::) {
    <ns2:getBatchDetail>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($consultaDetalleLote/CUSTOMER_ID)}</CustomerId>
        <QueryType>{fn:data($consultaDetalleLote/QUERY_TYPE)}</QueryType>
        <QueryValue>{fn:data($consultaDetalleLote/QUERY_VALUE)}</QueryValue>
        {
            for $FILTER in $consultaDetalleLote/TRANSACTION_FILTERS/FILTER
            return 
            <TransactionFilters>
                {
                    if ($FILTER/FIELD)
                    then <Field>{fn:data($FILTER/FIELD)}</Field>
                    else ()
                }
                {
                    if ($FILTER/VALUE)
                    then <Value>{fn:data($FILTER/VALUE)}</Value>
                    else ()
                }
            </TransactionFilters>
        }
        <PagingInfo>
            {
                if ($consultaDetalleLote/PAGING_INFO/INITIAL_RECORD)
                then <InitialRecord>{fn:data($consultaDetalleLote/PAGING_INFO/INITIAL_RECORD)}</InitialRecord>
                else ()
            }
            <PageSize>{fn:data($consultaDetalleLote/PAGING_INFO/RECORD_COUNT)}</PageSize></PagingInfo>
    </ns2:getBatchDetail>
};

local:func($consultaDetalleLote, $SourceBank, $DestinationBank)