(:: pragma bea:global-element-parameter parameter="$ecs" element="ns1:ecs" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:operacionesTCDesdeOccidente" location="../../xsds/OperacionesTCDesdeOccidente/XMLSchema_1247111820.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTCDesdeOccidenteTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/pagoTarjetaCreditoProxyCitiBodyInEcs/";

declare function xf:pagoTarjetaCreditoProxyCitiBodyInEcs($reqType as xs:string,
    $debitAccount as xs:string,
    $ecs as element(ns1:ecs))
    as element(ns0:operacionesTCDesdeOccidente) {
        <ns0:operacionesTCDesdeOccidente>
            <REQUEST_TYPE>{ $reqType }</REQUEST_TYPE>
            <CREDIT_CARD_NUMBER>{ data($ecs/ns1:numero_cuenta) }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY>{ data($ecs/ns1:moneda) }</BALANCE_CURRENCY>
            {
                for $moneda in $ecs/ns1:moneda
                return
                    <TRANSACTION_CURRENCY>{ data($moneda) }</TRANSACTION_CURRENCY>
            }
            <PAYMENT_AMOUNT>{ data($ecs/ns1:total) }</PAYMENT_AMOUNT>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            <CHANNEL_CODE></CHANNEL_CODE>
            <INTERFACE_REFERENCE_NO></INTERFACE_REFERENCE_NO>
        </ns0:operacionesTCDesdeOccidente>
};

declare variable $reqType as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $ecs as element(ns1:ecs) external;

xf:pagoTarjetaCreditoProxyCitiBodyInEcs($reqType,
    $debitAccount,
    $ecs)