(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validacionCuenta" element="ns1:validacionCuenta" location="validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validarCuenta" location="../Resources/XMLSchema_-1002780568.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://ficohsa.com.hn/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaIn/";

declare function xf:validacionCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $validacionCuenta as element(ns1:validacionCuenta))
    as element(ns0:validarCuenta) {
        <ns0:validarCuenta>
            <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
            <password>{ data($autenticacionRequestHeader/Password) }</password>
            <accountNumber>{ data($validacionCuenta/ACCOUNT_NUMBER) }</accountNumber>
            {
                for $ACCOUNT_NAME in $validacionCuenta/ACCOUNT_NAME
                return
                    <accountName>{ data($ACCOUNT_NAME) }</accountName>
            }
            <checkCancelled>{ data($validacionCuenta/CHECK_CANCELLED_YES_NO) }</checkCancelled>
        </ns0:validarCuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $validacionCuenta as element(ns1:validacionCuenta) external;

xf:validacionCuentaIn($autenticacionRequestHeader,
    $validacionCuenta)