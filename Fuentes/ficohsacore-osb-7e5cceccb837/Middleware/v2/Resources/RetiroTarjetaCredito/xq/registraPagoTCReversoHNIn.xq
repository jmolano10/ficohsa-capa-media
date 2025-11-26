(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito1" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registraPagoTCRequest" location="../../RegistraPagoTC/xsd/RegistraPagoTC.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/registraPagoTCHNIn/";

declare function xf:registraPagoTCHNIn($retiroTarjetaCredito1 as element(ns1:retiroTarjetaCredito),
    $paymentType as xs:string,
    $withdrawalDesc as xs:string,
    $transactionType as xs:string,
    $userName as xs:string,
    $org as xs:string,
    $SEQ as xs:string)
    as element(ns0:registraPagoTCRequest) {
        <ns0:registraPagoTCRequest>
            <CREDIT_CARD>{ data($retiroTarjetaCredito1/CREDIT_CARD_INFO/VALUE) }</CREDIT_CARD>
            <EXPIRATION_DATE>{ data($retiroTarjetaCredito1/CREDIT_CARD_INFO/EXPIRATION_DATE) }</EXPIRATION_DATE>
            <DESCRIPTION>{ $withdrawalDesc }</DESCRIPTION>
            <TRANSACTION_TYPE>{ $transactionType }</TRANSACTION_TYPE>
            <PAYMENT_AMOUNT>{ data($retiroTarjetaCredito1/AMOUNT) }</PAYMENT_AMOUNT>
            <CURRENCY>{ data($retiroTarjetaCredito1/CURRENCY) }</CURRENCY>
            <USERNAME>{ $userName }</USERNAME>
            <SECUENCIAL_NUMBER>{ $SEQ }</SECUENCIAL_NUMBER>
            <ORG>{ $org }</ORG>
            <PAYMENT_TYPE>{ $paymentType }</PAYMENT_TYPE>
        </ns0:registraPagoTCRequest>
};

declare variable $retiroTarjetaCredito1 as element(ns1:retiroTarjetaCredito) external;
declare variable $paymentType as xs:string external;
declare variable $withdrawalDesc as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $userName as xs:string external;
declare variable $org as xs:string external;
declare variable $SEQ as xs:string external;

xf:registraPagoTCHNIn($retiroTarjetaCredito1,
    $paymentType,
    $withdrawalDesc,
    $transactionType,
    $userName,
    $org,
    $SEQ)