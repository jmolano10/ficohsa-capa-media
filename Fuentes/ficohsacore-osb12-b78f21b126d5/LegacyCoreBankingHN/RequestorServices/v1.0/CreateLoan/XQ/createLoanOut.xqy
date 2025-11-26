xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/loansTypes";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/loansTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_APERTURA_PRESTAMOS_V2/OSB_P_APERTURA_PRESTAMO_2/";
(:: import schema at "../../../../ProviderServices/XSD/CreateLoans/CreateLoan_sp.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/middlewareservices/createLoanOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $crearPrestamoRSP as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function ns2:createLoanOut($uuid as xs:string,
                                   $crearPrestamoRSP as element() (:: schema-element(ns1:OutputParameters) ::))
                                   as element() (:: schema-element(ns3:createLoanResponse) ::) {
    <ns3:createLoanResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if ($crearPrestamoRSP/ns1:PV_NUMERO_PRESTAMO)
            then <ns3:LoanNumber>{fn:data($crearPrestamoRSP/ns1:PV_NUMERO_PRESTAMO)}</ns3:LoanNumber>
            else ()
        }
        {
            if ($crearPrestamoRSP/ns1:PN_NUMERO_CONTRATO)
            then <ns3:LoanContract>{fn:data($crearPrestamoRSP/ns1:PN_NUMERO_CONTRATO)}</ns3:LoanContract>
            else ()
        }
        {
            if ($crearPrestamoRSP/ns1:PN_NUMERO_GARANTIA)
            then <ns3:GuaranteeNumber>{fn:data($crearPrestamoRSP/ns1:PN_NUMERO_GARANTIA)}</ns3:GuaranteeNumber>
            else ()
        }
    </ns3:createLoanResponse>
};

ns2:createLoanOut($uuid, $crearPrestamoRSP)