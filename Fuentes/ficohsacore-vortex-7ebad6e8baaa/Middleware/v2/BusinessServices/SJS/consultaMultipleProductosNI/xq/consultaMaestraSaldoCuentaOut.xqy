xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaMaestraSaldosRespuesta" element="ns4:opConsultaMaestraSaldosRespuesta" location="../../../CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:local-element-return type="ns2:sjConsultaMultipleProductosNIResponse/ns2:ASSETS/ns2:ASSET" location="../xsd/sjConsultaMultipleProductosNI.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaMaestraSaldoCuentaOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:consultaMaestraSaldoCuentaOut($productID as xs:string,
    $opConsultaMaestraSaldosRespuesta as element(ns4:opConsultaMaestraSaldosRespuesta),
    $producType as xs:string)
    as element() {
        <ns2:ASSET>
            <ns2:ID>{ $productID }</ns2:ID>
            {
            	let $successIndicator := data($opConsultaMaestraSaldosRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta)         	
            	return
            		if($successIndicator = '0' or $successIndicator = 'SUCCESS')then(
        				if(count($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta) > 0) then (
	            			
	            			for $productName in $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:valCuentaHabiente
	            			return
	            				<ns2:PRODUCT_NAME>{ data($productName) }</ns2:PRODUCT_NAME>,
	            			
	            			for $codTipoMoneda in $opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:moneda/ns1:codTipoMoneda
	            			return(
		            			<ns2:CURRENCY>
		            			{ 
								    if (data($codTipoMoneda) = '0') then
								        'NIO'
								    else if(data($codTipoMoneda) = '1')then
								        'USD'
								    else if(data($codTipoMoneda) = '8')then
								        'EUR'
								    else
								        data($codTipoMoneda) 
								}
		            			</ns2:CURRENCY>
	            			),
	            			<ns2:RESERVE_BALANCE>
	            				{
	            					numIsNull($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:val12H)
	            					+
	            					numIsNull($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:val24H)
	            					+
	            					numIsNull($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valRemesa)
	            				}
	            			</ns2:RESERVE_BALANCE>,
	            			<ns2:LOCKED_BALANCE>{ numIsNull($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:valMontoBloqueado) }</ns2:LOCKED_BALANCE>,
	            			<ns2:VISA_FLOATING_BALANCE>0.0</ns2:VISA_FLOATING_BALANCE>,
	            			<ns2:INTEREST_BALANCE>0.0</ns2:INTEREST_BALANCE>,
	            			<ns2:TOTAL_BALANCE>{ numIsNull($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:valTotal) }</ns2:TOTAL_BALANCE>,
	            			<ns2:AVAILABLE_BALANCE>{ numIsNull($opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:valSaldoDisponible) }</ns2:AVAILABLE_BALANCE>,
	            			<ns2:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns2:OPENING_DATE>,
	            			<ns2:TYPE>{ $producType }</ns2:TYPE>,
	            			<ns2:SOURCE_BANK>NI01</ns2:SOURCE_BANK>,
	            			<ns2:SUCCESS_INDICATOR>SUCCESS</ns2:SUCCESS_INDICATOR>,
	            			<ns2:INTERNATIONAL_ACCOUNT_NUMBER>{$opConsultaMaestraSaldosRespuesta/ns1:saldosCuenta/ns1:cuenta/ns1:codigoIBAN}</ns2:INTERNATIONAL_ACCOUNT_NUMBER>	            			
            			) else (
            				<ns2:TYPE>{ $producType }</ns2:TYPE>,
            				<ns2:SOURCE_BANK>NI01</ns2:SOURCE_BANK>,
            				<ns2:SUCCESS_INDICATOR>NO RECORDS</ns2:SUCCESS_INDICATOR>,
	            			<ns2:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns2:ERROR_MESSAGE>
            			)
	            		
            		)else(
            			
	            			<ns2:TYPE>{ $producType }</ns2:TYPE>,
	            			<ns2:SOURCE_BANK>NI01</ns2:SOURCE_BANK>,
	            			<ns2:SUCCESS_INDICATOR>ERROR</ns2:SUCCESS_INDICATOR>,
		            		for $valDescripcionRespuesta in $opConsultaMaestraSaldosRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta
	                		return(
		            			<ns2:ERROR_MESSAGE>{ data($valDescripcionRespuesta) }</ns2:ERROR_MESSAGE>
	            			)
            		)
            }
        </ns2:ASSET>
};

declare variable $productID as xs:string external;
declare variable $producType as xs:string external;
declare variable $opConsultaMaestraSaldosRespuesta as element(ns4:opConsultaMaestraSaldosRespuesta) external;

xf:consultaMaestraSaldoCuentaOut($productID,
    $opConsultaMaestraSaldosRespuesta,
    $producType)