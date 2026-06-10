<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoPromedioCuenta1" element="ns0:consultaSaldoPromedioCuenta" location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoPromedioCuenta/xq/consultaSaldoPromedioCuentaValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";

declare function xf:consultaSaldoPromedioCuentaValidate($consultaSaldoPromedioCuenta1 as element(ns0:consultaSaldoPromedioCuenta))
    as xs:string {
    	(: Campos requeridos :)
        if (fn:string($consultaSaldoPromedioCuenta1/ACCOUNT_NUMBER/text()) = "" or 
        	fn:string($consultaSaldoPromedioCuenta1/START_DATE/text()) = "" or 
        	fn:string($consultaSaldoPromedioCuenta1/END_DATE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else (
        	""
        )
};

declare variable $consultaSaldoPromedioCuenta1 as element(ns0:consultaSaldoPromedioCuenta) external;

xf:consultaSaldoPromedioCuentaValidate($consultaSaldoPromedioCuenta1)</con:xquery>
    <con:dependency location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes"/>
    </con:dependency>
</con:xqueryEntry>