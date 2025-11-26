(:: pragma bea:global-element-parameter parameter="$consulta_cuenta_ECS" element="ns1:consulta_cuenta_ECS" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:operacionesTCDesdeOccidente" location="../../xsds/OperacionesTCDesdeOccidente/XMLSchema_1247111820.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTCDesdeOccidenteTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/pagoTarjetaCreditoProxyCitiBodyInConsulta/";

declare function xf:pagoTarjetaCreditoProxyCitiBodyInConsulta($reqType as xs:string,
    $consulta_cuenta_ECS as element(ns1:consulta_cuenta_ECS))
    as element(ns0:operacionesTCDesdeOccidente) {
        <ns0:operacionesTCDesdeOccidente>
            <REQUEST_TYPE>{ $reqType }</REQUEST_TYPE>
            <CREDIT_CARD_NUMBER>{ data($consulta_cuenta_ECS/ns1:numero_cuenta) }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY></BALANCE_CURRENCY>
            <TRANSACTION_CURRENCY></TRANSACTION_CURRENCY>
            <PAYMENT_AMOUNT></PAYMENT_AMOUNT>
            <DEBIT_ACCOUNT></DEBIT_ACCOUNT>
            <CHANNEL_CODE></CHANNEL_CODE>
            <INTERFACE_REFERENCE_NO></INTERFACE_REFERENCE_NO>
        </ns0:operacionesTCDesdeOccidente>
};

declare variable $reqType as xs:string external;
declare variable $consulta_cuenta_ECS as element(ns1:consulta_cuenta_ECS) external;

xf:pagoTarjetaCreditoProxyCitiBodyInConsulta($reqType,
    $consulta_cuenta_ECS)