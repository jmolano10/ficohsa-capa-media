(:: pragma bea:global-element-parameter parameter="$consultaSeguros" element="ns2:consultaSeguros" location="../xsd/consultaSegurosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$insuranceInquiryResponse" element="ns0:InsuranceInquiryResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraSeguros/xsd/registraSeguros_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaSegurosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraSeguros";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSeguros/xq/registraSegurosIn/";

declare function xf:registraSegurosIn($consultaSeguros as element(ns2:consultaSeguros),
    $insuranceInquiryResponse as element(ns0:InsuranceInquiryResponse),
    $countryCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_SEGUROS>
                <ns1:PT_SEGUROS_ITEM>
                    <ns1:ORG>{ data($consultaSeguros/ORG) }</ns1:ORG>
                    <ns1:ACCOUNT_NUMBER>{ data($consultaSeguros/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
                    <ns1:PRODUCT_COUNT>{ data($insuranceInquiryResponse/ARXIIO-NBR-INS-PRD) }</ns1:PRODUCT_COUNT>
                    <ns1:INSURANCE_PRODUCTS>
                    { 
                    	fn-bea:serialize(
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
				                			)else(
				                			)
				                		}
				                		<YEARLY_PREMIUM_BILLED>{ data($insurance/ARXIIO-CTD-PREMIUM-BILLED) }</YEARLY_PREMIUM_BILLED>
				            		</INSURANCE_PRODUCT>
		                    	)
		                    }
	                    	</INSURANCE_PRODUCTS>
	                    )
                    }
                    </ns1:INSURANCE_PRODUCTS>
                </ns1:PT_SEGUROS_ITEM>
            </ns1:PT_SEGUROS>
            <ns1:PV_COUNTRY_CODE>{ $countryCode }</ns1:PV_COUNTRY_CODE>
        </ns1:InputParameters>
};

declare variable $consultaSeguros as element(ns2:consultaSeguros) external;
declare variable $insuranceInquiryResponse as element(ns0:InsuranceInquiryResponse) external;
declare variable $countryCode as xs:string external;

xf:registraSegurosIn($consultaSeguros,
    $insuranceInquiryResponse,
    $countryCode)