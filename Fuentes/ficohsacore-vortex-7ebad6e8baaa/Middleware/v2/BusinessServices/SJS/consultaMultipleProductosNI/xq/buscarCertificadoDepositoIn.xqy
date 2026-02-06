xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:opBuscarCertificadoDPFSolicitud" location="../../../CTS/deposito/xsd/services.xsd" ::)

declare namespace ns1 = "http://service.srvaplcobiscertificadodeposito.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/buscarCertificadoDepositoIn/";

declare function xf:buscarCertificadoDepositoIn($productID as xs:string)
    as element(ns1:opBuscarCertificadoDPFSolicitud) {
        <ns1:opBuscarCertificadoDPFSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
                <ns0:codCuentaHabiente>{ $productID }</ns0:codCuentaHabiente>
            </ns0:cuenta>
        </ns1:opBuscarCertificadoDPFSolicitud>
};

declare variable $productID as xs:string external;

xf:buscarCertificadoDepositoIn($productID)