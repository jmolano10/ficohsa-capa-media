<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/obtenerBlazeData/xsd/obtenerBlazeData_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerBlazeData";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/obtenerBlazeDataIn/";

declare function search_criteria ($item as xs:string) as xs:integer {
	let $searchCriteria:=fn-bea:trim(fn:string($item))
	return
		if (upper-case($searchCriteria) = ('CARD_NUMBER'))then (
			1
		) else(0)
			
};

declare function xf:obtenerBlazeDataIn($numCuenta as xs:string,
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

xf:obtenerBlazeDataIn($numCuenta,
    $tipo,
    $codigoPais)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterData/obtenerBlazeData/xsd/obtenerBlazeData_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterData/obtenerBlazeData/xsd/obtenerBlazeData_sp"/>
    </con:dependency>
</con:xqueryEntry>