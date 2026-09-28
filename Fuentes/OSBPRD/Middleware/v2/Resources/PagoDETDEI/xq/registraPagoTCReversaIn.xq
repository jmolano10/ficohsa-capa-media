(:: pragma bea:global-element-parameter parameter="$pagoDET" element="ns0:pagoDET" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registraPagoTCRequest" location="../../RegistraPagoTC/xsd/RegistraPagoTC.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDETDEI/xq/registraPagoTCReversaIn/";

declare function xf:registraPagoTCReversaIn($pagoDET as element(ns0:pagoDET),
    $contractName as xs:string,
    $userName as xs:string,
    $transactionType as xs:string,
    $ORG as xs:string,
    $SEQ as xs:string,
    $paymentTypeValue as xs:string)
    as element(ns1:registraPagoTCRequest) {
        <ns1:registraPagoTCRequest>
            <CREDIT_CARD>{ data($pagoDET/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CREDIT_CARD>
            <EXPIRATION_DATE>{ data($pagoDET/PAYMENT_INFORMATION/EXPIRATION_DATE) }</EXPIRATION_DATE>
            <DESCRIPTION>{ $contractName }</DESCRIPTION>
            <TRANSACTION_TYPE>{ $transactionType }</TRANSACTION_TYPE>
            <PAYMENT_AMOUNT>{ data($pagoDET/TOTAL_PAYMENT) }</PAYMENT_AMOUNT>
            <CURRENCY>{ data($pagoDET/CURRENCY) }</CURRENCY>
            <USERNAME>{ $userName }</USERNAME>
            <SECUENCIAL_NUMBER>{ $SEQ }</SECUENCIAL_NUMBER>
            <ORG>{ $ORG }</ORG>
            <PAYMENT_TYPE>{ $paymentTypeValue }</PAYMENT_TYPE>
        </ns1:registraPagoTCRequest>
};

declare variable $pagoDET as element(ns0:pagoDET) external;
declare variable $contractName as xs:string external;
declare variable $userName as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $ORG as xs:string external;
declare variable $SEQ as xs:string external;
declare variable $paymentTypeValue as xs:string external;

xf:registraPagoTCReversaIn($pagoDET,
    $contractName,
    $userName,
    $transactionType,
    $ORG,
    $SEQ,
    $paymentTypeValue)