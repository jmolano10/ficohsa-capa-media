xquery version "2004-draft";
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

xf:validaProductoClienteDEPHNOut($consultadecertifdepositoResponse)