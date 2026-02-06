xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_UploadBatch/Schemas/UploadBatchTypes.xsd" ::)

declare variable $pagosMasivos as element() (:: schema-element(ns1:pagosMasivos) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $pagosMasivos as element() (:: schema-element(ns1:pagosMasivos) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:uploadBatch) ::) {
    <ns2:uploadBatch>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <GlobalId>{fn:data($pagosMasivos/GLOBAL_ID)}</GlobalId>
        <CustomerId>{fn:data($pagosMasivos/CUSTOMER_ID)}</CustomerId>
        <UserId>{fn:data($pagosMasivos/USERNAME)}</UserId>
        {
            for $BATCH in $pagosMasivos/BATCHES/BATCH
            return 
            <Batches>
                <CustomerBatchId>{fn:data($BATCH/CUSTOMER_BATCH_ID)}</CustomerBatchId>
                <Type>{fn:data($BATCH/TYPE)}</Type>
                {
                    if ($BATCH/CONCEPT_BATCH)
                    then <ConceptBatch>{fn:data($BATCH/CONCEPT_BATCH)}</ConceptBatch>
                    else ()
                }
                {
                    if ($BATCH/APPLICATION_DATE)
                    then <ApplicationDate>{fn:data($BATCH/APPLICATION_DATE)}</ApplicationDate>
                    else ()
                }
                <DataStructure>
                    <ValIdations>
                        <NumberOfTransactions>{fn:data($BATCH/DATA_STRUCTURE/VALIDATIONS/NUMBER_OF_TRANSACTIONS)}</NumberOfTransactions>
                        <TotalAmount>{fn:data($BATCH/DATA_STRUCTURE/VALIDATIONS/TOTAL_AMOUNT)}</TotalAmount>
                    </ValIdations>
                    {
                        for $FIELD in $BATCH/DATA_STRUCTURE/FIELDS/FIELD
                        return <Fields>{fn:data($FIELD)}</Fields>
                    }
                    <Delimiter>{fn:data($BATCH/DATA_STRUCTURE/DELIMITER)}</Delimiter>
                </DataStructure>
                {
                    for $TRANSACTION in $BATCH/TRANSACTIONS/TRANSACTION
                    return <Transactions>{fn:data($TRANSACTION)}</Transactions>
                }
            </Batches>
        }
    </ns2:uploadBatch>
};

local:func($pagosMasivos, $SourceBank, $DestinationBank)