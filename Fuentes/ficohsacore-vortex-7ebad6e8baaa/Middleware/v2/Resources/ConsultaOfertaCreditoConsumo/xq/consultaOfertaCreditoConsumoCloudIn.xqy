xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://fico.com/blaze/advisor/rma/";
(:: import schema at "../../../BusinessServices/BLAZE/xsd/blazeCloudApi.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
(:: import schema at "../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
(:: import schema at "../xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)

declare variable $consultaOfertaCreditoConsumoRequest as element() (:: schema-element(ns1:consultaOfertaCreditoConsumoRequest) ::) external;
declare variable $consultaConsolidadaRiesgoClienteResponse as element() (:: schema-element(ns2:consultaConsolidadaRiesgoClienteResponse) ::) external;

declare function local:func($consultaOfertaCreditoConsumoRequest as element() (:: schema-element(ns1:consultaOfertaCreditoConsumoRequest) ::), 
                            $consultaConsolidadaRiesgoClienteResponse as element() (:: schema-element(ns2:consultaConsolidadaRiesgoClienteResponse) ::)) 
                            as element() (:: schema-element(ns3:epOriginacionesHonduras) ::) {
     <ns3:epOriginacionesHonduras>
     <arg0>
	            {
	            if (exists($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/LABOR_YEARS) ) then
	            (	
	            	  <antiguedaLaboral>{ xs:int($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/LABOR_YEARS) }</antiguedaLaboral>
	            )
	            else (  <antiguedaLaboral>{ xs:int( 0) }</antiguedaLaboral>)
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
			                if (exists($EXTRA/INSTALLMENT)) then
				            (
				               	<cuotaExtra>{ xs:float($EXTRA/INSTALLMENT) }</cuotaExtra>
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
			                if (exists($EXTRA/AMOUNT)) then
				            (
				               	<montoTomado>{ xs:float($EXTRA/AMOUNT) }</montoTomado>
				            )
				            else ()
				            }
                            <numeroCuenta>{ data($EXTRA/ACCOUNT_NUMBER) }</numeroCuenta>
                            {
			                if (exists($EXTRA/RATE)) then
				            (
				               	<tasaExtra>{ xs:float($EXTRA/RATE) }</tasaExtra>
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
                if (exists($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_START_DATE)) then
	            (
	               	<fechaInicioLaboral>{ xs:date($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/JOB_START_DATE) }</fechaInicioLaboral>
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
                if (exists($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/CREDIT_MONTHS)) then
                (
                	<mesesDeposito>{ xs:int(data($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/CREDIT_MONTHS)) }</mesesDeposito>
                )
                else ()
                }
                {
                if (exists($consultaOfertaCreditoConsumoRequest/AGREEMENT/AMOUNT) ) then
                (
                	<montoConvenio>{ xs:float($consultaOfertaCreditoConsumoRequest/AGREEMENT/AMOUNT) }</montoConvenio>
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
		               if (exists($FOR_CONSOLIDATION_REFERENCE/OPENING_DATE)) then
		               (
		                	<fechaApertura>{ xs:date($FOR_CONSOLIDATION_REFERENCE/OPENING_DATE) }</fechaApertura>
		               )
		               else ()
		               }
		               {
		               if (exists($FOR_CONSOLIDATION_REFERENCE/CANCELATION_DATE)) then
		               (
		                	<fechaCancelacion>{ xs:date($FOR_CONSOLIDATION_REFERENCE/CANCELATION_DATE) }</fechaCancelacion>
		               )
		               else ()
		               }
		               {
		               if (exists($FOR_CONSOLIDATION_REFERENCE/EXPIRATION_DATE) ) then
		               (
		                	<fechaVencimiento>{ xs:date($FOR_CONSOLIDATION_REFERENCE/EXPIRATION_DATE) }</fechaVencimiento>
		               )
		               else ()
		               }
		               {
		               if (exists($FOR_CONSOLIDATION_REFERENCE/LIMIT)) then
		               (
		               		<limiteMonto>{ xs:float($FOR_CONSOLIDATION_REFERENCE/LIMIT) }</limiteMonto>
		               )
		               else ()
		               }
		               <noReferencia>{ data($FOR_CONSOLIDATION_REFERENCE/REFERENCE_NUMBER) }</noReferencia>
		               {
		               if (exists($FOR_CONSOLIDATION_REFERENCE/BALANCE)) then
		               (
		               		<saldoActual>{ xs:float($FOR_CONSOLIDATION_REFERENCE/BALANCE) }</saldoActual>
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
			               	if (exists($PREAPPROVED_OFFER/INSTALLMENT)) then
			               	(
			               			<cuotaFicoCredito>{ xs:float($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaFicoCredito>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) then
			               	(
			               			<ofertaFicoCredito12>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaFicoCredito12>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) ) then
			               	(
			               			<ofertaFicoCredito18>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaFicoCredito18>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) then
			               	(
			               			<ofertaFicoCredito24>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaFicoCredito24>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) then
			               	(
			               			<ofertaFicoCredito36>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaFicoCredito36>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) then
			               	(
			               			<ofertaFicoCredito48>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaFicoCredito48>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) then
			               	(
			               			<ofertaFicoCredito60>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaFicoCredito60>
			               	)
			               	else (),
							<tasaFicoCredito>{ data($PREAPPROVED_OFFER/RATE) }</tasaFicoCredito>,
							<timesIncomeFicoCredito>{ data($PREAPPROVED_OFFER/TIMES_INCOME) }</timesIncomeFicoCredito>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/TYPE) = 'FICOYA')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/INFORMATION_DATE) }</fechaInformacion>,
							if (exists($PREAPPROVED_OFFER/INSTALLMENT)) then
			               	(
			               			<cuotaFicoYa>{ xs:float($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaFicoYa>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) then
			               	(
			               			<ofertaFicoYa12>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaFicoYa12>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS)) then
			               	(
			               			<ofertaFicoYa18>{xs:float($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaFicoYa18>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) then
			               	(
			               			<ofertaFicoYa24>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaFicoYa24>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) then
			               	(
			               			<ofertaFicoYa36>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaFicoYa36>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) then
			               	(
			               			<ofertaFicoYa48>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaFicoYa48>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) then
			               	(
			               			<ofertaFicoYa60>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaFicoYa60>
			               	)
			               	else (),
							<tasaFicoYa>{ data($PREAPPROVED_OFFER/RATE) }</tasaFicoYa>,
							<timesIncomeFicoYa>{ data($PREAPPROVED_OFFER/TIMES_INCOME) }</timesIncomeFicoYa>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/TYPE) = 'OPI')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/INFORMATION_DATE) }</fechaInformacion>,
							if (exists($PREAPPROVED_OFFER/INSTALLMENT)) then
			               	(
			               			<cuotaOPI>{ xs:float($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaOPI>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) then
			               	(
			               			<ofertaOPI12>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaOPI12>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS)) then
			               	(
			               			<ofertaOPI18>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaOPI18>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) then
			               	(
			               			<ofertaOPI24>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaOPI24>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) then
			               	(
			               			<ofertaOPI36>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaOPI36>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) then
			               	(
			               			<ofertaOPI48>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaOPI48>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) then
			               	(
			               			<ofertaOPI60>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaOPI60>
			               	)
			               	else (),
							<tasaOPI>{ data($PREAPPROVED_OFFER/RATE) }</tasaOPI>,
							<timesIncomeOPI>{ data($PREAPPROVED_OFFER/TIMES_INCOME) }</timesIncomeOPI>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/TYPE) = 'RETANQUEO')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/INFORMATION_DATE) }</fechaInformacion>,
							if (exists($PREAPPROVED_OFFER/INSTALLMENT)) then
			               	(
			               			<cuotaRetanqueo>{ xs:float($PREAPPROVED_OFFER/INSTALLMENT) }</cuotaRetanqueo>
			               	)
			               	else (),
							if (exists($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS)) then
			               	(
			               			<ofertaRetanqueo12>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_12_MONTHS) }</ofertaRetanqueo12>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS)) then
			               	(
			               			<ofertaRetanqueo18>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_18_MONTHS) }</ofertaRetanqueo18>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS)) then
			               	(
			               			<ofertaRetanqueo24>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_24_MONTHS) }</ofertaRetanqueo24>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS)) then
			               	(
			               			<ofertaRetanqueo36>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_36_MONTHS) }</ofertaRetanqueo36>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS)) then
			               	(
			               			<ofertaRetanqueo48>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_48_MONTHS) }</ofertaRetanqueo48>
			               	)
			               	else (),
			               	if (exists($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS)) then
			               	(
			               			<ofertaRetanqueo60>{ xs:float($PREAPPROVED_OFFER/DETAILS/FOR_60_MONTHS) }</ofertaRetanqueo60>
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
                                	if (exists($OPENING_DATE)) then
					                (
					                	<fechaApertura>{ xs:date($OPENING_DATE) }</fechaApertura>
					                )
					                else ()
                            }
                            {
                                for $CANCELATION_DATE in $ASSETS/CANCELATION_DATE
                                return
                                	if (exists($CANCELATION_DATE)) then
					                (
					                	<fechaCierre>{ xs:date($CANCELATION_DATE) }</fechaCierre>
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
			                if (exists($ASSETS/CURRENT_BALANCE)) then
			                (
			                	<saldoActual>{ xs:float($ASSETS/CURRENT_BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (exists($ASSETS/END_OF_MONTH_BALANCE)) then
			                (
			                	<saldoFinMes>{ xs:float($ASSETS/END_OF_MONTH_BALANCE) }</saldoFinMes>
			                )
			                else ()
			                }
			                {
			                if (exists($ASSETS/AVERAGE_BALANCE)) then
			                (
			                	<saldoPromedioMensual>{ xs:float($ASSETS/AVERAGE_BALANCE) }</saldoPromedioMensual>
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
								                     
									                     <numero_Intereses_Creditos>{
                                                                                              if(exists($TRANSACTIONS/CREDITS_INFO/INTEREST_ON_PERIOD)) then
                                                                                                fn-bea:decimal-truncate(xs:decimal($TRANSACTIONS/CREDITS_INFO/INTEREST_ON_PERIOD))
                                                                                                else()
                                                                                             }</numero_Intereses_Creditos>
									                     <numero_Intereses_Debitos>{ if(exists($TRANSACTIONS/DEBITS_INFO/INTEREST_ON_PERIOD)) then
                                                                                              fn-bea:decimal-truncate(xs:decimal($TRANSACTIONS/DEBITS_INFO/INTEREST_ON_PERIOD))
                                                                                              else()
                                                                                             }</numero_Intereses_Debitos>
									                     
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
                if (exists($consultaOfertaCreditoConsumoRequest/AGREEMENT/TERM)) then
                (
                	<plazoConvenio>{ xs:float($consultaOfertaCreditoConsumoRequest/AGREEMENT/TERM) }</plazoConvenio>
                )
                else ()
                }
                {
                    for $LOAN in $consultaOfertaCreditoConsumoRequest/LIABILITIES/LOANS_INFO/LOAN
                    return
                        <prestamos>
                        	{
			                if (exists($LOAN/CHARGES)) then
			                (
			                	<cargos>{ xs:float($LOAN/CHARGES) }</cargos>
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
			                if (exists($LOAN/INTEREST)) then
			                (
			                	<intereses>{ xs:float($LOAN/INTEREST) }</intereses>
			                )
			                else ()
			                }
			                {
			                if (exists($LOAN/INITIAL_AMOUNT)) then
			                (
			                	<montoInicial>{ xs:float($LOAN/INITIAL_AMOUNT) }</montoInicial>
			                )
			                else ()
			                }
			                {
			                if (exists($LOAN/CURRENT_DUE)) then
			                (
			                	<moraActual>{ xs:int($LOAN/CURRENT_DUE) }</moraActual>
			                )
			                else ()
			                }
                            <numeroContrato>{ data($LOAN/CONTRACT_NUMBER) }</numeroContrato>
                            {
			                if (exists($LOAN/PAYMENT_NUMBER)) then
			                (
			                	<numeroCuotas>{ xs:float($LOAN/PAYMENT_NUMBER) }</numeroCuotas>
			                )
			                else ()
			                }
                            {
                                for $NUMBER in $LOAN/NUMBER
                                return
                                    <numeroPrestamo>{ data($NUMBER) }</numeroPrestamo>
                            }
                            {
			                if (exists($LOAN/OTHER_CHARGES)) then
			                (
			                	<otrosCargos>{ xs:float($LOAN/OTHER_CHARGES) }</otrosCargos>
			                )
			                else ()
			                }
			                {
			                if (exists($LOAN/TERM)) then
			                (
			                	<plazo>{ xs:float($LOAN/TERM) }</plazo>
			                )
			                else ()
			                }
                            {
			                if (exists($LOAN/CURRENT_BALANCE)) then
			                (
			                	<saldoActual>{ xs:float($LOAN/CURRENT_BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (exists($LOAN/INSURANCE)) then
			                (
			                	<seguros>{ xs:float($LOAN/INSURANCE) }</seguros>
			                )
			                else ()
			                }
			                {
			                if (exists($LOAN/RATE)) then
			                (
			                	<tasa>{ xs:float($LOAN/RATE) }</tasa>
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
			                if (exists($LOAN/PAYMENT_AMOUNT)) then
			                (
			                	<valorCuota>{ xs:float($LOAN/PAYMENT_AMOUNT) }</valorCuota>
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
			                if (exists($REFERENCE/INSTALLMENT)) then
			                (
			                	<cuota>{ xs:float($REFERENCE/INSTALLMENT) }</cuota>
			                )
			                else ()
			                }
                           <estado>{ data($REFERENCE/STATUS) }</estado>
                            {
			                if (exists($REFERENCE/EXCHANGE_FACTOR)) then
			                (
			                	<factorCambio>{ xs:float($REFERENCE/EXCHANGE_FACTOR) }</factorCambio>
			                )
			                else ()
			                }
                           	{
			                if (exists($REFERENCE/OPENING_DATE)) then
			                (
			                	<fechaApertura>{ xs:date($REFERENCE/OPENING_DATE) }</fechaApertura>
			                )
			                else ()
			                }
                           	{
			                if (exists($REFERENCE/CANCELATION_DATE)) then
			                (
			                	<fechaCancelacion>{ xs:date($REFERENCE/CANCELATION_DATE) }</fechaCancelacion>
			                )
			                else ()
			                }
                           	{
			                if (exists($REFERENCE/EXPIRATION_DATE)) then
			                (
			                	<fechaVencimiento>{ xs:date($REFERENCE/EXPIRATION_DATE) }</fechaVencimiento>
			                )
			                else ()
			                }
			                {
                        	if (exists($REFERENCE/LIMIT)) then
                        	(
                        		<limiteMonto>{ xs:float($REFERENCE/LIMIT) }</limiteMonto>
                        	)
                        	else ()
                        	}
                           <moneda>{ data($REFERENCE/CURRENCY) }</moneda>
                           <moraHistorica>{ data($REFERENCE/HISTORICAL_ARREAR) }</moraHistorica>
                           <nivelMora>{ data($REFERENCE/ARREAR_LEVEL) }</nivelMora>
                           <noReferencia>{ data($REFERENCE/REFERENCE_NUMBER) }</noReferencia>
                           <periodoInfo>{ data($REFERENCE/PERIOD) }</periodoInfo>
                            {
			                if (exists($REFERENCE/TERM)) then
			                (
			                	<plazo>{ xs:float($REFERENCE/TERM) }</plazo>
			                )
			                else ()
			                }
			                {
			                if (exists($REFERENCE/BALANCE)) then
			                (
			                	<saldoActual>{ xs:float($REFERENCE/BALANCE) }</saldoActual>
			                )
			                else ()
			                }
                            {
			                if (exists($REFERENCE/PUNISHED_BALANCE)) then
			                (
			                	<saldoCastigado>{ xs:float($REFERENCE/PUNISHED_BALANCE) }</saldoCastigado>
			                )
			                else ()
			                }
			                {
			                if (exists($REFERENCE/DUE_BALANCE)) then
			                (
			                	<saldoCobroJudicial>{ xs:float($REFERENCE/DUE_BALANCE) }</saldoCobroJudicial>
			                )
			                else ()
			                }
			                {
			                if (exists($REFERENCE/ARREAR_BALANCE)) then
			                (
			                	<saldoMora>{ xs:float($REFERENCE/ARREAR_BALANCE) }</saldoMora>
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
			                if (exists($REFERENCE/INSTALLMENT)) then
			                (
			                	<cuota>{ xs:float($REFERENCE/INSTALLMENT) }</cuota>
			                )
			                else ()
			                }
                           <estado>{ data($REFERENCE/STATUS) }</estado>
                           	{
			                if (exists($REFERENCE/EXCHANGE_FACTOR)) then
			                (
			                	<factorCambio>{ xs:float($REFERENCE/EXCHANGE_FACTOR) }</factorCambio>
			                )
			                else ()
			                }
			                {
			                if (exists($REFERENCE/OPENING_DATE)) then
			                (
			                	<fechaApertura>{ xs:date($REFERENCE/OPENING_DATE) }</fechaApertura>
			                )
			                else ()
			                }
                           	{
			                if (exists($REFERENCE/CANCELATION_DATE)) then
			                (
			                	<fechaCancelacion>{ xs:date($REFERENCE/CANCELATION_DATE) }</fechaCancelacion>
			                )
			                else ()
			                }
                           	{
			                if (exists($REFERENCE/EXPIRATION_DATE)) then
			                (
			                	<fechaVencimiento>{ xs:date($REFERENCE/EXPIRATION_DATE) }</fechaVencimiento>
			                )
			                else ()
			                }
                           	{
			                if (exists($REFERENCE/LIMIT)) then
			                (
			                	<limiteMonto>{ xs:float($REFERENCE/LIMIT) }</limiteMonto>
			                )
			                else ()
			                }
                           <moneda>{ data($REFERENCE/CURRENCY) }</moneda>
                           <moraHistorica>{ data($REFERENCE/HISTORICAL_ARREAR) }</moraHistorica>
			               <nivelMora>{ data($REFERENCE/ARREAR_LEVEL) }</nivelMora>
                           <noReferencia>{ data($REFERENCE/REFERENCE_NUMBER) }</noReferencia>
                           <periodoInfo>{ data($REFERENCE/PERIOD) }</periodoInfo>
                           	{
			                if (exists($REFERENCE/TERM)) then
			                (
			                	<plazo>{ xs:float($REFERENCE/TERM) }</plazo>
			                )
			                else ()
			                }
			                {
			                if (exists($REFERENCE/BALANCE)) then
			                (
			                	<saldoActual>{ xs:float($REFERENCE/BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (exists($REFERENCE/PUNISHED_BALANCE)) then
			                (
			                	<saldoCastigado>{ xs:float($REFERENCE/PUNISHED_BALANCE) }</saldoCastigado>
			                )
			                else ()
			                }
                           	{
			                if (exists($REFERENCE/DUE_BALANCE)) then
			                (
			                	<saldoCobroJudicial>{ xs:float($REFERENCE/DUE_BALANCE) }</saldoCobroJudicial>
			                )
			                else ()
			                }
			                {
			                if (exists($REFERENCE/ARREAR_BALANCE)) then
			                (
			                	<saldoMora>{ xs:float($REFERENCE/ARREAR_BALANCE) }</saldoMora>
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
                if (exists($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TOTAL_SALARY)) then
                (
                	<salarioBruto>{ xs:float($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/TOTAL_SALARY) }</salarioBruto>
                )
                else ()
                }
                {
                if (exists($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/NET_SALARY)) then
                (
                	<salarioNeto>{ xs:float($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/NET_SALARY) }</salarioNeto>
                )
                else ()
                }
                {
                if (exists($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/PAYROLL_SALARY)) then
                (
                	<salarioPlanilla>{ xs:float($consultaOfertaCreditoConsumoRequest/CUSTOMER_INFO/PAYROLL_SALARY) }</salarioPlanilla>
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
	                if (exists($consultaOfertaCreditoConsumoRequest/SCORE_INFO/SCORE_CALCULATION)) then
	                (
	                	<score>{ xs:float($consultaOfertaCreditoConsumoRequest/SCORE_INFO/SCORE_CALCULATION) }</score>
	                )
	                else ()
	                }
                </score>
                {
                if (exists($consultaOfertaCreditoConsumoRequest/EXTERNAL_SCORE)) then
                (
                	<scoreBuro>{ xs:float($consultaOfertaCreditoConsumoRequest/EXTERNAL_SCORE) }</scoreBuro>
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
                        	if (exists($CREDIT_CARD/BEHAVIOR_SCORE)) then
			                (
			                	<behaviorScore>{ xs:float($CREDIT_CARD/BEHAVIOR_SCORE) }</behaviorScore>
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
                        	if (exists($CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS)) then
			                (
			                	<cuotasExtraVigentes>{ xs:float($CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS) }</cuotasExtraVigentes>
			                )
			                else ()
			                }
                            <estado>{ data($CREDIT_CARD/STATUS) }</estado>
                            {
                        	if (exists($CREDIT_CARD/OPENING_DATE)) then
			                (
			                	<fechaApertura>{ xs:date($CREDIT_CARD/OPENING_DATE) }</fechaApertura>
			                )
			                else ()
			                }
			                {
                        	if (exists($CREDIT_CARD/CANCELATION_DATE)) then
			                (
			                	<fechaCancelacion>{ xs:date($CREDIT_CARD/CANCELATION_DATE) }</fechaCancelacion>
			                )
			                else ()
			                }
			                {
                        	if (exists($CREDIT_CARD/CASH_DISCOUNT_DATE)) then
			                (
			                	<fechaDescuentoContado>{ xs:date($CREDIT_CARD/CASH_DISCOUNT_DATE) }</fechaDescuentoContado>
			                )
			                else ()
			                }
			                {
                        	if (exists($CREDIT_CARD/LAST_EXTRA_DATE)) then
			                (
			                	<fechaUltimoExtra>{ xs:date($CREDIT_CARD/LAST_EXTRA_DATE) }</fechaUltimoExtra>
			                )
			                else ()
			                }
                            {
                                for $AFFINITY_GROUP in $CREDIT_CARD/AFFINITY_GROUP
                                return
                                    <grupoAfinidad>{ data($AFFINITY_GROUP) }</grupoAfinidad>
                            }
                            {
                        	if (exists($CREDIT_CARD/CURRENT_LIMIT)) then
			                (
			                	<limiteActual>{ xs:float($CREDIT_CARD/CURRENT_LIMIT) }</limiteActual>
			                )
			                else ()
			                }
                            <modeloLiquidacion>{ data($CREDIT_CARD/CLEARING_MODEL) }</modeloLiquidacion>
                            {
			                if (exists($CREDIT_CARD/CURRENT_DUE)) then
			                (
			                	<moraActual>{ xs:int($CREDIT_CARD/CURRENT_DUE) }</moraActual>
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
			                if (exists($CREDIT_CARD/CURRENT_BALANCE)) then
			                (
			                	<saldoActual>{ xs:float($CREDIT_CARD/CURRENT_BALANCE) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (exists($CREDIT_CARD/CLOSING_BALANCE)) then
			                (
			                	<saldoCorte>{ xs:float($CREDIT_CARD/CLOSING_BALANCE) }</saldoCorte>
			                )
			                else ()
			                }
			                {
			                if (exists($CREDIT_CARD/EXTRA_BALANCE)) then
			                (
			                	<saldoExtra>{ xs:float($CREDIT_CARD/EXTRA_BALANCE) }</saldoExtra>
			                )
			                else ()
			                }
			                {
			                if (exists($CREDIT_CARD/INTRA_BALANCE)) then
			                (
			                	<saldoIntra>{ xs:float($CREDIT_CARD/INTRA_BALANCE) }</saldoIntra>
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
                if (exists($consultaOfertaCreditoConsumoRequest/AGREEMENT/RATE)) then
                (
                	<tasaConvenio>{ xs:float($consultaOfertaCreditoConsumoRequest/AGREEMENT/RATE) }</tasaConvenio>
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
     </ns3:epOriginacionesHonduras>
};

local:func($consultaOfertaCreditoConsumoRequest, $consultaConsolidadaRiesgoClienteResponse)