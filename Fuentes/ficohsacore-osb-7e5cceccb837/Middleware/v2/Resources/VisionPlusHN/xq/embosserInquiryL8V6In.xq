xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:EmbosserInquiryL8V6Request" location="../../../BusinessServices/VisionPlusHN/vmx/wsdl/VMX.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusHN/embosserInquiryL8V6In/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:embosserInquiryL8V6In($cardNumber as xs:string,
    $numberType as xs:string,
    $org as xs:string,
    $tipoOrg as xs:string)
    as element(ns0:EmbosserInquiryL8V6Request) {
         <ns0:EmbosserInquiryL8V6Request>
            <AZXCII-ORG>{ data($org) }</AZXCII-ORG>
            <AZXCII-CARD>{ $cardNumber }</AZXCII-CARD>
            <AZXCII-SEQ>{ data($numberType) }</AZXCII-SEQ>
	   		{                                       	   				
	   			if( $tipoOrg = 'BASE')then( 
					<AZXCII-FOREIGN-USE>{ 1 }</AZXCII-FOREIGN-USE>
                )
                else(
                	<AZXCII-FOREIGN-USE>{ 0 }</AZXCII-FOREIGN-USE>
                )	                    		                    					
	   		} 
        </ns0:EmbosserInquiryL8V6Request>
};

declare variable $cardNumber as xs:string external;
declare variable $numberType as xs:string external;
declare variable $org as xs:string external;
declare variable $tipoOrg as xs:string external;

xf:embosserInquiryL8V6In($cardNumber,
    $numberType,
    $org,
    $tipoOrg)