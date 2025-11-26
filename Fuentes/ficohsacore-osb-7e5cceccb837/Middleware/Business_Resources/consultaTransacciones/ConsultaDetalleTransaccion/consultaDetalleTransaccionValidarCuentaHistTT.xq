(:: pragma bea:global-element-parameter parameter="$consultadetransaccionhistTTResponse" element="ns0:ConsultadetransaccionhistTTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionValidarCuentaHistTT/";

declare function xf:consultaDetalleTransaccionValidarCuentaHistTT($account as xs:string,
    $consultadetransaccionhistTTResponse as element(ns0:ConsultadetransaccionhistTTResponse))
    as xs:boolean {
    	let $ACCOUNT2 := number($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/ACCOUNT2/text())
    	let $ACCOUNT2ALTID := fn:string($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/ACCOUNT2ALTID/text())
        return
	        if ( $ACCOUNT2 = number($account) or $ACCOUNT2ALTID = $account) then(
	        	xs:boolean("1")	
	        ) else (
	        	xs:boolean("0")
	        )
};

declare variable $account as xs:string external;
declare variable $consultadetransaccionhistTTResponse as element(ns0:ConsultadetransaccionhistTTResponse) external;

xf:consultaDetalleTransaccionValidarCuentaHistTT($account,
    $consultadetransaccionhistTTResponse)