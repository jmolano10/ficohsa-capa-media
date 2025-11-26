(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCuentaOCategoriaResponse" location="../../xsds/ConsultaCuentaOCategoria/ConsultaCuentaOCategoria.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaOCategoriaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCuentaOCategoria/ConsultaDeDetallesDeLaCuentaOut/";

declare function xf:ConsultaDeDetallesDeLaCuentaOut($consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:consultaCuentaOCategoriaResponse) {
        <ns1:consultaCuentaOCategoriaResponse>
            {
                for $ID in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID
                return
                    <ACCOUNT_NUMBER>{ data($ID) }</ACCOUNT_NUMBER>
            }
            {
                for $SHORTTITLE in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
                return
                    <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
            }
        </ns1:consultaCuentaOCategoriaResponse>
};

declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:ConsultaDeDetallesDeLaCuentaOut($consultadedetallesdelacuentaResponse)