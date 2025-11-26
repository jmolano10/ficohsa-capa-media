(:: pragma bea:global-element-parameter parameter="$validarCuentaResponse" element="ns0:validarCuentaResponse" location="../Resources/XMLSchema_-1002780568.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaResponse" location="validacionCuentaType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://ficohsa.com.hn/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaOut/";

declare function xf:validacionCuentaOut($validarCuentaResponse as element(ns0:validarCuentaResponse))
    as element(ns1:validacionCuentaResponse) {
        <ns1:validacionCuentaResponse>
            {
                for $accountNumber in $validarCuentaResponse/return/accountNumber
                return
                    <ACCOUNT_NUMBER>{ data($accountNumber) }</ACCOUNT_NUMBER>
            }
            {
                for $accountName in $validarCuentaResponse/return/accountName
                return
                    <ACCOUNT_NAME>{ data($accountName) }</ACCOUNT_NAME>
            }
            {
                for $currency in $validarCuentaResponse/return/currency
                return
                    <CURRENCY>{ data($currency) }</CURRENCY>
            }
            {
                for $accountStatus in $validarCuentaResponse/return/accountStatus
                return
                    <ACCOUNT_STATUS>{ data($accountStatus) }</ACCOUNT_STATUS>
            }
        </ns1:validacionCuentaResponse>
};

declare variable $validarCuentaResponse as element(ns0:validarCuentaResponse) external;

xf:validacionCuentaOut($validarCuentaResponse)