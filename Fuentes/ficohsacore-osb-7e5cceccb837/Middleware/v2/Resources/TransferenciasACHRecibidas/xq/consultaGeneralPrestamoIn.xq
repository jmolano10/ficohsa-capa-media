(:: pragma bea:global-element-return element="ns0:consultaGeneralPrestamo" location="../../ConsultaGeneralPrestamo/xsd/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamoACHRecibida/xq/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($loanId as xs:string)
    as element(ns0:consultaGeneralPrestamo) {
        <ns0:consultaGeneralPrestamo>
            <LOAN_ID>{ $loanId }</LOAN_ID>
        </ns0:consultaGeneralPrestamo>
};

declare variable $loanId as xs:string external;

xf:consultaGeneralPrestamoIn($loanId)