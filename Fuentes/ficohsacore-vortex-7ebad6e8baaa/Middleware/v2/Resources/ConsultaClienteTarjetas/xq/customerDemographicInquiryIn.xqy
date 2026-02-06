xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClienteTarjetas" element="ns0:consultaClienteTarjetas" location="../xsd/consultaClienteTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CustomerDemographicInquiryRequest" location="../../../BusinessServices/VisionPlus/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteTarjetasTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteTarjetas/xq/consultaClienteTarjetaIn/";
declare function search_criteria ($item as xs:string) as xs:string {
	let $search_criteria:=fn-bea:trim(upper-case($item))
	return
		if ($search_criteria = ('CARD_NUMBER','ACC_NUMBER'))then (
			'0'
		) else if ($search_criteria = 'CUSTOMER_ID') then(
			'1'
		)else('')
};
declare function xf:consultaClienteTarjetaIn($consultaClienteTarjetas as element(ns0:consultaClienteTarjetas),
    $customer_id as xs:string,
    $org as xs:string)
    as element(ns1:CustomerDemographicInquiryRequest) {
        <ns1:CustomerDemographicInquiryRequest>
            <ARXNDI-ORG>{ $org }</ARXNDI-ORG>
           { 
            let $SEARCH_CRITERIA := $consultaClienteTarjetas/SEARCH_CRITERIA
            return
            	if (upper-case($SEARCH_CRITERIA/text())=('CARD_NUMBER','ACC_NUMBER','CUSTOMER_ID'))then(
            	 	 <ARXNDI-CUST-ACCT-CARD-NBR>{ data($consultaClienteTarjetas/SEARCH_VALUE) }</ARXNDI-CUST-ACCT-CARD-NBR>,
           			 <ARXNDI-NBR-TYPE>{search_criteria(fn:string($consultaClienteTarjetas/SEARCH_CRITERIA/text())) }</ARXNDI-NBR-TYPE>         			
           		)
           		else(
           				 <ARXNDI-CUST-ACCT-CARD-NBR>{ data($customer_id) }</ARXNDI-CUST-ACCT-CARD-NBR>,	
           				 <ARXNDI-NBR-TYPE>{search_criteria(upper-case('CUSTOMER_ID')) }</ARXNDI-NBR-TYPE> 
           		)
           	}
        </ns1:CustomerDemographicInquiryRequest>
};

declare variable $consultaClienteTarjetas as element(ns0:consultaClienteTarjetas) external;
declare variable $customer_id as xs:string external;
declare variable $org as xs:string external;

xf:consultaClienteTarjetaIn($consultaClienteTarjetas,
    $customer_id,
    $org)