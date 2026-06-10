<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaCargaArchivoDAT" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargaArchivoDAT/xq/consultaCargaArchivoIn/";

declare function xf:consultaCargaArchivoIn($FILE_REQUEST_ID as xs:integer)
    as element(ns0:consultaCargaArchivoDAT) {
        &lt;ns0:consultaCargaArchivoDAT>
            &lt;FILE_REQUEST_ID>{ $FILE_REQUEST_ID }&lt;/FILE_REQUEST_ID>
        &lt;/ns0:consultaCargaArchivoDAT>
};

declare variable $FILE_REQUEST_ID as xs:integer external;

xf:consultaCargaArchivoIn($FILE_REQUEST_ID)</con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
</con:xqueryEntry>