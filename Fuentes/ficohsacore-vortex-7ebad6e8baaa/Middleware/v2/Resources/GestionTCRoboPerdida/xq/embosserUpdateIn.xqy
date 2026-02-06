xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:EmbosserUpdateRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionTCRoboPerdida/xq/embosserUpdateIn/";

declare function xf:embosserUpdateIn($org as xs:string,
    $numTarjeta as xs:string,
    $razonBloqueo as xs:string)
    as element(ns0:EmbosserUpdateRequest) {
        <ns0:EmbosserUpdateRequest>
            <ARXEUI-ORG>{ data($org) }</ARXEUI-ORG>
            <ARXEUI-CARD-NBR>{ data($numTarjeta) }</ARXEUI-CARD-NBR>
            <ARXEUI-FOREIGN-USE>0</ARXEUI-FOREIGN-USE>
            <ARXEUI-USER-4>{ data($razonBloqueo) }</ARXEUI-USER-4>
        </ns0:EmbosserUpdateRequest>
};

declare variable $org as xs:string external;
declare variable $numTarjeta as xs:string external;
declare variable $razonBloqueo as xs:string external;

xf:embosserUpdateIn($org,
    $numTarjeta,
    $razonBloqueo)