xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOfertaCreditoConsumoRequest" element="ns0:consultaOfertaCreditoConsumoRequest" location="../xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoClienteResponse" element="ns2:consultaConsolidadaRiesgoClienteResponse" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:epOriginacionesHonduras" location="../../../BusinessServices/BLAZE/wsdl/RuleServiceDefinitionORPTMOHNService.wsdl" ::)

declare namespace ns2= "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace ns1 = "http://package.name.in.reverse.order";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoIn/";

declare function xf:consultaOfertaCreditoConsumoIn($consultaOfertaCreditoConsumoRequest as element(ns0:consultaOfertaCreditoConsumoRequest),
	$consultaConsolidadaRiesgoClienteResponse as element(ns2:consultaConsolidadaRiesgoClienteResponse))
    as element(ns1:epOriginacionesHonduras) {
        <ns1:epOriginacionesHonduras>
                        <arg0>
	            {
	            if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/LABOR_YEARS)) > 0) then
	            (	
	            	  <antiguedaLaboral>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/LABOR_YEARS) }</antiguedaLaboral>
	            )
	            else (  <antiguedaLaboral>{ 0 }</antiguedaLaboral>)
	            }
                        
                {
	            if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_CHARGE)) > 0) then
	            (	
	            	  <cargo>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_CHARGE) }</cargo>
	            )
	            else (  <cargo>{ 0 }</cargo>)
	            }
                       
                {
                       
                    for $QUERY_ITEM in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/QUERIES/QUERY_ITEM
                    return
                    <consultas>
                       <entidad>{ data($QUERY_ITEM/ENTITY) }</entidad>
                       <fechaConsulta>{ data($QUERY_ITEM/DATE) }</fechaConsulta>
                     
                    </consultas>
                }
                <edad>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/AGE) }</edad>
                {
                    for $JOB_COMPANY in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_COMPANY
                    return
                        <empresa>{ data($JOB_COMPANY) }</empresa>
                }
                {
                    for $COMPANY_NAME in $consultaOfertaCreditoConsumoRequest/AGREEMENT/COMPANY_NAME
                    return
                        <empresaConvenio>{ data($COMPANY_NAME) }</empresaConvenio>
                }
                {
                    for $STATUS in $consultaOfertaCreditoConsumoRequest/AGREEMENT/STATUS
                    return
                        <estadoConvenio>{ data($STATUS) }</estadoConvenio>
                }
                {
                    for $EXTRA in $consultaOfertaCreditoConsumoRequest/INTERNAL_EXTRAS/EXTRA
                    return
                        <extraInterno>
                        	{
			                if (fn:string-length(data($EXTRA/INSTALLMENT)) > 0) then
				            (
				               	<cuotaExtra>{ data($EXTRA/INSTALLMENT) }</cuotaExtra>
				            )
				            else ()
				            }
                            {
                                for $INSTALLMENT_COUNT in $EXTRA/INSTALLMENT_COUNT
                                return
                                    <cuotaNumero>{ data($INSTALLMENT_COUNT) }</cuotaNumero>
                            }
                            {
                                for $DATE in $EXTRA/DATE
                                return
                                    <fechaExtra>{ data($DATE) }</fechaExtra>
                            }
                            {
			                if (fn:string-length(data($EXTRA/AMOUNT)) > 0) then
				            (
				               	<montoTomado>{ data($EXTRA/AMOUNT) }</montoTomado>
				            )
				            else ()
				            }
                            <numeroCuenta>{ data($EXTRA/ACCOUNT_NUMBER) }</numeroCuenta>
                            {
			                if (fn:string-length(data($EXTRA/RATE)) > 0) then
				            (
				               	<tasaExtra>{ data($EXTRA/RATE) }</tasaExtra>
				            )
				            else ()
				            }
                            {
                                for $TOTAL_INSTALLMENT in $EXTRA/TOTAL_INSTALLMENT
                                return
                                    <totalCuotas>{ data($TOTAL_INSTALLMENT) }</totalCuotas>
                            }
                        </extraInterno>
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_START_DATE)) > 0) then
	            (
	               	<fechaInicioLaboral>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_START_DATE) }</fechaInicioLaboral>
	            )
	            else ()
	            }
                <fechaNacimiento>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/DATE_OF_BIRTH) }</fechaNacimiento>
                {
                    for $PAYMENT_METHOD in $consultaOfertaCreditoConsumoRequest/AGREEMENT/PAYMENT_METHOD
                    return
                        <formaPagoConvenio>{ data($PAYMENT_METHOD) }</formaPagoConvenio>
                }
                {
                    for $SOURCE_OF_INCOME in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/SOURCE_OF_INCOME
                    return
                        <fuentePago>{ data($SOURCE_OF_INCOME) }</fuentePago>
                }
                <identidad>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/ID) }</identidad>
                {
                    for $OFFER in $consultaOfertaCreditoConsumoRequest/OFFERS/OFFER
                    return
                    <mantenimientoPrestamo>
                        <codResolucionRetanqueoMC>{ data($OFFER/RESOLUTION/CODE) }</codResolucionRetanqueoMC>
                        <cuotaRetanqueoMC>{ data($OFFER/INSTALLMENT) }</cuotaRetanqueoMC>
                        {
                          for $FLAG_HIT in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/FLAG_HIT
                          return
                              <flagHit>{ data($FLAG_HIT) }</flagHit>
                        }
                        {
                          let $AMOUNT_CALCULATIONS := $OFFER/AMOUNT_CALCULATIONS
                          return(
                            <monto12RetanqueoMC>{ data($AMOUNT_CALCULATIONS/FOR_12_MONTHS) }</monto12RetanqueoMC>,
                            <monto18RetanqueoMC>{ data($AMOUNT_CALCULATIONS/FOR_18_MONTHS) }</monto18RetanqueoMC>,
                            <monto24RetanqueoMC>{ data($AMOUNT_CALCULATIONS/FOR_24_MONTHS) }</monto24RetanqueoMC>,
                            <monto36RetanqueoMC>{ data($AMOUNT_CALCULATIONS/FOR_36_MONTHS) }</monto36RetanqueoMC>,
                            <monto48RetanqueoMC>{ data($AMOUNT_CALCULATIONS/FOR_48_MONTHS) }</monto48RetanqueoMC>,
                            <monto60RetanqueoMC>{ data($AMOUNT_CALCULATIONS/FOR_60_MONTHS) }</monto60RetanqueoMC>
                            )
                        }
                        <montoRetanqueoMC>{ data($OFFER/MAX_AMOUNT) }</montoRetanqueoMC>
                        <tasaRetanqueoMC>{ data($OFFER/RATE) }</tasaRetanqueoMC>
                        <timesIncomeRetanqueoMC>{ data($OFFER/TIMES_INCOME) }</timesIncomeRetanqueoMC>
                    </mantenimientoPrestamo>
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/CREDIT_MONTHS)) > 0) then
                (
                	<mesesDeposito>{ xs:int(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/CREDIT_MONTHS)) }</mesesDeposito>
                )
                else ()
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/AGREEMENT/AMOUNT)) > 0) then
                (
                	<montoConvenio>{ data($consultaOfertaCreditoConsumoRequest/AGREEMENT/AMOUNT) }</montoConvenio>
                )
                else ()
                }
                <naturalezaProducto>{ data($consultaOfertaCreditoConsumoRequest/PRODUCT_NATURE) }</naturalezaProducto>
                <numeroSolicitud>{ data($consultaOfertaCreditoConsumoRequest/CASE_ID) }</numeroSolicitud>
                {
                	for $FOR_CONSOLIDATION_REFERENCE in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE
                	where ($FOR_CONSOLIDATION_REFERENCE/FOR_CONSOLIDATION) = 'YES'
                	return
                	<obligacionesConsolidacion>
		               <acreedor>{ data($FOR_CONSOLIDATION_REFERENCE/CREDITOR) }</acreedor>
		               <estado>{ data($FOR_CONSOLIDATION_REFERENCE/STATUS) }</estado>
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/OPENING_DATE)) > 0) then
		               (
		                	<fechaApertura>{ data($FOR_CONSOLIDATION_REFERENCE/OPENING_DATE) }</fechaApertura>
		               )
		               else ()
		               }
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/CANCELATION_DATE)) > 0) then
		               (
		                	<fechaCancelacion>{ data($FOR_CONSOLIDATION_REFERENCE/CANCELATION_DATE) }</fechaCancelacion>
		               )
		               else ()
		               }
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/EXPIRATION_DATE)) > 0) then
		               (
		                	<fechaVencimiento>{ data($FOR_CONSOLIDATION_REFERENCE/EXPIRATION_DATE) }</fechaVencimiento>
		               )
		               else ()
		               }
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/LIMIT)) > 0) then
		               (
		               		<limiteMonto>{ data($FOR_CONSOLIDATION_REFERENCE/LIMIT) }</limiteMonto>
		               )
		               else ()
		               }
		               <noReferencia>{ data($FOR_CONSOLIDATION_REFERENCE/REFERENCE_NUMBER) }</noReferencia>
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/BALANCE)) > 0) then
		               (
		               		<saldoActual>{ data($FOR_CONSOLIDATION_REFERENCE/BALANCE) }</saldoActual>
		               )
		               else ()
		               }
		               <tipoGarantia>{ data($FOR_CONSOLIDATION_REFERENCE/GUARANTEE_TYPE) }</tipoGarantia>
		               <tipoObligacion>{ data($FOR_CONSOLIDATION_REFERENCE/OBLIGATION_TYPE) }</tipoObligacion>
		               <tipoReferencia>{ data($FOR_CONSOLIDATION_REFERENCE/TYPE) }</tipoReferencia>
		            </obligacionesConsolidacion>
                }
                <ofertaPreAprobada>                    
                    {
                    	for $PREAPPROVED_OFFER in $consultaOfertaCreditoConsumoRequest/PRE_APPROVED_OFFERS/OFFER
                    	return
                    	if ((fn:upper-case($PREAPPROVED_OFFER/TYPE) = 'FICOCREDITO')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/INFORMATION_DATE) }</fechaInformacion>,
			               	if (fn:string-length(data($PREAPPROVED_OFFER/INSTALLMENT)) > 0) then
			               	(
			               			<cuotaFicoCredito>{ data($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaFicoCredito>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoCredito12>{ data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaFicoCredito12>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoCredito18>{ data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaFicoCredito18>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoCredito24>{ data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaFicoCredito24>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoCredito36>{ data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaFicoCredito36>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoCredito48>{ data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaFicoCredito48>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoCredito60>{ data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaFicoCredito60>
			               	)
			               	else (),
							<tasaFicoCredito>{ data($PREAPPROVED_OFFER/RATE) }</tasaFicoCredito>,
							<timesIncomeFicoCredito>{ data($PREAPPROVED_OFFER/TIMES_INCOME) }</timesIncomeFicoCredito>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/TYPE) = 'FICOYA')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/INFORMATION_DATE) }</fechaInformacion>,
							if (fn:string-length(data($PREAPPROVED_OFFER/INSTALLMENT)) > 0) then
			               	(
			               			<cuotaFicoYa>{ data($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaFicoYa>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoYa12>{ data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaFicoYa12>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoYa18>{ data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaFicoYa18>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoYa24>{ data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaFicoYa24>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoYa36>{ data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaFicoYa36>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoYa48>{ data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaFicoYa48>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) > 0) then
			               	(
			               			<ofertaFicoYa60>{ data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaFicoYa60>
			               	)
			               	else (),
							<tasaFicoYa>{ data($PREAPPROVED_OFFER/RATE) }</tasaFicoYa>,
							<timesIncomeFicoYa>{ data($PREAPPROVED_OFFER/TIMES_INCOME) }</timesIncomeFicoYa>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/TYPE) = 'OPI')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/INFORMATION_DATE) }</fechaInformacion>,
							if (fn:string-length(data($PREAPPROVED_OFFER/INSTALLMENT)) > 0) then
			               	(
			               			<cuotaOPI>{ data($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaOPI>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) > 0) then
			               	(
			               			<ofertaOPI12>{ data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaOPI12>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS)) > 0) then
			               	(
			               			<ofertaOPI18>{ data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaOPI18>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) > 0) then
			               	(
			               			<ofertaOPI24>{ data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaOPI24>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) > 0) then
			               	(
			               			<ofertaOPI36>{ data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaOPI36>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) > 0) then
			               	(
			               			<ofertaOPI48>{ data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaOPI48>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) > 0) then
			               	(
			               			<ofertaOPI60>{ data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaOPI60>
			               	)
			               	else (),
							<tasaOPI>{ data($PREAPPROVED_OFFER/RATE) }</tasaOPI>,
							<timesIncomeOPI>{ data($PREAPPROVED_OFFER/TIMES_INCOME) }</timesIncomeOPI>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/TYPE) = 'RETANQUEO')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/INFORMATION_DATE) }</fechaInformacion>,
							if (fn:string-length(data($PREAPPROVED_OFFER/INSTALLMENT)) > 0) then
			               	(
			               			<cuotaRetanqueo>{ data($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaRetanqueo>
			               	)
			               	else (),
							if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) > 0) then
			               	(
			               			<ofertaRetanqueo12>{ data($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaRetanqueo12>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS)) > 0) then
			               	(
			               			<ofertaRetanqueo18>{ data($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaRetanqueo18>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) > 0) then
			               	(
			               			<ofertaRetanqueo24>{ data($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaRetanqueo24>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) > 0) then
			               	(
			               			<ofertaRetanqueo36>{ data($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaRetanqueo36>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) > 0) then
			               	(
			               			<ofertaRetanqueo48>{ data($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaRetanqueo48>
			               	)
			               	else (),
			               	if (fn:string-length(data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) > 0) then
			               	(
			               			<ofertaRetanqueo60>{ data($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaRetanqueo60>
			               	)
			               	else (),
							<tasaRetanqueo>{ data($PREAPPROVED_OFFER/RATE) }</tasaRetanqueo>,
							<timesIncomeRetanqueo>{ data($PREAPPROVED_OFFER/TIMES_INCOME) }</timesIncomeRetanqueo>
						)
						else ()
                    }
                </ofertaPreAprobada>
                {
                    for $ASSETS in $consultaOfertaCreditoConsumoRequest/ASSETS/ASSET
                    return
                        <pasivos>
                            <categoria>{ data($ASSETS/CATEGORY) }</categoria>
                            {
                                for $OPENING_DATE in $ASSETS/OPENING_DATE
                                return
                                	if (fn:string-length(data($OPENING_DATE)) > 0) then
					                (
					                	<fechaApertura>{ data($OPENING_DATE) }</fechaApertura>
					                )
					                else ()
                            }
                            {
                                for $CANCELATION_DATE in $ASSETS/CANCELATION_DATE
                                return
                                	if (fn:string-length(data($CANCELATION_DATE)) > 0) then
					                (
					                	<fechaCierre>{ data($CANCELATION_DATE) }</fechaCierre>
					                )
					                else ()
                            }
                            {
                                for $CURRENCY in $ASSETS/CURRENCY
                                return
                                    <moneda>{ data($CURRENCY) }</moneda>
                            }
                            {
                                for $NUMBER in $ASSETS/NUMBER
                                return
                                    <numeroCuenta>{ data($NUMBER) }</numeroCuenta>
                            }
                            {
			                if (fn:string-length(data($ASSETS/CURRENT_BALANCE)) > 0) then
			                (
			                	<saldoActual>{ data($ASSETS/CURRENT_BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($ASSETS/END_OF_MONTH_BALANCE)) > 0) then
			                (
			                	<saldoFinMes>{ data($ASSETS/END_OF_MONTH_BALANCE) }</saldoFinMes>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($ASSETS/AVERAGE_BALANCE)) > 0) then
			                (
			                	<saldoPromedioMensual>{ data($ASSETS/AVERAGE_BALANCE) }</saldoPromedioMensual>
			                )
			                else ()
			                }
		              		{
			            	  	for $ConsultaConsolidadaASSET in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO/ASSETS/ASSET
		                       	return
		                       		(if (data($ConsultaConsolidadaASSET/NUMBER) = data($ASSETS/NUMBER)) then (
					                	
					                		(for $TRANSACTIONS in $ConsultaConsolidadaASSET/PRODUCT_TRANSACTIONS/TRANSACTION
			                                    return
						                    		<transaccionesPasivos>
						                    			 <cuenta>{ data($ConsultaConsolidadaASSET/NUMBER) }</cuenta>
									                     <fecha_Finde_Periodo>{ data($TRANSACTIONS/PERIOD_DATE) }</fecha_Finde_Periodo>
									                     <fecha_Ultimo_Credito>{ data($TRANSACTIONS/LAST_CREDIT_DATE) }</fecha_Ultimo_Credito>
									                     <fecha_Ultimo_Debito>{ data($TRANSACTIONS/LAST_DEBIT_DATE) }</fecha_Ultimo_Debito>
									                     <flag_Bloqueo_Cuenta>{ data($TRANSACTIONS/PRODUCT_BLOCK) }</flag_Bloqueo_Cuenta>
									                     <flag_Cuenta_Mancomunada>{ data($TRANSACTIONS/JOINT_ACCOUNTS) }</flag_Cuenta_Mancomunada>
									                     <flag_Cuenta_Planilla>{ data($TRANSACTIONS/PAYROLL_ACCOUNTS) }</flag_Cuenta_Planilla>
									                     <flag_Facilidades_Cuenta>{ data($TRANSACTIONS/FACILITIES) }</flag_Facilidades_Cuenta>
									                     <flag_Representante_Legal>{ data($TRANSACTIONS/LEGAL_REPRESENTATIVE) }</flag_Representante_Legal>
									                     <monto_Acreditado_Planilla>{ data($TRANSACTIONS/PAYROLL_CREDIT_AMOUNT) }</monto_Acreditado_Planilla>
									                     
									                     <monto_Creditos>{ data($TRANSACTIONS/CREDITS_INFO/AMOUNT_ON_PERIOD) }</monto_Creditos>
									                     <monto_Debitos>{ data($TRANSACTIONS/DEBITS_INFO/AMOUNT_ON_PERIOD) }</monto_Debitos>
									                     
									                     <monto_Intereses_Creditos>{ data($TRANSACTIONS/CREDITS_INFO/INTERESTS_SUMMATION) }</monto_Intereses_Creditos>
									                     <monto_Intereses_Debitos>{ data($TRANSACTIONS/DEBITS_INFO/INTERESTS_SUMMATION) }</monto_Intereses_Debitos>
									                     
									                     <numero_Creditos>{ data($TRANSACTIONS/CREDITS_INFO/SUMMATION) }</numero_Creditos>
									                     <numero_Debitos>{ data($TRANSACTIONS/DEBITS_INFO/SUMMATION) }</numero_Debitos>
								                     
									                     <numero_Intereses_Creditos>{ fn-bea:decimal-truncate(data($TRANSACTIONS/CREDITS_INFO/INTEREST_ON_PERIOD)) }</numero_Intereses_Creditos>
									                     <numero_Intereses_Debitos>{ fn-bea:decimal-truncate(data($TRANSACTIONS/DEBITS_INFO/INTEREST_ON_PERIOD)) }</numero_Intereses_Debitos>
									                     
									                     <saldo_Fin>{ data($TRANSACTIONS/PERIOD_BALANCE) }</saldo_Fin>
									                     <saldo_Max>{ data($TRANSACTIONS/MAX_BALANCE) }</saldo_Max>
									                     <saldo_Min>{ data($TRANSACTIONS/MIN_BALANCE) }</saldo_Min>
									                     <saldo_Promedio>{ data($TRANSACTIONS/AVERAGE_BALANCE) }</saldo_Promedio>
						                    		</transaccionesPasivos>
					                      )
					                )else()
					                )
					                
		              		}
                        </pasivos>
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/AGREEMENT/TERM)) > 0) then
                (
                	<plazoConvenio>{ data($consultaOfertaCreditoConsumoRequest/AGREEMENT/TERM) }</plazoConvenio>
                )
                else ()
                }
                {
                    for $LOAN in $consultaOfertaCreditoConsumoRequest/LIABILITIES/LOANS_INFO/LOAN
                    return
                        <prestamos>
                        	{
			                if (fn:string-length(data($LOAN/CHARGES)) > 0) then
			                (
			                	<cargos>{ data($LOAN/CHARGES) }</cargos>
			                )
			                else ()
			                }
                            {
                                for $AGENCY_CODE in $LOAN/AGENCY_CODE
                                return
                                    <codigoAgencia>{ data($AGENCY_CODE) }</codigoAgencia>
                            }
                            {
                                for $SUB_APPLICATION in $LOAN/SUB_APPLICATION
                                return
                                    <codigoSubAplicacion>{ data($SUB_APPLICATION) }</codigoSubAplicacion>
                            }
                            {
                                for $GUARANTEE_TYPE in $LOAN/GUARANTEE_TYPE
                                return
                                    <codigoTipoGarantia>{ data($GUARANTEE_TYPE) }</codigoTipoGarantia>
                            }
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
                            <identidad>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/ID) }</identidad>
                            {
			                if (fn:string-length(data($LOAN/INTEREST)) > 0) then
			                (
			                	<intereses>{ data($LOAN/INTEREST) }</intereses>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($LOAN/INITIAL_AMOUNT)) > 0) then
			                (
			                	<montoInicial>{ data($LOAN/INITIAL_AMOUNT) }</montoInicial>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($LOAN/CURRENT_DUE)) > 0) then
			                (
			                	<moraActual>{ data($LOAN/CURRENT_DUE) }</moraActual>
			                )
			                else ()
			                }
                            <numeroContrato>{ data($LOAN/CONTRACT_NUMBER) }</numeroContrato>
                            {
			                if (fn:string-length(data($LOAN/PAYMENT_NUMBER)) > 0) then
			                (
			                	<numeroCuotas>{ data($LOAN/PAYMENT_NUMBER) }</numeroCuotas>
			                )
			                else ()
			                }
                            {
                                for $NUMBER in $LOAN/NUMBER
                                return
                                    <numeroPrestamo>{ data($NUMBER) }</numeroPrestamo>
                            }
                            {
			                if (fn:string-length(data($LOAN/OTHER_CHARGES)) > 0) then
			                (
			                	<otrosCargos>{ data($LOAN/OTHER_CHARGES) }</otrosCargos>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($LOAN/TERM)) > 0) then
			                (
			                	<plazo>{ data($LOAN/TERM) }</plazo>
			                )
			                else ()
			                }
                            {
			                if (fn:string-length(data($LOAN/CURRENT_BALANCE)) > 0) then
			                (
			                	<saldoActual>{ data($LOAN/CURRENT_BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($LOAN/INSURANCE)) > 0) then
			                (
			                	<seguros>{ data($LOAN/INSURANCE) }</seguros>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($LOAN/RATE)) > 0) then
			                (
			                	<tasa>{ data($LOAN/RATE) }</tasa>
			                )
			                else ()
			                }
                            {
                                for $CODE_TYPE in $LOAN/CODE_TYPE
                                return
                                    <tipoPrestamo>{ data($CODE_TYPE) }</tipoPrestamo>
                            }
                            {
                                for $TRANSACTION in $LOAN/PRODUCT_TRANSACTIONS/TRANSACTION
                                return
                                    <transaccionesPrestamo>
                                        {
                                            for $AGENCY_CODE in $LOAN/AGENCY_CODE
                                            return
                                                <codigoAgencia>{ data($AGENCY_CODE) }</codigoAgencia>
                                        }
                                        {
                                            for $SUB_APPLICATION in $LOAN/SUB_APPLICATION
                                            return
                                                <codigoSubAplicacion>{ data($SUB_APPLICATION) }</codigoSubAplicacion>
                                        }
                                        {
                                            for $PERIOD_DATE in $TRANSACTION/PERIOD_DATE
                                            return
                                                <fechaCorte>{ data($PERIOD_DATE) }</fechaCorte>
                                        }
                                        {
                                            for $DUE_BALANCE in $TRANSACTION/DUE_BALANCE
                                            where xs:string(data($DUE_BALANCE)) != ''
                                            return
                                                <mora>{ data($DUE_BALANCE) }</mora>
                                        }
                                        {
                                            for $NUMBER in $LOAN/NUMBER
                                            return
                                                <numeroPrestamo>{ data($NUMBER) }</numeroPrestamo>
                                        }
                                        <saldoActual>{ data($TRANSACTION/CAPITAL_BALANCE) }</saldoActual>
                                    </transaccionesPrestamo>
                            }
                            {
			                if (fn:string-length(data($LOAN/PAYMENT_AMOUNT)) > 0) then
			                (
			                	<valorCuota>{ data($LOAN/PAYMENT_AMOUNT) }</valorCuota>
			                )
			                else ()
			                }
                        </prestamos>
                }
                {
                       
                        for $REFERENCE in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE
                        return
                        <referencias>
                        	{
                        	if (fn:string-length(data($REFERENCE/CREDITOR)) > 0) then
                        	(
                        		<acreedor>{ data($REFERENCE/CREDITOR) }</acreedor>
                        	)
                        	else ()
                        	}
                           <conteoHistoricoDol>{ data($REFERENCE/HISTORICAL_COUNT_DOL) }</conteoHistoricoDol>
                           <conteoHistoricoLoc>{ data($REFERENCE/HISTORICAL_COUNT_LOC) }</conteoHistoricoLoc>
                            {
			                if (fn:string-length(data($REFERENCE/INSTALLMENT)) > 0) then
			                (
			                	<cuota>{ data($REFERENCE/INSTALLMENT) }</cuota>
			                )
			                else ()
			                }
                           <estado>{ data($REFERENCE/STATUS) }</estado>
                            {
			                if (fn:string-length(data($REFERENCE/EXCHANGE_FACTOR)) > 0) then
			                (
			                	<factorCambio>{ data($REFERENCE/EXCHANGE_FACTOR) }</factorCambio>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/OPENING_DATE)) > 0) then
			                (
			                	<fechaApertura>{ data($REFERENCE/OPENING_DATE) }</fechaApertura>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/CANCELATION_DATE)) > 0) then
			                (
			                	<fechaCancelacion>{ data($REFERENCE/CANCELATION_DATE) }</fechaCancelacion>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/EXPIRATION_DATE)) > 0) then
			                (
			                	<fechaVencimiento>{ data($REFERENCE/EXPIRATION_DATE) }</fechaVencimiento>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(data($REFERENCE/LIMIT)) > 0) then
                        	(
                        		<limiteMonto>{ data($REFERENCE/LIMIT) }</limiteMonto>
                        	)
                        	else ()
                        	}
                           <moneda>{ data($REFERENCE/CURRENCY) }</moneda>
                           <moraHistorica>{ data($REFERENCE/HISTORICAL_ARREAR) }</moraHistorica>
                           <nivelMora>{ data($REFERENCE/ARREAR_LEVEL) }</nivelMora>
                           <noReferencia>{ data($REFERENCE/REFERENCE_NUMBER) }</noReferencia>
                           <periodoInfo>{ data($REFERENCE/PERIOD) }</periodoInfo>
                            {
			                if (fn:string-length(data($REFERENCE/TERM)) > 0) then
			                (
			                	<plazo>{ data($REFERENCE/TERM) }</plazo>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/BALANCE)) > 0) then
			                (
			                	<saldoActual>{ data($REFERENCE/BALANCE) }</saldoActual>
			                )
			                else ()
			                }
                            {
			                if (fn:string-length(data($REFERENCE/PUNISHED_BALANCE)) > 0) then
			                (
			                	<saldoCastigado>{ data($REFERENCE/PUNISHED_BALANCE) }</saldoCastigado>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/DUE_BALANCE)) > 0) then
			                (
			                	<saldoCobroJudicial>{ data($REFERENCE/DUE_BALANCE) }</saldoCobroJudicial>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/ARREAR_BALANCE)) > 0) then
			                (
			                	<saldoMora>{ data($REFERENCE/ARREAR_BALANCE) }</saldoMora>
			                )
			                else ()
			                }
                           <tipoGarantia>{ data($REFERENCE/GUARANTEE_TYPE) }</tipoGarantia>
                           <tipoObligacion>{ data($REFERENCE/OBLIGATION_TYPE) }</tipoObligacion>
                           <tipoPrestamo>{ data($REFERENCE/CREDIT_TYPE) }</tipoPrestamo>
                           <tipoReferencia>{ data($REFERENCE/TYPE) }</tipoReferencia>
                        </referencias>
                }
                {
                       
                        for $REFERENCE in $consultaOfertaCreditoConsumoRequest/REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE
                        return
                        <referencias>
                           <acreedor>{ data($REFERENCE/CREDITOR) }</acreedor>
                           <conteoHistoricoDol>{ data($REFERENCE/HISTORICAL_COUNT_DOL) }</conteoHistoricoDol>
                           <conteoHistoricoLoc>{ data($REFERENCE/HISTORICAL_COUNT_LOC) }</conteoHistoricoLoc>
                           	{
			                if (fn:string-length(data($REFERENCE/INSTALLMENT)) > 0) then
			                (
			                	<cuota>{ data($REFERENCE/INSTALLMENT) }</cuota>
			                )
			                else ()
			                }
                           <estado>{ data($REFERENCE/STATUS) }</estado>
                           	{
			                if (fn:string-length(data($REFERENCE/EXCHANGE_FACTOR)) > 0) then
			                (
			                	<factorCambio>{ data($REFERENCE/EXCHANGE_FACTOR) }</factorCambio>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/OPENING_DATE)) > 0) then
			                (
			                	<fechaApertura>{ data($REFERENCE/OPENING_DATE) }</fechaApertura>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/CANCELATION_DATE)) > 0) then
			                (
			                	<fechaCancelacion>{ data($REFERENCE/CANCELATION_DATE) }</fechaCancelacion>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/EXPIRATION_DATE)) > 0) then
			                (
			                	<fechaVencimiento>{ data($REFERENCE/EXPIRATION_DATE) }</fechaVencimiento>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/LIMIT)) > 0) then
			                (
			                	<limiteMonto>{ data($REFERENCE/LIMIT) }</limiteMonto>
			                )
			                else ()
			                }
                           <moneda>{ data($REFERENCE/CURRENCY) }</moneda>
                           <moraHistorica>{ data($REFERENCE/HISTORICAL_ARREAR) }</moraHistorica>
			               <nivelMora>{ data($REFERENCE/ARREAR_LEVEL) }</nivelMora>
                           <noReferencia>{ data($REFERENCE/REFERENCE_NUMBER) }</noReferencia>
                           <periodoInfo>{ data($REFERENCE/PERIOD) }</periodoInfo>
                           	{
			                if (fn:string-length(data($REFERENCE/TERM)) > 0) then
			                (
			                	<plazo>{ data($REFERENCE/TERM) }</plazo>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/BALANCE)) > 0) then
			                (
			                	<saldoActual>{ data($REFERENCE/BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/PUNISHED_BALANCE)) > 0) then
			                (
			                	<saldoCastigado>{ data($REFERENCE/PUNISHED_BALANCE) }</saldoCastigado>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/DUE_BALANCE)) > 0) then
			                (
			                	<saldoCobroJudicial>{ data($REFERENCE/DUE_BALANCE) }</saldoCobroJudicial>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/ARREAR_BALANCE)) > 0) then
			                (
			                	<saldoMora>{ data($REFERENCE/ARREAR_BALANCE) }</saldoMora>
			                )
			                else ()
			                }
                           <tipoGarantia>{ data($REFERENCE/GUARANTEE_TYPE) }</tipoGarantia>
                           <tipoObligacion>{ data($REFERENCE/OBLIGATION_TYPE) }</tipoObligacion>
                           <tipoPrestamo>{ data($REFERENCE/CREDIT_TYPE) }</tipoPrestamo>
                           <tipoReferencia>{ data($REFERENCE/TYPE) }</tipoReferencia>
                        </referencias>
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TOTAL_SALARY)) > 0) then
                (
                	<salarioBruto>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TOTAL_SALARY) }</salarioBruto>
                )
                else ()
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/NET_SALARY)) > 0) then
                (
                	<salarioNeto>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/NET_SALARY) }</salarioNeto>
                )
                else ()
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/PAYROLL_SALARY)) > 0) then
                (
                	<salarioPlanilla>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/PAYROLL_SALARY) }</salarioPlanilla>
                )
                else ()
                }
                <score>
                    {
                        for $QUALIFICATION in $consultaOfertaCreditoConsumoRequest/SCORE_INFO/QUALIFICATION
                        return
                            <calificacionScore>{ data($QUALIFICATION) }</calificacionScore>
                    }
                    {
                        for $RISK_LEVEL in $consultaOfertaCreditoConsumoRequest/SCORE_INFO/RISK_LEVEL
                        return
                            <nivelRiesgo>{ data($RISK_LEVEL) }</nivelRiesgo>
                    }
                    {
	                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/SCORE_INFO/SCORE_CALCULATION)) > 0) then
	                (
	                	<score>{ data($consultaOfertaCreditoConsumoRequest/SCORE_INFO/SCORE_CALCULATION) }</score>
	                )
	                else ()
	                }
                </score>
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/EXTERNAL_SCORE)) > 0) then
                (
                	<scoreBuro>{ data($consultaOfertaCreditoConsumoRequest/EXTERNAL_SCORE) }</scoreBuro>
                )
                else ()
                }
                <segmentoCliente>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TARGET) }</segmentoCliente>
                <sexo>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/GENDER) }</sexo>
                {
                    for $CREDIT_CARD in $consultaOfertaCreditoConsumoRequest/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD
                    return
                        <tarjetas>
                        	{
                        	if (fn:string-length(data($CREDIT_CARD/BEHAVIOR_SCORE)) > 0) then
			                (
			                	<behaviorScore>{ data($CREDIT_CARD/BEHAVIOR_SCORE) }</behaviorScore>
			                )
			                else ()
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
                                for $LOGO in $CREDIT_CARD/LOGO
                                return
                             		<grupoAfinidad>{ data($LOGO) }</grupoAfinidad>
                            }
                            {
                                for $AVAILABLE_CASH in $CREDIT_CARD/AVAILABLE_CASH
                                return
                             		<cash_diponible>{ data($AVAILABLE_CASH) }</cash_diponible>
                            }
                            {
                                for $LOCK_DATE1 in $CREDIT_CARD/LOCK_DATE1
                                return
                                if ($LOCK_DATE1!='') then (
                             		<fechabloqueo1>{ data($LOCK_DATE1) }</fechabloqueo1>
                             	) else ()
                             	
							}
                            {
                                for $LOCK_DATE2 in $CREDIT_CARD/LOCK_DATE2
                                return
                                if ($LOCK_DATE2!='') then (
                             		<fechabloqueo2>{ data($LOCK_DATE2) }</fechabloqueo2>
                             	) else ()
                            }
                            {
                        	if (fn:string-length(data($CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS)) > 0) then
			                (
			                	<cuotasExtraVigentes>{ data($CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS) }</cuotasExtraVigentes>
			                )
			                else ()
			                }
                            <estado>{ data($CREDIT_CARD/STATUS) }</estado>
                            {
                        	if (fn:string-length(data($CREDIT_CARD/OPENING_DATE)) > 0) then
			                (
			                	<fechaApertura>{ data($CREDIT_CARD/OPENING_DATE) }</fechaApertura>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(data($CREDIT_CARD/CANCELATION_DATE)) > 0) then
			                (
			                	<fechaCancelacion>{ data($CREDIT_CARD/CANCELATION_DATE) }</fechaCancelacion>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(data($CREDIT_CARD/CASH_DISCOUNT_DATE)) > 0) then
			                (
			                	<fechaDescuentoContado>{ data($CREDIT_CARD/CASH_DISCOUNT_DATE) }</fechaDescuentoContado>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(data($CREDIT_CARD/LAST_EXTRA_DATE)) > 0) then
			                (
			                	<fechaUltimoExtra>{ data($CREDIT_CARD/LAST_EXTRA_DATE) }</fechaUltimoExtra>
			                )
			                else ()
			                }
                            {
                                for $AFFINITY_GROUP in $CREDIT_CARD/AFFINITY_GROUP
                                return
                                    <grupoAfinidad>{ data($AFFINITY_GROUP) }</grupoAfinidad>
                            }
                            {
                        	if (fn:string-length(data($CREDIT_CARD/CURRENT_LIMIT)) > 0) then
			                (
			                	<limiteActual>{ data($CREDIT_CARD/CURRENT_LIMIT) }</limiteActual>
			                )
			                else ()
			                }
                            <modeloLiquidacion>{ data($CREDIT_CARD/CLEARING_MODEL) }</modeloLiquidacion>
                            {
			                if (fn:string-length(data($CREDIT_CARD/CURRENT_DUE)) > 0) then
			                (
			                	<moraActual>{ data($CREDIT_CARD/CURRENT_DUE) }</moraActual>
			                )
			                else ()
			                }
                            <numeroCuenta>{ data($CREDIT_CARD/ACCOUNT) }</numeroCuenta>
                            {
                                for $PRODUCT in $CREDIT_CARD/PRODUCT
                                return
                                    <producto>{ data($PRODUCT) }</producto>
                            }
                            {
			                if (fn:string-length(data($CREDIT_CARD/CURRENT_BALANCE)) > 0) then
			                (
			                	<saldoActual>{ data($CREDIT_CARD/CURRENT_BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($CREDIT_CARD/CLOSING_BALANCE)) > 0) then
			                (
			                	<saldoCorte>{ data($CREDIT_CARD/CLOSING_BALANCE) }</saldoCorte>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($CREDIT_CARD/EXTRA_BALANCE)) > 0) then
			                (
			                	<saldoExtra>{ data($CREDIT_CARD/EXTRA_BALANCE) }</saldoExtra>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($CREDIT_CARD/INTRA_BALANCE)) > 0) then
			                (
			                	<saldoIntra>{ data($CREDIT_CARD/INTRA_BALANCE) }</saldoIntra>
			                )
			                else ()
			                }
			                {
			                for $TRANSACTION in $CREDIT_CARD/TRANSACTION_CREDIT_CARD_TYPE/TRANSACTION
                    		return
                    		<transaccionesTarjeta>
                            	<cuota_extra>{ data($TRANSACTION/EXTRA_FEE) }</cuota_extra>
                            	<cuota_intra>{ data($TRANSACTION/INTRA_FEE) }</cuota_intra>
                            	<saldo_extra>{ data($TRANSACTION/EXTRA_BALANCE) }</saldo_extra>
                            	<saldo_intra>{ data($TRANSACTION/INTRA_BALANCE) }</saldo_intra>
                            </transaccionesTarjeta>
					        }
                        </tarjetas>
                }
                {
                if (fn:string-length(data($consultaOfertaCreditoConsumoRequest/AGREEMENT/RATE)) > 0) then
                (
                	<tasaConvenio>{ data($consultaOfertaCreditoConsumoRequest/AGREEMENT/RATE) }</tasaConvenio>
                )
                else ()
                }
                <tipoCliente>{ data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TYPE) }</tipoCliente>
                {
                    for $JOB_TYPE in $consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_TYPE
                    return
                        <tipoTrabajo>{ data($JOB_TYPE) }</tipoTrabajo>
                }
            </arg0>
        </ns1:epOriginacionesHonduras>
};

declare variable $consultaOfertaCreditoConsumoRequest as element(ns0:consultaOfertaCreditoConsumoRequest) external;
declare variable $consultaConsolidadaRiesgoClienteResponse as element(ns2:consultaConsolidadaRiesgoClienteResponse) external;

xf:consultaOfertaCreditoConsumoIn($consultaOfertaCreditoConsumoRequest,
$consultaConsolidadaRiesgoClienteResponse)