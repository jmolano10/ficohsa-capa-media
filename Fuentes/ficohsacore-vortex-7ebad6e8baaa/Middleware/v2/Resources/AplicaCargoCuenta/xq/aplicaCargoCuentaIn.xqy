xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$aplicaCargoCuenta" element="ns2:aplicaCargoCuenta" location="../xsd/aplicaCargoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/aplicaCargoCuenta/xsd/AplicaCargoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/aplicaCargoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AplicaCargoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AplicaCargoCuenta/xq/aplicaCargoCuentaIn/";

declare function xf:aplicaCargoCuentaIn($requestHeader as element(ns0:RequestHeader),
    $aplicaCargoCuenta as element(ns2:aplicaCargoCuenta))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_NUMERO_CUENTA>{ data($aplicaCargoCuenta/DEBIT_ACCOUNT) }</ns1:PN_NUMERO_CUENTA>
            {
                for $INTERFACE_REFERENCE_NO in $aplicaCargoCuenta/INTERFACE_REFERENCE_NO
                return
                    <ns1:PN_REFERENCIA_INTERFAZ>{ data($INTERFACE_REFERENCE_NO) }</ns1:PN_REFERENCIA_INTERFAZ>
            }
            <ns1:PN_MONTO>{ data($aplicaCargoCuenta/CHARGE_AMOUNT) }</ns1:PN_MONTO>
            <ns1:PV_CODIGO_TIPO_TRANSACCION>{ data($aplicaCargoCuenta/TRANSACTION_TYPE_CODE) }</ns1:PV_CODIGO_TIPO_TRANSACCION>
            <ns1:PV_USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:PV_USUARIO_SERVICIO>
            {
                for $DESCRIPTION in $aplicaCargoCuenta/DESCRIPTION
                return
                    <ns1:PV_DESCRIPCION>{ data($DESCRIPTION) }</ns1:PV_DESCRIPCION>
            }
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $aplicaCargoCuenta as element(ns2:aplicaCargoCuenta) external;

xf:aplicaCargoCuentaIn($requestHeader,
    $aplicaCargoCuenta)