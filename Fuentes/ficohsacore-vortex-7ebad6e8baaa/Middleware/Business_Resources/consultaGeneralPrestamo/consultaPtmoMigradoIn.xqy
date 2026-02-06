xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../v2/BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarPtmoMigrado";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/consultaPtmoMigradoIn/";

declare function xf:consultaPtmoMigradoIn($loanNumber as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_NUMERO_PRESTAMO>{ $loanNumber }</ns1:PV_NUMERO_PRESTAMO>
        </ns1:InputParameters>
};

declare variable $loanNumber as xs:string external;

xf:consultaPtmoMigradoIn($loanNumber)