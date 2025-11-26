(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentaOCategoria" element="ns1:consultaCuentaOCategoria" location="../../xsds/ConsultaCuentaOCategoria/ConsultaCuentaOCategoria.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaOCategoriaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCuentaOCategoria/ConsultaDeCategoriaIn/";

declare function xf:ConsultaDeCategoriaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaCuentaOCategoria as element(ns1:consultaCuentaOCategoria))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaCuentaOCategoria/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaCuentaOCategoria as element(ns1:consultaCuentaOCategoria) external;

xf:ConsultaDeCategoriaIn($autenticacionRequestHeader,
    $consultaCuentaOCategoria)