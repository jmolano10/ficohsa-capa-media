xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaActivosClienteRespuesta" element="ns1:opConsultaActivosClienteRespuesta" location="../../../BusinessServices/CTS/activos/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaActivosClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobisactivos.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";

declare function mensajeRespuesta($successIndicator as xs:string, $registros as item()*) as xs:string {
	if ((upper-case($successIndicator) = 'SUCCESS' or $successIndicator = '0')  and count($registros) > 0) then (
		'Success'
    ) else if (((upper-case($successIndicator) = 'SUCCESS' or $successIndicator = '0') and count($registros) = 0) or upper-case($successIndicator) = 'NO RECORDS' ) then (
    	'No Records'
    ) else (
    	'Error'
    )
};

declare function xf:consultaActivosClienteNIOut($opConsultaActivosClienteRespuesta as element(ns1:opConsultaActivosClienteRespuesta))
    as element(ns3:consultaActivosClienteResponse) {
        <ns3:consultaActivosClienteResponse>
            <ns3:consultaActivosClienteAhorrosResponseType>
            {
                for $ERROR_CODE in $opConsultaActivosClienteRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta
                return
                    <SUCCESS_INDICATOR>{ mensajeRespuesta(data($ERROR_CODE), $opConsultaActivosClienteRespuesta/ns0:activos[ns0:cuenta/ns0:codTipoProducto = 'AHO']) }</SUCCESS_INDICATOR>
            }            
            {
                for $activos in $opConsultaActivosClienteRespuesta/ns0:activos[ns0:cuenta/ns0:codTipoProducto = 'AHO']
                return         	
                    <ns3:consultaActivosClienteResponseRecordType>
	                	<ASSET_TYPE>AHO</ASSET_TYPE>
	                    <ASSET_NUMBER>{ data($activos/ns0:cuenta/ns0:codCuentaHabiente) }</ASSET_NUMBER>
	                    <ASSET_NAME>{ data($activos/ns0:cuenta/ns0:valTipoProducto) }</ASSET_NAME>
	                    <ASSET_CURRENCY>{ data($activos/ns0:cuenta/ns0:moneda/ns0:valSimboloMoneda) }</ASSET_CURRENCY>
	                    <ASSET_TOTAL_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoTotal), 2) }</ASSET_TOTAL_BALANCE>	                   
	                    <ASSET_RESERVE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuentaReserva/ns0:montoReserva), 2) }</ASSET_RESERVE_BALANCE>
	                    <ASSET_LOCKED_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valMontoBloqueado), 2) }</ASSET_LOCKED_BALANCE>
	                    <ASSET_VISA_FLOATING_BALANCE>{ fn:round-half-to-even(data($activos/ns0:valBalanceFlotante), 2) }</ASSET_VISA_FLOATING_BALANCE>
	                    <ASSET_AVAILABLE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoDisponible),2 ) }</ASSET_AVAILABLE_BALANCE>	
                  	    <INTERNATIONAL_ACCOUNT_NUMBER>{data($activos/ns0:cuenta/ns0:codigoIBAN)}</INTERNATIONAL_ACCOUNT_NUMBER>
					</ns3:consultaActivosClienteResponseRecordType>
            }
            </ns3:consultaActivosClienteAhorrosResponseType>
            
            <ns3:consultaActivosClienteCorrienteResponseType>
            {
                for $ERROR_CODE in $opConsultaActivosClienteRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta
                return
                    <SUCCESS_INDICATOR>{ mensajeRespuesta(data($ERROR_CODE), $opConsultaActivosClienteRespuesta/ns0:activos[ns0:cuenta/ns0:codTipoProducto = 'CTE']) }</SUCCESS_INDICATOR>
            }
            {
            	for $activos in $opConsultaActivosClienteRespuesta/ns0:activos[ns0:cuenta/ns0:codTipoProducto = 'CTE']
                return        	
                    <ns3:consultaActivosClienteResponseRecordType>
	                    <ASSET_TYPE>CHQ</ASSET_TYPE>
	                   <ASSET_NUMBER>{ data($activos/ns0:cuenta/ns0:codCuentaHabiente) }</ASSET_NUMBER>
	                    <ASSET_NAME>{ data($activos/ns0:cuenta/ns0:valTipoProducto) }</ASSET_NAME>
	                    <ASSET_CURRENCY>{ data($activos/ns0:cuenta/ns0:moneda/ns0:valSimboloMoneda) }</ASSET_CURRENCY>
	                    <ASSET_TOTAL_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoTotal), 2) }</ASSET_TOTAL_BALANCE>	                   
	                    <ASSET_RESERVE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuentaReserva/ns0:montoReserva), 2) }</ASSET_RESERVE_BALANCE>
	                    <ASSET_LOCKED_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valMontoBloqueado), 2) }</ASSET_LOCKED_BALANCE>
	                    <ASSET_VISA_FLOATING_BALANCE>{ fn:round-half-to-even(data($activos/ns0:valBalanceFlotante), 2) }</ASSET_VISA_FLOATING_BALANCE>
	                    <ASSET_AVAILABLE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoDisponible),2 ) }</ASSET_AVAILABLE_BALANCE>	
                  	    <INTERNATIONAL_ACCOUNT_NUMBER>{data($activos/ns0:cuenta/ns0:codigoIBAN)}</INTERNATIONAL_ACCOUNT_NUMBER>
					</ns3:consultaActivosClienteResponseRecordType>
            }
            </ns3:consultaActivosClienteCorrienteResponseType>
            
            <ns3:consultaActivosClienteDepositosResponseType>
            {
                for $ERROR_CODE in $opConsultaActivosClienteRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta
                return
                    <SUCCESS_INDICATOR>{ mensajeRespuesta(data($ERROR_CODE), $opConsultaActivosClienteRespuesta/ns0:activos[ns0:cuenta/ns0:codTipoProducto = 'PFI']) }</SUCCESS_INDICATOR>
            }
            {
                for $activos in $opConsultaActivosClienteRespuesta/ns0:activos[ns0:cuenta/ns0:codTipoProducto = 'PFI']
                return         	
                    <ns3:consultaActivosClienteResponseRecordType>
	                    <ASSET_TYPE>DEP</ASSET_TYPE>
	                   <ASSET_NUMBER>{ data($activos/ns0:cuenta/ns0:codCuentaHabiente) }</ASSET_NUMBER>
	                    <ASSET_NAME>{ data($activos/ns0:cuenta/ns0:valTipoProducto) }</ASSET_NAME>
	                    <ASSET_CURRENCY>{ data($activos/ns0:cuenta/ns0:moneda/ns0:valSimboloMoneda) }</ASSET_CURRENCY>
	                    <ASSET_TOTAL_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoTotal), 2) }</ASSET_TOTAL_BALANCE>	                   
	                    <ASSET_RESERVE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuentaReserva/ns0:montoReserva), 2) }</ASSET_RESERVE_BALANCE>
	                    <ASSET_LOCKED_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valMontoBloqueado), 2) }</ASSET_LOCKED_BALANCE>
	                    <ASSET_VISA_FLOATING_BALANCE>{ fn:round-half-to-even(data($activos/ns0:valBalanceFlotante), 2) }</ASSET_VISA_FLOATING_BALANCE>
	                    <ASSET_AVAILABLE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoDisponible),2 ) }</ASSET_AVAILABLE_BALANCE>	
	                    <INTERNATIONAL_ACCOUNT_NUMBER>{data($activos/ns0:cuenta/ns0:codigoIBAN)}</INTERNATIONAL_ACCOUNT_NUMBER>
                  	</ns3:consultaActivosClienteResponseRecordType>
            }
            </ns3:consultaActivosClienteDepositosResponseType>
            
            <ns3:consultaActivosClientePensionesResponseType/>
        
        </ns3:consultaActivosClienteResponse>
};

declare variable $opConsultaActivosClienteRespuesta as element(ns1:opConsultaActivosClienteRespuesta) external;

xf:consultaActivosClienteNIOut($opConsultaActivosClienteRespuesta)