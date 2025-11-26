(:: pragma bea:global-element-return element="ns0:consultaIntrasPorCuenta" location="../../../../../../Middleware/v2/Resources/ConsultaIntrasPorCuenta/xsd/consultaIntrasPorCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaIntrasPorCuentaTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/consultaIntrasPorCuentaGTIn/";

declare function xf:consultaIntrasPorCuentaGTIn($SEARCH_CRITERIA as xs:string,
    $SEARCH_VALUE as xs:string)
    as element(ns0:consultaIntrasPorCuenta) {
        <ns0:consultaIntrasPorCuenta>
            <SEARCH_VALUE>{ $SEARCH_VALUE }</SEARCH_VALUE>
            <SEARCH_CRITERIA>{ $SEARCH_CRITERIA }</SEARCH_CRITERIA>
        </ns0:consultaIntrasPorCuenta>
};

declare variable $SEARCH_CRITERIA as xs:string external;
declare variable $SEARCH_VALUE as xs:string external;

xf:consultaIntrasPorCuentaGTIn($SEARCH_CRITERIA,
    $SEARCH_VALUE)
