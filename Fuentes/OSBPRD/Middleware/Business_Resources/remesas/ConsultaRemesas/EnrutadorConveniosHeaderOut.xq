(:: pragma  parameter="$parametersOut" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosHeaderOut/";

declare function xf:EnrutadorConveniosHeaderOut($parametersOut as element(*))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
        	if (fn:string($parametersOut/errorCode/text()) = ("0", "2")) then (
        		<successIndicator>SUCCESS</successIndicator>
        	) else (
        		<successIndicator>ERROR</successIndicator>,
        		<messages>{ fn:string($parametersOut/errorMessage/text()) }</messages>
        	)
        }
        </ns0:ResponseHeader>
};

declare variable $parametersOut as element(*) external;

xf:EnrutadorConveniosHeaderOut($parametersOut)