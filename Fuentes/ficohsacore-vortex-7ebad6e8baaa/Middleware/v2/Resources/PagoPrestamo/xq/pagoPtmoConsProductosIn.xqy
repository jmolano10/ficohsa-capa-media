xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:sjConsultaProductos" location="../../../BusinessServices/SJS/consultaProductos/xsd/sjConsultaProductos.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaProductos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoConsProductosIn/";

declare function xf:pagoPtmoConsProductosIn($ldapUsername as xs:string,
    $ldapPassword as xs:string,
    $loanNumber as xs:string,
    $accountNumber as xs:string)
    as element(ns0:sjConsultaProductos) {
        <ns0:sjConsultaProductos>
            <ns0:T24_USERNAME/>
            <ns0:T24_PASSWORD/>
            <ns0:LDAP_USERNAME>{ $ldapUsername }</ns0:LDAP_USERNAME>
            <ns0:LDAP_PASSWORD>{ $ldapPassword }</ns0:LDAP_PASSWORD>
            <ns0:PRODUCTS>
                <ns0:PRODUCT>
                    <ns0:TYPE>PTM</ns0:TYPE>
                    <ns0:ID>{ $loanNumber }</ns0:ID>
                </ns0:PRODUCT>
                <ns0:PRODUCT>
                    <ns0:TYPE>CTA</ns0:TYPE>
                    <ns0:ID>{ $accountNumber }</ns0:ID>
                </ns0:PRODUCT>
            </ns0:PRODUCTS>
        </ns0:sjConsultaProductos>
};

declare variable $ldapUsername as xs:string external;
declare variable $ldapPassword as xs:string external;
declare variable $loanNumber as xs:string external;
declare variable $accountNumber as xs:string external;

xf:pagoPtmoConsProductosIn($ldapUsername,
    $ldapPassword,
    $loanNumber,
    $accountNumber)