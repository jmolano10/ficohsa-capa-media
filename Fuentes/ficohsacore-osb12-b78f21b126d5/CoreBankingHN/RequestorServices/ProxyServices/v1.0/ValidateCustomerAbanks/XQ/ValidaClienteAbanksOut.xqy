xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/validaClienteAbanks";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/validateCustomerAbanks.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaClienteAbanks_BS";
(:: import schema at "../../../../../ProviderServices/XSD/ValidaClienteAbanks/ValidaClienteAbanks_BS_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $ValidaClienteAbanksResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($uuid as xs:string,
                            $ValidaClienteAbanksResponse as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:validateCustomerAbanksResponse) ::) {
    <ns2:validateCustomerAbanksResponse>
     <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
      </ns2:StatusInfo>
        {
            if ($ValidaClienteAbanksResponse/ns1:PV_REGISTRADO)
            then <ns2:Registered>{fn:data($ValidaClienteAbanksResponse/ns1:PV_REGISTRADO)}</ns2:Registered>
            else ()
        }
        {
            if ($ValidaClienteAbanksResponse/ns1:PV_ESTADO)
            then <ns2:Status>{fn:data($ValidaClienteAbanksResponse/ns1:PV_ESTADO)}</ns2:Status>
            else ()
        }     
    </ns2:validateCustomerAbanksResponse>
};

local:func($uuid,$ValidaClienteAbanksResponse)