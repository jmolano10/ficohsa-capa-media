xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaMaestraSaldosRespuesta" element="ns4:opConsultaMaestraSaldosRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaMaestraSaldoCuentaResponse" location="../xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaNIOut/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultasType";

declare function round2decimals($item as item()?) as xs:double?
{
	if(string($item/text()) != '')then(
		fn:round-half-to-even(xs:decimal(data($item)), 2)
	)else(0.0)
	
};

declare function xf:consultaMaestraSaldoCuentaNIOut($opConsultaMaestraSaldosRespuesta as element(ns4:opConsultaMaestraSaldosRespuesta))
    as element(ns3:consultaMaestraSaldoCuentaResponse) {
        <ns3:consultaMaestraSaldoCuentaResponse>
            <BALANCE_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd", fn:current-date()) }</BALANCE_DATE>
            {
                let $nombreCuenta := fn:replace(string($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:valCuentaHabiente/text()),"[Ññ]","#")
                return
                    <ACCOUNT_NAME>{ $nombreCuenta }</ACCOUNT_NAME>
            }
            {
                let $codTipoMoneda := string($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:moneda/ns1:codTipoMoneda/text())
                return
                    <CURRENCY>
                        {
                            if ($codTipoMoneda = '0') then
                                ('NIO')
                            else if ($codTipoMoneda = '1') then
                                ('USD')
                            else if ($codTipoMoneda = '8') then
                                ('EUR')
                            else 
                                $codTipoMoneda
                        }
					</CURRENCY>
            }
            {
                let $saldoDisponible := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:valSaldoDisponible
                return
                    <AVAILABLE_BALANCE>{ fn:round-half-to-even(xs:decimal(data($saldoDisponible)), 2) }</AVAILABLE_BALANCE>
            }
            {
                <CLEARING_BALANCE>
                	{ 
                		fn:round-half-to-even(xs:decimal(data($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:val12H)), 2)
                		+
                		fn:round-half-to-even(xs:decimal(data($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:val24H)), 2)
                		+
                		fn:round-half-to-even(xs:decimal(data($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valRemesa)), 2)
                	}
                </CLEARING_BALANCE>
            }
            {
                let $saldoBloqueado := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:valMontoBloqueado
                return
                    <LOCKED_BALANCE>{ fn:round-half-to-even(xs:decimal(data($saldoBloqueado)), 2) }</LOCKED_BALANCE>
            }
            {
                let $saldoFlotante := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valReservado
                return
                    <VISA_FLOATING_BALANCE>{ fn:round-half-to-even(xs:decimal(data($saldoFlotante)), 2) }</VISA_FLOATING_BALANCE>
            }
            {
                let $sobregiro := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valSobregirado
                return
                    <OVRDF_CLRNG_CA_BALANCE>{ fn:round-half-to-even(xs:decimal(data($sobregiro)), 2) }</OVRDF_CLRNG_CA_BALANCE>
            }
            {
                let $saldoTotalDisponible := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valTotalDisponible
                return
                    <TOTAL_AVAILABLE_BALANCE>{ fn:round-half-to-even(xs:decimal(data($saldoTotalDisponible)), 2) }</TOTAL_AVAILABLE_BALANCE>
            }
            {
                let $saldoTotal := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valTotal
                return
                    <TOTAL_BALANCE>{ fn:round-half-to-even(xs:decimal(data($saldoTotal)), 2) }</TOTAL_BALANCE>
            }
            <CASH_ADVANCE>
                <LIMIT_AMOUNT>0.00</LIMIT_AMOUNT>
                <USED_AMOUNT>0.00</USED_AMOUNT>
                <AVAILABLE_AMOUNT>0.00</AVAILABLE_AMOUNT>
            </CASH_ADVANCE>
            <AUTHORIZED_OVERDRAFT>
                {
                    let $limiteSobregiro := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valLimiteSgiro
                    return
                        <LIMIT_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($limiteSobregiro)) ,2) }</LIMIT_AMOUNT>
                }
                {
                    let $sobregiroUsado := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valUsadoSgiro
                    return
                        <USED_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($sobregiroUsado)), 2) }</USED_AMOUNT>
                }
                {
                    let $sobregiroDisponible := $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valDisponibleSgiro
                    return
                        <AVAILABLE_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($sobregiroDisponible)), 2) }</AVAILABLE_AMOUNT>
                }
                {
                    let $fechaSobreGiro := string($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valFechaSgiro/text())
                    return
                    	if($fechaSobreGiro != '')then(
                    		<EXPIRATION_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valFechaSgiro)) }</EXPIRATION_DATE>
                    	)else(
                    		<EXPIRATION_DATE/>
                    	)
                        
                }
            </AUTHORIZED_OVERDRAFT>
            <UNAUTHORIZED_OVERDRAFT>
                <USED_AMOUNT>0.00</USED_AMOUNT>
            </UNAUTHORIZED_OVERDRAFT>
            <CLEARING_FUNDS>
                <LIMIT_AMOUNT>0.00</LIMIT_AMOUNT>
                <USED_AMOUNT>0.00</USED_AMOUNT>
                <AVAILABLE_AMOUNT>0.00</AVAILABLE_AMOUNT>
                <EXPIRATION_DATE/>
            </CLEARING_FUNDS>
        </ns3:consultaMaestraSaldoCuentaResponse>
};

declare variable $opConsultaMaestraSaldosRespuesta as element(ns4:opConsultaMaestraSaldosRespuesta) external;

xf:consultaMaestraSaldoCuentaNIOut($opConsultaMaestraSaldosRespuesta)