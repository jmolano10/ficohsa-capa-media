xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:EmbosserUpdateR8V7Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaProductoTC/xq/embosserUpdateR8V7GTIn/";

declare function xf:embosserUpdateR8V7GTIn($org as xs:string,
    $cardNumber as xs:string,
    $productType as xs:string,
    $updateValue as xs:string)
    as element(ns0:EmbosserUpdateR8V7Request) {
        <ns0:EmbosserUpdateR8V7Request>
            <ARXEUI-ORG>{ data($org) }</ARXEUI-ORG>
            <ARXEUI-CARD-NBR>{ data($cardNumber) }</ARXEUI-CARD-NBR>
            <ARXEUI-CARD-SEQ>1</ARXEUI-CARD-SEQ>
            <ARXEUI-FOREIGN-USE>0</ARXEUI-FOREIGN-USE>
            {
              if ($productType = 'CEMACO') then(
              
              <ARXEUI-EMBOSSED-NAME-2>{ $updateValue }</ARXEUI-EMBOSSED-NAME-2>
              
              )elseif($productType = 'PRIORITY') then(
              
              <ARXEUI-USER-1>{ $updateValue }</ARXEUI-USER-1>
              
              )else()
            
            
            }
        </ns0:EmbosserUpdateR8V7Request>
};

declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $productType as xs:string external;
declare variable $updateValue as xs:string external;

xf:embosserUpdateR8V7GTIn($org,
    $cardNumber,
    $productType,$updateValue)