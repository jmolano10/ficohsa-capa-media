(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaProductoOnBaseResponse" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseCTAHNOut/";

declare function xf:consultaProductoOnBaseCTAHNOut($consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:consultaProductoOnBaseResponse) {
        <ns1:consultaProductoOnBaseResponse>
            <PRODUCT_NAME>{ data($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE) }</PRODUCT_NAME>
            <CURRENCY>{ data($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CURRENCY) }</CURRENCY>
            <OPENING_DATE>{ data($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/OPENINGDATE) }</OPENING_DATE>
        </ns1:consultaProductoOnBaseResponse>
};

declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaProductoOnBaseCTAHNOut($consultadedetallesdelacuentaResponse)