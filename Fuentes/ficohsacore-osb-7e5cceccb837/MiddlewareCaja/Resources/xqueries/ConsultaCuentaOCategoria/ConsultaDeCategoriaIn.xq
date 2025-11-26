(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentaOCategoria" element="ns1:consultaCuentaOCategoria" location="../../xsds/ConsultaCuentaOCategoria/ConsultaCuentaOCategoria.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecategoria" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaOCategoriaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCuentaOCategoria/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaCuentaOCategoria as element(ns1:consultaCuentaOCategoria))
    as element(ns0:Consultadecategoria) {
        <ns0:Consultadecategoria>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSCATEGORYLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ substring($consultaCuentaOCategoria/ACCOUNT_NUMBER, 3) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCATEGORYLISTType>
        </ns0:Consultadecategoria>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaCuentaOCategoria as element(ns1:consultaCuentaOCategoria) external;

xf:ConsultaDeDetallesDeLaCuentaIn($autenticacionRequestHeader,
    $consultaCuentaOCategoria)