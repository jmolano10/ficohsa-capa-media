(:: pragma bea:global-element-parameter parameter="$pagoROP" element="ns0:pagoROP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registraPagoTCRequest" location="../../RegistraPagoTC/xsd/RegistraPagoTC.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoROPDEI/xq/registraPagoTCIn/";

declare function xf:registraPagoTCIn($pagoROP as element(ns0:pagoROP),
    $contractName as xs:string,
    $userName as xs:string,
    $transactionType as xs:string,
    $ORG as xs:string,
    $paymentTypeValue as xs:string)
    as element(ns1:registraPagoTCRequest) {
        <ns1:registraPagoTCRequest>
            <CREDIT_CARD>{ data($pagoROP/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CREDIT_CARD>
            <EXPIRATION_DATE>{ data($pagoROP/PAYMENT_INFORMATION/EXPIRATION_DATE) }</EXPIRATION_DATE>
            <DESCRIPTION>{ $contractName }</DESCRIPTION>
            <TRANSACTION_TYPE>{ $transactionType }</TRANSACTION_TYPE>
            <PAYMENT_AMOUNT>{ data($pagoROP/TOTAL_PAYMENT) }</PAYMENT_AMOUNT>
            <CURRENCY>{ data($pagoROP/CURRENCY) }</CURRENCY>
            <USERNAME>{ $userName }</USERNAME>
            <ORG>{ $ORG }</ORG>
            <PAYMENT_TYPE>{ $paymentTypeValue }</PAYMENT_TYPE>
        </ns1:registraPagoTCRequest>
};

declare variable $pagoROP as element(ns0:pagoROP) external;
declare variable $contractName as xs:string external;
declare variable $userName as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $ORG as xs:string external;
declare variable $paymentTypeValue as xs:string external;

xf:registraPagoTCIn($pagoROP,
    $contractName,
    $userName,
    $transactionType,
    $ORG,
    $paymentTypeValue)