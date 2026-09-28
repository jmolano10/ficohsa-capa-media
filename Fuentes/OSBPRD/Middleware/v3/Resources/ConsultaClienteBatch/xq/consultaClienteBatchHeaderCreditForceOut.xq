(:: pragma bea:global-element-parameter parameter="$clientResponse" element="ns0:ClientResponse" location="../../../../v2/BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteBatch/xq/consultaClienteBatchHeaderCreditForceOut/";

declare function xf:consultaClienteBatchHeaderCreditForceOut($clientResponse as element(ns0:ClientResponse))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
        	{
        		if ($clientResponse/ns0:ClientResult/ns1:Status != '0') then
            		(
            		<successIndicator>SUCCESS</successIndicator>
            		)
            	else
            		(
            		<successIndicator>ERROR</successIndicator>
            		)
            }
            {
                for $Message in $clientResponse/ns0:ClientResult/ns1:Message
                return
                    <messages>{ data($Message) }</messages>
            }
        </ns2:ResponseHeader>
};

declare variable $clientResponse as element(ns0:ClientResponse) external;

xf:consultaClienteBatchHeaderCreditForceOut($clientResponse)