xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaTasaCambio" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ConsultaTasaCambioIn/";

declare function xf:ConsultaTasaCambioIn($SOURCE as xs:string,
    $TARGET as xs:string)
    as element(ns0:consultaTasaCambio) {
        <ns0:consultaTasaCambio>
            <SOURCE_CURRENCY>{ $SOURCE }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ $TARGET }</TARGET_CURRENCY>
        </ns0:consultaTasaCambio>
};

declare variable $SOURCE as xs:string external;
declare variable $TARGET as xs:string external;

xf:ConsultaTasaCambioIn($SOURCE,
    $TARGET)