(:: pragma bea:global-element-parameter parameter="$generaDetalleEmboceResponse" element="ns0:generaDetalleEmboceResponse" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:encryptPinRequest" location="../../../BusinessServices/Switch/operacionesCriptograficasPin/wsdl/cryptographicOperationsPin.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/cryptographicOperationsPinTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/encriptaPin/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare function getKey ($userInstruction as xs:string) as xs:string {
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($userInstruction)))
  		return
		   $data/con:password/text()
};

declare function xf:encriptaPin($generaDetalleEmboceResponse as element(ns0:generaDetalleEmboceResponse),
    $key as xs:string,
    $iv as xs:string)
    as element(ns1:encryptPinRequest) {
        <ns1:encryptPinRequest>
        {
         	for $cardItemResponse in $generaDetalleEmboceResponse/cardDetailsResponse/cardItemResponse
            return(
	            <fieldItem>
	                <cardNumber>{ data($cardItemResponse/cardNumber) }</cardNumber>
	                <pin>{ data($cardItemResponse/pin) }</pin>
	            </fieldItem>
            )
        }
            <key>{ getKey($key) }</key>
            <iv>{ getKey($iv) }</iv>
        </ns1:encryptPinRequest>
};

declare variable $generaDetalleEmboceResponse as element(ns0:generaDetalleEmboceResponse) external;
declare variable $key as xs:string external;
declare variable $iv as xs:string external;

xf:encriptaPin($generaDetalleEmboceResponse,
    $key,
    $iv)
