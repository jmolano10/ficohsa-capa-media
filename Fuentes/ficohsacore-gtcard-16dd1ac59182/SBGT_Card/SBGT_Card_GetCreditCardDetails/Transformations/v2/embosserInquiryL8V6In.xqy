xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
(:: import schema at "../../Resources/v2/VMX.wsdl" ::)

declare function local:embosserInquiryL8V6In($cardNumber as xs:string,
    $numberType as xs:integer,
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
declare variable $numberType as xs:integer external;
declare variable $org as xs:string external;
declare variable $tipoOrg as xs:string external;

local:embosserInquiryL8V6In($cardNumber,
    $numberType,
    $org,
    $tipoOrg)