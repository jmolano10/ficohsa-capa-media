(:: pragma bea:global-element-return element="ns0:consultaTransaccionACH" location="../../ConsultaTransaccionACH/xsd/consultaTransaccionACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/consultaTransaccionACHIn/";

declare function xf:consultaTransaccionACHIn($transactionType as xs:string,
    $transactionCurrency as xs:string,
    $searchCriteria as xs:string,
    $searchValue as xs:string,
    $sequencyT24 as xs:string,
    $updatedBackendYesNo as xs:string)
    as element(ns0:consultaTransaccionACH) {
        <ns0:consultaTransaccionACH>
            <TRANSACTION_TYPE>{ $transactionType }</TRANSACTION_TYPE>
            <TRANSACTION_CURRENCY>{ $transactionCurrency }</TRANSACTION_CURRENCY>
            <SEARCH_CRITERIA>{ $searchCriteria }</SEARCH_CRITERIA>
            <SEARCH_VALUE>{ $searchValue }</SEARCH_VALUE>
            <SEQUENCY_T24>{ $sequencyT24 }</SEQUENCY_T24>
            <UPDATE_BACKEND_YES_NO>{ $updatedBackendYesNo }</UPDATE_BACKEND_YES_NO>
        </ns0:consultaTransaccionACH>
};

declare variable $transactionType as xs:string external;
declare variable $transactionCurrency as xs:string external;
declare variable $searchCriteria as xs:string external;
declare variable $searchValue as xs:string external;
declare variable $sequencyT24 as xs:string external;
declare variable $updatedBackendYesNo as xs:string external;

xf:consultaTransaccionACHIn($transactionType,
    $transactionCurrency,
    $searchCriteria,
    $searchValue,
    $sequencyT24,
    $updatedBackendYesNo)
