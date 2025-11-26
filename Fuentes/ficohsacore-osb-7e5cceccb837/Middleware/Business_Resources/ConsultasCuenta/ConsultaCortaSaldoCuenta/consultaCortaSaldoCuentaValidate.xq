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

xf:consultaCortaSaldoCuentaValidate($consultaCortaSaldoCuenta)