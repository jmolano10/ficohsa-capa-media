xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRelationOperationCollection";
(:: import schema at "../../../../ProviderServices/XSD/GetRelationOperationCollection/GetRelationOperationCollection_sp.xsd" ::)

declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

declare function local:func($paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CODIGO_CONTRATO>{ data($paymentCollectionRequest/ns1:ContractId) }</ns2:CODIGO_CONTRATO>
        <ns2:CODIGO_DEUDOR>{ data($paymentCollectionRequest/ns1:DebtorCode) }</ns2:CODIGO_DEUDOR>
        <ns2:MONEDA_SOLICITUD>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency) }</ns2:MONEDA_SOLICITUD>
        <ns2:CODIGO_FACTURA_REQ>{ data($paymentCollectionRequest/ns1:BillInformation/ns1:BillNumber) }</ns2:CODIGO_FACTURA_REQ>            
    </ns2:InputParameters>
};

local:func($paymentCollectionRequest)