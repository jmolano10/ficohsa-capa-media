(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns0:consultaMovimientosCuenta" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuenta/ConsultaMovimientosCuentaValidate/";

declare function xf:ConsultaMovimientosCuentaValidate($consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta))
    as xs:string {
        let $ACCOUNTNUMBER := fn:string($consultaMovimientosCuenta1/ACCOUNT_NUMBER/text())
        let $ENTRYRANGE := fn:string($consultaMovimientosCuenta1/ENTRY_RANGE/text())
        let $BEGINDATE := fn:string($consultaMovimientosCuenta1/BEGIN_DATE/text())
        let $ENDDATE := fn:string($consultaMovimientosCuenta1/END_DATE/text())
        return 
        	if ($ACCOUNTNUMBER = "") then (
        		"MISSING ACOUNT NUMBER"
        	) else if($ENTRYRANGE = "") then (
        		"MISSING ENTRY RANGE"
        	) else if (fn:not(fn:upper-case($ENTRYRANGE) = ("TODAY", "LAST_STMT", "FREE_RANGE"))) then (
        		"INVALID ENTRY RANGE"
        	) else if (fn:upper-case($ENTRYRANGE) = "FREE_RANGE" and
        				($BEGINDATE = "" or $ENDDATE = "")) then (
        				"MISSING BEGIN DATE OR END DATE"
        	) else (
        		""
        	)
        					
};

declare variable $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta) external;

xf:ConsultaMovimientosCuentaValidate($consultaMovimientosCuenta1)