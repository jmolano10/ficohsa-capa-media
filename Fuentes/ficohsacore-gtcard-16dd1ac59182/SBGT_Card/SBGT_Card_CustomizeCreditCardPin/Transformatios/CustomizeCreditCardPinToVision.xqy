xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../Resources/VisionPlusService_1.wsdl" ::)
declare namespace ns1="https://www.ficohsa.com/guatemala/card";
(:: import schema at "../Schemas/CustomizeCreditCardPin.xsd" ::)

declare variable $CustomizeCreditCardPinToVision as element() (:: schema-element(ns1:customizeCreditCardPin) ::) external;
declare variable $PinBlock as xs:string external;
declare variable $logo as xs:string external;
declare variable $org as xs:string external;

declare function local:funcCustomizeCreditCardPinToVision($CustomizeCreditCardPinToVision as element() (:: schema-element(ns1:customizeCreditCardPin) ::),
                                                            $PinBlock as xs:string,
                                                            $logo as xs:string,
                                                            $org as xs:string) as element() (:: schema-element(ns2:PINReassignRequest) ::) {
    <ns2:PINReassignRequest>
        <ARXPAI-ORG>{fn:data($org)}</ARXPAI-ORG>
        <ARXPAI-LOGO>{fn:data($logo)}</ARXPAI-LOGO>
        <ARXPAI-CARD-NBR>{fn:data($CustomizeCreditCardPinToVision/CardNumber)}</ARXPAI-CARD-NBR>
        <ARXPAI-CURR-PIN-BLOCK>{fn:data($PinBlock)}</ARXPAI-CURR-PIN-BLOCK>
        <ARXPAI-CHANNEL>{'W'}</ARXPAI-CHANNEL>
        <ARXPAI-KEY-ASSOC>{' 12'}</ARXPAI-KEY-ASSOC>
    </ns2:PINReassignRequest>
};

local:funcCustomizeCreditCardPinToVision($CustomizeCreditCardPinToVision, $PinBlock, $logo, $org)