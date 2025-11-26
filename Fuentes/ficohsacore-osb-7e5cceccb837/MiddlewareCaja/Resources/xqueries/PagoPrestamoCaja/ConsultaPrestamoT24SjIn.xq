(:: pragma bea:global-element-return element="ns0:sjConsultaPrestamo" location="../../xsds/PagoPrestamoCaja/sjConsultaPrestamo.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/ConsultaPrestamoT24SjIn/";

declare function xf:ConsultaPrestamoT24SjIn($username as xs:string,
    $password as xs:string,
    $loanNumber as xs:string,
    $transactionId as xs:string)
    as element(ns0:sjConsultaPrestamo) {
        <ns0:sjConsultaPrestamo>
            <USERNAME>{ $username }</USERNAME>
            <PASSWORD>{ $password }</PASSWORD>
            <LOAN_ID>{ $loanNumber }</LOAN_ID>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        </ns0:sjConsultaPrestamo>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $loanNumber as xs:string external;
declare variable $transactionId as xs:string external;

xf:ConsultaPrestamoT24SjIn($username,
    $password,
    $loanNumber,
    $transactionId)