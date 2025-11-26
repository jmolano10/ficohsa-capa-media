(:: pragma bea:global-element-parameter parameter="$registrarImagenesChequesResponse1" element="ns0:registrarImagenesChequesResponse" location="../Resources/XMLSchema_-753785776.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://services.com/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/registroIndividualImagenCheque/registroIndividualImagenChequeHeaderOut/";

declare function xf:obtener-success-indicator($indicator as xs:string) as xs:string {
	if ($indicator = "true" or $indicator = "TRUE") then (
		"Success"
	) else (
		"Error"
	)
};

declare function xf:registroIndividualImagenChequeHeaderOut($registrarImagenesChequesResponse1 as element(ns0:registrarImagenesChequesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>{ xf:obtener-success-indicator(data($registrarImagenesChequesResponse1/registroImagenesChequesResponse[1]/resultadoOperacion)) }</successIndicator>
            {
                for $mensajeError in $registrarImagenesChequesResponse1/registroImagenesChequesResponse[1]/mensajeError
                return
                    <messages>{ data($mensajeError) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $registrarImagenesChequesResponse1 as element(ns0:registrarImagenesChequesResponse) external;

xf:registroIndividualImagenChequeHeaderOut($registrarImagenesChequesResponse1)