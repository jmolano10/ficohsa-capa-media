(:: pragma bea:global-element-parameter parameter="$cuentasResponse" element="ns1:sjConsultaActivosClienteResponse" location="../../../BusinessServices/SJS/consultaActivosCliente/xsd/sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaActivosClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/consultaActivosClienteSjOut/";

declare function mensajeRespuesta($successIndicator as xs:string, $registros as item()*) as xs:string {
	if (upper-case($successIndicator) = 'SUCCESS' and count($registros) > 0) then (
		'Success'
    ) else if (upper-case($successIndicator) = 'SUCCESS' and count($registros) = 0) then (
    	'No Records'
    ) else (
    	'Error'
    )
};

declare function xf:consultaActivosClienteOut_v2($cuentasResponse as element(ns1:sjConsultaActivosClienteResponse),
	$functionalityDisplayIndicator as xs:string)
    as element(ns2:consultaActivosClienteResponse) {
        <ns2:consultaActivosClienteResponse>
            <ns2:consultaActivosClienteAhorrosResponseType>
            	{
                    for $successIndicator in $cuentasResponse/ns1:consultaCuentaAhorrosResponse/ns1:successIndicator
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($successIndicator), $cuentasResponse/ns1:consultaCuentaAhorrosResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord) }</SUCCESS_INDICATOR>
                }
                {
                    for $consultaActivoResponseRecord in $cuentasResponse/ns1:consultaCuentaAhorrosResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                    return
                        <ns2:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>AHO</ASSET_TYPE>
                            {
                                for $ACCOUNTNUMBER in $consultaActivoResponseRecord/ns1:ACCOUNTNUMBER
                                return
                                    <ASSET_NUMBER>{ data($ACCOUNTNUMBER) }</ASSET_NUMBER>
                            }
                            {
                                for $ACCOUNTNAME in $consultaActivoResponseRecord/ns1:ACCOUNTNAME
                                return
                                    <ASSET_NAME>{ data($ACCOUNTNAME) }</ASSET_NAME>
                            }
                            {
                                for $CURRENCY in $consultaActivoResponseRecord/ns1:CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
									for $TOTALBALANCE in $consultaActivoResponseRecord/ns1:TOTALBALANCE
                                	return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
								)else
								(
								)
                            }
                            {                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
									for $RESERVEBALANCE in $consultaActivoResponseRecord/ns1:RESERVEBALANCE
                               	 	return
                                    <ASSET_RESERVE_BALANCE>{ data($RESERVEBALANCE) }</ASSET_RESERVE_BALANCE>
								)else
								(
								)                           
                            }
                            {                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
									for $LIENBALANCE in $consultaActivoResponseRecord/ns1:LIENBALANCE
                                	return
                                    <ASSET_LOCKED_BALANCE>{ data($LIENBALANCE) }</ASSET_LOCKED_BALANCE>
								)else
								(
								)                                                            
                            }
                            {                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','AHO','CTA')) then (
									for $BLOCKEDFUNDSPOS in $consultaActivoResponseRecord/ns1:BLOCKEDFUNDSPOS,
                                    $BLOCKEDFUNDSATM in $consultaActivoResponseRecord/ns1:BLOCKEDFUNDSATM
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
									for $AVAILABLEBAL in $consultaActivoResponseRecord/ns1:AVAILABLEBAL
                                	return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBAL) }</ASSET_AVAILABLE_BALANCE>
								)else
								(
								)                                                            
                            }
                            <ASSET_SOURCE_BANK>HN01</ASSET_SOURCE_BANK>
                            {
                                for $PRODUCT_TYPE in $consultaActivoResponseRecord/ns1:PRODUCTTYPE
                                return
                                    <ASSET_PRODUCT_TYPE>{ data($PRODUCT_TYPE) }</ASSET_PRODUCT_TYPE>
                            }
                            {
                                for $OPENINGDATE in $consultaActivoResponseRecord/ns1:OPENINGDATE
                                return
                                    <OPENING_DATE>{ data($OPENINGDATE) }</OPENING_DATE>
                            }
                            {
                                for $RECORDSTATUS in $consultaActivoResponseRecord/ns1:INACTIVMARKER
                                return
                                    <ACCOUNT_STATUS>{ data($RECORDSTATUS) }</ACCOUNT_STATUS>
                            }                            
                        </ns2:consultaActivosClienteResponseRecordType>
                }
            </ns2:consultaActivosClienteAhorrosResponseType>
            <ns2:consultaActivosClienteCorrienteResponseType>
            	{
                    for $successIndicator in $cuentasResponse/ns1:consultaCuentaCorrienteResponse/ns1:successIndicator
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($successIndicator), $cuentasResponse/ns1:consultaCuentaCorrienteResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord)  }</SUCCESS_INDICATOR>
                }
                {
                    for $consultaActivoResponseRecord in $cuentasResponse/ns1:consultaCuentaCorrienteResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                    return
                        <ns2:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>CHQ</ASSET_TYPE>
                            {
                                for $ACCOUNTNUMBER in $consultaActivoResponseRecord/ns1:ACCOUNTNUMBER
                                return
                                    <ASSET_NUMBER>{ data($ACCOUNTNUMBER) }</ASSET_NUMBER>
                            }
                            {
                                for $ACCOUNTNAME in $consultaActivoResponseRecord/ns1:ACCOUNTNAME
                                return
                                    <ASSET_NAME>{ data($ACCOUNTNAME) }</ASSET_NAME>
                            }
                            {
                                for $CURRENCY in $consultaActivoResponseRecord/ns1:CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $TOTALBALANCE in $consultaActivoResponseRecord/ns1:TOTALBALANCE
                                	return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
								)else
								(
								)                            	                                     
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $RESERVEBALANCE in $consultaActivoResponseRecord/ns1:RESERVEBALANCE
                                	return
                                    <ASSET_RESERVE_BALANCE>{ data($RESERVEBALANCE) }</ASSET_RESERVE_BALANCE>
								)else
								(
								)                            	                                     
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $LIENBALANCE in $consultaActivoResponseRecord/ns1:LIENBALANCE
                                	return
                                    <ASSET_LOCKED_BALANCE>{ data($LIENBALANCE) }</ASSET_LOCKED_BALANCE>
								)else
								(
								)                            	                                     
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','CTA','CHQ')) then (
									for $BLOCKEDFUNDSPOS in $consultaActivoResponseRecord/ns1:BLOCKEDFUNDSPOS,
                                    $BLOCKEDFUNDSATM in $consultaActivoResponseRecord/ns1:BLOCKEDFUNDSATM
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
									for $AVAILABLEBAL in $consultaActivoResponseRecord/ns1:AVAILABLEBAL
                                	return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBAL) }</ASSET_AVAILABLE_BALANCE>
								)else
								(
								)                            	                                     
                            }
                            <ASSET_SOURCE_BANK>HN01</ASSET_SOURCE_BANK>
                            {
                                for $PRODUCT_TYPE in $consultaActivoResponseRecord/ns1:PRODUCTTYPE
                                return
                                    <ASSET_PRODUCT_TYPE>{ data($PRODUCT_TYPE) }</ASSET_PRODUCT_TYPE>
                            }
                            {
                                for $OPENINGDATE in $consultaActivoResponseRecord/ns1:OPENINGDATE
                                return
                                    <OPENING_DATE>{ data($OPENINGDATE) }</OPENING_DATE>
                            }
                            {
                                for $RECORDSTATUS in $consultaActivoResponseRecord/ns1:INACTIVMARKER
                                return
                                    <ACCOUNT_STATUS>{ data($RECORDSTATUS) }</ACCOUNT_STATUS>
                            }                            
                        </ns2:consultaActivosClienteResponseRecordType>
                }
            </ns2:consultaActivosClienteCorrienteResponseType>
            <ns2:consultaActivosClienteDepositosResponseType>
            	{
                    for $successIndicator in $cuentasResponse/ns1:consultaCertifDepositoResponse/ns1:successIndicator
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($successIndicator), $cuentasResponse/ns1:consultaCertifDepositoResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord)  }</SUCCESS_INDICATOR>
                }
                {
                    for $consultaActivoResponseRecord in $cuentasResponse/ns1:consultaCertifDepositoResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                    return
                        <ns2:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>DEP</ASSET_TYPE>
                            {
                                for $ACCOUNTNUMBER in $consultaActivoResponseRecord/ns1:ACCOUNTNUMBER
                                return
                                    <ASSET_NUMBER>{ data($ACCOUNTNUMBER) }</ASSET_NUMBER>
                            }
                            {
                                for $ACCOUNTNAME in $consultaActivoResponseRecord/ns1:ACCOUNTNAME
                                return
                                    <ASSET_NAME>{ data($ACCOUNTNAME) }</ASSET_NAME>
                            }
                            {
                                for $CURRENCY in $consultaActivoResponseRecord/ns1:CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','DEP')) then (
									for $TOTALBALANCE in $consultaActivoResponseRecord/ns1:TOTALBALANCE
                                	return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
								)else
								(
								)
                                
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','DEP')) then (
									for $RESERVEBALANCE in $consultaActivoResponseRecord/ns1:RESERVEBALANCE
                                	return
                                    <ASSET_RESERVE_BALANCE>{ data($RESERVEBALANCE) }</ASSET_RESERVE_BALANCE>
								)else
								(
								)
                                
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','DEP')) then (
									for $LIENBALANCE in $consultaActivoResponseRecord/ns1:LIENBALANCE
                                	return
                                    <ASSET_LOCKED_BALANCE>{ data($LIENBALANCE) }</ASSET_LOCKED_BALANCE>
								)else
								(
								)
                                
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','DEP')) then (
									for $BLOCKEDFUNDSPOS in $consultaActivoResponseRecord/ns1:BLOCKEDFUNDSPOS,
                                    $BLOCKEDFUNDSATM in $consultaActivoResponseRecord/ns1:BLOCKEDFUNDSATM
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
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','DEP')) then (
									for $AVAILABLEBAL in $consultaActivoResponseRecord/ns1:AVAILABLEBAL
                                	return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBAL) }</ASSET_AVAILABLE_BALANCE>
								)else
								(
								)
                                
                            }
                            <ASSET_SOURCE_BANK>HN01</ASSET_SOURCE_BANK>
                            {
                                for $OPENINGDATE in $consultaActivoResponseRecord/ns1:OPENINGDATE
                                return
                                    <OPENING_DATE>{ data($OPENINGDATE) }</OPENING_DATE>
                            }
                            {
                                for $RECORDSTATUS in $consultaActivoResponseRecord/ns1:INACTIVMARKER
                                return
                                    <ACCOUNT_STATUS>{ data($RECORDSTATUS) }</ACCOUNT_STATUS>
                            }                            
                        </ns2:consultaActivosClienteResponseRecordType>
                }
            </ns2:consultaActivosClienteDepositosResponseType>
            
             <ns2:consultaActivosClientePensionesResponseType>
                {
                    for $successIndicator in $cuentasResponse/ns1:consultaActivosClientePensionesResponseType/ns1:successIndicator
                    return
                        <SUCCESS_INDICATOR>{ mensajeRespuesta(data($successIndicator), $cuentasResponse/ns1:consultaActivosClientePensionesResponseType/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord)  }</SUCCESS_INDICATOR>
                }
                {
                    for $consultaActivoResponseRecord in $cuentasResponse/ns1:consultaActivosClientePensionesResponseType/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                    return
                        <ns2:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>FPC</ASSET_TYPE>
                            {
                                for $ACCOUNTNUMBER in $consultaActivoResponseRecord/ns1:ACCOUNTNUMBER
                                return
                                    <ASSET_NUMBER>{ fn:string($ACCOUNTNUMBER/text()) }</ASSET_NUMBER>
                            }
                            {
                                for $ACCOUNTNAME in $consultaActivoResponseRecord/ns1:ACCOUNTNAME
                                return
                                    <ASSET_NAME>{ data($ACCOUNTNAME) }</ASSET_NAME>
                            }
                            {
                                for $CURRENCY in $consultaActivoResponseRecord/ns1:CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','FPC')) then (
									for $TOTALBALANCE in $consultaActivoResponseRecord/ns1:TOTALBALANCE
                                	return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
								)else
								(
								)
                                
                            }
                            {
                                                        	
                            	if ($functionalityDisplayIndicator = ('ALL','FPC')) then (
									for $AVAILABLEBAL in $consultaActivoResponseRecord/ns1:AVAILABLEBAL
                                	return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBAL) }</ASSET_AVAILABLE_BALANCE>
								)else
								(
								)
                                
                            }
                            <ASSET_SOURCE_BANK>HN01</ASSET_SOURCE_BANK>
                            {
                                for $OPENINGDATE in $consultaActivoResponseRecord/ns1:OPENINGDATE
                                return
                                    <OPENING_DATE>{ data($OPENINGDATE) }</OPENING_DATE>
                            }
                            {
                                for $RECORDSTATUS in $consultaActivoResponseRecord/ns1:INACTIVMARKER
                                return
                                    <ACCOUNT_STATUS>{ data($RECORDSTATUS) }</ACCOUNT_STATUS>
                            }                            
                        </ns2:consultaActivosClienteResponseRecordType>
                }
            </ns2:consultaActivosClientePensionesResponseType>
        </ns2:consultaActivosClienteResponse>
};

declare variable $cuentasResponse as element(ns1:sjConsultaActivosClienteResponse) external;
declare variable $functionalityDisplayIndicator as xs:string external;

xf:consultaActivosClienteOut_v2($cuentasResponse,
$functionalityDisplayIndicator)