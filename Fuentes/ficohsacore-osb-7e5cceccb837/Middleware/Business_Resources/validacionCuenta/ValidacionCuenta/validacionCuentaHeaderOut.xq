(:: pragma bea:global-element-parameter parameter="$validarCuentaResponse" element="ns0:validarCuentaResponse" location="../Resources/XMLSchema_-1002780568.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://ficohsa.com.hn/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaHeaderOut/";

declare function xf:validacionCuentaHeaderOut($validarCuentaResponse as element(ns0:validarCuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $statusIndicator in $validarCuentaResponse/return/statusIndicator
                return
                    <successIndicator>{ data($statusIndicator) }</successIndicator>
            }
            {
                for $errorMessage in $validarCuentaResponse/return/errorMessage
                return
                    <messages>{ data($errorMessage) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $validarCuentaResponse as element(ns0:validarCuentaResponse) external;

xf:validacionCuentaHeaderOut($validarCuentaResponse)