xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/CrearClienteSimplificado/CrearClienteSimplificado_BS.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/crearClienteSimplificadoHNOUT";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $creaciondeClienteSimplificadoResponse as element() (:: schema-element(ns2:CreaciondeClienteSimplificadoResponse) ::) external;

declare function ns1:crearClienteSimplificadoHNOUT($uuid as xs:string, 
                                                   $creaciondeClienteSimplificadoResponse as element() (:: schema-element(ns2:CreaciondeClienteSimplificadoResponse) ::)) 
                                                   as element() (:: schema-element(ns3:createCustomerResponse) ::) {
    <ns3:createCustomerResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:CustomerId>5218971</ns3:CustomerId>
        <ns3:CustomerName>Frodo Bolson</ns3:CustomerName>
        <ns3:AccountNumber>100002892775</ns3:AccountNumber>
        <ns3:AddressList>
            <ns3:Type>1</ns3:Type>
            <ns3:IsMain>Hobbiton</ns3:IsMain>
            <ns3:AddressLine1>Bolsón Cerrado</ns3:AddressLine1>
            <ns3:AddressLine2>Y</ns3:AddressLine2>
        </ns3:AddressList>
    </ns3:createCustomerResponse>
};

ns1:crearClienteSimplificadoHNOUT($uuid, $creaciondeClienteSimplificadoResponse)