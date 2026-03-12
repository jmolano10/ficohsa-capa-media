xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../Resources/VisionPlusService_1.wsdl" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeCreditCardPin.xsd" ::)

declare variable $VisionToCustomizeCreditCardPin as element() (:: schema-element(ns1:PINReassignResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:funcVisionToCustomizeCreditCardPin($VisionToCustomizeCreditCardPin as element() (:: schema-element(ns1:PINReassignResponse) ::),
                                                            $globalId as xs:string) as element() (:: schema-element(ns2:customizeCreditCardPinResponse) ::) {
    <ns2:customizeCreditCardPinResponse>
    
        <StatusInfo>
          {if (fn:data($VisionToCustomizeCreditCardPin/ARXPAO-SVC-RETURN/text() = 'P')) then (<Status>{'SUCCESS'}</Status>) else ()}
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
    </ns2:customizeCreditCardPinResponse>
};

local:funcVisionToCustomizeCreditCardPin($VisionToCustomizeCreditCardPin, $globalId)
