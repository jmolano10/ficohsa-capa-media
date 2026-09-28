(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataGT/conDatoTarjetas_v2/xsd/conDatoTarjetas_v2_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns3:OutputParameters" location="../../../BusinessServices/CLIENTDATA/consultaDatosTC_v2/xsd/consultaDatosTC_V2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns2 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC_V2";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoGTOut/";

declare function xf:consultaDatosTarjetaCreditoGTOut($resultGroup as element(*)?,
    $outputParameters as element(ns0:OutputParameters)?,
    $estadoPlastico as xs:string?,
    $estadoCuenta as xs:string?,
    $outputParameters1 as element(ns3:OutputParameters)?)
    as element(ns1:consultaDatosTarjetaCreditoResponse) {
        <ns1:consultaDatosTarjetaCreditoResponse>
            <ns1:consultaDatosTarjetaCreditoResponseType>
            {
            	if(not(empty($outputParameters1/ns3:PT_DATOS_TARJETA/ns3:PT_DATOS_TARJETA_ITEM[1])))then(
	            	for $PT_DATOS_TARJETA_ITEM in $outputParameters1/ns3:PT_DATOS_TARJETA/ns3:PT_DATOS_TARJETA_ITEM
	            	return(
		                <ns1:consultaDatosTarjetaCreditoResponseRecordType>
                            <CARD_NUMBER>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_NUMBER) }</CARD_NUMBER>
                            <ACCOUNT_HOLDER_NAME>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>
                            <CARD_HOLDER_NAME>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
                            <CARD_TYPE>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_TYPE) }</CARD_TYPE>
                            <CUSTOMER_ID>{ data($PT_DATOS_TARJETA_ITEM/ns3:CUSTOMER_ID) }</CUSTOMER_ID>
                            <CARD_HOLDER_LEGAL_ID>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_HOLDER_LEGAL_ID) }</CARD_HOLDER_LEGAL_ID>
                            <ACCOUNT_HOLDER_LEGAL_ID>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_HOLDER_LEGAL_ID) }</ACCOUNT_HOLDER_LEGAL_ID>
                            <ACCOUNT_NUMBER>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                            <PRODUCT>{ data($PT_DATOS_TARJETA_ITEM/ns3:PRODUCT) }</PRODUCT>
                            <AFINITY_GROUP>{ data($PT_DATOS_TARJETA_ITEM/ns3:AFINITY_GROUP) }</AFINITY_GROUP>
                            <ACCOUNT_STATUS>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_STATUS) }</ACCOUNT_STATUS>
   		                    <CARD_STATUS>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_STATUS) }</CARD_STATUS>
                            <CARD_EXPIRATION_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_EXPIRATION_DATE) }</CARD_EXPIRATION_DATE>
		                </ns1:consultaDatosTarjetaCreditoResponseRecordType>
	         		)
	         	)else(
					<ns1:consultaDatosTarjetaCreditoResponseRecordType>
						<CARD_NUMBER>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='numtarjeta']/text() }</CARD_NUMBER>
						<ACCOUNT_HOLDER_NAME>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='account_name']/text() }</ACCOUNT_HOLDER_NAME>
						<CARD_HOLDER_NAME>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='cardholder_name']/text() }</CARD_HOLDER_NAME>
						{
							for $cardType in $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns2:EmbosserInquiryL8V6Response[1]/AZXCIO-CARDHOLDER-TYPE
							return
							        <CARD_TYPE>{ data($cardType) }</CARD_TYPE>
						}
						<CUSTOMER_ID>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='customer_id']/text() }</CUSTOMER_ID>
						<CARD_HOLDER_LEGAL_ID>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='card_holder_id']/text() }</CARD_HOLDER_LEGAL_ID>
						<ACCOUNT_HOLDER_LEGAL_ID>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='account_holder_legal_id']/text() }</ACCOUNT_HOLDER_LEGAL_ID>
						<ACCOUNT_NUMBER>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='numcuenta']/text() }</ACCOUNT_NUMBER>
						<PRODUCT>TCR</PRODUCT>
						<AFINITY_GROUP>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='logo']/text() }</AFINITY_GROUP>
						<ACCOUNT_STATUS>{ $estadoCuenta }</ACCOUNT_STATUS>
						<CARD_STATUS>{ $estadoPlastico }</CARD_STATUS>
						{
							for $cardExpirationDate in $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns2:EmbosserInquiryL8V6Response[1]/AZXCIO-DATE-EXPIRE
							return
								<CARD_EXPIRATION_DATE>{ data($cardExpirationDate) }</CARD_EXPIRATION_DATE>
						}                
					</ns1:consultaDatosTarjetaCreditoResponseRecordType>
				)
	         }
	         </ns1:consultaDatosTarjetaCreditoResponseType>
        </ns1:consultaDatosTarjetaCreditoResponse>
};

declare variable $resultGroup as element(*)? external;
declare variable $outputParameters as element(ns0:OutputParameters)? external;
declare variable $estadoPlastico as xs:string? external;
declare variable $estadoCuenta as xs:string? external;
declare variable $outputParameters1 as element(ns3:OutputParameters)? external;

xf:consultaDatosTarjetaCreditoGTOut($resultGroup,
    $outputParameters,
    $estadoPlastico,
    $estadoCuenta,
    $outputParameters1)