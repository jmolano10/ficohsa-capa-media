xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/conDatoCuentaIn/";

declare function xf:conDatoCuentaIn($accountNumber as xs:string, $org as xs:string, $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            {
            	if($org != "")then(
            		<ns0:Org>{ $org }</ns0:Org>
            	)else()
            }
            <ns0:NumCuenta>{ fn-bea:pad-left($accountNumber, 19, '0') }</ns0:NumCuenta>
        </ns0:InputParameters>
};

declare variable $accountNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $codigoPais as xs:string external;
xf:conDatoCuentaIn($accountNumber, $org, $codigoPais)