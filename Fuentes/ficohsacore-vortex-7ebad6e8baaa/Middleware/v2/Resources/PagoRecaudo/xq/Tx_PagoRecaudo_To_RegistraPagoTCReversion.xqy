xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registraPagoTCRequest" location="../../RegistraPagoTC/xsd/RegistraPagoTC.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/Tx_PagoRecaudo_To_RegistraPagoTCAuthorization/";

declare function xf:Tx_PagoRecaudo_To_RegistraPagoTCAuthorization($pagoRecaudo1 as element(ns1:pagoRecaudo),
    $contractName as xs:string,
    $userName as xs:string,
    $transactionType as xs:string,
    $ORG as xs:string,
    $SEQ as xs:string,
    $paymentTypeValue as xs:string)
    as element(ns0:registraPagoTCRequest) {
        <ns0:registraPagoTCRequest>
            <CREDIT_CARD>{ data($pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CREDIT_CARD>
            <EXPIRATION_DATE>{ data($pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE) }</EXPIRATION_DATE>
            {
             if ($pagoRecaudo1/DESCRIPTION='' or count($pagoRecaudo1/DESCRIPTION/text())=0)
            then
            <DESCRIPTION>{ $contractName }</DESCRIPTION>
            else
            <DESCRIPTION>{ data($pagoRecaudo1/DESCRIPTION) }</DESCRIPTION>
            }
            <TRANSACTION_TYPE>{ $transactionType }</TRANSACTION_TYPE>
            <PAYMENT_AMOUNT>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
            <CURRENCY>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</CURRENCY>
            <USERNAME>{ $userName }</USERNAME>
            <SECUENCIAL_NUMBER>{$SEQ}</SECUENCIAL_NUMBER>
            <ORG>{ $ORG }</ORG>
            <PAYMENT_TYPE>{$paymentTypeValue}</PAYMENT_TYPE>
        </ns0:registraPagoTCRequest>
};

declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $contractName as xs:string external;
declare variable $userName as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $ORG as xs:string external;
declare variable $SEQ as xs:string external;
declare variable $paymentTypeValue as xs:string external;

xf:Tx_PagoRecaudo_To_RegistraPagoTCAuthorization($pagoRecaudo1,
    $contractName,
    $userName,
    $transactionType,
    $ORG,
    $SEQ,
    $paymentTypeValue)