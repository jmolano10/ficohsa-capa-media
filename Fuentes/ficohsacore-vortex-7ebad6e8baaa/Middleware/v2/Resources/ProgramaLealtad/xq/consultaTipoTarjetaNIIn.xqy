xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:sjConsultaTipoTarjeta" location="../../../BusinessServices/SJS/consultaTipoTarjetaNI/xsd/sjConsultaTipoTarjetaNI.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjetaNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/consultaTipoTarjetaNIIn/";

declare function xf:consultaTipoTarjetaNIIn($cardNumber as xs:integer,
    $operation as xs:string)
    as element(ns0:sjConsultaTipoTarjeta) {
        <ns0:sjConsultaTipoTarjeta>
            <ns0:CARD_NUMBER>{ $cardNumber }</ns0:CARD_NUMBER>
            <ns0:OPERATION>{ $operation }</ns0:OPERATION>
        </ns0:sjConsultaTipoTarjeta>
};

declare variable $cardNumber as xs:integer external;
declare variable $operation as xs:string external;

xf:consultaTipoTarjetaNIIn($cardNumber,
    $operation)