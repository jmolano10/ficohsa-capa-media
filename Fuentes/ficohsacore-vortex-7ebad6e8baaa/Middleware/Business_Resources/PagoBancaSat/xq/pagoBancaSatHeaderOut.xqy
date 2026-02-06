xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$aplicaCargoCuentaMessageOut" element="ns4:AplicaCargoCuentaMessageOut" location="../../../v2/BusinessServices/ICB/BancaSatService/wsdl/BancaSatServiceSingle.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns6 = "urn:infocorp.framework.businessentities.security";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns8 = "urn:Infocorp.framework.services.common";
declare namespace ns7 = "urn:infocorp.framework.businessentities.common";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatHeaderOut/";
declare namespace ns4 = "urn:tailored.icbanking.services.bancasat";
declare namespace ns3 = "urn:infocorp.framework.businessentities.logging";

declare function xf:pagoBancaSatHeaderOut($aplicaCargoCuentaMessageOut as element(ns4:AplicaCargoCuentaMessageOut))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
                for $transaction_reference in $aplicaCargoCuentaMessageOut/ns4:transaction_reference
                return
                    <transactionId>{ data($transaction_reference) }</transactionId>
            }
            {	let $operationResult := string($aplicaCargoCuentaMessageOut/ns5:OperationResult/ns7:Value/text())
            	return
        			if ($operationResult = '0')then(
        				<successIndicator>{ "SUCCESS" }</successIndicator>
        			)else(
        				<successIndicator>{ concat("ICBBSAT-", $operationResult) }</successIndicator>
    				)
            		
            } 
            {
                for $backend_message in $aplicaCargoCuentaMessageOut/ns4:backend_message
                return
        			if (string($aplicaCargoCuentaMessageOut/ns5:OperationResult/ns7:Value/text())!= '0')then(
        				<messages>{ data($backend_message) }</messages>
        			)else()
                    
            }
            {
                for $value_date in $aplicaCargoCuentaMessageOut/ns4:value_date
                return
                    <valueDate>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", $value_date) }</valueDate>
            }
        </ns2:ResponseHeader>
};

declare variable $aplicaCargoCuentaMessageOut as element(ns4:AplicaCargoCuentaMessageOut) external;

xf:pagoBancaSatHeaderOut($aplicaCargoCuentaMessageOut)