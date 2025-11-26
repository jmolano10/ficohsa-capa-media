(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns2:pagoTarjetaCredito" location="../../PagoTarjetaCredito/xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v2/BusinessServices/ABKGT/aplicaCargoCuenta/xsd/AplicaCargoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AplicaCargoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/DebitosGTIn/";

declare function xf:DebitosGTIn($TransactionType as xs:string,
    $requestHeader as element(ns0:RequestHeader),
    $pagoTarjetaCredito as element(ns2:pagoTarjetaCredito))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_NUMERO_CUENTA>{ xs:integer($pagoTarjetaCredito/DEBIT_ACCOUNT) }</ns1:PN_NUMERO_CUENTA>
            {
                for $INTERFACE_REFERENCE_NO in $pagoTarjetaCredito/INTERFACE_REFERENCE_NO
                return
                    <ns1:PN_REFERENCIA_INTERFAZ>{ data($INTERFACE_REFERENCE_NO) }</ns1:PN_REFERENCIA_INTERFAZ>
            }
            <ns1:PN_MONTO>{ fn:number($pagoTarjetaCredito/PAYMENT_AMOUNT/text()) }</ns1:PN_MONTO>
            <ns1:PV_CODIGO_TIPO_TRANSACCION>{ xs:integer($TransactionType) }</ns1:PV_CODIGO_TIPO_TRANSACCION>
            <ns1:PV_USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:PV_USUARIO_SERVICIO>
            <ns1:PV_DESCRIPCION>{ fn:concat("Pago desde Guatemala a tarjeta de crédito No. ", $pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns1:PV_DESCRIPCION>
        </ns1:InputParameters>
};

declare variable $TransactionType as xs:string external;
declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCredito as element(ns2:pagoTarjetaCredito) external;

xf:DebitosGTIn($TransactionType,
    $requestHeader,
    $pagoTarjetaCredito)