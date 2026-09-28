(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns0:consultaGeneralPrestamo" location="../xsd/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaCertificadoDeposito/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($consultaGeneralPrestamo1/LOAN_ID) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo) external;

xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1)