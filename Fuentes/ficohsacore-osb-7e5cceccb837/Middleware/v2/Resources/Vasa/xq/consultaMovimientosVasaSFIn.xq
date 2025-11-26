xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/VASA/ConsultaMovimientosVasaSF/xsd/ConsultaMovimientosVasaSF_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Vasa/consultaMovimientosVasaSFIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMovimientosVasaSF";

declare function xf:consultaMovimientosVasaSFIn($currentDate as xs:string, $transactionType as xs:string,
    $acount as xs:string)
    as element(ns0:InputParameters) {
          <ns0:InputParameters>
          {
	      	  if(data($currentDate) != "")then(
	      	  	<ns0:fechaConsulta>{ $currentDate }</ns0:fechaConsulta>
	      	  )else(
	      	  	<ns0:fechaConsulta/>
	      	  )
          }
          	<ns0:tipoConsulta>{ data($transactionType) }</ns0:tipoConsulta>
            <ns0:cuenta>{ data($acount) }</ns0:cuenta>
        </ns0:InputParameters>
};

declare variable $currentDate as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $acount as xs:string external;

xf:consultaMovimientosVasaSFIn($currentDate, $transactionType,
    $acount)
