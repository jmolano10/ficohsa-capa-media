(:: pragma bea:global-element-parameter parameter="$consultaestadoremesaenbackendResponse1" element="ns1:ConsultaestadoremesaenbackendResponse" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesaBackendResponse" location="../xsd/consultaRemesaBackendTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaBackendTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaBackend/xq/consultaRemesaBackendOut/";

declare function xf:consultaRemesaBackendOut($consultaestadoremesaenbackendResponse1 as element(ns1:ConsultaestadoremesaenbackendResponse))
    as element(ns0:consultaRemesaBackendResponse) {
    	if (fn:string($consultaestadoremesaenbackendResponse1/Status/successIndicator/text()) = "Success" and
			fn:string($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/ZERORECORDS/text()) = "") then(
	        <ns0:consultaRemesaBackendResponse>
	            <REMITTANCE_ID>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/ID) }</REMITTANCE_ID>
	            <REMITTER_ID>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/CONTRACTID) }</REMITTER_ID>
	            <TRANSACTION_ID>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/TRANSACTIONID) }</TRANSACTION_ID>
	            <STATUS>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/STATUS) }</STATUS>
	            <BRANCH_CODE>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/BRANCHCODE) }</BRANCH_CODE>
	            <CURRENCY>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/CURRENCY) }</CURRENCY>
	            <AMOUNT>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/AMOUNT) }</AMOUNT>
	            <PAYMENT_METHOD>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/PAYMENTMETHOD) }</PAYMENT_METHOD>
	            <PAYMENT_DATE>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/PAYMENTDATE) }</PAYMENT_DATE>
	            <INPUTTER>{ data($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type[1]/gWSREMITSTATUST24DetailType/mWSREMITSTATUST24DetailType[1]/INPUTTER) }</INPUTTER>
	        </ns0:consultaRemesaBackendResponse>
	    ) else (
	    	<ns0:consultaRemesaBackendResponse/>
	    )
};

declare variable $consultaestadoremesaenbackendResponse1 as element(ns1:ConsultaestadoremesaenbackendResponse) external;

xf:consultaRemesaBackendOut($consultaestadoremesaenbackendResponse1)