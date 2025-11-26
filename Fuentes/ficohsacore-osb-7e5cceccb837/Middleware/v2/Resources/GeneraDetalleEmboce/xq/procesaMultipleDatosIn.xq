(:: pragma bea:global-element-parameter parameter="$generaDetalleEmboceResponse" element="ns0:generaDetalleEmboceResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:procesaMultipleDatos" location="../../OperacionesCriptograficas/xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/procesaMultipleDatosIn/";

declare function getFieldItem($cardNumber as xs:string, $key as xs:string, $keyValue as xs:string)
	as element(*){
		if($keyValue != '') then(
			<ns1:FIELD_ITEM>
				{
					<ns1:NAME>{ fn:concat($cardNumber, '.', $key) }</ns1:NAME>,
			        <ns1:VALUE>{ $keyValue }</ns1:VALUE>
			    }
			</ns1:FIELD_ITEM>
		)else()
		
};

declare function xf:procesaMultipleDatosIn($generaDetalleEmboceResponse as element(ns0:generaDetalleEmboceResponse),
	$cipher as xs:string,
	$cryptokeyAlias as xs:string)
    as element(ns1:procesaMultipleDatos) {
        <ns1:procesaMultipleDatos>
            <ns1:OPERATION_TYPE>ENCRYPT</ns1:OPERATION_TYPE>
            <ns1:CIPHER>{ $cipher }</ns1:CIPHER>
            <ns1:CRYPTOKEY_ALIAS>{ $cryptokeyAlias }</ns1:CRYPTOKEY_ALIAS>
            <ns1:DATA_ITEMS>
                {
                    for $cardItemResponse  in ($generaDetalleEmboceResponse/cardDetailsResponse/cardItemResponse)  
                    return
                        (
                        	getFieldItem(
                        		fn:string($cardItemResponse/cardNumber/text()),
                        		'pin',
                        		fn:string($cardItemResponse/pin/text())
                        	),
	                        for $generationItem in $cardItemResponse/instructionDetails/generationItem
	                        return(
	                        	getFieldItem(
		                        	fn:string($cardItemResponse/cardNumber/text()),
		                        	fn:string($generationItem/generatedInstruction/text()),
		                        	fn:string($generationItem/generatedValue/text())
	                        	)
	                        )
	                    )
                }
			</ns1:DATA_ITEMS>
        </ns1:procesaMultipleDatos>
};

declare variable $generaDetalleEmboceResponse as element(ns0:generaDetalleEmboceResponse) external;
declare variable $cipher as xs:string external;
declare variable $cryptokeyAlias as xs:string external;

xf:procesaMultipleDatosIn($generaDetalleEmboceResponse,
	$cipher,
	$cryptokeyAlias)