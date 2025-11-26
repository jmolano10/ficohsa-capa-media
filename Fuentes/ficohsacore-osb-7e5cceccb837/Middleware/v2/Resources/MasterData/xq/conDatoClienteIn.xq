(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conDatoCliente/xsd/conDatoCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/conDatoClienteIn/";

declare function search_criteria ($item as xs:string) as xs:string {
	let $searchCriteria:=fn-bea:trim(fn:string($item))
		return
		if (upper-case($searchCriteria) = ('CARD_NUMBER','ACC_NUMBER'))then (
			'0'
		) else if (upper-case($searchCriteria) = 'CUSTOMER_ID') then(
			'1'
		)else('')
			
};
declare function xf:conDatoClienteIn($searchCriteria as xs:string,
    $searchValue as xs:string,
    $org as xs:string, $codigoPais as xs:string )
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{$codigoPais}</ns0:Pais>
            {
            	if($org != "")then(
            		<ns0:Org>{ $org }</ns0:Org>
            	)else()
            }
        	<ns0:Numero>{ fn-bea:pad-left($searchValue, 19, '0') }</ns0:Numero>
        	<ns0:Tipo>{ search_criteria($searchCriteria) }</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $searchCriteria as xs:string external;
declare variable $searchValue as xs:string external;
declare variable $org as xs:string external;
declare variable $codigoPais as xs:string external;

xf:conDatoClienteIn($searchCriteria,
    $searchValue,
    $org, $codigoPais)