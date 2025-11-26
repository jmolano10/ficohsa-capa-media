xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:creaUsuarioSistema" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/creaUsuarioSistemaIN2/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";

declare function xf:creaUsuarioSistemaIN2($DocumentType as xs:string,
    $DocumentNumber as xs:string,
    $ProductType as xs:string,
    $ProductNumber as xs:string,
    $Subsidiary as xs:string,
    $username as xs:string,
    $names as xs:string,
    $lastname as xs:string,
    $phone as xs:string,
    $email as xs:string)
    as element(ns0:creaUsuarioSistema) {
        <ns0:creaUsuarioSistema>
            <DOCUMENT_TYPE_ID>{ data($DocumentType) }</DOCUMENT_TYPE_ID>
            <DOCUMENT_NUMBER>{ data($DocumentNumber) }</DOCUMENT_NUMBER>
            <CUSTOMER_NAMES>{ data($names) }</CUSTOMER_NAMES>
            <CUSTOMER_LAST_NAMES>{ data($lastname) }</CUSTOMER_LAST_NAMES>
            <EMAIL>{ data($email) }</EMAIL>
            <PHONE>{ data( $phone) }</PHONE>
            <PRODUCT_TYPE_ID>{ data( $ProductType) }</PRODUCT_TYPE_ID>
            <PRODUCT_NUMBER>{ data($ProductNumber) }</PRODUCT_NUMBER>
            <USER_NAME>{ data( $username) }</USER_NAME>
        </ns0:creaUsuarioSistema>
       
};

declare variable $DocumentType as xs:string external;
declare variable $DocumentNumber as xs:string external;
declare variable $ProductType as xs:string external;
declare variable $ProductNumber as xs:string external;
declare variable $Subsidiary as xs:string external;
declare variable $username as xs:string external;
declare variable $names as xs:string external;
declare variable $lastname as xs:string external;
declare variable $phone as xs:string external;
declare variable $email as xs:string external;

xf:creaUsuarioSistemaIN2($DocumentType,
    $DocumentNumber,
    $ProductType,
    $ProductNumber,
    $Subsidiary,
    $username,
    $names,
    $lastname,
    $phone,
    $email)
