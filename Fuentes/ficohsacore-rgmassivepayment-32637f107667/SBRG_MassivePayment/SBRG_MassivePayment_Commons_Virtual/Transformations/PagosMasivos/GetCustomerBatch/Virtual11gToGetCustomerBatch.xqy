xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetCustomerBatch/Schemas/GetCustomerBatchTypes.xsd" ::)

declare variable $consultaLotesCliente as element() (:: schema-element(ns1:consultaLotesCliente) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $consultaLotesCliente as element() (:: schema-element(ns1:consultaLotesCliente) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:getCustomerBatch) ::) {
    <ns2:getCustomerBatch>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($consultaLotesCliente/CUSTOMER_ID)}</CustomerId>
        <BeginDate>{fn:data($consultaLotesCliente/BEGIN_DATE)}</BeginDate>
        <EndDate>{fn:data($consultaLotesCliente/END_DATE)}</EndDate>
    </ns2:getCustomerBatch>
};

local:func($consultaLotesCliente, $SourceBank, $DestinationBank)