xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:opConsultaMaestraSaldosSolicitud" location="../../../CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaMaestraSaldoCuentaIn/";

declare function xf:consultaMaestraSaldoCuentaIn($productID as xs:string)
    as element(ns1:opConsultaMaestraSaldosSolicitud) {
        <ns1:opConsultaMaestraSaldosSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
                <ns0:codCuentaHabiente>{ $productID }</ns0:codCuentaHabiente>
            </ns0:cuenta>
        </ns1:opConsultaMaestraSaldosSolicitud>
};

declare variable $productID as xs:string external;

xf:consultaMaestraSaldoCuentaIn($productID)