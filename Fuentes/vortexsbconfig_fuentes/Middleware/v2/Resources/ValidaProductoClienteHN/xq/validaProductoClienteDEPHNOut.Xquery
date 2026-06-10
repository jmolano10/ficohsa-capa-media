<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadecertifdepositoResponse" element="ns0:ConsultadecertifdepositoResponse" location="../../../../Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClienteDEPHNOut/";

declare function xf:validaProductoClienteDEPHNOut($consultadecertifdepositoResponse as element(ns0:ConsultadecertifdepositoResponse))
    as element(ns1:validaProductoClienteResponse) {
        <ns1:validaProductoClienteResponse>
            <PRODUCT_NAME>{ data($consultadecertifdepositoResponse/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/DEPOSITNAME) }</PRODUCT_NAME>
            <CURRENCY>{ data($consultadecertifdepositoResponse/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/CURRENCY) }</CURRENCY>
        </ns1:validaProductoClienteResponse>
};

declare variable $consultadecertifdepositoResponse as element(ns0:ConsultadecertifdepositoResponse) external;

xf:validaProductoClienteDEPHNOut($consultadecertifdepositoResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080"/>
    </con:dependency>
    <con:dependency location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoCliente/xsd/validaProductoClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>