(:: pragma bea:global-element-parameter parameter="$encryptPinResponse" element="ns0:encryptPinResponse" location="../../../BusinessServices/Switch/operacionesCriptograficasPin/wsdl/cryptographicOperationsPin.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$generaDetalleEmboceResponse" element="ns1:generaDetalleEmboceResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:generaDetalleEmboceResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/cryptographicOperationsPinTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/generaDetalleEmboceRSP/";

declare function xf:generaDetalleEmboceRSP($encryptPinResponse as element(ns0:encryptPinResponse),
    $generaDetalleEmboceResponse as element(ns1:generaDetalleEmboceResponse))
    as element(ns1:generaDetalleEmboceResponse) {
        <ns1:generaDetalleEmboceResponse>
            {
                for $status in $generaDetalleEmboceResponse/status
                return
                    <status>{ data($status) }</status>
            }
            {
                for $message in $generaDetalleEmboceResponse/message
                return
                    <message>{ data($message) }</message>
            }
            <cardDetailsResponse>
            	{
            		let $cardItemResponse:= $generaDetalleEmboceResponse/cardDetailsResponse/cardItemResponse
            		let $fieldItem := $encryptPinResponse/fieldItem
            		for $i in 1 to count($encryptPinResponse/fieldItem)
            	    return(
            	    	if(data($fieldItem[$i]/cardNumber) = data($cardItemResponse[$i]/cardNumber))then(
		            	    <cardItemResponse>
			                    	<cardNumber>{ concat(data($fieldItem[$i]/cardNumber)) }</cardNumber>
			                		<pin>{ data($fieldItem[$i]/result) }</pin>
			                		<nameOnCard>{ data($cardItemResponse[$i]/nameOnCard) }</nameOnCard>
			                		<pinBlock>{ data($cardItemResponse[$i]/pinBlock) }</pinBlock>
			                 		<serviceCode>{ data($cardItemResponse[$i]/serviceCode) }</serviceCode>
			                 		
			                 		<instructionDetails>
			                 		{
			                 			for $generationItem in $generaDetalleEmboceResponse/cardDetailsResponse/cardItemResponse[$i]/instructionDetails/generationItem
			                 			return(
					                        <generationItem>
					                       		 <generatedInstruction>{ data($generationItem/generatedInstruction) }</generatedInstruction>
					                             <generatedValue>{ data($generationItem/generatedValue) }</generatedValue>
					                             <generatedValueStatus>{ data($generationItem/generatedValueStatus) }</generatedValueStatus>
					                             <generatedValueMessage>{ data($generationItem/generatedValueMessage) }</generatedValueMessage>
					                        </generationItem>
					                       )
					                       
					                  }
				                    </instructionDetails>
			                 </cardItemResponse> 
	                   	)else()
	                )
            		
                
                }
            </cardDetailsResponse>
        </ns1:generaDetalleEmboceResponse>
};

declare variable $encryptPinResponse as element(ns0:encryptPinResponse) external;
declare variable $generaDetalleEmboceResponse as element(ns1:generaDetalleEmboceResponse) external;

xf:generaDetalleEmboceRSP($encryptPinResponse,
    $generaDetalleEmboceResponse)
