xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/UploadBatchTypes.xsd" ::)

declare variable $uploadBatch as element() (:: schema-element(ns1:uploadBatch) ::) external;

declare function local:func(
    $uploadBatch as element() (:: schema-element(ns1:uploadBatch) ::)
    ) as element() (:: schema-element(ns2:PagosMasivos) ::) {
    <ns2:PagosMasivos>
        <requestHeader>
            <sourceBank>{fn:data($uploadBatch/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($uploadBatch/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($uploadBatch/CustomerId)}</customerId>
            <userName>{fn:data($uploadBatch/GeneralInfo/ApplicationId)}</userName>
            <userId>{fn:data($uploadBatch/UserId)}</userId>
        </requestHeader>
        {
            if ($uploadBatch/GlobalId)
            then <globalId>{fn:data($uploadBatch/GlobalId)}</globalId>
            else ()
        }
        {
            for $Batches in $uploadBatch/Batches
            return 
            <batches>
                {
                    if ($Batches/Ticket)
                    then <ticket>{fn:data($Batches/Ticket)}</ticket>
                    else ()
                }
                <customerBatchId>{fn:data($Batches/CustomerBatchId)}</customerBatchId>
                <operationType>{fn:data($Batches/Type)}</operationType>
                {
                    if ($Batches/ConceptBatch)
                    then <concept>{fn:data($Batches/ConceptBatch)}</concept>
                    else ()
                }
                {
                    if ($Batches/ApplicationDate)
                    then <applicationDate>{fn:data($Batches/ApplicationDate)}</applicationDate>
                    else ()
                }
                <transactionCount>{fn:data($Batches/DataStructure/ValIdations/NumberOfTransactions)}</transactionCount>
                <totalAmount>{fn:data($Batches/DataStructure/ValIdations/TotalAmount)}</totalAmount>
                <dataStructure>
                    {
                        for $Fields in $Batches/DataStructure/Fields
                        return 
                        <fields>{fn:data($Fields)}</fields>
                    }
                    <delimiter>{fn:data($Batches/DataStructure/Delimiter)}</delimiter>
                </dataStructure>
                {
                    for $Transactions in $Batches/Transactions
                    return 
                    <transactions>{fn:data($Transactions)}</transactions>
                }
            </batches>
        }
    </ns2:PagosMasivos>
};

local:func($uploadBatch)