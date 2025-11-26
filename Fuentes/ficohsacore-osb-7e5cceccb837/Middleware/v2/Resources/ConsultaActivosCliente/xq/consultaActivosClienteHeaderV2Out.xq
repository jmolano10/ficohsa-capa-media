(:: pragma bea:global-element-parameter parameter="$ahorroResponse" element="ns0:ConsultaCuentaAhorroxClienteResponse" location="../../../BusinessServices/T24/ConsultaCuentaAhorro/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$corrienteResponse" element="ns0:ConsultaCuentaCorrientexClienteResponse" location="../../../BusinessServices/T24/ConsultaCuentaCorriente/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoResponse" element="ns0:ConsultadecertifdepporclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/ConsultaFondoPensiones12c/xsd/GetAssetsCustomerTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "https://www.ficohsa.com/regional/pension";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/consultaActivosClienteHeaderOut/";

declare function xf:consultaActivosClienteHeaderOut($ahorroResponse as element(ns0:ConsultaCuentaAhorroxClienteResponse),
    $corrienteResponse as element(ns0:ConsultaCuentaCorrientexClienteResponse),
    $depositoResponse as element(ns0:ConsultadecertifdepporclienteResponse),
    $outputParameters as element(ns2:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicatorAhorro := $ahorroResponse/Status/successIndicator,
                    $successIndicatorCorriente := $corrienteResponse/Status/successIndicator,
                    $successIndicatorDeposito := $depositoResponse/Status/successIndicator,
                    $successIndicatorPensiones := $outputParameters/StatusInfo/Status
                return
                	if ( data($successIndicatorAhorro) != "Success" and data($successIndicatorCorriente) != "Success" and data($successIndicatorDeposito) != "Success" and ($successIndicatorPensiones) != "Success") then (
                    	<successIndicator>ERROR</successIndicator>,
                    	for $messages in $ahorroResponse/Status/messages union $depositoResponse/Status/messages union $corrienteResponse/Status/messages union $outputParameters/ErrorInfo/Details/Messages
                    	return
                    		<messages>{data($messages)}</messages> 
                    ) else (
                    	let $ahorros := count($ahorroResponse/WSFICOLINKSAVINGSACCOUNTType/gWSFICOLINKSAVINGSACCOUNTDetailType/mWSFICOLINKSAVINGSACCOUNTDetailType)
                    	let $corrientes := count($corrienteResponse/WSFICOLINKCURRENTACCOUNTType/gWSFICOLINKCURRENTACCOUNTDetailType/mWSFICOLINKCURRENTACCOUNTDetailType)
                    	let $depositos := count($depositoResponse/WSFICOTERMDEPOSITType/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType)
                    	let $pensiones := count($outputParameters/PT_CUENTAS/CUENTA)
                    	return 
		                    if ( (number($ahorros) + number($corrientes) + number($depositos) + number($pensiones)) > 0) then (
		                    	<successIndicator>Success</successIndicator>
		                    ) else (
		                    	<successIndicator>NO RECORDS</successIndicator>,
		                    	for $messages in $ahorroResponse/Status/messages union $depositoResponse/Status/messages union $corrienteResponse/Status/messages union $outputParameters/ns2:DESCRIPCION_ERROR
		                    	return
		                    		<messages>{data($messages)}</messages>		                    
		                    )
                    )
            }
        </ns1:ResponseHeader>
};

declare variable $ahorroResponse as element(ns0:ConsultaCuentaAhorroxClienteResponse) external;
declare variable $corrienteResponse as element(ns0:ConsultaCuentaCorrientexClienteResponse) external;
declare variable $depositoResponse as element(ns0:ConsultadecertifdepporclienteResponse) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:consultaActivosClienteHeaderOut($ahorroResponse,
    $corrienteResponse,
    $depositoResponse,
    $outputParameters)