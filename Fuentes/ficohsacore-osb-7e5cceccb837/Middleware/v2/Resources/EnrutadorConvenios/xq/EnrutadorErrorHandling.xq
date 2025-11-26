(:: pragma bea:schema-type-parameter parameter="$serviceRequest1" type="ns0:serviceRequest" location="../xsd/enrutadorConveniosTypes.xsd" ::)
(:: pragma bea:schema-type-return type="ns0:serviceResponse" location="../xsd/enrutadorConveniosTypes.xsd" ::)

declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnrutadorConvenios/xq/EnrutadorErrorHandling/";

declare function xf:EnrutadorErrorHandling($serviceRequest1 as element(),
    $errorCode as xs:string,
    $errorMessage as xs:string)
    as element() {
	    <ns0:invokeResponse>
	        <ns0:serviceResponse>
	        	<responseConnector>{ "WS Provider 'OSB'" }</responseConnector>
		        <responseTime>{ 0 }</responseTime>
	            {
	                for $requestData in $serviceRequest1/requestData
	                return
	                    <responseData>{ data($requestData) }</responseData>
	            }
	            <responseError>{ concat($errorCode , $errorMessage) }</responseError>
	        </ns0:serviceResponse>
	    </ns0:invokeResponse>
};

declare variable $serviceRequest1 as element() external;
declare variable $errorCode as xs:string external;
declare variable $errorMessage as xs:string external;

xf:EnrutadorErrorHandling($serviceRequest1,
    $errorCode,
    $errorMessage)