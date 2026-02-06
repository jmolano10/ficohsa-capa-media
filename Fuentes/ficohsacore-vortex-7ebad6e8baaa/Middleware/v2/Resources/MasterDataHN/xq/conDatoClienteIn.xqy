xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataHN/conDatoCliente/xsd/conDatoCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conDatoClienteIn/";

declare function xf:conDatoClienteIn($searchValue as xs:string,
    $searchCriteria as xs:string,
    $org as xs:string,
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            {
            	if($org != "")then(
            		<ns0:Org>{ $org }</ns0:Org>
            	)else()
            }
            <ns0:Numero>{ fn-bea:pad-left($searchValue, 19, '0') }</ns0:Numero>
            <ns0:Tipo>{ $searchCriteria }</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $searchValue as xs:string external;
declare variable $searchCriteria as xs:string external;
declare variable $org as xs:string external;
declare variable $codigoPais as xs:string external;

xf:conDatoClienteIn($searchValue,
    $searchCriteria,
    $org,
    $codigoPais)