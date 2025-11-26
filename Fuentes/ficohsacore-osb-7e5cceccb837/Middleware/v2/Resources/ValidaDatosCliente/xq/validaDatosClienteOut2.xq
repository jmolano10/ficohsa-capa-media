(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteResponse1" element="ns1:sjConsultaListasClienteResponse" location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaDatosClienteResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/validaDatosClienteOut/";


(: Función que determina si cliente está o no en una lista :)
declare function CustomerStatus($customerName as xs:string, $successIndicator as xs:string) as xs:string {
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

declare function xf:validaDatosClienteOut($sjConsultaListasClienteResponse1 as element(ns1:sjConsultaListasClienteResponse),
    $CustomerName as xs:string,
    $LegalID as xs:string,
    $existsCustomer as xs:string,
    $MessageCustomer as xs:string,
    $existsUsername as xs:string,
    $MessageUsername as xs:string,
    $ActivosPasivosCliente as xs:string)
    as element(ns0:validaDatosClienteResponse) {
        <ns0:validaDatosClienteResponse>
            <LEGAL_ID>{ $LegalID }</LEGAL_ID>
             {
                 if (fn:string($CustomerName ) !='') then (
                 <CUSTOMER_NAME>{ $CustomerName }</CUSTOMER_NAME>
                 ) else ()
                 }
            <ASSOCIATIONS_LIST>
	            {
	            	for $ASSOCIATION in $sjConsultaListasClienteResponse1/ns1:consultaListaClienteResponse
	            	return
	                <ASSOCIATION>
	                    <ASSOCIATION_NAME>{ data($ASSOCIATION/ns1:ASSOCIATION_NAME) }</ASSOCIATION_NAME>
	                    <CUSTOMER_STATUS>{ CustomerStatus(fn:string($ASSOCIATION/ns1:CUSTOMER_NAME/text()),fn:string($ASSOCIATION/ns1:successIndicator/text())) }</CUSTOMER_STATUS>
	                </ASSOCIATION>
	            }
	            </ASSOCIATIONS_LIST>
            <CUSTOMER_INFORMATION>
                <CUSTOMER_STATUS>{ $existsCustomer }</CUSTOMER_STATUS>
                 {
                 if (fn:string($existsCustomer) = ("ERROR")) then (
                 <ERROR_MESSAGE>{ $MessageCustomer }</ERROR_MESSAGE>
                 ) else ()
                 }
                <USERNAME_STATUS>{ $existsUsername }</USERNAME_STATUS>
                {
                 if (fn:string($existsUsername) = ("ERROR")) then (
                 <ERROR_MESSAGE>{ $MessageUsername }</ERROR_MESSAGE>
                 ) else ()
                 }
            </CUSTOMER_INFORMATION>
        </ns0:validaDatosClienteResponse>
};

declare variable $sjConsultaListasClienteResponse1 as element(ns1:sjConsultaListasClienteResponse) external;
declare variable $CustomerName as xs:string external;
declare variable $LegalID as xs:string external;
declare variable $existsCustomer as xs:string external;
declare variable $MessageCustomer as xs:string external;
declare variable $existsUsername as xs:string external;
declare variable $MessageUsername as xs:string external;
declare variable $ActivosPasivosCliente as xs:string external;

xf:validaDatosClienteOut($sjConsultaListasClienteResponse1,
    $CustomerName,
    $LegalID,
    $existsCustomer,
    $MessageCustomer,
    $existsUsername,
    $MessageUsername,
    $ActivosPasivosCliente)
