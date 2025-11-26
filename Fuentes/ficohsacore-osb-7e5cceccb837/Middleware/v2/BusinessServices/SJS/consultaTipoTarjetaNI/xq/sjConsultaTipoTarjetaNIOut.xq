(:: pragma bea:global-element-parameter parameter="$opConsultaTarjetaDebitoRespuesta" element="ns0:opConsultaTarjetaDebitoRespuesta" location="../../../CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns3:OutputParameters" location="../../../MasterData/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns6:OutputParameters" location="../../../MasterData/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns4:sjConsultaTipoTarjetaResponse" location="../xsd/sjConsultaTipoTarjetaNI.xsd" ::)

declare namespace ns5 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns0 = "http://service.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/xq/sjConsultaTipoTarjetaNIOut/";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjetaNI";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns6 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";

declare function xf:sjConsultaTipoTarjetaNIOut($opConsultaTarjetaDebitoRespuesta as element(ns0:opConsultaTarjetaDebitoRespuesta),
    $outputParameters as element(ns3:OutputParameters)?,
    $outputParameters1 as element(ns6:OutputParameters)?)
    as element(ns4:sjConsultaTipoTarjetaResponse) {
        <ns4:sjConsultaTipoTarjetaResponse>
        	{
	        	let $successIndTD := fn:string($opConsultaTarjetaDebitoRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
	            let $successIndTCDatoTarjeta := fn:string($outputParameters/ns3:CodigoError/text())	
	            let $successIndTCDatoCuenta := fn:string($outputParameters1/ns6:CodigoError/text()) 
	            	
				return
					if($successIndTD = '0') then(
						<ns4:SUCCESS_INDICATOR>SUCCESS</ns4:SUCCESS_INDICATOR>,
						<ns4:CARD_STATUS>{ data($opConsultaTarjetaDebitoRespuesta/ns1:tarjeta/ns1:estadoTarjeta) }</ns4:CARD_STATUS>,
						<ns4:CUSTOMER_ID>{ data($opConsultaTarjetaDebitoRespuesta/ns1:tarjeta/ns1:idCliente) }</ns4:CUSTOMER_ID>,
						<ns4:CUSTOMER_NAME>{ data($opConsultaTarjetaDebitoRespuesta/ns1:tarjeta/ns1:nombreTarjeta) }</ns4:CUSTOMER_NAME>,
						<ns4:LEGAL_ID>{ data($opConsultaTarjetaDebitoRespuesta/ns1:tarjeta/ns1:idCliente) }</ns4:LEGAL_ID>,
						<ns4:CARD_TYPE>DEBIT</ns4:CARD_TYPE>
					)else if($successIndTCDatoCuenta = '-1') then(
						<ns4:SUCCESS_INDICATOR>SUCCESS</ns4:SUCCESS_INDICATOR>,
						<ns4:CUSTOMER_ID>{ fn:string($outputParameters1/ns6:RowSet[1]/ns6:Row[1]/ns6:Column[fn:upper-case(@name)='CUST_NBR']/text()) }</ns4:CUSTOMER_ID>,
						<ns4:CUSTOMER_NAME>{ fn:string($outputParameters1/ns6:RowSet[1]/ns6:Row[1]/ns6:Column[fn:upper-case(@name)='NOMBRE_CLIENTE']/text()) }</ns4:CUSTOMER_NAME>,
						<ns4:LOGO>{ fn:string($outputParameters1/ns6:RowSet[1]/ns6:Row[1]/ns6:Column[upper-case(@name)= 'LOGO']) }</ns4:LOGO>,
						<ns4:LEGAL_ID>{ fn:string($outputParameters1/ns6:RowSet[1]/ns6:Row[1]/ns6:Column[upper-case(@name) = 'LEGAL_ID']/text()) }</ns4:LEGAL_ID>,
						<ns4:ACCOUNT_DATA_REGISTRATION>
							{
								let $rowAlt := $outputParameters1/ns6:RowSet[1]/ns6:Row[ns6:Column/@name='TipoOrg' and ns6:Column/text() = 'ALT']
								let $rowBase := $outputParameters1/ns6:RowSet[1]/ns6:Row[ns6:Column/@name='TipoOrg' and ns6:Column/text() = 'BASE']
								return
									(
										if(fn:count($rowAlt) > 0) then
											( $rowAlt ) else
												( $rowBase )
									)  
							}
						</ns4:ACCOUNT_DATA_REGISTRATION>,
						<ns4:ORG>{ fn:string($outputParameters1/ns6:RowSet[1]/ns6:Row[1]/ns6:Column[fn:upper-case(@name) = 'ORG']) }</ns4:ORG>,
						<ns4:ACCOUNT_NUMBER>{ fn:string($outputParameters1/ns6:RowSet[1]/ns6:Row[1]/ns6:Column[fn:upper-case(@name) = 'LMS_ACC']/text()) }</ns4:ACCOUNT_NUMBER>,
						<ns4:SCHEME>{ fn:string($outputParameters1/ns6:RowSet[1]/ns6:Row[1]/ns6:Column[fn:upper-case(@name) = 'LMS_SCHEME']/text()) }</ns4:SCHEME>,
						<ns4:CARD_TYPE>CREDIT</ns4:CARD_TYPE>
					)else if($successIndTCDatoTarjeta = '-1') then(
						<ns4:SUCCESS_INDICATOR>SUCCESS</ns4:SUCCESS_INDICATOR>,
						<ns4:CUSTOMER_ID>{ fn:string($outputParameters/ns3:RowSet[1]/ns3:Row[1]/ns3:Column[upper-case(@name)= 'CUSTOMER_ID']/text()) }</ns4:CUSTOMER_ID>,
						<ns4:CUSTOMER_NAME>{ fn:string($outputParameters/ns3:RowSet[1]/ns3:Row[1]/ns3:Column[upper-case(@name)= 'ACCOUNT_NAME']/text()) }</ns4:CUSTOMER_NAME>,
						<ns4:LOGO>{ fn:string($outputParameters/ns3:RowSet[1]/ns3:Row[1]/ns3:Column[upper-case(@name)= 'LOGO']/text()) }</ns4:LOGO>,
						<ns4:CARD_TYPE>CREDIT</ns4:CARD_TYPE>
					)else(
						<ns4:SUCCESS_INDICATOR>ERROR</ns4:SUCCESS_INDICATOR>,
						<ns4:ERROR_MESSAGE>ERROR CONSULTANDO EL NUMERO DE TARJETA</ns4:ERROR_MESSAGE>
					)
			}            
        </ns4:sjConsultaTipoTarjetaResponse>
};

declare variable $opConsultaTarjetaDebitoRespuesta as element(ns0:opConsultaTarjetaDebitoRespuesta) external;
declare variable $outputParameters as element(ns3:OutputParameters) external;
declare variable $outputParameters1 as element(ns6:OutputParameters) external;

xf:sjConsultaTipoTarjetaNIOut($opConsultaTarjetaDebitoRespuesta,
    $outputParameters,
    $outputParameters1)