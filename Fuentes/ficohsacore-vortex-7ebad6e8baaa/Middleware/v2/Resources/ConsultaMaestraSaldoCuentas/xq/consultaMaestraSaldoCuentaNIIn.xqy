xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldoCuenta" element="ns1:consultaMaestraSaldoCuenta" location="../xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaMaestraSaldosSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaNIIn/";

declare function xf:consultaMaestraSaldoCuentaNIIn($consultaMaestraSaldoCuenta as element(ns1:consultaMaestraSaldoCuenta))
    as element(ns2:opConsultaMaestraSaldosSolicitud) {
        <ns2:opConsultaMaestraSaldosSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
                <ns0:codCuentaHabiente>{ data($consultaMaestraSaldoCuenta/ACCOUNT_NUMBER) }</ns0:codCuentaHabiente>
            </ns0:cuenta>
        </ns2:opConsultaMaestraSaldosSolicitud>
};

declare variable $consultaMaestraSaldoCuenta as element(ns1:consultaMaestraSaldoCuenta) external;

xf:consultaMaestraSaldoCuentaNIIn($consultaMaestraSaldoCuenta)