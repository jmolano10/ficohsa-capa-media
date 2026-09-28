(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataGT/conDatoTarjetas_v2/xsd/conDatoTarjetas_v2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraDatosTC_v2/xsd/registraDatosTC_v2_sp.xsd" ::)

declare namespace ns2 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraDatosTC_v2";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/registraDatosTCIn/";

declare function xf:registraDatosTCGTIn($resultGroup as element(*),
    $outputParameters as element(ns0:OutputParameters),
    $estadoPlastico as xs:string,
    $estadoCuenta as xs:string,
    $countryCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_DATOS_TARJETA>
                <ns1:PT_DATOS_TARJETA_ITEM>
                	<ns1:CARD_NUMBER>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='numtarjeta']/text() }</ns1:CARD_NUMBER>
                	<ns1:ACCOUNT_HOLDER_NAME>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='account_name']/text() }</ns1:ACCOUNT_HOLDER_NAME>
        			<ns1:CARD_HOLDER_NAME>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='cardholder_name']/text() }</ns1:CARD_HOLDER_NAME>
                	{
	                	for $cardType in $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns2:EmbosserInquiryL8V6Response[1]/AZXCIO-CARDHOLDER-TYPE
						return
				        	<ns1:CARD_TYPE>{ data($cardType) }</ns1:CARD_TYPE>
				    }
                	<ns1:CUSTOMER_ID>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='customer_id']/text() }</ns1:CUSTOMER_ID>
				    <ns1:CARD_HOLDER_LEGAL_ID>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='card_holder_id']/text() }</ns1:CARD_HOLDER_LEGAL_ID>
				    <ns1:ACCOUNT_HOLDER_LEGAL_ID>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='account_holder_legal_id']/text() }</ns1:ACCOUNT_HOLDER_LEGAL_ID>
				    <ns1:ACCOUNT_NUMBER>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='numcuenta']/text() }</ns1:ACCOUNT_NUMBER>
				    <ns1:PRODUCT>TCR</ns1:PRODUCT>
				    <ns1:AFINITY_GROUP>{ $outputParameters/ns0:RowSet/ns0:Row[1]/ns0:Column[@name='logo']/text() }</ns1:AFINITY_GROUP>
				    <ns1:ACCOUNT_STATUS>{ $estadoCuenta }</ns1:ACCOUNT_STATUS>
				    <ns1:CARD_STATUS>{ $estadoPlastico }</ns1:CARD_STATUS>
					{
						for $cardExpirationDate in $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns2:EmbosserInquiryL8V6Response[1]/AZXCIO-DATE-EXPIRE
						return
							<ns1:CARD_EXPIRATION_DATE>{ data($cardExpirationDate) }</ns1:CARD_EXPIRATION_DATE>
					}       
                    
                </ns1:PT_DATOS_TARJETA_ITEM>
            </ns1:PT_DATOS_TARJETA>
			 <ns1:PV_COUNTRY_CODE>{ $countryCode }</ns1:PV_COUNTRY_CODE>
        </ns1:InputParameters>
};

declare variable $resultGroup as element(*) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $estadoPlastico as xs:string external;
declare variable $estadoCuenta as xs:string external;
declare variable $countryCode as xs:string external;

xf:registraDatosTCGTIn($resultGroup,
    $outputParameters,
    $estadoPlastico,
    $estadoCuenta,
    $countryCode)