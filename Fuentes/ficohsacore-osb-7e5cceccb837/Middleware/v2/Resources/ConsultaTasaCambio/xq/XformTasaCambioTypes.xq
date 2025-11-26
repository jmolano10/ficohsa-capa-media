(:: pragma bea:global-element-return element="ns0:consultaTasaCambio" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambio/xq/XformTasaCambioTypes/";

declare function xf:XformTasaCambioTypes($SOURCE_CURRENCY as xs:string,
    $TARGET_CURRENCY as xs:string)
    as element(ns0:consultaTasaCambio) {
        <ns0:consultaTasaCambio>
            <SOURCE_CURRENCY>{ $SOURCE_CURRENCY }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ $TARGET_CURRENCY }</TARGET_CURRENCY>
        </ns0:consultaTasaCambio>
};

declare variable $SOURCE_CURRENCY as xs:string external;
declare variable $TARGET_CURRENCY as xs:string external;

xf:XformTasaCambioTypes($SOURCE_CURRENCY,
    $TARGET_CURRENCY)
