(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ConsultaPtmoMigrado/consultarPtmoMigrado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarPtmoMigrado";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaGeneralPrestamo/ConsultarPtmoMigradoIn/";

declare function xf:ConsultarPtmoMigradoIn($loanNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_PRESTAMO>{ $loanNumber }</ns0:PV_NUMERO_PRESTAMO>
        </ns0:InputParameters>
};

declare variable $loanNumber as xs:string external;

xf:ConsultarPtmoMigradoIn($loanNumber)