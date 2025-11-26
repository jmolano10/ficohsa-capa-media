xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaClienteOpi";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerOpi.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CustomerOpi_BS";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerOpi/v1.0/CustomerOpi_BS_sp.xsd" ::)

declare namespace cus="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $CustomerOpiResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function cus:CustomerOpiHNOut($CustomerOpiResponse as element(), $uuid as xs:string) as element() (:: schema-element(ns2:getCustomerOpiResponse) ::) {
    <ns2:getCustomerOpiResponse>
    <ns2:StatusInfo>
        <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
    </ns2:StatusInfo>
    {
      for $CustomerOpi in $CustomerOpiResponse/ns1:RowSet/ns1:Row
      return
        <ns2:CustomerDetails>
            <ns2:LegalID>{fn:data($CustomerOpi/ns1:Column[@name='IDENTIDAD'])}</ns2:LegalID>
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='PERFIL_CLIENTE']))then 
                <ns2:CustomerProfile>{fn:data($CustomerOpi/ns1:Column[@name='PERFIL_CLIENTE'])}</ns2:CustomerProfile>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='CUENTA']))then 
                <ns2:Account>{fn:data($CustomerOpi/ns1:Column[@name='CUENTA'])}</ns2:Account>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='TIPO_CUENTA']))then 
                <ns2:AccountType>{fn:data($CustomerOpi/ns1:Column[@name='TIPO_CUENTA'])}</ns2:AccountType>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='CATEGORIA']))then 
                <ns2:Category>{fn:data($CustomerOpi/ns1:Column[@name='CATEGORIA'])}</ns2:Category>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='CGP']))then 
                <ns2:PayrollCode>{fn:data($CustomerOpi/ns1:Column[@name='CGP'])}</ns2:PayrollCode>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='NOMBRE_CGP']))then 
                <ns2:PayrollName>{fn:data($CustomerOpi/ns1:Column[@name='NOMBRE_CGP'])}</ns2:PayrollName>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='CODIGO_PLANILLA_ABANKS']))then 
                <ns2:AgreementCode>{fn:data($CustomerOpi/ns1:Column[@name='CODIGO_PLANILLA_ABANKS'])}</ns2:AgreementCode>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='NOMBRE_CONVENIO']))then 
                <ns2:AgreementName>{fn:data($CustomerOpi/ns1:Column[@name='NOMBRE_CONVENIO'])}</ns2:AgreementName>
                else ()
            }
            {
                if (fn:data($CustomerOpi/ns1:Column[@name='CONDICION']))then 
                <ns2:AgreementRate>{fn:data($CustomerOpi/ns1:Column[@name='CONDICION'])}</ns2:AgreementRate>
                else ()
            }
        </ns2:CustomerDetails>
        }
    </ns2:getCustomerOpiResponse>
};

cus:CustomerOpiHNOut($CustomerOpiResponse, $uuid)
