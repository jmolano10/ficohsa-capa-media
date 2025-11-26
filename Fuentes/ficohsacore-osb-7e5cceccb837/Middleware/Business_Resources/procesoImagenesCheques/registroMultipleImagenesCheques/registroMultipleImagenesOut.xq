(:: pragma bea:global-element-parameter parameter="$registrarImagenesChequesResponse1" element="ns1:registrarImagenesChequesResponse" location="../Resources/XMLSchema_-753785776.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registroMultipleImagenesChequesResponse" location="../Resources/procesoImagenesChequesTypes.xsd" ::)

declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/registroMultipleImagenesCheques/registroMultipleImagenesOut/";

declare function xf:obtener-success-indicator($indicator as xs:string) as xs:string {
	if ($indicator = "true" or $indicator = "TRUE") then (
		"Success"
	) else (
		"Error"
	)
};

declare function xf:registroMultipleImagenesOut($registrarImagenesChequesResponse1 as element(ns1:registrarImagenesChequesResponse))
    as element(ns0:registroMultipleImagenesChequesResponse) {
        <ns0:registroMultipleImagenesChequesResponse>
            {
                for $registroImagenesChequesResponse in $registrarImagenesChequesResponse1/registroImagenesChequesResponse
                return
                    <ns0:registroMultipleImagenesChequesResponseType>
                        <CHEQUE_RECORD_STATUS>{ xf:obtener-success-indicator(data($registroImagenesChequesResponse/resultadoOperacion)) }</CHEQUE_RECORD_STATUS>
                        <ACCOUNT_NUMBER>{ data($registroImagenesChequesResponse/numeroCuenta) }</ACCOUNT_NUMBER>
                        <CHEQUE_NUMBER>{ data($registroImagenesChequesResponse/numeroCheque) }</CHEQUE_NUMBER>
                        {
                            for $mensajeError in $registroImagenesChequesResponse/mensajeError
                            return
                                <CHEQUE_ERROR_MESSAGE>{ data($mensajeError) }</CHEQUE_ERROR_MESSAGE>
                        }
                    </ns0:registroMultipleImagenesChequesResponseType>
            }
        </ns0:registroMultipleImagenesChequesResponse>
};

declare variable $registrarImagenesChequesResponse1 as element(ns1:registrarImagenesChequesResponse) external;

xf:registroMultipleImagenesOut($registrarImagenesChequesResponse1)