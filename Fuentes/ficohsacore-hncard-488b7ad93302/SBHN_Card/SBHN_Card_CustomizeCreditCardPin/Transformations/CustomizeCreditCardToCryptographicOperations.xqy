xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/cryptographicOperationsTypes";
(:: import schema at "../Resources/cryptographicOperations.wsdl" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeCreditCardPin.xsd" ::)

declare variable $CustomizeCreditCardToCryptographicOperations as element() (:: schema-element(ns1:customizeCreditCardPin) ::) external;
declare variable $operationType as xs:string external;
declare variable $cipher as xs:string external;
declare variable $keyAlias as xs:string external;

declare function local:funcCustomizeCreditCardToCryptographicOperations($CustomizeCreditCardToCryptographicOperations as element() (:: schema-element(ns1:customizeCreditCardPin) ::),
                                                                         $operationType as xs:string,
                                                                       $cipher as xs:string,
                                                                       $keyAlias as xs:string) as element() (:: schema-element(ns2:processDataRequest) ::) {
    <ns2:processDataRequest>
        <operationType>{fn:data($operationType)}</operationType>
    <cipher>{fn:data($cipher)}</cipher>
    <keyAlias>{fn:data($keyAlias)}</keyAlias>
        <dataItems>
            <fieldItem>
                <value>{fn:data($CustomizeCreditCardToCryptographicOperations/Pin)}</value>
            </fieldItem>
        </dataItems>
    </ns2:processDataRequest>
};

local:funcCustomizeCreditCardToCryptographicOperations($CustomizeCreditCardToCryptographicOperations, $operationType, $cipher, $keyAlias)
