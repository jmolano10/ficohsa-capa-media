(:: pragma bea:global-element-parameter parameter="$consultadetransaccionhistFTResponse" element="ns0:ConsultadetransaccionhistFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionValidarCuentaHistFT/";

declare function xf:consultaDetalleTransaccionValidarCuentaHistFT($account as xs:string,
    $consultadetransaccionhistFTResponse as element(ns0:ConsultadetransaccionhistFTResponse))
    as xs:boolean {
    	let $DEBITACCOUNT := number($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/DEBITACCOUNT/text())
    	let $CREDITACCOUNT := number($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/CREDITACCOUNT/text())
    	let $DEBITACCTALTID := fn:string($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/DEBITACCTALTID/text())
    	let $CREDITACCTALTID := fn:string($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/CREDITACCTALTID/text())
    	return 
	        if ( $DEBITACCOUNT = number($account) or $CREDITACCOUNT = number($account) or $DEBITACCTALTID = $account or $CREDITACCTALTID = $account) then (
	        	xs:boolean("1")	
	        ) else (
	        	xs:boolean("0")
	        )
};

declare variable $account as xs:string external;
declare variable $consultadetransaccionhistFTResponse as element(ns0:ConsultadetransaccionhistFTResponse) external;

xf:consultaDetalleTransaccionValidarCuentaHistFT($account,
    $consultadetransaccionhistFTResponse)