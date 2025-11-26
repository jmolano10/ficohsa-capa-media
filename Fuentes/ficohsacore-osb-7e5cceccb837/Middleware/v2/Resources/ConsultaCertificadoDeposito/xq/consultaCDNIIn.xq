(:: pragma bea:global-element-parameter parameter="$consultaCertificadoDeposito1" element="ns2:consultaCertificadoDeposito" location="../../../../Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opBuscarCertificadoDPFSolicitud" location="../../../BusinessServices/CTS/deposito/xsd/services.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace ns1 = "http://service.srvaplcobiscertificadodeposito.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCertificadoDeposito/xq/consultaCDNIIn/";

declare function xf:consultaCDNIIn($consultaCertificadoDeposito1 as element(ns2:consultaCertificadoDeposito))
    as element(ns1:opBuscarCertificadoDPFSolicitud) {
        <ns1:opBuscarCertificadoDPFSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
                <ns0:codCuentaHabiente>{ data($consultaCertificadoDeposito1/DEPOSIT_NUMBER) }</ns0:codCuentaHabiente>
            </ns0:cuenta>
        </ns1:opBuscarCertificadoDPFSolicitud>
};

declare variable $consultaCertificadoDeposito1 as element(ns2:consultaCertificadoDeposito) external;

xf:consultaCDNIIn($consultaCertificadoDeposito1)