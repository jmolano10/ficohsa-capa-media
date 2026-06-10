<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ahorroResponse" element="ns0:ConsultadectasahorroporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$corrienteResponse" element="ns0:ConsultactascorrienteporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoResponse" element="ns0:ConsultadecertifdepporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/consultaActivosClienteHeaderOut/";

declare function xf:consultaActivosClienteHeaderOut($ahorroResponse as element(ns0:ConsultadectasahorroporclienteResponse),
    $corrienteResponse as element(ns0:ConsultactascorrienteporclienteResponse),
    $depositoResponse as element(ns0:ConsultadecertifdepporclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicatorAhorro := $ahorroResponse/Status/successIndicator,
                    $successIndicatorCorriente := $corrienteResponse/Status/successIndicator,
                    $successIndicatorDeposito := $depositoResponse/Status/successIndicator
                return
                	if ( data($successIndicatorAhorro) != "Success" and data($successIndicatorCorriente) != "Success" and data($successIndicatorDeposito) != "Success") then (
                    	<successIndicator>ERROR</successIndicator>,
                    	for $messages in $ahorroResponse/Status/messages union $depositoResponse/Status/messages union $corrienteResponse/Status/messages
                    	return
                    		<messages>{data($messages)}</messages> 
                    ) else (
                    	let $ahorros := count($ahorroResponse/WSFICOLINKSAVINGSACCTType/gWSFICOLINKSAVINGSACCTDetailType/mWSFICOLINKSAVINGSACCTDetailType)
                    	let $corrientes := count($corrienteResponse/WSFICOLINKCURRENTACCTType/gWSFICOLINKCURRENTACCTDetailType/mWSFICOLINKCURRENTACCTDetailType)
                    	let $depositos := count($depositoResponse/WSFICOTERMDEPOSITType/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType)
                    	return 
		                    if ( (number($ahorros) + number($corrientes) + number($depositos)) > 0 ) then (
		                    	<successIndicator>Success</successIndicator>
		                    ) else (
		                    	<successIndicator>NO RECORDS</successIndicator>,
		                    	for $messages in $ahorroResponse/Status/messages union $depositoResponse/Status/messages union $corrienteResponse/Status/messages
		                    	return
		                    		<messages>{data($messages)}</messages>		                    
		                    )
                    )
            }
        </ns1:ResponseHeader>
};

declare variable $ahorroResponse as element(ns0:ConsultadectasahorroporclienteResponse) external;
declare variable $corrienteResponse as element(ns0:ConsultactascorrienteporclienteResponse) external;
declare variable $depositoResponse as element(ns0:ConsultadecertifdepporclienteResponse) external;

xf:consultaActivosClienteHeaderOut($ahorroResponse,
    $corrienteResponse,
    $depositoResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_1144838292.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>