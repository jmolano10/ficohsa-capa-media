(:: pragma bea:global-element-return element="ns0:consultaExtrafinanciamientoDisponible" location="../../../../../../Middleware/v2/Resources/ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/consultaExtrafinanciamientoDisponibleGTIn/";

declare function xf:consultaExtrafinanciamientoDisponibleGTIn($SEARCH_CRITERIA as xs:string,
    $SEARCH_VALUE as xs:string)
    as element(ns0:consultaExtrafinanciamientoDisponible) {
        <ns0:consultaExtrafinanciamientoDisponible>
            <SEARCH_VALUE>{ $SEARCH_VALUE }</SEARCH_VALUE>
            <SEARCH_CRITERIA>{ $SEARCH_CRITERIA }</SEARCH_CRITERIA>
        </ns0:consultaExtrafinanciamientoDisponible>
};

declare variable $SEARCH_CRITERIA as xs:string external;
declare variable $SEARCH_VALUE as xs:string external;

xf:consultaExtrafinanciamientoDisponibleGTIn($SEARCH_CRITERIA,
    $SEARCH_VALUE)
