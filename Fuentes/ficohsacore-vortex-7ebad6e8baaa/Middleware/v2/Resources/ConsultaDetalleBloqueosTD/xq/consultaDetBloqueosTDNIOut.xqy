xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns3:opConsultaFlotanteRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:consultaDetalleBloqueosTDResponse" location="../../../../Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes.xsd" ::)

declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleBloqueosTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleBloqueosTD/xq/consultaDetBloqueosTDNIOut/";
declare namespace ns3 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";

declare function redondear($valor as element(*)?) 
    as xs:string {
        if (fn-bea:trim(xs:string(data($valor))) != '') then
            xs:string(fn:round-half-to-even(xs:decimal($valor), 2)) 
        else ("")
};

declare function xf:consultaDetBloqueosTDNIOut($outputParameters1 as element(ns3:opConsultaFlotanteRespuesta))
    as element(ns4:consultaDetalleBloqueosTDResponse) {
        <ns4:consultaDetalleBloqueosTDResponse>
            <ACCOUNT_NUMBER>{ data($outputParameters1/ns1:cuenta/ns1:codCuentaHabiente) }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>{ data($outputParameters1/ns1:cuenta/ns1:valCuentaHabiente) }</ACCOUNT_NAME>
            <TOTAL_VISA_LOCKED_AMOUNT>{ redondear($outputParameters1/ns1:cuenta/ns1:valMontoBloqueado) }</TOTAL_VISA_LOCKED_AMOUNT>
            <ns4:consultaDetalleBloqueosTDResponseType>
            {               
                for $saldosFlotantesCuenta in $outputParameters1/ns1:saldosFlotantesCuenta
                return                    
                    <ns4:consultaDetalleBloqueosTDResponseRecordType>
                    	{
                    		for $fechaReserva in $saldosFlotantesCuenta/ns1:fechaReserva
                            return
                    			<VALUE_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($saldosFlotantesCuenta/ns1:fechaReserva)) }</VALUE_DATE>
                    	}                        
                        {
                            for $valDescripcionComercio in $saldosFlotantesCuenta/ns1:valDescripcionComercio
                            return
                                <TERMINAL_DESCRIPTION>{ data($valDescripcionComercio) }</TERMINAL_DESCRIPTION>
                        }
                        {
                        	for $fechaLiberacion in $saldosFlotantesCuenta/ns1:fechaLiberacion
                        	return
                        		<RELEASE_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($fechaLiberacion)) }</RELEASE_DATE>
                        }                        
                        {
                            for $valSimboloMoneda in $saldosFlotantesCuenta/ns1:moneda/ns1:valSimboloMoneda
                            return
                                <CURRENCY>{ data($valSimboloMoneda) }</CURRENCY>
                        }
                        {
                        	for $valMontoOriginal in $saldosFlotantesCuenta/ns1:valMontoOriginal
                            return
                        		<ORIGINAL_AMOUNT>{ redondear($valMontoOriginal) }</ORIGINAL_AMOUNT>
                        }                        
                        {
                            for $valEstatusReserva in $saldosFlotantesCuenta/ns1:valEstatusReserva
                            return
                                <BLOCK_STATUS>{ data($valEstatusReserva) }</BLOCK_STATUS>
                        }
                        {
                        	for $valMontoConfirmado in $saldosFlotantesCuenta/ns1:valMontoConfirmado
                            return
                        		<CONFIRMED_AMOUNT>{ redondear($valMontoConfirmado) }</CONFIRMED_AMOUNT>
                        } 
                    </ns4:consultaDetalleBloqueosTDResponseRecordType>                
            }
            </ns4:consultaDetalleBloqueosTDResponseType>
        </ns4:consultaDetalleBloqueosTDResponse>
};

declare variable $outputParameters1 as element(ns3:opConsultaFlotanteRespuesta) external;

xf:consultaDetBloqueosTDNIOut($outputParameters1)