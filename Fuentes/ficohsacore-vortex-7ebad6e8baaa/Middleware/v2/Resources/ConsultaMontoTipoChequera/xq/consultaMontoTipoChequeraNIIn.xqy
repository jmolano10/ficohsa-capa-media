xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMontoTipoChequera" element="ns0:consultaMontoTipoChequera" location="../xsd/consultaMontoTipoChequeraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaComisionesSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTipoChequera/xq/consultaMontoTipoChequeraNIIn/";

declare function xf:consultaMontoTipoChequeraNIIn($consultaMontoTipoChequera as element(ns0:consultaMontoTipoChequera))
    as element(ns1:opConsultaComisionesSolicitud) {
        <ns1:opConsultaComisionesSolicitud>
            <ns2:contextoTransaccional>
                <ns2:codCanalOriginador>1</ns2:codCanalOriginador>
            </ns2:contextoTransaccional>
            <ns2:cuenta>
                <ns2:codCuentaHabiente>{ data($consultaMontoTipoChequera/ACCOUNT_NUMBER) }</ns2:codCuentaHabiente>
            </ns2:cuenta>
            <ns2:tipoTransaccion>CHECKBOOK</ns2:tipoTransaccion>
            <ns2:tipoACH>{ data($consultaMontoTipoChequera/CHECKBOOK_TYPE) }</ns2:tipoACH>
        </ns1:opConsultaComisionesSolicitud>
};

declare variable $consultaMontoTipoChequera as element(ns0:consultaMontoTipoChequera) external;

xf:consultaMontoTipoChequeraNIIn($consultaMontoTipoChequera)