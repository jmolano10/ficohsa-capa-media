(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosGT/conFechaMaximaPago/xsd/conFechaMaximaPago_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conFechaMaximaPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosGT/xq/conFechaMaximaPagoGTIn/";

declare function xf:conFechaMaximaPagoGTIn($accountNumber as xs:string,
    $countryCode as xs:string,
    $org as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($countryCode) }</ns0:Pais>
            <ns0:Org>{ data($org) }</ns0:Org>
            <ns0:NumCuenta>{ data($accountNumber) }</ns0:NumCuenta>
        </ns0:InputParameters>
};

declare variable $accountNumber as xs:string external;
declare variable $countryCode as xs:string external;
declare variable $org as xs:string external;

xf:conFechaMaximaPagoGTIn($accountNumber,
    $countryCode,
    $org)