xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($ID as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:LOAN_ID>{ $ID }</ns0:LOAN_ID>
        </ns0:InputParameters>
};

declare variable $ID as xs:string external;

xf:consultaGeneralPrestamoIn($ID)