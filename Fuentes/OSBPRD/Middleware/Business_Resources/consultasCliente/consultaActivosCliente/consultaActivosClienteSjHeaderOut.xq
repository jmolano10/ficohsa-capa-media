(:: pragma bea:global-element-parameter parameter="$activosResponse" element="ns0:sjConsultaActivosClienteResponse" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/consultaActivosClienteCtaHeaderOut/";

declare function xf:consultaActivosClienteCtaHeaderOut($activosResponse as element(ns0:sjConsultaActivosClienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicatorAhorros := $activosResponse/ns0:consultaCuentaAhorrosResponse/ns0:successIndicator/text()
                let $successIndicatorCorriente := $activosResponse/ns0:consultaCuentaCorrienteResponse/ns0:successIndicator/text()
                let $successIndicatorDepositos := $activosResponse/ns0:consultaCertifDepositoResponse/ns0:successIndicator/text()
                return
                	if ( data($successIndicatorAhorros) != "Success" and data($successIndicatorCorriente) != "Success" and data($successIndicatorDepositos) != "Success") then (
                    	<successIndicator>ERROR</successIndicator>,
                    	for $messages in $activosResponse/ns0:consultaCuentaAhorrosResponse/ns0:messages union $activosResponse/ns0:consultaCuentaCorrienteResponse/ns0:messages union $activosResponse/ns0:consultaCertifDepositoResponse/ns0:messages
                    	return
                    		<messages>{data($messages)}</messages> 
                    ) else (
                    	let $ahorros := count($activosResponse/ns0:consultaCuentaAhorrosResponse/ns0:consultaActivoResponseRecords/ns0:consultaActivoResponseRecord)
                    	let $corrientes := count($activosResponse/ns0:consultaCuentaCorrienteResponse/ns0:consultaActivoResponseRecords/ns0:consultaActivoResponseRecord)
                    	let $depositos := count($activosResponse/ns0:consultaCertifDepositoResponse/ns0:consultaActivoResponseRecords/ns0:consultaActivoResponseRecord)
                    	return 
		                    if ( (number($ahorros) + number($corrientes) + number($depositos) ) > 0 ) then (
		                    	<successIndicator>Success</successIndicator>
		                    ) else (
		                    	<successIndicator>NO RECORDS</successIndicator>,
		                    	for $messages in $activosResponse/ns0:consultaCuentaAhorrosResponse/ns0:messages union $activosResponse/ns0:consultaCuentaCorrienteResponse/ns0:messages union $activosResponse/ns0:consultaCertifDepositoResponse/ns0:messages
		                    	return
		                    		<messages>{data($messages)}</messages>		                    
		                    )
                    )
            }
        </ns1:ResponseHeader>
};

declare variable $activosResponse as element(ns0:sjConsultaActivosClienteResponse) external;

xf:consultaActivosClienteCtaHeaderOut($activosResponse)