xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
(:: import schema at "../Schemas/debitCardOperationServices.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeDebitCardPinTypes.xsd" ::)

declare variable $CustomizeDebitCardPinToDebitCardOperation as element() (:: schema-element(ns1:customizeDebitCardPin) ::) external;
declare variable $cryptographicKeyPinBlock as xs:string external;
declare variable $cryptographicKeyPVV as xs:string external;
declare variable $pvki as xs:string external;
declare variable $decryptedPin as xs:string external;
declare function local:funcCustomizeDebitCardPinToDebitCardOperation($CustomizeDebitCardPinToDebitCardOperation as element() (:: schema-element(ns1:customizeDebitCardPin) ::),
                                                                      $cryptographicKeyPinBlock as xs:string,
                                                                  $cryptographicKeyPVV as xs:string,
                                                                  $pvki as xs:string,
                                                                  $decryptedPin as xs:string) as element() (:: schema-element(ns2:setNewPinRequest) ::) {
    <ns2:setNewPinRequest>
        <cardNumber>{fn:data($CustomizeDebitCardPinToDebitCardOperation/CardNumber)}</cardNumber>
        <pin>{fn:data($decryptedPin)}</pin>
        <cryptographicKeyPinBlock>{fn:data($cryptographicKeyPinBlock)}</cryptographicKeyPinBlock>
        <cryptographicKeyPVV>{fn:data($cryptographicKeyPVV)}</cryptographicKeyPVV>
        <pvki>{fn:data($pvki)}</pvki>
    </ns2:setNewPinRequest>
};

local:funcCustomizeDebitCardPinToDebitCardOperation($CustomizeDebitCardPinToDebitCardOperation, $cryptographicKeyPinBlock, $cryptographicKeyPVV, $pvki, $decryptedPin)
