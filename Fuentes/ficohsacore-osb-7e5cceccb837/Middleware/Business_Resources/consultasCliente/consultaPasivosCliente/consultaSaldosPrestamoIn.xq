(:: pragma bea:global-element-return element="ns0:consultaGeneralPrestamo" location="../../consultaGeneralPrestamo/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaSaldosPrestamoIn/";

declare function xf:consultaSaldosPrestamoIn($LOAN_NUMBER as xs:string)
    as element(ns0:consultaGeneralPrestamo) {
        <ns0:consultaGeneralPrestamo>
            <LOAN_ID>{ $LOAN_NUMBER }</LOAN_ID>
        </ns0:consultaGeneralPrestamo>
};

declare variable $LOAN_NUMBER as xs:string external;

xf:consultaSaldosPrestamoIn($LOAN_NUMBER)