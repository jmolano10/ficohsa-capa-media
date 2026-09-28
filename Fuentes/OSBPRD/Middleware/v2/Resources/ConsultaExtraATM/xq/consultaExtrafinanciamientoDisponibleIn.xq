(:: pragma bea:local-element-parameter parameter="$CreditCards1" type="ns1:consultaTarjetasCreditoPorClienteResponse/CREDIT_CARDS" location="../../ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaExtrafinanciamientoDisponible" location="../../ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtraATM/xq/consultaExtrafinanciamientoDisponibleIn/";

declare function xf:consultaExtrafinanciamientoDisponibleIn(
$creditCardNumber as xs:string
)
    as element(ns0:consultaExtrafinanciamientoDisponible) {
        <ns0:consultaExtrafinanciamientoDisponible>
            <SEARCH_VALUE>{ $creditCardNumber }</SEARCH_VALUE>
            <SEARCH_CRITERIA>CARD_NUMBER</SEARCH_CRITERIA>
        </ns0:consultaExtrafinanciamientoDisponible>
};

declare variable $creditCardNumber as xs:string external;

xf:consultaExtrafinanciamientoDisponibleIn($creditCardNumber)