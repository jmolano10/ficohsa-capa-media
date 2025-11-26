(:: pragma bea:global-element-parameter parameter="$consultadecategoriaResponse" element="ns0:ConsultadecategoriaResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCuentaOCategoriaResponse" location="../../xsds/ConsultaCuentaOCategoria/ConsultaCuentaOCategoria.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaOCategoriaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCuentaOCategoria/ConsultaDeCategoriaOut/";

declare function xf:ConsultaDeCategoriaOut($consultadecategoriaResponse as element(ns0:ConsultadecategoriaResponse))
    as element(ns1:consultaCuentaOCategoriaResponse) {
        <ns1:consultaCuentaOCategoriaResponse>
            {
                for $ID in $consultadecategoriaResponse/WSCATEGORYLISTType[1]/gWSCATEGORYLISTDetailType/mWSCATEGORYLISTDetailType[1]/ID
                return
                    <ACCOUNT_NUMBER>{ data($ID) }</ACCOUNT_NUMBER>
            }
            {
                for $DESCRIPTION in $consultadecategoriaResponse/WSCATEGORYLISTType[1]/gWSCATEGORYLISTDetailType/mWSCATEGORYLISTDetailType[1]/DESCRIPTION
                return
                    <ACCOUNT_NAME>{ data($DESCRIPTION) }</ACCOUNT_NAME>
            }
        </ns1:consultaCuentaOCategoriaResponse>
};

declare variable $consultadecategoriaResponse as element(ns0:ConsultadecategoriaResponse) external;

xf:ConsultaDeCategoriaOut($consultadecategoriaResponse)