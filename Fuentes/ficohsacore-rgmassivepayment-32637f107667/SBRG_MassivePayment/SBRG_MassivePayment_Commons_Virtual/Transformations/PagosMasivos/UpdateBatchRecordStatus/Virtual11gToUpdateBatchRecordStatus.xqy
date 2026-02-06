xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_UpdateBatchRecordStatus/Schemas/UpdateBatchRecordStatusTypes.xsd" ::)

declare variable $editarEstadoRegistroLote as element() (:: schema-element(ns1:editarEstadoRegistroLote) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $editarEstadoRegistroLote as element() (:: schema-element(ns1:editarEstadoRegistroLote) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:updateBatchRecordStatus) ::) {
    <ns2:updateBatchRecordStatus>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($editarEstadoRegistroLote/CUSTOMER_ID)}</CustomerId>
        <UserId>{fn:data($editarEstadoRegistroLote/USER_ID)}</UserId>
        <QueryType>BANK_BATCH_ID</QueryType>
        <QueryValue>{fn:data($editarEstadoRegistroLote/BANK_BATCH_ID)}</QueryValue>
        {
            for $TRANSACTION in $editarEstadoRegistroLote/TRANSACTIONS/TRANSACTION
            return 
            <Transactions>{fn:data($TRANSACTION/ID)}</Transactions>
        }
        <Status>{fn:data($editarEstadoRegistroLote/STATUS)}</Status>
    </ns2:updateBatchRecordStatus>
};

local:func($editarEstadoRegistroLote, $SourceBank, $DestinationBank)