xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadectasahorroporclienteResponse1" element="ns0:ConsultadectasahorroporclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultactascorrienteporclienteResponse1" element="ns0:ConsultactascorrienteporclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadecertifdepporclienteResponse1" element="ns0:ConsultadecertifdepporclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaActivosClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFondoPensiones";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteOut/";

declare function mensajeRespuesta($successIndicator as xs:string, $registros as item()*) as xs:string {
	if (upper-case($successIndicator) = 'SUCCESS' and count($registros) > 0) then (
		'Success'
    ) else if (upper-case($successIndicator) = 'SUCCESS' and count($registros) = 0) then (
    	'No Records'
    ) else (
    	'Error'
    )
};


declare function xf:consultaActivosClienteOut($functionalityDisplayIndicator as xs:string,
    $consultadectasahorroporclienteResponse1 as element(ns0:ConsultadectasahorroporclienteResponse),
    $consultactascorrienteporclienteResponse1 as element(ns0:ConsultactascorrienteporclienteResponse),
    $consultadecertifdepporclienteResponse1 as element(ns0:ConsultadecertifdepporclienteResponse),
    $outputParameters as element(ns2:OutputParameters))
    as element(ns1:consultaActivosClienteResponse) {
        <ns1:consultaActivosClienteResponse>
            <ns1:consultaActivosClienteAhorrosResponseType>
            	{
                    for $successIndicator in $consultadectasahorroporclienteResponse1/Status/successIndicator
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($successIndicator), $consultadectasahorroporclienteResponse1/WSFICOLINKSAVINGSACCTType[1]/gWSFICOLINKSAVINGSACCTDetailType/mWSFICOLINKSAVINGSACCTDetailType)  }</SUCCESS_INDICATOR>
                }
                {
                    for $mFICOLINKSAVINGSACCTDetailType in $consultadectasahorroporclienteResponse1/WSFICOLINKSAVINGSACCTType[1]/gWSFICOLINKSAVINGSACCTDetailType/mWSFICOLINKSAVINGSACCTDetailType
                    return
                        <ns1:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>AHO</ASSET_TYPE>
                            {
                                let $ACCOUNTNUMBER := $mFICOLINKSAVINGSACCTDetailType/ACCOUNTNUMBER/text()
                                let $ALTACCTID := $mFICOLINKSAVINGSACCTDetailType/ALTACCTID/text()
                                return
                                if ( exists($ALTACCTID) ) then (
                                	<ASSET_NUMBER>{ $ALTACCTID }</ASSET_NUMBER>
                                ) else (
                                	<ASSET_NUMBER>{ $ACCOUNTNUMBER }</ASSET_NUMBER>
                                )                              
                            }
                            {
                                for $ACCOUNTTITLE in $mFICOLINKSAVINGSACCTDetailType/ACCOUNTTITLE
                                return
                                    <ASSET_NAME>{ data($ACCOUNTTITLE) }</ASSET_NAME>
                            }                            
                            {
                                for $CURRENCY in $mFICOLINKSAVINGSACCTDetailType/CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {                            
                                if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
                                	for $TOTALBALANCE in $mFICOLINKSAVINGSACCTDetailType/TOTALBALANCE
                                	return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
                                )else
                                (
                                )                                
                            }                            
                            {	                            
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
                                	for $RESERVEBALANCE in $mFICOLINKSAVINGSACCTDetailType/RESERVEBALANCE
                                	return
                                    <ASSET_RESERVE_BALANCE>{ data($RESERVEBALANCE) }</ASSET_RESERVE_BALANCE>
                                )else
                                (
                                ) 
                                
                            }
                            {
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
                                	for $LIENBALANCE in $mFICOLINKSAVINGSACCTDetailType/LIENBALANCE
                                	return
                                    <ASSET_LOCKED_BALANCE>{ data($LIENBALANCE) }</ASSET_LOCKED_BALANCE>
                                )else
                                (
                                )
                            }
                            {
                            	
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
									for $BLOCKEDFUNDSPOS in $mFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSPOS,
                                    $BLOCKEDFUNDSATM in $mFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSATM
                                	return
                                    <ASSET_VISA_FLOATING_BALANCE>
                                        {
                                            if ((string(number($BLOCKEDFUNDSPOS)) = "NaN" and string(number($BLOCKEDFUNDSATM)) = "NaN")) then
                                                (0)
                                            else 
                                                if (string(number($BLOCKEDFUNDSPOS)) != "NaN" and string(number($BLOCKEDFUNDSATM)) != "NaN") then (
                                                number($BLOCKEDFUNDSPOS) + number($BLOCKEDFUNDSATM)
                                                ) else if (string(number($BLOCKEDFUNDSPOS)) = "NaN") then (
                                                data($BLOCKEDFUNDSATM)
                                                ) else (
                                                data($BLOCKEDFUNDSPOS)
                                                )
                                        }
									</ASSET_VISA_FLOATING_BALANCE>
								)else
								(
								)                            	                            	                                
                            }
                            {                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
									for $AVAILABLEBAL in $mFICOLINKSAVINGSACCTDetailType/AVAILABLEBAL
                                	return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBAL) }</ASSET_AVAILABLE_BALANCE>
								)else
								(
								)                            	                                                            
                            }
                            <ASSET_SOURCE_BANK>HN01</ASSET_SOURCE_BANK>
                            {                            
                                if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
                                	for $OPERATIONTYPE in $mFICOLINKSAVINGSACCTDetailType/OPERATIONTYPE
                                	return
                                    <ASSET_PRODUCT_TYPE>{ data($OPERATIONTYPE) }</ASSET_PRODUCT_TYPE>
                                )else
                                (
                                )                                
                            }
                        </ns1:consultaActivosClienteResponseRecordType>
                }
            </ns1:consultaActivosClienteAhorrosResponseType>
            <ns1:consultaActivosClienteCorrienteResponseType>
            	{
                    for $successIndicator in $consultactascorrienteporclienteResponse1/Status/successIndicator
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($successIndicator),  $consultactascorrienteporclienteResponse1/WSFICOLINKCURRENTACCTType[1]/gWSFICOLINKCURRENTACCTDetailType/mWSFICOLINKCURRENTACCTDetailType) }</SUCCESS_INDICATOR>
                }
                {
                    for $mFICOLINKCURRENTACCTDetailType in $consultactascorrienteporclienteResponse1/WSFICOLINKCURRENTACCTType[1]/gWSFICOLINKCURRENTACCTDetailType/mWSFICOLINKCURRENTACCTDetailType
                    return
                        <ns1:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>CHQ</ASSET_TYPE>
                            {
                                let $ACCOUNTNUMBER := $mFICOLINKCURRENTACCTDetailType/ACCOUNTNUMBER/text()
                                let $ALTACCTID := $mFICOLINKCURRENTACCTDetailType/ALTACCTID/text()
                                return
                                if ( exists($ALTACCTID) ) then (
                                	<ASSET_NUMBER>{ $ALTACCTID }</ASSET_NUMBER>
                                ) else (
                                	<ASSET_NUMBER>{ $ACCOUNTNUMBER }</ASSET_NUMBER>
                                )                              
                            }
                            {
                                for $ACCOUNTNAME in $mFICOLINKCURRENTACCTDetailType/ACCOUNTNAME
                                return
                                    <ASSET_NAME>{ data($ACCOUNTNAME) }</ASSET_NAME>
                            }
                            {                                                        	
								for $CURRENCY in $mFICOLINKCURRENTACCTDetailType/CURRENCY
                                return
                                <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY> 
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $TOTALBALANCE in $mFICOLINKCURRENTACCTDetailType/TOTALBALANCE
                                	return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
								)else
								(
								)
                            	      
                                
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $RESERVEBALANCE in $mFICOLINKCURRENTACCTDetailType/RESERVEBALANCE
                                	return
                                    <ASSET_RESERVE_BALANCE>{ data($RESERVEBALANCE) }</ASSET_RESERVE_BALANCE>
								)else
								(
								)                            	                                      
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $LIENBALANCE in $mFICOLINKCURRENTACCTDetailType/LIENBALANCE
                                	return
                                    <ASSET_LOCKED_BALANCE>{ data($LIENBALANCE) }</ASSET_LOCKED_BALANCE>
								)else
								(
								)                            	                                      
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $BLOCKEDFUNDSPOS in $mFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSPOS,
                                    $BLOCKEDFUNDSATM in $mFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSATM
                                	return
                                    <ASSET_VISA_FLOATING_BALANCE>
                                        {
                                            if ((string(number($BLOCKEDFUNDSPOS)) = "NaN" and string(number($BLOCKEDFUNDSATM)) = "NaN")) then
                                                (0)
                                            else 
                                                if (string(number($BLOCKEDFUNDSPOS)) != "NaN" and string(number($BLOCKEDFUNDSATM)) != "NaN") then (
                                                number($BLOCKEDFUNDSPOS) + number($BLOCKEDFUNDSATM)
                                                ) else if (string(number($BLOCKEDFUNDSPOS)) = "NaN") then (
                                                data($BLOCKEDFUNDSATM)
                                                ) else (
                                                data($BLOCKEDFUNDSPOS)
                                                )
                                        }
									</ASSET_VISA_FLOATING_BALANCE>
								)else
								(
								)                            	                                      
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $AVAILABLEBALANCE in $mFICOLINKCURRENTACCTDetailType/AVAILABLEBALANCE
                                	return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBALANCE) }</ASSET_AVAILABLE_BALANCE>
								)else
								(
								)                            	                                      
                            }
                            <ASSET_SOURCE_BANK>HN01</ASSET_SOURCE_BANK>
                            {                            
                                if ($functionalityDisplayIndicator = ('ALL','CHQ','CTA')) then (
                                	for $OPERATIONTYPE in $mFICOLINKCURRENTACCTDetailType/OPERATIONTYPE
                                	return
                                    <ASSET_PRODUCT_TYPE>{ data($OPERATIONTYPE) }</ASSET_PRODUCT_TYPE>
                                )else
                                (
                                )                                
                            }
                        </ns1:consultaActivosClienteResponseRecordType>
                }
            </ns1:consultaActivosClienteCorrienteResponseType>
            <ns1:consultaActivosClienteDepositosResponseType>
            	{
                    for $successIndicator in $consultadecertifdepporclienteResponse1/Status/successIndicator
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($successIndicator), $consultadecertifdepporclienteResponse1/WSFICOTERMDEPOSITType[1]/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType) }</SUCCESS_INDICATOR>
                }
                {
                    for $mWSFICOTERMDEPOSITDetailType in $consultadecertifdepporclienteResponse1/WSFICOTERMDEPOSITType[1]/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType
                    return
                        <ns1:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>DEP</ASSET_TYPE>
                            {
                                let $DEPOSITNUMBER := $mWSFICOTERMDEPOSITDetailType/DEPOSITNUMBER/text()
                                let $ALTACCTID := $mWSFICOTERMDEPOSITDetailType/ALTACCTID/text()
                                return
                                if ( exists($ALTACCTID) ) then (
                                	<ASSET_NUMBER>{ $ALTACCTID }</ASSET_NUMBER>
                                ) else (
                                	<ASSET_NUMBER>{ $DEPOSITNUMBER }</ASSET_NUMBER>
                                )                              
                            }  
                            {
                                for $CUSTOMERNAME in $mWSFICOTERMDEPOSITDetailType/CUSTOMERNAME
                                return
                                    <ASSET_NAME>{ data($CUSTOMERNAME) }</ASSET_NAME>
                            }                                                      
                            {
                                for $CURRENCY in $mWSFICOTERMDEPOSITDetailType/CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {
                                                       	
                            	if ($functionalityDisplayIndicator = ('ALL','DEP')) then (
									for $AMOUNT in $mWSFICOTERMDEPOSITDetailType/AMOUNT
                                	return
                                    <ASSET_TOTAL_BALANCE>{ data($AMOUNT) }</ASSET_TOTAL_BALANCE>
								)else
								(
								)
                            	 
                                
                            }
                            {
                                                       	
                            	if ($functionalityDisplayIndicator = ('ALL','DEP')) then (
									for $AMOUNT in $mWSFICOTERMDEPOSITDetailType/AMOUNT
                                	return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AMOUNT) }</ASSET_AVAILABLE_BALANCE>
								)else
								(
								)                            	                                 
                            }
                            <ASSET_SOURCE_BANK>HN01</ASSET_SOURCE_BANK>
                        </ns1:consultaActivosClienteResponseRecordType>
                }
            </ns1:consultaActivosClienteDepositosResponseType>
            <ns1:consultaActivosClientePensionesResponseType>
            	{
                    for $CODIGO_ERROR in $outputParameters/ns2:CODIGO_ERROR
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($CODIGO_ERROR), $outputParameters/ns2:PT_CUENTAS/ns2:CUENTA) }</SUCCESS_INDICATOR>
                }
                {
                    for $CUENTA in $outputParameters/ns2:PT_CUENTAS/ns2:CUENTA
                    return
                        <ns1:consultaActivosClienteResponseRecordType>
                        	<ASSET_TYPE>FPC</ASSET_TYPE>
                            <ASSET_NUMBER>{ data($CUENTA/ns2:NUMERO_CUENTA) }</ASSET_NUMBER>
                            <ASSET_NAME>{ data($CUENTA/ns2:DESCRIPCION_CUENTA) }</ASSET_NAME>
                            <ASSET_CURRENCY>{ data($CUENTA/ns2:MONEDA) }</ASSET_CURRENCY>
                            <ASSET_TOTAL_BALANCE>{ data($CUENTA/ns2:SALDO_TOTAL) }</ASSET_TOTAL_BALANCE>
                            <ASSET_AVAILABLE_BALANCE>{ data($CUENTA/ns2:SALDO_DISPONIBLE) }</ASSET_AVAILABLE_BALANCE>
                        </ns1:consultaActivosClienteResponseRecordType>
                }
            </ns1:consultaActivosClientePensionesResponseType> 
        </ns1:consultaActivosClienteResponse>
};

declare variable $functionalityDisplayIndicator as xs:string external;
declare variable $consultadectasahorroporclienteResponse1 as element(ns0:ConsultadectasahorroporclienteResponse) external;
declare variable $consultactascorrienteporclienteResponse1 as element(ns0:ConsultactascorrienteporclienteResponse) external;
declare variable $consultadecertifdepporclienteResponse1 as element(ns0:ConsultadecertifdepporclienteResponse) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
xf:consultaActivosClienteOut($functionalityDisplayIndicator,
    $consultadectasahorroporclienteResponse1,
    $consultactascorrienteporclienteResponse1,
    $consultadecertifdepporclienteResponse1,
    $outputParameters)