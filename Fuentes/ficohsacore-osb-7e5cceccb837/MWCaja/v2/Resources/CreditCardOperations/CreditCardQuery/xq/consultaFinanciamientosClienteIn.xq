(:: pragma bea:global-element-return element="ns0:consultaFinanciamientosCliente" location="../../../../../../Middleware/v2/Resources/ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/consultaFinanciamientosClienteIn/";

declare function xf:consultaFinanciamientosClienteIn($SEARCH_CRITERIA as xs:string,
    $SEARCH_VALUE as xs:string)
    as element(ns0:consultaFinanciamientosCliente) {
        <ns0:consultaFinanciamientosCliente>
            <SEARCH_VALUE>{ $SEARCH_VALUE }</SEARCH_VALUE>
            <SEARCH_CRITERIA>{ $SEARCH_CRITERIA }</SEARCH_CRITERIA>
        </ns0:consultaFinanciamientosCliente>
};

declare variable $SEARCH_CRITERIA as xs:string external;
declare variable $SEARCH_VALUE as xs:string external;

xf:consultaFinanciamientosClienteIn($SEARCH_CRITERIA,
    $SEARCH_VALUE)
