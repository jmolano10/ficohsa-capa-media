xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/CrearClienteNormalIntermedio/v1.0/CrearClienteNormalIntermedio.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace crearClienteNormalIntermedioHNOut="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $crearClienteRsp as element() (:: schema-element(ns1:CreacionClientesparaDynamoResponse) ::) external;

declare function crearClienteNormalIntermedioHNOut:crearClienteNormalIntermedioHNOut($uuid as xs:string, $crearClienteRsp as element() (:: schema-element(ns1:CreacionClientesparaDynamoResponse) ::)) as element() (:: schema-element(ns2:createCustomerResponse) ::) {
    <ns2:createCustomerResponse>
        <ns2:StatusInfo>
            {
                if ($crearClienteRsp/Status/successIndicator)
                then <com:Status>{fn:data($crearClienteRsp/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($crearClienteRsp/Status/transactionId)
                then <com:TransactionId>{fn:data($crearClienteRsp/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
            if ($crearClienteRsp/FICOBULKPRODUCTType/FIELDS4)
            then <ns2:CustomerId>{fn:data($crearClienteRsp/FICOBULKPRODUCTType/FIELDS4)}</ns2:CustomerId>
            else ()
        }
        {
            if ($crearClienteRsp/FICOBULKPRODUCTType/FIELDS134)
            then <ns2:CustomerName>{fn:concat(fn:data($crearClienteRsp/FICOBULKPRODUCTType/FIELDS134), " ", fn:data($crearClienteRsp/FICOBULKPRODUCTType/FIELDS135))}</ns2:CustomerName>
            else ()
        }
        {
            if ($crearClienteRsp/FICOBULKPRODUCTType/FIELDS51)
            then <ns2:AccountNumber>{fn:data($crearClienteRsp/FICOBULKPRODUCTType/FIELDS51)}</ns2:AccountNumber>
            else ()
        }
    </ns2:createCustomerResponse>
};

crearClienteNormalIntermedioHNOut:crearClienteNormalIntermedioHNOut($uuid, $crearClienteRsp)