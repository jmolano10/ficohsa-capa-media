(:: pragma bea:global-element-return element="ns0:EmbosserUpdateR8V7Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/embosserUpdateR8V7In/";

declare function xf:embosserUpdateR8V7In($org as xs:string,
    $cardNumber as xs:string,
    $foreignUse as xs:string,
    $firstCardName as xs:string,
    $secondCardName as xs:string)
    as element(ns0:EmbosserUpdateR8V7Request) {
        <ns0:EmbosserUpdateR8V7Request>
            <ARXEUI-ORG>{ data($org) }</ARXEUI-ORG>
            <ARXEUI-CARD-NBR>{ data($cardNumber) }</ARXEUI-CARD-NBR>
            <ARXEUI-FOREIGN-USE>{ data($foreignUse) }</ARXEUI-FOREIGN-USE>
            <ARXEUI-EMBOSSED-NAME-1>{ data($firstCardName) }</ARXEUI-EMBOSSED-NAME-1>
            <ARXEUI-EMBOSSED-NAME-2>{ data($secondCardName) }</ARXEUI-EMBOSSED-NAME-2>
        </ns0:EmbosserUpdateR8V7Request>
};

declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $foreignUse as xs:string external;
declare variable $firstCardName as xs:string external;
declare variable $secondCardName as xs:string external;

xf:embosserUpdateR8V7In($org,
    $cardNumber,
    $foreignUse,
    $firstCardName,
    $secondCardName)