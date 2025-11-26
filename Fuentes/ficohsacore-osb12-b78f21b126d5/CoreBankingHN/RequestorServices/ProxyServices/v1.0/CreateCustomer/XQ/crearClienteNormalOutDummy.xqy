xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace crearClienteNormalOutDummy="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";


declare function crearClienteNormalOutDummy:crearClienteNormalOutDummy() as element() (:: schema-element(ns1:createCustomerResponse) ::) {
    <ns1:createCustomerResponse>
        <ns1:GlobalId></ns1:GlobalId>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId></com:GlobalId>
        </ns1:StatusInfo>
        <ns1:CustomerId>5218971</ns1:CustomerId>
        <ns1:CustomerName>Frodo Bolson</ns1:CustomerName>
    </ns1:createCustomerResponse>
};

crearClienteNormalOutDummy:crearClienteNormalOutDummy()
