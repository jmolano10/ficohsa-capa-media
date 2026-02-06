xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaListasClienteResponse" element="ns1:consultaListasClienteResponse" location="../../../BusinessServices/consultaListasCliente/xsd/consultaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CreditOrigination/ProcessCustomerListXML/xsd/processCustomerListXML_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/processCustomerListXML";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/processCustomerListXMLIn/";

declare function xf:buildXMLResponse($successIndicator as xs:string,
    $message as xs:string,
    $caseId as xs:string,
    $consultaListasClienteResponse as element(ns1:consultaListasClienteResponse)) 
    as element(*) {
    	<CUSTOMER_LIST_RESPONSE>
			<SUCCESS_INDICATOR>{ $successIndicator }</SUCCESS_INDICATOR>
			{
				if ($message != "") then (
					<MESSAGE>{ $message }</MESSAGE>
				) else ()
			}
			<CASE_ID>{ $caseId }</CASE_ID>
			{
				for $CUSTOMER_ID in $consultaListasClienteResponse/CUSTOMER_ID
				return
				<CUSTOMER_ID>{ fn:data($CUSTOMER_ID) }</CUSTOMER_ID>
			}
			{
				for $CUSTOMER_NAME in $consultaListasClienteResponse/CUSTOMER_NAME
				return
				<CUSTOMER_NAME>{ fn:data($CUSTOMER_NAME) }</CUSTOMER_NAME>
			}
			{
				if (fn:exists($consultaListasClienteResponse/ASSOCIATIONS_LIST/ASSOCIATION)) then (
					<ASSOCIATIONS_LIST>
					{
						for $ASSOCIATION in $consultaListasClienteResponse/ASSOCIATIONS_LIST/ASSOCIATION
						return(
							<ASSOCIATION>
								<ASSOCIATION_NAME>{ fn:data($ASSOCIATION/ASSOCIATION_NAME) }</ASSOCIATION_NAME>
								<CUSTOMER_STATUS>{ fn:data($ASSOCIATION/CUSTOMER_STATUS) }</CUSTOMER_STATUS>
							</ASSOCIATION>
						)
					}
					</ASSOCIATIONS_LIST>
				) else ()
			}
		</CUSTOMER_LIST_RESPONSE>
};

declare function xf:processCustomerListXMLIn($successIndicator as xs:string,
    $message as xs:string,
    $caseId as xs:string,
    $consultaListasClienteResponse as element(ns1:consultaListasClienteResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_XMLRESPONSE>{ fn-bea:serialize(xf:buildXMLResponse($successIndicator, $message, $caseId, $consultaListasClienteResponse)) }</ns0:P_XMLRESPONSE>
        </ns0:InputParameters>
};

declare variable $successIndicator as xs:string external;
declare variable $message as xs:string external;
declare variable $caseId as xs:string external;
declare variable $consultaListasClienteResponse as element(ns1:consultaListasClienteResponse) external;

xf:processCustomerListXMLIn($successIndicator,
    $message,
    $caseId,
    $consultaListasClienteResponse)