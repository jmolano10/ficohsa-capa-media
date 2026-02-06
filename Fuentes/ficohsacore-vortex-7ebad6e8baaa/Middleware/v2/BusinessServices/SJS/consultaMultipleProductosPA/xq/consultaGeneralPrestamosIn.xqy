xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABKPA/consultaGeneralPrestamo/xsd/consultaGeneralPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaGeneralPrestamosIn/";

declare function xf:consultaGeneralPrestamosIn($ID as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:LOAN_ID>{ $ID }</ns0:LOAN_ID>
        </ns0:InputParameters>
};

declare variable $ID as xs:string external;

xf:consultaGeneralPrestamosIn($ID)