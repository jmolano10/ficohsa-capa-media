xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaClienteporTarjetaDebitoResponse" element="ns1:ConsultaClienteporTarjetaDebitoResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma  parameter="$questions" type="anyType" ::)
(:: pragma bea:global-element-return element="ns2:ingresaVentaSeguros" location="../../IngresaVentaSeguros/xsd/ingresaVentaSegurosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ingresaVentaSegurosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguroFacade/xq/ingresaVentaSegurosIn/";

declare function xf:ingresaVentaSegurosIn($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest),
    $consultaClienteporTarjetaDebitoResponse as element(ns1:ConsultaClienteporTarjetaDebitoResponse),
    $questions as element(*),
    $onlinePayment as xs:string,
    $description as xs:string,
    $productCode as xs:string,
    $policyCode as xs:string,
    $amount as xs:string,
    $frequency as xs:string)
    as element(ns2:ingresaVentaSeguros) {
        <ns2:ingresaVentaSeguros>
            <INSURANCE_PRODUCT_CODE>{ $productCode }</INSURANCE_PRODUCT_CODE>
            <INSURANCE_PLAN_CODE>{ fn:tokenize(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048),"\|\|")[1] }</INSURANCE_PLAN_CODE>
            <INSURANCE_POLICY_CODE>{ $policyCode }</INSURANCE_POLICY_CODE>
            <INSURED>
                <CUSTOMER_ID>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CustomerID) }</CUSTOMER_ID>
                <LEGAL_DOCUMENT_NAME>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/TipodeIndentificacion) }</LEGAL_DOCUMENT_NAME>
                <LEGAL_ID>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/NumerodeIdentificacion) }</LEGAL_ID>
                <LEGAL_HOLDER_NAME>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/NombreCompleto) }</LEGAL_HOLDER_NAME>
                <DATE_OF_BIRTH>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("yyyyMMdd",data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/FechadeNacimiento)))  }</DATE_OF_BIRTH>
                <GENDER>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoSexo) }</GENDER>
                <MARITAL_STATUS>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoEstadoCivil) }</MARITAL_STATUS>
                <OCCUPATION>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoOcupacion) }</OCCUPATION>
                <EMAIL_ADDRESS>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CorreoElectronico) }</EMAIL_ADDRESS>
                <PHONE_INFO>
                    <PHONE_NUMBER_ITEM>
                        <PHONE_NUMBER>{ fn:tokenize(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048),"\|\|")[2]}</PHONE_NUMBER>
                    </PHONE_NUMBER_ITEM>
                    {
            			if( $consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/Telefono/text() != '')then(
            				<PHONE_NUMBER_ITEM>
                        		<PHONE_NUMBER>{ $consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/Telefono/text() }</PHONE_NUMBER>
                    		</PHONE_NUMBER_ITEM>
            			)else()
         			}
                </PHONE_INFO>
                <ADDRESS_INFO>
                	{
                		let $ADDRESS_TYPES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/TipodeDireccion, "!!")	            	
	            		let $COUNTRY_CODES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoPais, "!!")
	            		let $STATE_CODES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoDepartamento, "!!")
	            		let $CITY_CODES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoMunicipio, "!!")
	            		let $ADDRESS_LINES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/DireccionDomicilio, "!!")
                		for $ADDRESS_TYPE at $i in $ADDRESS_TYPES
		           		return
		            		if ($ADDRESS_TYPE != "") then (
		            			<ADDRESS_ITEM>
                        			<ADDRESS_TYPE>{ $ADDRESS_TYPE }</ADDRESS_TYPE>
                 	 				<COUNTRY_CODE>{ $COUNTRY_CODES[$i] }</COUNTRY_CODE>
                  					<DEPARTMENT_CODE>{ $STATE_CODES[$i] }</DEPARTMENT_CODE>
                  					<MUNICIPALITY_CODE>{ $CITY_CODES[$i] }</MUNICIPALITY_CODE>
                  					<ADDRESS_LINE>{ $ADDRESS_LINES[$i] }</ADDRESS_LINE>
                   				</ADDRESS_ITEM>
		            		) else ()
                	}
                </ADDRESS_INFO>
                {
                	$questions
                }
            </INSURED>
            <PAYMENT_INFORMATION>
                <CUSTOMER_ID>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CustomerID) }</CUSTOMER_ID>
                <LEGAL_DOCUMENT_NAME>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/TipodeIndentificacion) }</LEGAL_DOCUMENT_NAME>
                <LEGAL_ID>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/NumerodeIdentificacion) }</LEGAL_ID>
                <LEGAL_HOLDER_NAME>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/NombreCompleto) }</LEGAL_HOLDER_NAME>
                <DATE_OF_BIRTH>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn-bea:date-from-string-with-format("yyyyMMdd",data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/FechadeNacimiento)))  }</DATE_OF_BIRTH>
                <GENDER>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoSexo) }</GENDER>
                <MARITAL_STATUS>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoEstadoCivil) }</MARITAL_STATUS>
                <OCCUPATION>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoOcupacion) }</OCCUPATION>
                <EMAIL_ADDRESS>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CorreoElectronico) }</EMAIL_ADDRESS>
                <PHONE_INFO>
                    <PHONE_NUMBER_ITEM>
                        <PHONE_NUMBER>{ fn:tokenize(data($procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/AdditionalDataPrivate_048),"\|\|")[2] }</PHONE_NUMBER>
                    </PHONE_NUMBER_ITEM>
                    {
            			if( $consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/Telefono/text() != '')then(
            				<PHONE_NUMBER_ITEM>
                        		<PHONE_NUMBER>{ $consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/Telefono/text() }</PHONE_NUMBER>
                    		</PHONE_NUMBER_ITEM>
            			)else()
         			}
                </PHONE_INFO>
                <ADDRESS_INFO>
                	{
                		let $ADDRESS_TYPES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/TipodeDireccion, "!!")	            	
	            		let $COUNTRY_CODES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoPais, "!!")
	            		let $STATE_CODES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoDepartamento, "!!")
	            		let $CITY_CODES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CodigoMunicipio, "!!")
	            		let $ADDRESS_LINES := fn:tokenize($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/DireccionDomicilio, "!!")
                		for $ADDRESS_TYPE at $i in $ADDRESS_TYPES
		           		return
		            		if ($ADDRESS_TYPE != "") then (
		            			<ADDRESS_ITEM>
                        			<ADDRESS_TYPE>{ $ADDRESS_TYPE }</ADDRESS_TYPE>
                 	 				<COUNTRY_CODE>{ $COUNTRY_CODES[$i] }</COUNTRY_CODE>
                  					<DEPARTMENT_CODE>{ $STATE_CODES[$i] }</DEPARTMENT_CODE>
                  					<MUNICIPALITY_CODE>{ $CITY_CODES[$i] }</MUNICIPALITY_CODE>
                  					<ADDRESS_LINE>{ $ADDRESS_LINES[$i] }</ADDRESS_LINE>
                   				</ADDRESS_ITEM>
		            		) else ()
                	}
                </ADDRESS_INFO>
                <PAYMENT_DETAIL>
                	<PAYMENT_METHOD>ACCT_DEBIT</PAYMENT_METHOD>
                	<PAYMENT_AMOUNT>{ $amount }</PAYMENT_AMOUNT>
                    <PAYMENT_FREQUENCY>{ $frequency }</PAYMENT_FREQUENCY>
                    <PAYMENT_CURRENCY>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/MonedaCuentaprimaria) }</PAYMENT_CURRENCY>
                    <PAYMENT_PRODUCT_NUMBER>{ data($consultaClienteporTarjetaDebitoResponse/WSFICOCARDINFOType[1]/gWSFICOCARDINFODetailType/mWSFICOCARDINFODetailType[1]/CuentasPrimerarias) }</PAYMENT_PRODUCT_NUMBER>
                    <PAYMENT_ONLINE>{ $onlinePayment }</PAYMENT_ONLINE>
                    <PRODUCT_NUMBER_REF>{ $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/PrimaryAccountNumber_002/text() }</PRODUCT_NUMBER_REF>
                </PAYMENT_DETAIL>
            </PAYMENT_INFORMATION>
            <CHANNEL_INFORMATION>
            	<CODE>{ $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041/text() }</CODE>
            	<NAME>ATM</NAME>
            	<LOCATION>{ $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT/CardAcceptorNameLocation_043/text() }</LOCATION>
         	</CHANNEL_INFORMATION>
        </ns2:ingresaVentaSeguros>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;
declare variable $consultaClienteporTarjetaDebitoResponse as element(ns1:ConsultaClienteporTarjetaDebitoResponse) external;
declare variable $questions as element(*) external;
declare variable $onlinePayment as xs:string external;
declare variable $description as xs:string external;
declare variable $productCode as xs:string external;
declare variable $policyCode as xs:string external;
declare variable $amount as xs:string external;
declare variable $frequency as xs:string external;

xf:ingresaVentaSegurosIn($procesaMensajeGenericoSwitchFacadeRequest,
    $consultaClienteporTarjetaDebitoResponse,
    $questions,
    $onlinePayment,
    $description,
    $productCode,
    $policyCode,
    $amount,
    $frequency)