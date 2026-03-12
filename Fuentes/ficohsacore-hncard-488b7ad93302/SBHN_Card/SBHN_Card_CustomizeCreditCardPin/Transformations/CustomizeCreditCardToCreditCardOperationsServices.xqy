xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/schema/creditCardOperationTypes";
(:: import schema at "../Resources/creditCardOperationsServices.wsdl" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeCreditCardPin.xsd" ::)

declare variable $CustomizeCreditCardToCreditCardOperationsServices as element() (:: schema-element(ns1:customizeCreditCardPin) ::) external;
declare variable $cryptographicKeyPinBlock as xs:string external;
declare variable $decryptedPin as xs:string external;

declare function local:funcCustomizeCreditCardToCreditCardOperationsServices($CustomizeCreditCardToCreditCardOperationsServices as element() (:: schema-element(ns1:customizeCreditCardPin) ::),
                                                                                $cryptographicKeyPinBlock as xs:string,
                                                                                $decryptedPin as xs:string) as element() (:: schema-element(ns2:setNewPinRequest) ::) {
    <ns2:setNewPinRequest>
        <cardNumber>{fn:data($CustomizeCreditCardToCreditCardOperationsServices/CardNumber)}</cardNumber>
        <pin>{fn:data($decryptedPin)}</pin>
        <cryptographicKeyPinBlock>{fn:data($cryptographicKeyPinBlock)}</cryptographicKeyPinBlock>
    </ns2:setNewPinRequest>
};

local:funcCustomizeCreditCardToCreditCardOperationsServices($CustomizeCreditCardToCreditCardOperationsServices, $cryptographicKeyPinBlock, $decryptedPin)
