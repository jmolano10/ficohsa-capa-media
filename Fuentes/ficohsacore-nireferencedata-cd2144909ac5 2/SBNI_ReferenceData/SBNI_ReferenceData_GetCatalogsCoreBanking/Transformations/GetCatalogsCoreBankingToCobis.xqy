xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCatalogosCobis";
(:: import schema at "../Schemas/ConsultaCatalogosCobis_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/nicaragua/referenceData";
(:: import schema at "../Schemas/GetCatalogsCoreBankingTypes.xsd" ::)

declare variable $getCatalogsCorebanking as element() (:: schema-element(ns1:getCatalogsCoreBanking) ::) external;

declare function local:func($getCatalogsCorebanking as element() (:: schema-element(ns1:getCatalogsCoreBanking) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:i_canal>{xs:int($getCatalogsCorebanking/Channel)}</ns2:i_canal>
        <ns2:i_operacion>{fn:data($getCatalogsCorebanking/Operation)}</ns2:i_operacion>
        {
            if ($getCatalogsCorebanking/Condition1)
            then <ns2:i_cond1>{fn:data($getCatalogsCorebanking/Condition1)}</ns2:i_cond1>
            else ()
        }
        {
            if ($getCatalogsCorebanking/Condition2)
            then <ns2:i_cond2>{fn:data($getCatalogsCorebanking/Condition2)}</ns2:i_cond2>
            else ()
        }
        {
            if ($getCatalogsCorebanking/Condition3)
            then <ns2:i_cond3>{fn:data($getCatalogsCorebanking/Condition3)}</ns2:i_cond3>
            else ()
        }
        {
            if ($getCatalogsCorebanking/Condition4)
            then <ns2:i_cond4>{fn:data($getCatalogsCorebanking/Condition4)}</ns2:i_cond4>
            else ()
        }
        {
            if ($getCatalogsCorebanking/GeneralInfo/TransactionDate)
            then <ns2:i_transaction_date>{fn:data($getCatalogsCorebanking/GeneralInfo/TransactionDate)}</ns2:i_transaction_date>
            else ()
        }
    </ns2:InputParameters>
};

local:func($getCatalogsCorebanking)