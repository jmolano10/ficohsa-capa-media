xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetCustomerBatchTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)

declare variable $getCustomerBatch as element() (:: schema-element(ns1:getCustomerBatch) ::) external;

declare function local:func($getCustomerBatch as element() (:: schema-element(ns1:getCustomerBatch) ::)) as element() (:: schema-element(ns2:ConsultarLotesCliente) ::) {
    <ns2:ConsultarLotesCliente>
        <requestHeader>
            <sourceBank>{fn:data($getCustomerBatch/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($getCustomerBatch/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($getCustomerBatch/CustomerId)}</customerId>
            <userName>{fn:data($getCustomerBatch/GeneralInfo/ApplicationId)}</userName>
        </requestHeader>
        <beginDate>{fn:concat(fn:data($getCustomerBatch/BeginDate),'T00:00:00')}</beginDate>
        <endDate>{fn:concat(fn:data($getCustomerBatch/EndDate),'T00:00:00')}</endDate>
    </ns2:ConsultarLotesCliente>
};

local:func($getCustomerBatch)