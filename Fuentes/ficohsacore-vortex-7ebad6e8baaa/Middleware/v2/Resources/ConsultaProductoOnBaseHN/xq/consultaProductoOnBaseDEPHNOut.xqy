xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadecertifdepositoResponse" element="ns0:ConsultadecertifdepositoResponse" location="../../../../Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaProductoOnBaseResponse" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseDEPHNOut/";

declare function xf:consultaProductoOnBaseDEPHNOut($consultadecertifdepositoResponse as element(ns0:ConsultadecertifdepositoResponse))
    as element(ns1:consultaProductoOnBaseResponse) {
        <ns1:consultaProductoOnBaseResponse>
            <PRODUCT_NAME>{ data($consultadecertifdepositoResponse/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/DEPOSITNAME) }</PRODUCT_NAME>
            <CURRENCY>{ data($consultadecertifdepositoResponse/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/CURRENCY) }</CURRENCY>
        </ns1:consultaProductoOnBaseResponse>
};

declare variable $consultadecertifdepositoResponse as element(ns0:ConsultadecertifdepositoResponse) external;

xf:consultaProductoOnBaseDEPHNOut($consultadecertifdepositoResponse)