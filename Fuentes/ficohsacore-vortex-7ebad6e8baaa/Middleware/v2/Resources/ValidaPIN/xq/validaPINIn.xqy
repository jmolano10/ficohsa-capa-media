xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaPIN" element="ns0:validaPIN" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaPINRequest" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaPIN/xq/validaPINIn/";

declare function getKey ($userInstruction as xs:string) as xs:string {
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($userInstruction)))
  		return
		   $data/con:password/text()
};

declare function xf:validaPINIn($validaPIN as element(ns0:validaPIN),
    $method as xs:string,
    $pinBlockFormat as xs:string,
    $keyIndicator as xs:string,
    $pinBlockUser as xs:string,
    $pvvUser as xs:string,
    $countryCode as xs:string)
    as element(ns1:validaPINRequest) {    	
	        <ns1:validaPINRequest>
	        	{
		        	let $pvki := fn:substring($pvvUser, fn:string-length($pvvUser), 1)
	    			return(        	
				        <method>{ $method }</method>,
				        <pinBlockFormat>{ $pinBlockFormat }</pinBlockFormat>,
				        <cryptographicKeyPinBlock>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLAPINBLOCK',$pvki)), $pinBlockUser) }</cryptographicKeyPinBlock>,
				        <cryptographicKeyPVV>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLAPVV',$pvki)), $pvvUser) }</cryptographicKeyPVV>,
				        <keyIndicator>{ $keyIndicator }</keyIndicator>,
				        <cardDetails>
				            {
				                for $CARD_ITEM in $validaPIN/CARD_DETAILS/CARD_ITEM
				                return
				                    <cardItem>
				                        <pvki>{ fn:substring($pvvUser, fn:string-length($pvvUser), 1) }</pvki>
				                        <cardNumber>{ data($CARD_ITEM/CARD_NUMBER) }</cardNumber>
				                        <pvv>{ data($CARD_ITEM/PVV_VALUE) }</pvv>
				                        <pinBlock>{ data($CARD_ITEM/PINBLOCK_VALUE) }</pinBlock>
				                    </cardItem>
				            }
				        </cardDetails>
			        )	
				}        
	        </ns1:validaPINRequest>
};

declare variable $validaPIN as element(ns0:validaPIN) external;
declare variable $method as xs:string external;
declare variable $pinBlockFormat as xs:string external;
declare variable $keyIndicator as xs:string external;
declare variable $pinBlockUser as xs:string external;
declare variable $pvvUser as xs:string external;
declare variable $countryCode as xs:string external;

xf:validaPINIn($validaPIN,
    $method,
    $pinBlockFormat,
    $keyIndicator,
    $pinBlockUser,
    $pvvUser,
    $countryCode)