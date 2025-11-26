(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../../../../../Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/consultaDatosTarjetaCreditoGTIn/";

declare function xf:consultaDatosTarjetaCreditoGTIn($CARD_NUMBER as xs:string,
    $ORG as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        <ns0:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ $CARD_NUMBER }</CARD_NUMBER>
            <ORG>{ $ORG }</ORG>
        </ns0:consultaDatosTarjetaCredito>
};

declare variable $CARD_NUMBER as xs:string external;
declare variable $ORG as xs:string external;

xf:consultaDatosTarjetaCreditoGTIn($CARD_NUMBER,
    $ORG)
