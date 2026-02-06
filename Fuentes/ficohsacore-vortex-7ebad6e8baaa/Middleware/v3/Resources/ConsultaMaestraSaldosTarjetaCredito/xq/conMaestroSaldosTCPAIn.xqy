xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/ProcesosPA/conMaestroSaldos/xsd/ConsultaMaestroSaldosTarjetaCredito_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/conMaestroSaldosTCPAIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMaestroSaldosTarjetaCredito";

declare function xf:conMaestroSaldosTCPAIn($cardNumber as xs:string,
	$codigoPais as xs:string,
    $org as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:Org>{ data($org) }</ns0:Org>
            <ns0:NumTarjeta>{ data($cardNumber) }</ns0:NumTarjeta>
        </ns0:InputParameters>
};


declare variable $cardNumber as xs:string external;
declare variable $codigoPais as xs:string external;
declare variable $org as xs:string external;

xf:conMaestroSaldosTCPAIn($cardNumber, 
	$codigoPais, 
	$org)