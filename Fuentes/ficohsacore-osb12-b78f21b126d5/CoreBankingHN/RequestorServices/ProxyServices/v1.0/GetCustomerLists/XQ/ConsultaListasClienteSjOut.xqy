xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/consultaListasCliente";
(:: import schema at "../../../../../../MWBanking/Compliances/RequestorServices/XSD/getCustomerLists.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";

declare namespace dyn = "http://www.ficohsa.com.hn/middleware.services/dynamoTypes";

declare variable $customerId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $uuid as xs:string external;
declare variable $sjConsultaListasClienteResponse as element() (:: schema-element(ns2:getCustomerListsHN_SJResponse) ::) external;

(: Función que determina si cliente está o no en una lista :)
declare function ns3:CustomerStatus($customerName as xs:string, $successIndicator as xs:string) as xs:string {
	if (fn:upper-case($successIndicator) = "SUCCESS") then (
		if ($customerName != "") then (
			"YES"
		) else (
			"NO"
		)
	) else if (fn:upper-case($successIndicator) = "NOMATCH") then (
		"NO"
	) else if (fn:upper-case($successIndicator) = "HINT") then (
		"I"
	) else if (fn:upper-case($successIndicator) = "RELUCTANT") then (
		"R"
	) else (
		"ERROR"
	)
};

declare function ns1:ConsultaListasClienteSjOut($customerId as xs:string, 
                                                $customerName as xs:string,
                                                $uuid as xs:string, 
                                                $sjConsultaListasClienteResponse as element() (:: schema-element(ns2:getCustomerListsHN_SJResponse) ::)) 
                                                as element() (:: schema-element(ns3:getCustomerListsResponse) ::) {
    <ns3:getCustomerListsResponse>
        <ns3:StatusInfo>
            {
                let $SUCCESS_INDICATOR := fn:count($sjConsultaListasClienteResponse/ns2:consultaListaClienteResponse[fn:upper-case(ns2:successIndicator/text()) = "SUCCESS"])
                  return
                  if ($SUCCESS_INDICATOR > 0) then (
                    <dyn:Status>Success</dyn:Status>
                  ) else (
                    <dyn:Status>Error</dyn:Status>
                  )
            }
            <dyn:TransactionId></dyn:TransactionId>
            <dyn:ValueDate>{fn:string(fn:current-date())}</dyn:ValueDate>
            <dyn:DateTime>{fn:string(fn:current-dateTime())}</dyn:DateTime>
            <dyn:GlobalId>{fn:data($uuid)}</dyn:GlobalId>
        </ns3:StatusInfo>
        <ns3:CustomerId>{fn:data($customerId)}</ns3:CustomerId>
        <ns3:CustomerName>{fn:data($customerName)}</ns3:CustomerName>
        <ns3:AssociationsList>
            {
                let $SUCCESS_INDICATOR := fn:count($sjConsultaListasClienteResponse/ns2:consultaListaClienteResponse[fn:upper-case(ns2:successIndicator/text()) = "SUCCESS"])
                  return
                  if ($SUCCESS_INDICATOR > 0) then (
                    for $consultaListaClienteResponse in $sjConsultaListasClienteResponse/ns2:consultaListaClienteResponse
                      return 
                        <ns3:Association>
                          <AssociationName>{ data($consultaListaClienteResponse/ns2:ASSOCIATION_NAME) }</AssociationName>
                          <CustomerStatus>{ ns3:CustomerStatus(fn:string($consultaListaClienteResponse/ns2:CUSTOMER_NAME/text()),fn:string($consultaListaClienteResponse/ns2:successIndicator/text())) }</CustomerStatus>
                        </ns3:Association>
                  ) else ()
            }
        </ns3:AssociationsList>
    </ns3:getCustomerListsResponse>
};

ns1:ConsultaListasClienteSjOut($customerId, $customerName, $uuid, $sjConsultaListasClienteResponse)