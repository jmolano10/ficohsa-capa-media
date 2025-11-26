(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cancelacionCuentaAhorros" element="ns1:cancelacionCuentaAhorros" location="../../xsds/CancelacionCuentaAhorros/CancelacionCuentaAhorros.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelacionCuentaAhorrosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/ConsultaIDCuentaIn/";

declare function xf:ConsultaIDCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $cancelacionCuentaAhorros as element(ns1:cancelacionCuentaAhorros))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($cancelacionCuentaAhorros/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $cancelacionCuentaAhorros as element(ns1:cancelacionCuentaAhorros) external;

xf:ConsultaIDCuentaIn($autenticacionRequestHeader,
    $cancelacionCuentaAhorros)