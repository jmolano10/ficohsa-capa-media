(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/consultarPtmoMigrado/xsd/consultarPtmoMigrado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarPtmoMigrado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaPrestamoMigrado/";

declare function xf:consultaPrestamoMigrado($NumerPrestamo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_PRESTAMO>{ $NumerPrestamo }</ns0:PV_NUMERO_PRESTAMO>
        </ns0:InputParameters>
};

declare variable $NumerPrestamo as xs:string external;

xf:consultaPrestamoMigrado($NumerPrestamo)