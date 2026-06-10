<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCortaSaldoCuenta" element="ns0:consultaCortaSaldoCuenta" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaCortaSaldoCuenta/consultaCortaSaldoCuentaValidate/";

declare function xf:consultaCortaSaldoCuentaValidate($consultaCortaSaldoCuenta as element(ns0:consultaCortaSaldoCuenta))
    as xs:string {
        if (fn:string($consultaCortaSaldoCuenta/ACCOUNT_NUMBER/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else ( 
            ""
		)
};

declare variable $consultaCortaSaldoCuenta as element(ns0:consultaCortaSaldoCuenta) external;

xf:consultaCortaSaldoCuentaValidate($consultaCortaSaldoCuenta)</con:xquery>
    <con:dependency location="../Resources/consultasGeneralesCuentasTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes"/>
    </con:dependency>
</con:xqueryEntry>