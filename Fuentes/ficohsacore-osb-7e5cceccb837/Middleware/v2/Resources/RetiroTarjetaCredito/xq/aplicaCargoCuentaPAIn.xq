(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns2:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/AplicaCargoCuenta/xsd/AplicaCargoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AplicaCargoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/aplicaCargoPAIn/";

declare function xf:aplicaCargoPAIn($requestHeader as element(ns0:RequestHeader),
    $retiroTarjetaCredito as element(ns2:retiroTarjetaCredito),
    $transactionType as xs:string,
    $secuenciaIdRetiro as xs:string,
    $descripcion as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_NUMERO_CUENTA>{ data($retiroTarjetaCredito/DISBURSEMENT/VALUE) }</ns1:PN_NUMERO_CUENTA>
            <ns1:PN_REFERENCIA_INTERFAZ>{ data($secuenciaIdRetiro) }</ns1:PN_REFERENCIA_INTERFAZ>
            <ns1:PN_MONTO>{ data($retiroTarjetaCredito/AMOUNT) }</ns1:PN_MONTO>
            <ns1:PV_CODIGO_TIPO_TRANSACCION>{ xs:decimal(data($transactionType)) }</ns1:PV_CODIGO_TIPO_TRANSACCION>
            <ns1:PV_USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:PV_USUARIO_SERVICIO>
            <ns1:PV_DESCRIPCION>{ $descripcion }</ns1:PV_DESCRIPCION>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $retiroTarjetaCredito as element(ns2:retiroTarjetaCredito) external;
declare variable $transactionType as xs:string external;
declare variable $secuenciaIdRetiro as xs:string external;
declare variable $descripcion as xs:string external;

xf:aplicaCargoPAIn($requestHeader,
    $retiroTarjetaCredito,
    $transactionType,
    $secuenciaIdRetiro,
    $descripcion)
