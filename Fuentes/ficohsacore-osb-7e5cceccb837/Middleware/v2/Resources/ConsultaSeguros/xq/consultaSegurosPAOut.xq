xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$insuranceInquiryResponse" element="ns1:InsuranceInquiryResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSegurosResponse" location="../xsd/consultaSegurosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/CLIENTDATA/consultaSeguros/xsd/consultaSeguros_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSeguros/xq/consultaSegurosPAOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSegurosTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSeguros";

declare function xf:consultaSegurosPAOut($outputParameters as element(ns2:OutputParameters)?,
	$insuranceInquiryResponse as element(ns1:InsuranceInquiryResponse)?)
    as element(ns0:consultaSegurosResponse) {
        <ns0:consultaSegurosResponse>
        {	
        	if(not(empty($outputParameters/ns2:PT_SEGUROS/ns2:PT_SEGUROS_ITEM)))then(
        		<PRODUCT_COUNT>{ data($outputParameters/ns2:PT_SEGUROS/ns2:PT_SEGUROS_ITEM[1]/ns2:PRODUCT_COUNT) }</PRODUCT_COUNT>,
        		let $INSURANCE_INFO := fn-bea:inlinedXML($outputParameters/ns2:PT_SEGUROS/ns2:PT_SEGUROS_ITEM[1]/ns2:INSURANCE_PRODUCTS)
                return(
                	<INSURANCE_PRODUCTS>
                	{
		                for $INSURANCE_PRODUCTS in $INSURANCE_INFO/INSURANCE_PRODUCT
		                return(
		                	<INSURANCE_PRODUCT>
		                		<PRODUCT_CODE>{ data($INSURANCE_PRODUCTS/PRODUCT_CODE) }</PRODUCT_CODE>
	                			<PRODUCT_DESCRIPTION>{ data($INSURANCE_PRODUCTS/PRODUCT_DESCRIPTION) }</PRODUCT_DESCRIPTION>
	                			<PRODUCT_STATUS>{ data($INSURANCE_PRODUCTS/PRODUCT_STATUS) }</PRODUCT_STATUS>
	                			<CANCEL_REASON>{ data($INSURANCE_PRODUCTS/CANCEL_REASON) }</CANCEL_REASON>
	                			<EFF_DATE>{ data($INSURANCE_PRODUCTS/EFF_DATE) }</EFF_DATE>
	                			<PREMIUM_RATE>{ data($INSURANCE_PRODUCTS/PREMIUM_RATE) }</PREMIUM_RATE>
	                			<DATE_LAST_BILLED>{ data($INSURANCE_PRODUCTS/DATE_LAST_BILLED) }</DATE_LAST_BILLED>
	                			<YEARLY_PREMIUM_BILLED>{ data($INSURANCE_PRODUCTS/YEARLY_PREMIUM_BILLED) }</YEARLY_PREMIUM_BILLED>	
		                	</INSURANCE_PRODUCT>
		                )
		            }
		            </INSURANCE_PRODUCTS>
	            )
        	)else(
	        	 <PRODUCT_COUNT>{ data($insuranceInquiryResponse/ARXIIO-NBR-INS-PRD) }</PRODUCT_COUNT>,
	            <INSURANCE_PRODUCTS>
	            {
	           		for $insurance in $insuranceInquiryResponse/InsuranceProductArray/InsuranceProductData
	            	return(
	            		<INSURANCE_PRODUCT>
	                		<PRODUCT_CODE>{ data($insurance/ARXIIO-INS-PRODUCT) }</PRODUCT_CODE>
	                		<PRODUCT_DESCRIPTION>{ data($insurance/ARXIIO-INS-PROD-DESC) }</PRODUCT_DESCRIPTION>
	                		<PRODUCT_STATUS>{ data($insurance/ARXIIO-INS-STATUS-CODE) }</PRODUCT_STATUS>
	                		<CANCEL_REASON>{ data($insurance/ARXIIO-CAN-REASON) }</CANCEL_REASON>
	                		{
	                			for $EFF_DATE in $insurance/ARXIIO-EFF-DATE
	                			return
	                			if(string($EFF_DATE/text()) != "")then(
	                				<EFF_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",data($EFF_DATE)) }</EFF_DATE>
	                			)else()
	                		}
	                		<PREMIUM_RATE>{ data($insurance/ARXIIO-PREMIUM-RATE) }</PREMIUM_RATE>
	                		{
	                			for $DATE_LAST_BILLED in $insurance/ARXIIO-DATE-LAST-BILLED
	                			return
	                			if(string($DATE_LAST_BILLED/text()) != "")then(
	                				<DATE_LAST_BILLED>{ fn-bea:date-to-string-with-format("yyyyMMdd",data($DATE_LAST_BILLED)) }</DATE_LAST_BILLED>
	                			)else()
	                		}
	                		<YEARLY_PREMIUM_BILLED>{ data($insurance/ARXIIO-CTD-PREMIUM-BILLED) }</YEARLY_PREMIUM_BILLED>
	            		</INSURANCE_PRODUCT>
	            	)
					
	            	
	            }
	            </INSURANCE_PRODUCTS>
         	)
         }
        </ns0:consultaSegurosResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters)? external;
declare variable $insuranceInquiryResponse as element(ns1:InsuranceInquiryResponse)? external;

xf:consultaSegurosPAOut($outputParameters, $insuranceInquiryResponse)