xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOfertaCreditoConsumoRequest" element="ns0:consultaOfertaCreditoConsumoRequest" location="../../ConsultaOfertaCreditoConsumo/xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:processWithDecisionFlow2" location="../../../BusinessServices/OIC/originacionesGT/wsdl/originacionesGT.wsdl" ::)

declare namespace ns1 = "http://fico.com/blaze/advisor/rma/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOfertaCreditoConsumoGT/xq/processWithDecisionFlow2In/";

declare function xf:processWithDecisionFlow2In($token as xs:string,
    $consultaOfertaCreditoConsumoRequest as element(ns0:consultaOfertaCreditoConsumoRequest))
    as element(ns1:processWithDecisionFlow2) {
        <ns1:processWithDecisionFlow2>
            <arg0>
                <token>{ $token }</token>
                <accion>
                {
                	for $referenciaSIB in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/SIB_REFERENCE
                	return
                	<referenciaSIB>{ fn:data($referenciaSIB) }</referenciaSIB>
                }
                </accion>
                <antiguedadExtrafinanciamiento>0</antiguedadExtrafinanciamiento>
                <antiguedadLaboral>0</antiguedadLaboral>
                <antiguedadPrestamo>0</antiguedadPrestamo>
                <antiguedadPrestamoExterno>0</antiguedadPrestamoExterno>
                <antiguedadPrestamoFiduciario>0</antiguedadPrestamoFiduciario>
                <antiguedadTarjeta>0</antiguedadTarjeta>
                <antiguedadTarjetaCancelada>0</antiguedadTarjetaCancelada>
                {
                	for $SALES_ORIGIN in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/SALES_ORIGIN
                	return
                	<canalDeVenta>{ fn:data($SALES_ORIGIN) }</canalDeVenta>
                }
                <clienteCastigado>0</clienteCastigado>
                <clienteCobroJudicial>0</clienteCobroJudicial>
                <clienteCuentaCancelada>0</clienteCuentaCancelada>
                <clientePignorado>0</clientePignorado>
                <clienteRPDA>0</clienteRPDA>
                <clienteSaldoRestructurado>0</clienteSaldoRestructurado>
                <clienteUniversitario>0</clienteUniversitario>
                {
                    for $VIP_CLIENT in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/VIP_CLIENT
                    return
                        <clienteVIP>{ data($VIP_CLIENT) }</clienteVIP>
                }
                <codigoTipoCliente>0</codigoTipoCliente>
                {
                	if (fn:exists($consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/QUERIES/QUERY_ITEM)) then (
                	for $QUERY_ITEM in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/QUERIES/QUERY_ITEM
                	return(
                		<consultaTuca>
                		{
                        	for $ENTITY in $QUERY_ITEM/ENTITY
                        	return
                            <entidad>{ data($ENTITY) }</entidad>
                    	}
                    	{
                      for $DATE in $QUERY_ITEM/DATE
                return
                  if (fn:string($DATE/text()) != "") then (
                    let $fechaTexto := fn:string($DATE)
                    return
                      if (fn:matches($fechaTexto, "^\d{2}/\d{2}/\d{4}$")) then (
                        (: Si viene como dd/MM/yyyy, la convertimos :)
                        let $dia := fn:substring($fechaTexto, 1, 2)
                        let $mes := fn:substring($fechaTexto, 4, 2)
                        let $anio := fn:substring($fechaTexto, 7, 4)
                        let $fechaFormateada := fn:concat($anio, "-", $mes, "-", $dia, "T00:00:00")
                        return <fechaConsulta>{ fn-bea:date-from-string-with-format("yyyy-MM-dd'T'HH:mm:ss", $fechaFormateada) }</fechaConsulta>
                      )
                      else (
                        (: Si ya viene como yyyy-MM-dd'T'HH:mm:ss u otro formato válido :)
                        <fechaConsulta>{ fn-bea:date-from-string-with-format("yyyy-MM-dd'T'HH:mm:ss", data($DATE)) }</fechaConsulta>
                      )
                  ) else ()
                    	}
                    	{
                        	for $MOTIVE in $QUERY_ITEM/MOTIVE
                        	return
                            <motivo>{ data($MOTIVE) }</motivo>
                    	}
                    	{
                    		for $TYPE in $QUERY_ITEM/TYPE
                    		return
                    		<tipoConsulta>{ data($TYPE) }</tipoConsulta>
                    	}
                		</consultaTuca>
                	)) else (<consultaTuca/>)
                }
                <cuotasExternasTotales>0</cuotasExternasTotales>
                <cuotasInternasTotales>0</cuotasInternasTotales>
                <cuotasPagadasPrestamo>0</cuotasPagadasPrestamo>
                <edad>0</edad>
                <exposicionActual>0</exposicionActual>
                <exposicionGlobal>0</exposicionGlobal>
                <fechaActual>{ fn-bea:dateTime-to-string-with-format('dd-MMM-yyyy', fn:current-dateTime()) }</fechaActual>
                {
                	for $JOB_START_DATE in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_START_DATE
                	return
                	<fechaIncioLaboral>{ fn-bea:date-to-string-with-format('dd-MMM-yyyy', data($JOB_START_DATE)) }</fechaIncioLaboral>
                }
                {
                	for $DATE_OF_BIRTH in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/DATE_OF_BIRTH
                	return
                	<fechaNacimiento>{ data($DATE_OF_BIRTH) }</fechaNacimiento>
                }
                <flagColaborador>0</flagColaborador>
                {
                	for $GENDER in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/GENDER
                	return
                	<genero>{ data($GENDER) }</genero>
                }
                <ingresoResidual>0</ingresoResidual>
                <ingresosMensuales>0</ingresosMensuales>
                <limiteMaximoUSD>0</limiteMaximoUSD>
                <limitesTarjetas>0</limitesTarjetas>
                <moraActualExtena>0</moraActualExtena>
                <moraActualInterna>0</moraActualInterna>
                <moraPrestamo>0</moraPrestamo>
                {
                	for $CAMPAING in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/CAMPAING
                	return
                	<naturalezaProducto>{ data($CAMPAING) }</naturalezaProducto>
                }
                {
                	for $FISCAL_ID in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/FISCAL_ID
                	return
                	<nit>{ fn:data($FISCAL_ID) }</nit>
                }
                <nivelEndeudamiento>0</nivelEndeudamiento>
                <nivelEndeudamientoExterno>0</nivelEndeudamientoExterno>
                {
                	for $CASE_ID in $consultaOfertaCreditoConsumoRequest/CASE_ID
                	return
                	<noSolicitud>{ data($CASE_ID) }</noSolicitud>
                }
                {
                	for $USER_NAME in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/USER_NAME
                	return
                	<nombreUsuario>{ fn:data($USER_NAME) }</nombreUsuario>
                }
                {
                	if (fn:exists($consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/FOR_CONSOLIDATE/FOR_CONSOLIDATE)) then (
                	for $FOR_CONSOLIDATE in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/FOR_CONSOLIDATE/FOR_CONSOLIDATE
                	return(
                		<obligacionesConsolidar>
                		{
                        	for $CHECK_BENEFECIARY in $FOR_CONSOLIDATE/CHECK_BENEFECIARY
                        	return
                            <chequeANombreDe>{ data($CHECK_BENEFECIARY) }</chequeANombreDe>
                    	}
                    	{
                    		for $REFERENCE_INSTALLMENT_AMOUNT in $FOR_CONSOLIDATE/REFERENCE_INSTALLMENT_AMOUNT
                    		return
                    		<cuotaConsolidar>{ data($REFERENCE_INSTALLMENT_AMOUNT) }</cuotaConsolidar>
                    	}
                    	{
                        	for $REFERENCE_ENTITY in $FOR_CONSOLIDATE/REFERENCE_ENTITY
                        	return
                            <entidad>{ data($REFERENCE_ENTITY) }</entidad>
                    	}
                    	{
                        	for $REFERENCE_CURRENCY in $FOR_CONSOLIDATE/REFERENCE_CURRENCY
                        	return
                            <moneda>{ data($REFERENCE_CURRENCY) }</moneda>
                    	}
                    	{
                        	for $REFERENCE_ACCOUNT_NUMBER in $FOR_CONSOLIDATE/REFERENCE_ACCOUNT_NUMBER
                        	return
                            <numeroCuenta>{ data($REFERENCE_ACCOUNT_NUMBER) }</numeroCuenta>
                    	}
                    	{
                    		for $REFERENCE_LIMIT_AMOUNT in $FOR_CONSOLIDATE/REFERENCE_LIMIT_AMOUNT
                    		return
                    		<saldoConsolidar>{ data($REFERENCE_LIMIT_AMOUNT) }</saldoConsolidar>
                    	}
                    	{
                        	for $REFERENCE_TYPE in $FOR_CONSOLIDATE/REFERENCE_TYPE
                        	return
                            <tipoProducto>{ data($REFERENCE_TYPE) }</tipoProducto>
                    	}
                		</obligacionesConsolidar>
                	)) else (<obligacionesConsolidar/>)
                }
                <poseeConsultasTuca>0</poseeConsultasTuca>
                <poseePrestamo>0</poseePrestamo>
                <poseeReferenciaSIRC>0</poseeReferenciaSIRC>
                <poseeReferenciaTUCA>0</poseeReferenciaTUCA>
                <poseeTarjeta>0</poseeTarjeta>
                {
                	if (fn:exists($consultaOfertaCreditoConsumoRequest/LIABILITIES/LOANS_INFO/LOAN)) then (
                	for $LOAN in $consultaOfertaCreditoConsumoRequest/LIABILITIES/LOANS_INFO/LOAN
                	return(
                		<prestamo>
                    		<antiguedadPrestamo>0</antiguedadPrestamo>
                    		{
                    			for $PAID_PAYMENTS in $LOAN/PAID_PAYMENTS
                    			return
                    			<cantidadCuotasPagadas>{ data($PAID_PAYMENTS) }</cantidadCuotasPagadas>
                    		}
                    		{
                    			for $CHARGES in $LOAN/CHARGES
                    			return
                    			<cargos>{ data($CHARGES) }</cargos>
                    		}
                    		{
                    			for $AGENCY_CODE in $LOAN/AGENCY_CODE
                    			return
                    			<codigoAgencia>{ data($AGENCY_CODE) }</codigoAgencia>
                    		}
                    		<codigoDestino>0</codigoDestino>
                    		{
                    			for $SUB_APPLICATION in $LOAN/SUB_APPLICATION
                    			return
                    			<codigoSubAplicacion>{ data($SUB_APPLICATION) }</codigoSubAplicacion>
                    		}
                    		<codigoTipoGarantia>0</codigoTipoGarantia>
                    		{
                    			for $OPENING_DATE in $LOAN/OPENING_DATE
                    			return
                    			<fechaApertura>{ data($OPENING_DATE) }</fechaApertura>
                    		}
                    		{
                    			for $CANCELATION_DATE in $LOAN/CANCELATION_DATE
                    			return
                    			<fechaCancelacion>{ data($CANCELATION_DATE) }</fechaCancelacion>
                    		}
                    		{
                    			for $FIRST_PAYMENT_DATE in $LOAN/FIRST_PAYMENT_DATE
                    			return
                    			<fechaPrimerPagoCapital>{ data($FIRST_PAYMENT_DATE) }</fechaPrimerPagoCapital>
                    		}
                    		{
                    			for $LAST_PAYMENT_DATE in $LOAN/LAST_PAYMENT_DATE
                    			return
                    			<fechaUltimoPago>{ data($LAST_PAYMENT_DATE) }</fechaUltimoPago>
                    		}
                    		<identidad>{ fn:string('') }</identidad>
                    		{
                    			for $INTEREST in $LOAN/INTEREST
                    			return
                    			<intereses>{ data($INTEREST) }</intereses>
                    		}
                    		{
                    			for $INITIAL_AMOUNT in $LOAN/INITIAL_AMOUNT
                    			return
                    			<montoInicial>{ data($INITIAL_AMOUNT) }</montoInicial>
                    		}
                    		{
                        		for $CURRENT_DUE in $LOAN/CURRENT_DUE
                        		return
                            	<moraActual>{ data($CURRENT_DUE) }</moraActual>
                    		}
                    		<numeroContrato>0</numeroContrato>
                    		{
                        		for $PAYMENT_NUMBER in $LOAN/PAYMENT_NUMBER
                        		return
                            	<numeroCuotas>{ data($PAYMENT_NUMBER) }</numeroCuotas>
                    		}
                    		{
                        		for $NUMBER in $LOAN/NUMBER
                        		return
                            	<numeroPrestamo>{ data($NUMBER) }</numeroPrestamo>
                    		}
                    		{
                        		for $OTHER_CHARGES in $LOAN/OTHER_CHARGES
                        		return
                            	<otrosCargos>{ data($OTHER_CHARGES) }</otrosCargos>
                    		}
                    		{
                        		for $TERM in $LOAN/TERM
                        		return
                            	<plazo>{ data($TERM) }</plazo>
                    		}
                    		<prestamoCancelado>0</prestamoCancelado>
                    		<prestamoVigente>0</prestamoVigente>
                    		<primaMensual>0</primaMensual>
                    		{
                        		for $CURRENT_BALANCE in $LOAN/CURRENT_BALANCE
                        		return
                            	<saldoActual>{ data($CURRENT_BALANCE) }</saldoActual>
                    		}
                    		{
                        		for $INSURANCE in $LOAN/INSURANCE
                        		return
                            	<seguros>{ data($INSURANCE) }</seguros>
                    		}
                    		{
                        		for $RATE in $LOAN/RATE
                        		return
                            	<tasa>{ data($RATE) }</tasa>
                    		}
                    		<tipoDeudor>D</tipoDeudor>
                    		{
                        		for $PAYMENT_AMOUNT in $LOAN/PAYMENT_AMOUNT
                        		return
                            	<valorCuota>{ data($PAYMENT_AMOUNT) }</valorCuota>
                    		}
                		</prestamo>
                	)) else (<prestamo/>)
                }
                {
                	for $FIRST_NAME in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/FIRST_NAME
                	return
                	<primerNombre>{ fn:data($FIRST_NAME) }</primerNombre>
                }
                {
                	if (fn:exists($consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/REFERENCE_BUREAU_SIRC/REFERENCE)) then (
                	for $REFERENCE in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/REFERENCE_BUREAU_SIRC/REFERENCE
                	return(
                		<referenciaSirc>
                		{
                			for $AMOUNT in $REFERENCE/AMOUNT
                			return
                			<capitalOriginal>{ data($AMOUNT) }</capitalOriginal>
                		}
                    	{
                        	for $CATEGORY in $REFERENCE/CATEGORY
                        	return
                            <categoria>{ data($CATEGORY) }</categoria>
                    	}
                    	{
                        	for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
                        	return
                            <comportamiento>{ data($HISTORICAL_ARREAR) }</comportamiento>
                    	}
                    	<comportamientoArray>{ fn:string('') }</comportamientoArray>
                    	{
                        	for $CREDITOR in $REFERENCE/CREDITOR
                        	return
                            <entidad>{ data($CREDITOR) }</entidad>
                    	}
                    	{
                        	for $STATUS in $REFERENCE/STATUS
                        	return
                            <estadoCredito>{ data($STATUS) }</estadoCredito>
                    	}
                    	{
                    		for $OPENING_DATE in $REFERENCE/OPENING_DATE
                    		return
                    		<fechaActivo>{ data($OPENING_DATE) }</fechaActivo>
                    	}
                    	{
                    		for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
                    		return
                    		<fechaCancelacion>{ data($CANCELATION_DATE) }</fechaCancelacion>
                    	}
                    	{
                    		for $CONSESSION_DATE in $REFERENCE/CONSESSION_DATE
                    		return
                    		<fechaConcesion>{ data($CONSESSION_DATE) }</fechaConcesion>
                    	}
                    	{
                    		for $EXPIRATION_DATE in $REFERENCE/EXPIRATION_DATE
                    		return
                    		<fechaVencimiento>{ data($EXPIRATION_DATE) }</fechaVencimiento>
                    	}
                    	{
                        	for $CURRENCY in $REFERENCE/CURRENCY
                        	return
                            <moneda>{ data($CURRENCY) }</moneda>
                    	}
                    	<numeroEvaluacionSirc>0</numeroEvaluacionSirc>
                    	{
                        	for $BALANCE in $REFERENCE/BALANCE
                        	return
                            <saldoCapital>{ data($BALANCE) }</saldoCapital>
                    	}
                    	<tarjetaFicohsa>0</tarjetaFicohsa>
                    	{
                        	for $ASSET_TYPE in $REFERENCE/ASSET_TYPE
                        	return
                            <tipoActivo>{ data($ASSET_TYPE) }</tipoActivo>
                    	}
                    	{
                        	for $DEBTOR_TYPE in $REFERENCE/DEBTOR_TYPE
                        	return
                            <tipoDeudor>{ data($DEBTOR_TYPE) }</tipoDeudor>
                    	}
                    	{
                        	for $WARRANTY_TYPE in $REFERENCE/WARRANTY_TYPE
                        	return
                            <tipoGarantia>{ data($WARRANTY_TYPE) }</tipoGarantia>
                    	}
                    	{
                        	for $TYPE in $REFERENCE/TYPE
                        	return
                            <tipoReferencia>{ data($TYPE) }</tipoReferencia>
                    	}
                    	{
                        	for $DUE_BALANCE in $REFERENCE/DUE_BALANCE
                        	return
                            <vencido>{ data($DUE_BALANCE) }</vencido>
                    	}
                		</referenciaSirc>
                	)) else (<referenciaSirc/>)
                }
                {
                	if (fn:exists($consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/REFERENCE_BUREAU_TUCA/REFERENCE)) then (
                	for $REFERENCE in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/REFERENCE_BUREAU_TUCA/REFERENCE
                	return(
                		<referenciaTuca>
                		<antiguedad>0</antiguedad>
                		<antiguedadCancelacion>0</antiguedadCancelacion>
                		<balance>0</balance>
                    	{
                        	for $CATEGORY in $REFERENCE/CATEGORY
                        	return
                            <calificacion>{ data($CATEGORY) }</calificacion>
                    	}
                    	{
                        	for $OBLIGATION_CODE in $REFERENCE/OBLIGATION_CODE
                        	return
                            <codigoObligacion>{ data($OBLIGATION_CODE) }</codigoObligacion>
                    	}
                    	{
                        	for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
                        	return
                            <comportamiento>{ data($HISTORICAL_ARREAR) }</comportamiento>
                    	}
                    	<comportamientoArray>0</comportamientoArray>
                    	<creditLimit>0</creditLimit>
                    	{
                        	for $INSTALLMENT in $REFERENCE/INSTALLMENT
                        	return
                            <cuota>{ data($INSTALLMENT) }</cuota>
                    	}
                    	{
                        	for $CREDITOR in $REFERENCE/CREDITOR
                        	return
                            <entidad>{ data($CREDITOR) }</entidad>
                    	}
                    	{
                        	for $CREDIT_STATUS in $REFERENCE/CREDIT_STATUS
                        	return
                            <estadoCredito>{ data($CREDIT_STATUS) }</estadoCredito>
                    	}
                    	{
                        	for $STATUS in $REFERENCE/STATUS
                        	return
                            <estatus>{ data($STATUS) }</estatus>
                    	}
                    	{
                        	for $INFORMATION_DATE in $REFERENCE/INFORMATION_DATE
                        	return
                            <fechaActualizacion>{ data($INFORMATION_DATE) }</fechaActualizacion>
                    	}
                    	{
                        	for $OPENING_DATE in $REFERENCE/OPENING_DATE
                        	return
                            <fechaApertura>{ data($OPENING_DATE) }</fechaApertura>
                    	}
                    	{
                        	for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
                        	return
                            <fechaVencimiento>{ data($CANCELATION_DATE) }</fechaVencimiento>
                    	}
                    	<flagDateNumerica>0</flagDateNumerica>
                    	{
                        	for $REFERENCE_NUMBER in $REFERENCE/REFERENCE_NUMBER
                        	return
                            <idEvaluacion>{ data($REFERENCE_NUMBER) }</idEvaluacion>
                    	}
                    	<largoCadena>0</largoCadena>
                    	{
                        	for $LIMIT in $REFERENCE/LIMIT
                        	return
                            <limiteCredito>{ data($LIMIT) }</limiteCredito>
                    	}
                    	{
                        	for $CURRENCY in $REFERENCE/CURRENCY
                        	return
                            <moneda>{ data($CURRENCY) }</moneda>
                    	}
                    	<monthsSinceDateROpened>0</monthsSinceDateROpened>
                    	<monthsSinceDateReported>0</monthsSinceDateReported>
                    	{
                        	for $QUERY_ID in $REFERENCE/QUERY_ID
                        	return
                            <numeroEvaluacionTuca>{ data($QUERY_ID) }</numeroEvaluacionTuca>
                    	}
                    	<openTradeLine>0</openTradeLine>
                    	{
                        	for $PAYMENT_METHOD in $REFERENCE/PAYMENT_METHOD
                        	return
                            <periodoPago>{ data($PAYMENT_METHOD) }</periodoPago>
                    	}
                    	<referenciaCancelada>0</referenciaCancelada>
                    	<referenciaVigente>0</referenciaVigente>
                    	{
                        	for $BALANCE in $REFERENCE/BALANCE
                        	return
                            <saldoActual>{ data($BALANCE) }</saldoActual>
                    	}
                    	{
                        	for $ARREAR_BALANCE in $REFERENCE/ARREAR_BALANCE
                        	return
                            <saldoMora>{ data($ARREAR_BALANCE) }</saldoMora>
                    	}
                    	<sameAccount>0</sameAccount>
                    	{
                        	for $OBLIGATION_SECTOR in $REFERENCE/OBLIGATION_SECTOR
                        	return
                            <sectorObligacion>{ data($OBLIGATION_SECTOR) }</sectorObligacion>
                    	}
                    	<status30>0</status30>
                    	<status60>0</status60>
                    	<statusBypass>0</statusBypass>
                    	<statusCollection>0</statusCollection>
                    	<statusInactive>0</statusInactive>
                    	<statusUnknownDelinquency>0</statusUnknownDelinquency>
                    	<tarjetaFicohsa>0</tarjetaFicohsa>
                    	{
                        	for $CREDIT_TYPE in $REFERENCE/CREDIT_TYPE
                        	return
                            <tipoActivo>{ data($CREDIT_TYPE) }</tipoActivo>
                    	}
                    	{
                        	for $GUARANTEE_TYPE in $REFERENCE/GUARANTEE_TYPE
                        	return
                            <tipoGarantia>{ data($GUARANTEE_TYPE) }</tipoGarantia>
                    	}
                    	{
                        	for $OBLIGATION_TYPE in $REFERENCE/OBLIGATION_TYPE
                        	return
                            <tipoObligacion>{ data($OBLIGATION_TYPE) }</tipoObligacion>
                    	}
                    	{
                        	for $TYPE in $REFERENCE/TYPE
                        	return
                            <tipoReferencia>{ data($TYPE) }</tipoReferencia>
                    	}
                    	<tradeLine>0</tradeLine>
                    	<typeNonCredit>0</typeNonCredit>
                    	<typeRevolving>0</typeRevolving>
                    	<typeStudent>0</typeStudent>
                    	<typeTelecommunications>0</typeTelecommunications>
                    	<typesInstallment>0</typesInstallment>
                    	{
                        	for $LAST_MOVEMENT_YEAR in $REFERENCE/LAST_MOVEMENT_YEAR
                        	return
                            <ultMovAnio>{ data($LAST_MOVEMENT_YEAR) }</ultMovAnio>
                    	}
                    	{
                        	for $LAST_MOVEMENT_MONTH in $REFERENCE/LAST_MOVEMENT_MONTH
                        	return
                            <ultMovMes>{ data($LAST_MOVEMENT_MONTH) }</ultMovMes>
                    	}
                		</referenciaTuca>
                	)) else (<referenciaTuca/>)
                }
                <referenciasEstadoIncobrables>0</referenciasEstadoIncobrables>
                {
                	for $TOTAL_SALARY in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TOTAL_SALARY
                	return
                	<salarioBruto>{ data($TOTAL_SALARY) }</salarioBruto>
                }
                <salarioDB>0</salarioDB>
                <salarioInferido>0</salarioInferido>
                <saldoConsolidacion>0</saldoConsolidacion>
                {
                	for $EXTERNAL_SCORE in $consultaOfertaCreditoConsumoRequest/EXTERNAL_SCORE
                	return
                	<scoreBuro>{ data($EXTERNAL_SCORE) }</scoreBuro>
                }
                {
                	for $LAST_NAME in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/LAST_NAME
                	return
                	<segundoNombre>{ fn:data($LAST_NAME) }</segundoNombre>
                }
                <sexo>0</sexo>
                {
                	for $TARGET in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TARGET
                	return
                	<target>{ data($TARGET) }</target>
                }
                {
                	if (fn:exists($consultaOfertaCreditoConsumoRequest/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD)) then (
                	for $CREDIT_CARD in $consultaOfertaCreditoConsumoRequest/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD
                	return(
                		<tarjeta>
                		{
                			for $BEHAVIOR_SCORE in $CREDIT_CARD/BEHAVIOR_SCORE
                			return
                			<behaviorScore>{ data($BEHAVIOR_SCORE) }</behaviorScore>
                		}
                    	{
                        	for $QUALIFICATION_SCORE in $CREDIT_CARD/QUALIFICATION_SCORE
                        	return
                            <calificacionScore>{ data($QUALIFICATION_SCORE) }</calificacionScore>
                    	}
                    	{
                        	for $QUALIFICATION_CUSTOMER_SCORE in $CREDIT_CARD/QUALIFICATION_CUSTOMER_SCORE
                        	return
                            <calificacionScoreCliente>{ data($QUALIFICATION_CUSTOMER_SCORE) }</calificacionScoreCliente>
                    	}
                    	{
                        	for $AVAILABLE_CASH in $CREDIT_CARD/AVAILABLE_CASH
                        	return
                            <cashDisponible>{ data($AVAILABLE_CASH) }</cashDisponible>
                    	}
                    	{
                        	for $LOCKCODE1 in $CREDIT_CARD/LOCKCODE1
                        	return
                            <codbloqueo1>{ data($LOCKCODE1) }</codbloqueo1>
                    	}
                    	{
                        	for $LOCKCODE2 in $CREDIT_CARD/LOCKCODE2
                        	return
                            <codbloqueo2>{ data($LOCKCODE2) }</codbloqueo2>
                    	}
                    	{
                        	for $ACTIVE_EXTRA_INSTALLMENTS in $CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS
                        	return
                            <cuotasExtraVigentes>{ data($ACTIVE_EXTRA_INSTALLMENTS) }</cuotasExtraVigentes>
                    	}
                    	{
                        	for $STATUS in $CREDIT_CARD/STATUS
                        	return
                            <estado>{ data($STATUS) }</estado>
                    	}
                    	{
                        	for $OPENING_DATE in $CREDIT_CARD/OPENING_DATE
                        	return
                            <fechaApertura>{ data($OPENING_DATE) }</fechaApertura>
                    	}
                    	{
                        	for $LAST_EXTRA_DATE in $CREDIT_CARD/LAST_EXTRA_DATE
                        	return
                            <fechaAprobacionExtra>{ data($LAST_EXTRA_DATE) }</fechaAprobacionExtra>
                    	}
                    	{
                        	for $LAST_INTRA_DATE in $CREDIT_CARD/LAST_INTRA_DATE
                        	return
                            <fechaAprobacionIntra>{ data($LAST_INTRA_DATE) }</fechaAprobacionIntra>
                    	}
                    	{
                        	for $LAST_PIL_DATE in $CREDIT_CARD/LAST_PIL_DATE
                        	return
                            <fechaAprobacionPil>{ data($LAST_PIL_DATE) }</fechaAprobacionPil>
                    	}
                    	{
                        	for $LOCK_DATE1 in $CREDIT_CARD/LOCK_DATE1
                        	return
                            <fechaBloqueo1>{ data($LOCK_DATE1) }</fechaBloqueo1>
                    	}
                    	{
                        	for $LOCK_DATE2 in $CREDIT_CARD/LOCK_DATE2
                        	return
                            <fechaBloqueo2>{ data($LOCK_DATE2) }</fechaBloqueo2>
                    	}
                    	{
                        	for $CANCELATION_DATE in $CREDIT_CARD/CANCELATION_DATE
                        	return
                            <fechaCancelacion>{ data($CANCELATION_DATE) }</fechaCancelacion>
                    	}
                    	{
                        	for $CHARGE_OFF_FLAG in $CREDIT_CARD/CHARGE_OFF_FLAG
                        	return
                            <flagCastigo>{ data($CHARGE_OFF_FLAG) }</flagCastigo>
                    	}
                    	{
                        	for $AFFINITY_GROUP in $CREDIT_CARD/AFFINITY_GROUP
                        	return
                            <grupoAfinidad>{ data($AFFINITY_GROUP) }</grupoAfinidad>
                    	}
                    	{
                        	for $CURRENT_LIMIT in $CREDIT_CARD/CURRENT_LIMIT
                        	return
                            <limite>{ data($CURRENT_LIMIT) }</limite>
                    	}
                    	{
                        	for $PRIOR_LIMIT in $CREDIT_CARD/PRIOR_LIMIT
                        	return
                            <limitePrevio>{ data($PRIOR_LIMIT) }</limitePrevio>
                    	}
                    	{
                        	for $LOGO in $CREDIT_CARD/LOGO
                        	return
                            <logo>{ data($LOGO) }</logo>
                    	}
                    	{
                        	for $CLEARING_MODEL in $CREDIT_CARD/CLEARING_MODEL
                        	return
                            <modeloLiquidacion>{ data($CLEARING_MODEL) }</modeloLiquidacion>
                    	}
                    	{
                        	for $CURRENT_DUE in $CREDIT_CARD/CURRENT_DUE
                        	return
                            <moraActual>{ data($CURRENT_DUE) }</moraActual>
                    	}
                    	{
                        	for $HISTORICAL_ARREAR_LOC in $CREDIT_CARD/HISTORICAL_ARREAR_LOC
                        	return
                            <morosidadHistoricaLOC>{ data($HISTORICAL_ARREAR_LOC) }</morosidadHistoricaLOC>
                    	}
                    	{
                        	for $HISTORICAL_ARREAR_USD in $CREDIT_CARD/HISTORICAL_ARREAR_USD
                        	return
                            <morosidadHistoricaUSD>{ data($HISTORICAL_ARREAR_USD) }</morosidadHistoricaUSD>
                    	}
                    	{
                        	for $ACCOUNT in $CREDIT_CARD/ACCOUNT
                        	return
                            <numeroCuenta>{ data($ACCOUNT) }</numeroCuenta>
                    	}
                    	{
                        	for $CURRENT_BALANCE in $CREDIT_CARD/CURRENT_BALANCE
                        	return
                            <saldoActual>{ data($CURRENT_BALANCE) }</saldoActual>
                    	}
                    	{
                        	for $CLOSING_BALANCE in $CREDIT_CARD/CLOSING_BALANCE
                        	return
                            <saldoCorte>{ data($CLOSING_BALANCE) }</saldoCorte>
                    	}
                    	{
                        	for $EXTRA_BALANCE in $CREDIT_CARD/EXTRA_BALANCE
                        	return
                            <saldoExtra>{ data($EXTRA_BALANCE) }</saldoExtra>
                    	}
                    	{
                        	for $INTRA_BALANCE in $CREDIT_CARD/INTRA_BALANCE
                        	return
                            <saldoIntra>{ data($INTRA_BALANCE) }</saldoIntra>
                    	}
                		</tarjeta>
                	)) else (<tarjeta/>)
                }
                {
                    for $HOUSING_ANTIQUITY in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/HOUSING_ANTIQUITY
                    return
                        <tiempoResidenciaActual>{ data($HOUSING_ANTIQUITY) }</tiempoResidenciaActual>
                }
                <tiempoResidenciaMeses>0</tiempoResidenciaMeses>
                <tipoCambio>0</tipoCambio>
                {
                    for $CLIENT_PROFILE in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/CLIENT_PROFILE
                    return
                        <tipoCliente>{ data($CLIENT_PROFILE) }</tipoCliente>
                }
                {
                    for $HOUSING_TYPE in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/HOUSING_TYPE
                    return
                        <tipoVivienda>{ data($HOUSING_TYPE) }</tipoVivienda>
                }
                <vecesMora120_18m>0</vecesMora120_18m>
                <vecesMora30_3m>0</vecesMora30_3m>
                <vecesMora60_6m>0</vecesMora60_6m>
                <vecesMora90_12m>0</vecesMora90_12m>
            </arg0>
        </ns1:processWithDecisionFlow2>
};

declare variable $token as xs:string external;
declare variable $consultaOfertaCreditoConsumoRequest as element(ns0:consultaOfertaCreditoConsumoRequest) external;

xf:processWithDecisionFlow2In($token,
    $consultaOfertaCreditoConsumoRequest)