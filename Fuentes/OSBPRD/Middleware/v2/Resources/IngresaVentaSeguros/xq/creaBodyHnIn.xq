(:: pragma bea:global-element-parameter parameter="$ingresaVentaSeguros" element="ns0:ingresaVentaSeguros" location="../xsd/ingresaVentaSegurosTypes.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ingresaVentaSegurosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguro/xq/creaBodyHnIn/";

declare function obtenerReespuesta()
    as element(*){
    	<ANSWER_CODES>
		    <ANSWER_TYPE tipo="SIMPLE">
		        <ANSWER_CODE osb="YES">S</ANSWER_CODE>
		        <ANSWER_CODE osb="NO">N</ANSWER_CODE>
		    </ANSWER_TYPE>
		    <ANSWER_TYPE tipo="SPANISH">
		        <ANSWER_CODE osb="YES">Si</ANSWER_CODE>
		        <ANSWER_CODE osb="NO">No</ANSWER_CODE>
		    </ANSWER_TYPE>
		</ANSWER_CODES>
};

declare function xf:creaBodyHnIn($ingresaVentaSeguros as element(ns0:ingresaVentaSeguros),
    $codigoContratante as xs:string,
    $codigoEmpleado as xs:string,
    $nombreEmpleado as xs:string,
    $cuentaEmpleado as xs:string,
    $codigoAgencia as xs:string,
    $onlinePayment as xs:string,
    $descountOnline as xs:string)
    as element(*) {
    	<altaDeSeguro>
    		<certificado>
    			<codigoContratante>{ $codigoContratante } </codigoContratante>
    			<codigoProductoSeguros>{ $ingresaVentaSeguros/INSURANCE_PRODUCT_CODE/text() }</codigoProductoSeguros>
    			<codigoPlan>{ $ingresaVentaSeguros/INSURANCE_PLAN_CODE/text() }</codigoPlan>
    			<codigoPolizaMadre>{ $ingresaVentaSeguros/INSURANCE_POLICY_CODE/text() }</codigoPolizaMadre>
    			<fechaVenta>{ fn-bea:date-to-string-with-format("yyyy-MM-dd",fn:current-date()) }</fechaVenta>
    			<codigoEmpleado>{ $codigoEmpleado }</codigoEmpleado>
    			<cuentaEmpleado>{ $cuentaEmpleado }</cuentaEmpleado>
    			<nombreEmpleado>{ $nombreEmpleado }</nombreEmpleado>
    			<codigoAgenciaVenta>{ $codigoAgencia }</codigoAgenciaVenta>
    			{
            		for $WEIGHT in $ingresaVentaSeguros/INSURED/WEIGHT
            		return
            		<pesoClienteEnVenta>{ data($WEIGHT) }</pesoClienteEnVenta>
            	}
    			{
            		for $HEIGHT in $ingresaVentaSeguros/INSURED/HEIGHT
            		return
            		<estaturaClienteEnVenta>{ data($HEIGHT) }</estaturaClienteEnVenta>
            	}
            	{
            		for $NUMBER_CHILDREN in $ingresaVentaSeguros/INSURED/NUMBER_CHILDREN
            		return
            		<cantidadHijosClienteEnVenta>{ data($NUMBER_CHILDREN) }</cantidadHijosClienteEnVenta>
            	}
    			<cliente>
    				<codigoUnicoPersona>{ $ingresaVentaSeguros/INSURED/CUSTOMER_ID/text() }</codigoUnicoPersona>
    				<codigoTipoIdentificacion>{ $ingresaVentaSeguros/INSURED/LEGAL_DOCUMENT_NAME/text() }</codigoTipoIdentificacion>
    				<numeroIdentificacion>{ $ingresaVentaSeguros/INSURED/LEGAL_ID/text() }</numeroIdentificacion>
    				<nombreCompleto>{ $ingresaVentaSeguros/INSURED/LEGAL_HOLDER_NAME/text() }</nombreCompleto>
    				<fechaNacimiento>{ $ingresaVentaSeguros/INSURED/DATE_OF_BIRTH/text() }</fechaNacimiento>
    				<codigoSexo>{ $ingresaVentaSeguros/INSURED/GENDER/text() }</codigoSexo>
    				<codigoEstadoCivil>{ $ingresaVentaSeguros/INSURED/MARITAL_STATUS/text() }</codigoEstadoCivil>
    				<codigoOcupacion>{ $ingresaVentaSeguros/INSURED/OCCUPATION/text() }</codigoOcupacion>
    				<correoElectronico>{ $ingresaVentaSeguros/INSURED/EMAIL_ADDRESS/text() }</correoElectronico>
    				<telefono1>{ $ingresaVentaSeguros/INSURED/PHONE_INFO/PHONE_NUMBER_ITEM[1]/PHONE_NUMBER/text() }</telefono1>
    				{
            			if( $ingresaVentaSeguros/INSURED/PHONE_INFO/PHONE_NUMBER_ITEM[2]/PHONE_NUMBER/text() != '')then(
            				<telefono2>{ $ingresaVentaSeguros/INSURED/PHONE_INFO/PHONE_NUMBER_ITEM[2]/PHONE_NUMBER/text() }</telefono2>
            			)else(
            				<telefono2>{ $ingresaVentaSeguros/INSURED/PHONE_INFO/PHONE_NUMBER_ITEM[1]/PHONE_NUMBER/text() }</telefono2>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<direccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/ADDRESS_LINE/text() }</direccionDomicilio>
            			)else(
            				<direccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/ADDRESS_LINE/text() }</direccionDomicilio>
         				)
         			}
					{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<codigoPaisDireccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/COUNTRY_CODE/text() }</codigoPaisDireccionDomicilio>
            			)else(
            				<codigoPaisDireccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/COUNTRY_CODE/text() }</codigoPaisDireccionDomicilio>
         				)
         			}
					{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<codigoDeptoDireccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionDomicilio>
            			)else(
            				<codigoDeptoDireccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionDomicilio>
         				)
         			}
					{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<codigoMunicipioDireccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionDomicilio>
            			)else(
            				<codigoMunicipioDireccionDomicilio>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionDomicilio>
         				)
         			}
            		{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<direccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/ADDRESS_LINE/text() }</direccionTrabajo>
            			)else(
            				<direccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/ADDRESS_LINE/text() }</direccionTrabajo>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<codigoPaisDireccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/COUNTRY_CODE/text() }</codigoPaisDireccionTrabajo>
            			)else(
            				<codigoPaisDireccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/COUNTRY_CODE/text() }</codigoPaisDireccionTrabajo>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<codigoDeptoDireccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionTrabajo>
            			)else(
            				<codigoDeptoDireccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionTrabajo>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<codigoMunicipioDireccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionTrabajo>
            			)else(
            				<codigoMunicipioDireccionTrabajo>{$ingresaVentaSeguros/INSURED/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionTrabajo>
         				)
         			}
    				<nit>{ $ingresaVentaSeguros/INSURED/LEGAL_ID/text() }</nit>
    			</cliente>
    			{
            		if( $ingresaVentaSeguros/INSURED/HEALTH_QUESTIONS != '')then(
            			<cuestionarioDeSalud codigo='{fn:concat($ingresaVentaSeguros/INSURANCE_PRODUCT_CODE/text(),"-",$ingresaVentaSeguros/INSURANCE_PLAN_CODE/text())}'>
    						{
            					for $NUMBER_CHILDREN in $ingresaVentaSeguros/INSURED/HEALTH_QUESTIONS/HEALTH_QUESTION
            					return
            						<codigoPregunta padecimiento='{ $NUMBER_CHILDREN/ADICIONAL_INFO/text() }' respuesta='{ obtenerReespuesta()/ANSWER_TYPE[ @tipo='SPANISH' ]/ANSWER_CODE[ @osb=$NUMBER_CHILDREN/ANSWER/text() ]/text() }'>{ $NUMBER_CHILDREN/ID/text() }</codigoPregunta >
            			} 
    					</cuestionarioDeSalud>
            		)else()
         		}
    			<responsableDePago>
    				<codigoUnicoPersona>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/CUSTOMER_ID/text() }</codigoUnicoPersona>
    				<codigoTipoIdentificacion>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/LEGAL_DOCUMENT_NAME/text() }</codigoTipoIdentificacion>
    				<numeroIdentificacion>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/LEGAL_ID/text() }</numeroIdentificacion>
    				<nombreCompleto>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/LEGAL_HOLDER_NAME/text() }</nombreCompleto>
    				<fechaNacimiento>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/DATE_OF_BIRTH/text() }</fechaNacimiento>
    				<codigoSexo>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/GENDER/text() }</codigoSexo>
    				<codigoEstadoCivil>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/MARITAL_STATUS/text() }</codigoEstadoCivil>
    				<codigoOcupacion>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/OCCUPATION/text() }</codigoOcupacion>
    				<correoElectronico>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/EMAIL_ADDRESS/text() }</correoElectronico>
    				<telefono1>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/PHONE_INFO/PHONE_NUMBER_ITEM[1]/PHONE_NUMBER/text() }</telefono1>
    				{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/PHONE_INFO/PHONE_NUMBER_ITEM[2]/PHONE_NUMBER/text() != '')then(
            				<telefono2>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/PHONE_INFO/PHONE_NUMBER_ITEM[2]/PHONE_NUMBER/text() }</telefono2>
            			)else(
            				<telefono2>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/PHONE_INFO/PHONE_NUMBER_ITEM[1]/PHONE_NUMBER/text() }</telefono2>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<direccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/ADDRESS_LINE/text() }</direccionDomicilio>
            			)else(
            				<direccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/ADDRESS_LINE/text() }</direccionDomicilio>
         				)
         			}
					{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<codigoPaisDireccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/COUNTRY_CODE/text() }</codigoPaisDireccionDomicilio>
            			)else(
            				<codigoPaisDireccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/COUNTRY_CODE/text() }</codigoPaisDireccionDomicilio>
         				)
         			}
					{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<codigoDeptoDireccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionDomicilio>
            			)else(
            				<codigoDeptoDireccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionDomicilio>
         				)
         			}
					{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1'] != '')then(
            				<codigoMunicipioDireccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionDomicilio>
            			)else(
            				<codigoMunicipioDireccionDomicilio>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionDomicilio>
         				)
         			}
            		{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<direccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/ADDRESS_LINE/text() }</direccionTrabajo>
            			)else(
            				<direccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/ADDRESS_LINE/text() }</direccionTrabajo>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<codigoPaisDireccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/COUNTRY_CODE/text() }</codigoPaisDireccionTrabajo>
            			)else(
            				<codigoPaisDireccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/COUNTRY_CODE/text() }</codigoPaisDireccionTrabajo>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<codigoDeptoDireccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionTrabajo>
            			)else(
            				<codigoDeptoDireccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/DEPARTMENT_CODE/text() }</codigoDeptoDireccionTrabajo>
         				)
         			}
         			{
            			if( $ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2'] != '')then(
            				<codigoMunicipioDireccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='2']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionTrabajo>
            			)else(
            				<codigoMunicipioDireccionTrabajo>{$ingresaVentaSeguros/PAYMENT_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM[ADDRESS_TYPE='1']/MUNICIPALITY_CODE/text() }</codigoMunicipioDireccionTrabajo>
         				)
         			}
    				<nit>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/LEGAL_ID/text() }</nit>
    				<formaDePago>
    					<codigoFrecuenciaPago>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_FREQUENCY/text() }</codigoFrecuenciaPago>
    					<codigoProductoBancario>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_METHOD/text() }</codigoProductoBancario>
    					{
            				for $PAYMENT_PRODUCT_NUMBER in $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_PRODUCT_NUMBER
               				 return
                    				<numeroCuentaDebito>{ data($PAYMENT_PRODUCT_NUMBER) }</numeroCuentaDebito>
         				}
         				<codigoMonedaProductoBancario>{ $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_CURRENCY/text() }</codigoMonedaProductoBancario>
         				<descuentaOnLine>{ obtenerReespuesta()/ANSWER_TYPE[ @tipo='SIMPLE' ]/ANSWER_CODE[ @osb=$descountOnline ]/text() }</descuentaOnLine>		
         				{
            				for $EXPIRATION_DATE in $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/EXPIRATION_DATE
            				return
            					<fechaVencimientoTc>{ data($EXPIRATION_DATE) }</fechaVencimientoTc>
            			}
         				{
            				for $PAYMENT_PRODUCT_NUMBER in $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_PRODUCT_NUMBER
               				 return
            					if( $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_METHOD/text() = 'CREDIT_CARD')then(
                    				<numeroDeTarjeta>{ data($PAYMENT_PRODUCT_NUMBER) }</numeroDeTarjeta>
            					)else()
         				}
         				<pagoEnLinea>{ obtenerReespuesta()/ANSWER_TYPE[ @tipo='SIMPLE' ]/ANSWER_CODE[ @osb=$onlinePayment ]/text() }</pagoEnLinea>
    				</formaDePago>
    			</responsableDePago>
    			{
            		if( $ingresaVentaSeguros/INSURED/BENEFICIARIES != '')then(
            			<beneficiarios>
    						{
            					for $BENEFICIARY in $ingresaVentaSeguros/INSURED/BENEFICIARIES/BENEFICIARY
            					return
            						<beneficiario>
    									<codigoTipoIdentificacion>{ $BENEFICIARY/LEGAL_ID_TYPE/text() }</codigoTipoIdentificacion>
    									<numeroIdentificacion>{ $BENEFICIARY/LEGAL_ID/text() }</numeroIdentificacion>
    									<nombreCompleto>{ $BENEFICIARY/NAME/text() }</nombreCompleto>
    									<codigoParentesco>{ $BENEFICIARY/RELATIONSHIP/text() }</codigoParentesco>
    									<fechaNacimiento>{ $BENEFICIARY/DATE_OF_BIRTH/text() }</fechaNacimiento>
    									<porcentaje>{ $BENEFICIARY/PERCENTAGE/text() }</porcentaje>
    								</beneficiario>
            		}
    					</beneficiarios>
            		)else()
         		}
         		{
            		if( $ingresaVentaSeguros/ADDITIONAL_INSUREDS != '')then(
            			<aseguradosAdicionales>
    						{
            					for $ADDITIONAL_INSURED in $ingresaVentaSeguros/ADDITIONAL_INSUREDS/ADDITIONAL_INSURED
            					return
            						<aseguradoAdicional>
    									<codigoTipoIdentificacion>{ $ADDITIONAL_INSURED/LEGAL_ID_TYPE/text() }</codigoTipoIdentificacion>
    									<numeroIdentificacion>{ $ADDITIONAL_INSURED/LEGAL_ID/text() }</numeroIdentificacion>
    									<nombreCompleto>{ $ADDITIONAL_INSURED/NAME/text() }</nombreCompleto>
    									<fechaNacimiento>{ $ADDITIONAL_INSURED/DATE_OF_BIRTH/text() }</fechaNacimiento>
    									<codigoParentesco>{ $ADDITIONAL_INSURED/RELATIONSHIP/text() }</codigoParentesco>
    								</aseguradoAdicional>
            		}
    					</aseguradosAdicionales>
            		)else()
         		}	
    		</certificado>
    	</altaDeSeguro>
        
};

declare variable $ingresaVentaSeguros as element(ns0:ingresaVentaSeguros) external;
declare variable $codigoContratante as xs:string external;
declare variable $codigoEmpleado as xs:string external;
declare variable $nombreEmpleado as xs:string external;
declare variable $cuentaEmpleado as xs:string external;
declare variable $codigoAgencia as xs:string external;
declare variable $onlinePayment as xs:string external;
declare variable $descountOnline as xs:string external;

xf:creaBodyHnIn($ingresaVentaSeguros,
    $codigoContratante,
    $codigoEmpleado,
    $nombreEmpleado,
    $cuentaEmpleado,
    $codigoAgencia,
    $onlinePayment,
    $descountOnline)