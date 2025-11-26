(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/aplicaCargoCuenta/xsd/AplicaCargoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AplicaCargoCuenta";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/aplicaCargoCuentaGTIn/";

declare function xf:aplicaCargoCuentaGTIn($requestHeader as element(ns2:RequestHeader),
    $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito),
    $transactionType as xs:string,
    $secuenciaIdRetiro as xs:string,
    $descripcion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_NUMERO_CUENTA>{ xs:decimal(data($retiroTarjetaCredito/DISBURSEMENT[1]/VALUE)) }</ns0:PN_NUMERO_CUENTA>
            <ns0:PN_REFERENCIA_INTERFAZ>{ $secuenciaIdRetiro }</ns0:PN_REFERENCIA_INTERFAZ>
            <ns0:PN_MONTO>{ xs:decimal(data($retiroTarjetaCredito/AMOUNT)) }</ns0:PN_MONTO>
            <ns0:PV_CODIGO_TIPO_TRANSACCION>{ xs:decimal(data($transactionType)) }</ns0:PV_CODIGO_TIPO_TRANSACCION>
            <ns0:PV_USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns0:PV_USUARIO_SERVICIO>
            <ns0:PV_DESCRIPCION>{ $descripcion }</ns0:PV_DESCRIPCION>
        </ns0:InputParameters>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito) external;
declare variable $transactionType as xs:string external;
declare variable $secuenciaIdRetiro as xs:string external;
declare variable $descripcion as xs:string external;

xf:aplicaCargoCuentaGTIn($requestHeader,
    $retiroTarjetaCredito,
    $transactionType,
    $secuenciaIdRetiro,
    $descripcion)
