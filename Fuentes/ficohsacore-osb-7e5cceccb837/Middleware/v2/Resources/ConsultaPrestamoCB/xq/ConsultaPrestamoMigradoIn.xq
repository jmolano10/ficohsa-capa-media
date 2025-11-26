(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarPtmoMigrado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPrestamoCB/xq/ConsultaPrestamoMigradoIn/";

declare function xf:ConsultaPrestamoMigradoIn($NumeroPrestamo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_PRESTAMO>{ $NumeroPrestamo }</ns0:PV_NUMERO_PRESTAMO>
        </ns0:InputParameters>
};

declare variable $NumeroPrestamo as xs:string external;

xf:ConsultaPrestamoMigradoIn($NumeroPrestamo)