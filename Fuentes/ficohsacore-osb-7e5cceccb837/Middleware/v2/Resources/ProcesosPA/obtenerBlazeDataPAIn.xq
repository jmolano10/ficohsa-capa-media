xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../BusinessServices/ProcesosPA/obtenerBlazeData/xsd/obtenerBlazeData_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosPA/xq/obtenerBlazeDataPAIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerBlazeData";

declare function search_criteria ($item as xs:string) as xs:integer {
	let $searchCriteria:=fn-bea:trim(fn:string($item))
	return
		if (upper-case($searchCriteria) = ('CARD_NUMBER'))then (
			1
		) else(0)
			
};

declare function xf:obtenerBlazeDataPAIn($numCuenta as xs:string,
    $tipo as xs:string,
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            <ns0:NumCuenta>{ fn-bea:pad-left($numCuenta, 19, '0') }</ns0:NumCuenta>
            <ns0:Tipo>{ fn:data(search_criteria(($tipo))) }</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $numCuenta as xs:string external;
declare variable $tipo as xs:string external;
declare variable $codigoPais as xs:string external;

xf:obtenerBlazeDataPAIn($numCuenta,
    $tipo,
    $codigoPais)