(:: pragma bea:global-element-parameter parameter="$consultadetransaccionFTResponse" element="ns0:ConsultadetransaccionFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionValidarCuentaFT/";

declare function xf:consultaDetalleTransaccionValidarCuentaFT($consultadetransaccionFTResponse as element(ns0:ConsultadetransaccionFTResponse),
    $account as xs:string)
    as xs:boolean {
    	let $DEBITACCOUNT := number($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITACCOUNT/text())
    	let $CREDITACCOUNT := number($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CREDITACCOUNT/text())
    	let $DEBITACCTALTID := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITACCTALTID/text())
    	let $CREDITACCTALTID := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CREDITACCTALTID/text())
    	return 
	        if ( $DEBITACCOUNT = number($account) or $CREDITACCOUNT = number($account) or $DEBITACCTALTID = $account or $CREDITACCTALTID = $account) then (
	        	xs:boolean("1")	
	        ) else (
	        	xs:boolean("0")
	        )
};

declare variable $consultadetransaccionFTResponse as element(ns0:ConsultadetransaccionFTResponse) external;
declare variable $account as xs:string external;

xf:consultaDetalleTransaccionValidarCuentaFT($consultadetransaccionFTResponse,
    $account)