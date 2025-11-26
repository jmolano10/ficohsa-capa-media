(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta" element="ns1:pagoRemesaCreditoCuenta" location="pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validarCuenta" location="../../validacionCuenta/Resources/XMLSchema_-1002780568.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace ns0 = "http://ficohsa.com.hn/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaValidacionCuenta/";

declare function xf:pagoRemesaCreditoCuentaValidacionCuenta($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta), $validationType as xs:string)
    as element(ns0:validarCuenta) {
                        
        <ns0:validarCuenta>
            <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
            <password>{ data($autenticacionRequestHeader/Password) }</password>
            <accountNumber>{ data($pagoRemesaCreditoCuenta/ACCOUNT_NUMBER) }</accountNumber>
            <accountName> 
            {if ($validationType = "ACCONLY") then () else (data($pagoRemesaCreditoCuenta/BENEFICIARY_NAME)) }
            </accountName>
            <checkCancelled>NO</checkCancelled>            
        </ns0:validarCuenta>        
        
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta) external;
declare variable $validationType as xs:string external;


xf:pagoRemesaCreditoCuentaValidacionCuenta($autenticacionRequestHeader,
    $pagoRemesaCreditoCuenta, $validationType)