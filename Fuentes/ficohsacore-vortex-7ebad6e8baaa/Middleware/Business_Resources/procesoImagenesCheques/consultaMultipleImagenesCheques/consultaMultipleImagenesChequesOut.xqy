xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarImagenesChequesResponse1" element="ns1:consultarImagenesChequesResponse" location="../Resources/XMLSchema_-753785776.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMultipleImagenesChequesResponse" location="../Resources/procesoImagenesChequesTypes.xsd" ::)

declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/consultaMultipleImagenesCheques/consultaMultipleImagenesChequesOut/";

declare function xf:obtener-success-indicator($indicator as xs:string) as xs:string {
	if ($indicator = "true" or $indicator = "TRUE") then (
		"Success"
	) else (
		"Error"
	)
};

declare function xf:consultaMultipleImagenesChequesOut($consultarImagenesChequesResponse1 as element(ns1:consultarImagenesChequesResponse))
    as element(ns0:consultaMultipleImagenesChequesResponse) {
        <ns0:consultaMultipleImagenesChequesResponse>
            {
                for $numeroCuenta in $consultarImagenesChequesResponse1/consultaImagenesChequesResponse/numeroCuenta
                return
                    <ACCOUNT_NUMBER>{ data($numeroCuenta) }</ACCOUNT_NUMBER>
            }
            <TOTAL_CHEQUES_FOUND>{ fn:string(data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/totalChequesEncontrados)) }</TOTAL_CHEQUES_FOUND>
            <TOTAL_CHEQUES_RETURNED>{ fn:string(data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/totalChequesRetornados)) }</TOTAL_CHEQUES_RETURNED>
            <INITIAL_POSITION_RETURNED>{ fn:string(data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/posicionInicial)) }</INITIAL_POSITION_RETURNED>
            <LAST_POSITION_RETURNED>{ fn:string(data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/posicionFinal)) }</LAST_POSITION_RETURNED>
            {
                for $consultaImagenesChequesArrayDetailResponse in $consultarImagenesChequesResponse1/consultaImagenesChequesResponse/consultaImagenesChequesArrayResponse/consultaImagenesChequesArrayDetailResponse
                return
                    <ns0:consultaMultipleImagenesChequesResponseType>
                        {
                            for $numeroCheque in $consultaImagenesChequesArrayDetailResponse/numeroCheque
                            return
                                <CHEQUE_NUMBER>{ data($numeroCheque) }</CHEQUE_NUMBER>
                        }
                        {
                            for $fechaTransaccion in $consultaImagenesChequesArrayDetailResponse/fechaTransaccion
                            return
                                <TRANSACTION_DATE>{ data($fechaTransaccion) }</TRANSACTION_DATE>
                        }
                        {
                            for $anversoCheque in $consultaImagenesChequesArrayDetailResponse/anversoCheque
                            return
                                <CHEQUE_IMAGE_FRONT>{ data($anversoCheque) }</CHEQUE_IMAGE_FRONT>
                        }
                        {
                            for $reversoCheque in $consultaImagenesChequesArrayDetailResponse/reversoCheque
                            return
                                <CHEQUE_IMAGE_BACK>{ data($reversoCheque) }</CHEQUE_IMAGE_BACK>
                        }
                        {
                            for $formatoImagen in $consultaImagenesChequesArrayDetailResponse/formatoImagen
                            return
                                <FILE_EXTENSION>{ data($formatoImagen) }</FILE_EXTENSION>
                        }
                        <QUERY_STATUS>{ xf:obtener-success-indicator(data($consultaImagenesChequesArrayDetailResponse/resultadoOperacion)) }</QUERY_STATUS>
                        {
                            for $mensajeError in $consultaImagenesChequesArrayDetailResponse/mensajeError
                            return
                                <QUERY_DESCRIPTION>{ data($mensajeError) }</QUERY_DESCRIPTION>
                        }
                    </ns0:consultaMultipleImagenesChequesResponseType>
            }
        </ns0:consultaMultipleImagenesChequesResponse>
};

declare variable $consultarImagenesChequesResponse1 as element(ns1:consultarImagenesChequesResponse) external;

xf:consultaMultipleImagenesChequesOut($consultarImagenesChequesResponse1)