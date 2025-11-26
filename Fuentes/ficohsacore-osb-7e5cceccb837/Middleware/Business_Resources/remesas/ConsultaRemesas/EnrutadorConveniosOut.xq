(:: pragma  parameter="$anyType1" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="consultaRemesasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosOut/";

declare function xf:EnrutadorConveniosOut($parametersOut as element(*))
    as element(ns0:consultaRemesasResponse) {
    	if (fn:string($parametersOut/errorCode/text()) = "0") then (
	        <ns0:consultaRemesasResponse>
	            <ns0:consultaRemesasResponseType>
	                <ns0:consultaRemesasResponseRecordType>
		               	<ns0:REMITTANCE_ID>{ data($parametersOut/moreParameters/data[@fieldName="remittanceNumber"]/text()) }</ns0:REMITTANCE_ID>                	                					
		               	<ns0:REMITTER_NAME>{ data($parametersOut/moreParameters/data[@fieldName="senderName"]/text()) }</ns0:REMITTER_NAME>
		               	<ns0:BENEFICIARY_NAME>{ data($parametersOut/moreParameters/data[@fieldName="beneficiaryName"]/text()) }</ns0:BENEFICIARY_NAME>
		               	<ns0:REMITTANCE_STATUS>{ data($parametersOut/moreParameters/data[@fieldName="remittanceStatus"]/text()) }</ns0:REMITTANCE_STATUS>
		               	<ns0:REMITTANCE_AMOUNT>{ data($parametersOut/totalAmount/text()) }</ns0:REMITTANCE_AMOUNT>
	                </ns0:consultaRemesasResponseRecordType>
	            </ns0:consultaRemesasResponseType>
	        </ns0:consultaRemesasResponse>
	    ) else (
	    	<ns0:consultaRemesasResponse/>
	    )
};

declare variable $parametersOut as element(*) external;

xf:EnrutadorConveniosOut($parametersOut)