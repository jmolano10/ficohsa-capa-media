(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse" element="ns0:ConsultadetransaccionTTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionValidarCuentaTT/";

declare function xf:consultaDetalleTransaccionValidarCuentaTT($consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse),
    $account as xs:string)
    as xs:boolean {
    	let $ACCOUNT2 := number($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/ACCOUNT2/text())
    	let $ACCOUNT2ALTID := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/ACCOUNT2ALTID/text())
        return
	        if ( $ACCOUNT2 = number($account) or $ACCOUNT2ALTID = $account) then(
	        	xs:boolean("1")	
	        ) else (
	        	xs:boolean("0")
	        )
};

declare variable $consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse) external;
declare variable $account as xs:string external;

xf:consultaDetalleTransaccionValidarCuentaTT($consultadetransaccionTTResponse,
    $account)