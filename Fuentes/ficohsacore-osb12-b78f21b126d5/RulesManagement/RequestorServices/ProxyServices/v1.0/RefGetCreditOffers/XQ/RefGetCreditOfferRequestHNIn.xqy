xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://package.name.in.reverse.order";
(:: import schema at "../../../../../ProviderServices/WSDL/GetCustomerOffers/RuleServiceDefinitionOriginacionesHNService.wsdl" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/RefcreditManagement";
(:: import schema at "../../../../../../MWBanking/CreditManagement/RequestorServices/XSD/RefcreditManagement.xsd" ::)

declare variable $getCreditOffersRequest as element() (:: schema-element(ns1:getCreditOffersRequest) ::) external;

declare function local:func($getCreditOffersRequest as element() (:: schema-element(ns1:getCreditOffersRequest) ::)) as element() (:: schema-element(ns2:epOriginacionesHonduras) ::) {
     <ns2:epOriginacionesHonduras>
        <arg0>
            { if (fn:string-length(fn:string(fn:data($getCreditOffersRequest/ns1:CustomerInfo/ns1:LaborYears)))>0)
            then
             <antiguedaLaboral>{fn:data($getCreditOffersRequest/ns1:CustomerInfo/ns1:LaborYears)}</antiguedaLaboral>
            else
            <antiguedaLaboral>0</antiguedaLaboral>
            }
             {
                if (fn:string-length(fn:string(fn:data($getCreditOffersRequest/ns1:CustomerInfo/ns1:JobCharge)))>0)
                then <cargo>{fn:data($getCreditOffersRequest/ns1:CustomerInfo/ns1:JobCharge)}</cargo>
                else
                 <cargo>0</cargo>
            }
            {
            for $QUERY_ITEM in $getCreditOffersRequest/ns1:ReferencesDetails/ns1:Queries/ns1:QueryItem
            return
            <consultas>
              <entidad>{fn:data($QUERY_ITEM/ns1:Entity)}</entidad>
              <fechaConsulta>{fn:data($QUERY_ITEM/ns1:Date)}</fechaConsulta>
            </consultas>
            }    
            <edad>{fn:data($getCreditOffersRequest/ns1:CustomerInfo/ns1:Age)}</edad>
                {
                    for $JOB_COMPANY in $getCreditOffersRequest/ns1:CustomerInfo/ns1:JobCompany
                    return
                        <empresa>{ data($JOB_COMPANY) }</empresa>
                }
                {
            for $COMPANY_NAME in $getCreditOffersRequest/ns1:Agreement/ns1:CompanyName
            return
              <empresaConvenio>{fn:data($COMPANY_NAME)}</empresaConvenio>
            }               
            {
            for $STATUS in $getCreditOffersRequest/ns1:Agreement/ns1:Status
            return
              <estadoConvenio>{fn:data($STATUS)}</estadoConvenio>
            }              
                {
            for $EXTRA in $getCreditOffersRequest/ns1:InternalExtras/ns1:Extra
            return            
            <extraInterno>
              {
              if (fn:string-length(xs:string(fn:data($EXTRA/ns1:Installment)))>0)then
                <cuotaExtra>{fn:data($EXTRA/*:Installment)}</cuotaExtra>
              else
              ()
              }
              {
               for $INSTALLMENT_COUNT in $EXTRA/ns1:InstallmentCount
               return
               <cuotaNumero>{ data($INSTALLMENT_COUNT) }</cuotaNumero>
              }
                            {
                                for $DATE in $EXTRA/*:Date
                                return
                                    <fechaExtra>{ data($DATE) }</fechaExtra>
                            }
                            {
			                if (fn:string-length(xs:string(data($EXTRA/ns1:Amount))) > 0) then
				            (
				               	<montoTomado>{ data($EXTRA/ns1:Amount) }</montoTomado>
				            )
				            else ()
				            }
                            <numeroCuenta>{ data($EXTRA/ns1:AccountNumber) }</numeroCuenta>
                            {
			                if (fn:string-length(xs:string(data($EXTRA/ns1:Rate))) > 0) then
				            (
				               	<tasaExtra>{ data($EXTRA/ns1:Rate) }</tasaExtra>
				            )
				            else ()
				            }
                            {
                                for $TOTAL_INSTALLMENT in $EXTRA/ns1:TotalInstallment
                                return
                                    <totalCuotas>{ data($TOTAL_INSTALLMENT) }</totalCuotas>
                            }
                        </extraInterno>
            }
                           
                {
                if (fn:string-length(data($getCreditOffersRequest/ns1:CustomerInfo/ns1:JobStartDate)) > 0) then
	            (
	               	<fechaInicioLaboral>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:JobStartDate) }</fechaInicioLaboral>
	            )
	            else ()
	            }
            <fechaNacimiento>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:DateOfBirth) }</fechaNacimiento>
            {
                    for $PAYMENT_METHOD in $getCreditOffersRequest/ns1:Agreement/ns1:PaymentMethod
                    return
                        <formaPagoConvenio>{ data($PAYMENT_METHOD) }</formaPagoConvenio>
                }
                
                {
                    for $SOURCE_OF_INCOME in $getCreditOffersRequest/ns1:CustomerInfo/ns1:SourceOfIncome
                    return
                        <fuentePago>{ data($SOURCE_OF_INCOME) }</fuentePago>
                }
                <identidad>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:Id) }</identidad>
           
               
                {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:CustomerInfo/ns1:CreditMonths))) > 0) then
                (
                	<mesesDeposito>{ xs:int(data($getCreditOffersRequest/ns1:CustomerInfo/ns1:CreditMonths)) }</mesesDeposito>
                )
                else ()
                }
                {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:Agreement/ns1:Amount))) > 0) then
                (
                	<montoConvenio>{ data($getCreditOffersRequest/ns1:Agreement/ns1:Amount) }</montoConvenio>
                )
                else ()
                }
                <naturalezaProducto>{ data($getCreditOffersRequest/ns1:ProductNature) }</naturalezaProducto>
                <numeroSolicitud>{ data($getCreditOffersRequest/ns1:CaseId) }</numeroSolicitud>
                {
                	for $FOR_CONSOLIDATION_REFERENCE in $getCreditOffersRequest/ns1:ReferencesDetails/ns1:ActiveReferences/ns1:Reference
                	where ($FOR_CONSOLIDATION_REFERENCE/ns1:ForConsolidation) = 'YES'
                	return
                	<obligacionesConsolidacion>
		               <acreedor>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:Creditor) }</acreedor>
		               <estado>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:Status) }</estado>
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/ns1:OpeningDate)) > 0) then
		               (
		                	<fechaApertura>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:OpeningDate) }</fechaApertura>
		               )
		               else ()
		               }
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/ns1:CancelationDate)) > 0) then
		               (
		                	<fechaCancelacion>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:CancelationDate) }</fechaCancelacion>
		               )
		               else ()
		               }
		               {
		               if (fn:string-length(data($FOR_CONSOLIDATION_REFERENCE/ns1:ExpirationDate)) > 0) then
		               (
		                	<fechaVencimiento>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:ExpirationDate) }</fechaVencimiento>
		               )
		               else ()
		               }
		               {
		               if (fn:string-length(xs:string(data($FOR_CONSOLIDATION_REFERENCE/ns1:Limit))) > 0) then
		               (
		               		<limiteMonto>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:Limit) }</limiteMonto>
		               )
		               else ()
		               }
		               <noReferencia>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:ReferenceNumber) }</noReferencia>
		               {
		               if (fn:string-length(xs:string(data($FOR_CONSOLIDATION_REFERENCE/ns1:Balance))) > 0) then
		               (
		               		<saldoActual>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:Balance) }</saldoActual>
		               )
		               else ()
		               }
		               <tipoGarantia>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:GuaranteeType) }</tipoGarantia>
		               <tipoObligacion>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:ObligationType) }</tipoObligacion>
		               <tipoReferencia>{ data($FOR_CONSOLIDATION_REFERENCE/ns1:Type) }</tipoReferencia>
		            </obligacionesConsolidacion>
                }
                <ofertaPreAprobada>                    
                    {
                    	for $PREAPPROVED_OFFER in $getCreditOffersRequest/ns1:PreApprovedOffers/ns1:Offer
                        return
                    	if ((fn:upper-case($PREAPPROVED_OFFER/ns1:Type) = 'FICOCREDITO')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/ns1:InformationDate) }</fechaInformacion>,
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Installment))) > 0) then
			               	(
			               			<cuotaFicoCredito>{ data($PREAPPROVED_OFFER/ns1:Installment) }</cuotaFicoCredito>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months))) > 0) then
			               	(
			               			<ofertaFicoCredito12>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months) }</ofertaFicoCredito12>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months))) > 0) then
			               	(
			               			<ofertaFicoCredito18>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months) }</ofertaFicoCredito18>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months))) > 0) then
			               	(
			               			<ofertaFicoCredito24>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months) }</ofertaFicoCredito24>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months))) > 0) then
			               	(
			               			<ofertaFicoCredito36>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months) }</ofertaFicoCredito36>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months))) > 0) then
			               	(
			               			<ofertaFicoCredito48>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months) }</ofertaFicoCredito48>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months))) > 0) then
			               	(
			               			<ofertaFicoCredito60>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months) }</ofertaFicoCredito60>
			               	)
			               	else (),
							<tasaFicoCredito>{ data($PREAPPROVED_OFFER/ns1:Rate) }</tasaFicoCredito>,
							<timesIncomeFicoCredito>{ data($PREAPPROVED_OFFER/ns1:TimesIncome) }</timesIncomeFicoCredito>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/ns1:Type) = 'FICOYA')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/ns1:InformationDate) }</fechaInformacion>,
							if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Installment))) > 0) then
			               	(
			               			<cuotaFicoYa>{ data($PREAPPROVED_OFFER/ns1:Installment) }</cuotaFicoYa>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months))) > 0) then
			               	(
			               			<ofertaFicoYa12>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months) }</ofertaFicoYa12>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months))) > 0) then
			               	(
			               			<ofertaFicoYa18>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months) }</ofertaFicoYa18>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months))) > 0) then
			               	(
			               			<ofertaFicoYa24>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months) }</ofertaFicoYa24>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months))) > 0) then
			               	(
			               			<ofertaFicoYa36>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months) }</ofertaFicoYa36>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months))) > 0) then
			               	(
			               			<ofertaFicoYa48>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months) }</ofertaFicoYa48>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months))) > 0) then
			               	(
			               			<ofertaFicoYa60>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months) }</ofertaFicoYa60>
			               	)
			               	else (),
							<tasaFicoYa>{ data($PREAPPROVED_OFFER/ns1:Rate) }</tasaFicoYa>,
							<timesIncomeFicoYa>{ data($PREAPPROVED_OFFER/ns1:TimesIncome) }</timesIncomeFicoYa>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/ns1:Type) = 'OPI')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/ns1:InformationDate) }</fechaInformacion>,
							if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Installment))) > 0) then
			               	(
			               			<cuotaOPI>{ data($PREAPPROVED_OFFER/ns1:Installment) }</cuotaOPI>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months))) > 0) then
			               	(
			               			<ofertaOPI12>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months) }</ofertaOPI12>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months))) > 0) then
			               	(
			               			<ofertaOPI18>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months) }</ofertaOPI18>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months))) > 0) then
			               	(
			               			<ofertaOPI24>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months) }</ofertaOPI24>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months))) > 0) then
			               	(
			               			<ofertaOPI36>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months) }</ofertaOPI36>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months))) > 0) then
			               	(
			               			<ofertaOPI48>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months) }</ofertaOPI48>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months))) > 0) then
			               	(
			               			<ofertaOPI60>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months) }</ofertaOPI60>
			               	)
			               	else (),
							<tasaOPI>{ data($PREAPPROVED_OFFER/ns1:Rate) }</tasaOPI>,
							<timesIncomeOPI>{ data($PREAPPROVED_OFFER/ns1:TimesIncome) }</timesIncomeOPI>
						)
						else if ((fn:upper-case($PREAPPROVED_OFFER/ns1:Type) = 'RETANQUEO')) then
                    	(
							<fechaInformacion>{ data($PREAPPROVED_OFFER/ns1:InformationDate) }</fechaInformacion>,
							if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Installment))) > 0) then
			               	(
			               			<cuotaRetanqueo>{ data($PREAPPROVED_OFFER/ns1:Installment) }</cuotaRetanqueo>
			               	)
			               	else (),
							if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months))) > 0) then
			               	(
			               			<ofertaRetanqueo12>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For12Months) }</ofertaRetanqueo12>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months))) > 0) then
			               	(
			               			<ofertaRetanqueo18>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For18Months) }</ofertaRetanqueo18>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months))) > 0) then
			               	(
			               			<ofertaRetanqueo24>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For24Months) }</ofertaRetanqueo24>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months))) > 0) then
			               	(
			               			<ofertaRetanqueo36>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For36Months) }</ofertaRetanqueo36>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months))) > 0) then
			               	(
			               			<ofertaRetanqueo48>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For48Months) }</ofertaRetanqueo48>
			               	)
			               	else (),
			               	if (fn:string-length(xs:string(data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months))) > 0) then
			               	(
			               			<ofertaRetanqueo60>{ data($PREAPPROVED_OFFER/ns1:Details/ns1:For60Months) }</ofertaRetanqueo60>
			               	)
			               	else (),
							<tasaRetanqueo>{ data($PREAPPROVED_OFFER/ns1:Rate) }</tasaRetanqueo>,
							<timesIncomeRetanqueo>{ data($PREAPPROVED_OFFER/ns1:TimesIncome) }</timesIncomeRetanqueo>
						)
						else ()
                    }
                </ofertaPreAprobada>
                {
                    for $ASSETS in $getCreditOffersRequest/ns1:Assets/ns1:Asset
                    return
                        <pasivos>
                            <categoria>{ data($ASSETS/ns1:Category) }</categoria>
                            {
                                for $OPENING_DATE in $ASSETS/ns1:OpeningDate
                                return
                                	if (fn:string-length(data($OPENING_DATE)) > 0) then
					                (
					                	<fechaApertura>{ data($OPENING_DATE) }</fechaApertura>
					                )
					                else ()
                            }
                            {
                                for $CANCELATION_DATE in $ASSETS/ns1:CancelationDate
                                return
                                	if (fn:string-length(data($CANCELATION_DATE)) > 0) then
					                (
					                	<fechaCierre>{ data($CANCELATION_DATE) }</fechaCierre>
					                )
					                else ()
                            }
                            {
                                for $CURRENCY in $ASSETS/ns1:Currency
                                return
                                    <moneda>{ data($CURRENCY) }</moneda>
                            }
                            {
                                for $NUMBER in $ASSETS/ns1:Number
                                return
                                    <numeroCuenta>{ data($NUMBER) }</numeroCuenta>
                            }
                            {
			                if (fn:string-length(xs:string(data($ASSETS/ns1:CurrentBalance))) > 0) then
			                (
			                	<saldoActual>{ data($ASSETS/ns1:CurrentBalance) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($ASSETS/ns1:EndOfMonthBalance))) > 0) then
			                (
			                	<saldoFinMes>{ data($ASSETS/ns1:EndOfMonthBalance) }</saldoFinMes>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($ASSETS/ns1:AverageBalance))) > 0) then
			                (
			                	<saldoPromedioMensual>{ data($ASSETS/ns1:AverageBalance) }</saldoPromedioMensual>
			                )
			                else ()
			                }
                                        
                            {
                              for $TRANSACTION in $ASSETS/ns1:ProductTransactions/ns1:Transaction
                          return
                        <transaccionesPasivos>
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:Account))) > 0) then
                              (
                                <cuenta>{ data($TRANSACTION/ns1:Account) }</cuenta>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:PeriodDate))) > 0) then
                              (
                                <fecha_Finde_Periodo>{ data($TRANSACTION/ns1:PeriodDate) }</fecha_Finde_Periodo>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:LastCreditDate))) > 0) then
                              (
                                <fecha_Ultimo_Credito>{ data($TRANSACTION/ns1:LastCreditDate) }</fecha_Ultimo_Credito>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:LastDebitDate))) > 0) then
                              (
                                <fecha_Ultimo_Debito>{ data($TRANSACTION/ns1:LastDebitDate) }</fecha_Ultimo_Debito>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:ProductBlock))) > 0) then
                              (
                                <flag_Bloqueo_Cuenta>{ data($TRANSACTION/ns1:ProductBlock) }</flag_Bloqueo_Cuenta>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:JointAccounts))) > 0) then
                              (
                                <flag_Cuenta_Mancomunada>{ data($TRANSACTION/ns1:JointAccounts) }</flag_Cuenta_Mancomunada>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:PayrollAccount))) > 0) then
                              (
                                <flag_Cuenta_Planilla>{ data($TRANSACTION/ns1:PayrollAccount) }</flag_Cuenta_Planilla>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:Facilities))) > 0) then
                              (
                                <flag_Facilidades_Cuenta>{ data($TRANSACTION/ns1:Facilities) }</flag_Facilidades_Cuenta>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:LegalRepresentative))) > 0) then
                              (
                                <flag_Representante_Legal>{ data($TRANSACTION/ns1:LegalRepresentative) }</flag_Representante_Legal>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:PayrollCreditAmount))) > 0) then
                              (
                                <monto_Acreditado_Planilla>{ data($TRANSACTION/ns1:PayrollCreditAmount) }</monto_Acreditado_Planilla>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:PeriodBalance))) > 0) then
                              (
                                <saldo_Fin>{ data($TRANSACTION/ns1:PeriodBalance) }</saldo_Fin>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:MaxBalance))) > 0) then
                              (
                                <saldo_Max>{ data($TRANSACTION/ns1:MaxBalance) }</saldo_Max>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:MinBalance))) > 0) then
                              (
                                <saldo_Min>{ data($TRANSACTION/ns1:MinBalance) }</saldo_Min>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:AverageBalance))) > 0) then
                              (
                                <saldo_Promedio>{ data($TRANSACTION/ns1:AverageBalance) }</saldo_Promedio>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:CreditsInfo))) > 0) then
                              (
                                <monto_Creditos>{ data($TRANSACTION/ns1:CreditsInfo/ns1:AmountOnPeriod) }</monto_Creditos>,
                                <numero_Creditos>{ data($TRANSACTION/ns1:CreditsInfo/ns1:Summation) }</numero_Creditos>,
                                <monto_Intereses_Creditos>{ data($TRANSACTION/ns1:CreditsInfo/ns1:InterestsSummation) }</monto_Intereses_Creditos>,
                                <numero_Intereses_Creditos>{ data($TRANSACTION/ns1:CreditsInfo/ns1:InterestOnPeriod) }</numero_Intereses_Creditos>
                              )
                                else ()
			  }
                          {
                            if (fn:string-length(xs:string(data($TRANSACTION/ns1:DebitsInfo))) > 0) then
                              (
                                <monto_Debitos>{ data($TRANSACTION/ns1:DebitsInfo/ns1:AmountOnPeriod) }</monto_Debitos>,
                                <numero_Debitos>{ data($TRANSACTION/ns1:DebitsInfo/ns1:Summation) }</numero_Debitos>,
                                <monto_Intereses_Debitos>{ data($TRANSACTION/ns1:DebitsInfo/ns1:InterestsSummation) }</monto_Intereses_Debitos>,
                                <numero_Intereses_Debitos>{ data($TRANSACTION/ns1:DebitsInfo/ns1:InterestOnPeriod) }</numero_Intereses_Debitos>
                              )
                                else ()
			  }
                        </transaccionesPasivos>
                            }
                      </pasivos>       
                }
                 {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:Agreement/ns1:Term))) > 0) then
                (
                	<plazoConvenio>{ data($getCreditOffersRequest/ns1:Agreement/ns1:Term) }</plazoConvenio>
                )
                else ()
                }
                
                {
                    for $LOAN in $getCreditOffersRequest/ns1:Liabilities/ns1:LoansInfo/ns1:Loan
                    return
                        <prestamos>
                        	{
			                if (fn:string-length(xs:string(data($LOAN/ns1:Charges))) > 0) then
			                (
			                	<cargos>{ data($LOAN/ns1:Charges) }</cargos>
			                )
			                else ()
			                }
                            {
                                for $AGENCY_CODE in $LOAN/ns1:AgencyCode
                                return
                                    <codigoAgencia>{ data($AGENCY_CODE) }</codigoAgencia>
                            }
                            {
                                for $SUB_APPLICATION in $LOAN/ns1:SubApplication
                                return
                                    <codigoSubAplicacion>{ data($SUB_APPLICATION) }</codigoSubAplicacion>
                            }
                            {
                                for $GUARANTEE_TYPE in $LOAN/ns1:GuaranteeType
                                return
                                    <codigoTipoGarantia>{ data($GUARANTEE_TYPE) }</codigoTipoGarantia>
                            }
                            {
                                for $OPENING_DATE in $LOAN/ns1:OpeningDate
                                return
                                    <fechaApertura>{ data($OPENING_DATE) }</fechaApertura>
                            }
                            {
                                for $CANCELATION_DATE in $LOAN/ns1:CancelationDate
                                return
                                    <fechaCancelacion>{ data($CANCELATION_DATE) }</fechaCancelacion>
                            }
                            <identidad>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:Id) }</identidad>
                            {
			                if (fn:string-length(xs:string(data($LOAN/ns1:Interest))) > 0) then
			                (
			                	<intereses>{ data($LOAN/ns1:Interest) }</intereses>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($LOAN/ns1:InitialAmount))) > 0) then
			                (
			                	<montoInicial>{ data($LOAN/ns1:InitialAmount) }</montoInicial>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($LOAN/ns1:CurrentDue))) > 0) then
			                (
			                	<moraActual>{ data($LOAN/ns1:CurrentDue) }</moraActual>
			                )
			                else ()
			                }
                            <numeroContrato>{ data($LOAN/ns1:ContractNumber) }</numeroContrato>
                            {
			                if (fn:string-length(xs:string(data($LOAN/ns1:PaymentNumber))) > 0) then
			                (
			                	<numeroCuotas>{ data($LOAN/ns1:PaymentNumber) }</numeroCuotas>
			                )
			                else ()
			                }
                            {
                                for $NUMBER in $LOAN/ns1:Number
                                return
                                    <numeroPrestamo>{ data($NUMBER) }</numeroPrestamo>
                            }
                            {
			                if (fn:string-length(xs:string(data($LOAN/ns1:OtherCharges))) > 0) then
			                (
			                	<otrosCargos>{ data($LOAN/ns1:OtherCharges) }</otrosCargos>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($LOAN/ns1:Term))) > 0) then
			                (
			                	<plazo>{ data($LOAN/ns1:Term) }</plazo>
			                )
			                else ()
			                }
                            {
			                if (fn:string-length(xs:string(data($LOAN/ns1:CurrentBalance))) > 0) then
			                (
			                	<saldoActual>{ data($LOAN/ns1:CurrentBalance) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($LOAN/ns1:Insurance))) > 0) then
			                (
			                	<seguros>{ data($LOAN/ns1:Insurance) }</seguros>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($LOAN/ns1:Rate))) > 0) then
			                (
			                	<tasa>{ data($LOAN/ns1:Rate) }</tasa>
			                )
			                else ()
			                }
                            {
                                for $CODE_TYPE in $LOAN/ns1:CodeType
                                return
                                    <tipoPrestamo>{ data($CODE_TYPE) }</tipoPrestamo>
                            }
                            {
                                for $TRANSACTION in $LOAN/ns1:ProductTransactions/ns1:Transaction
                                return
                                    <transaccionesPrestamo>
                                        {
                                            for $AGENCY_CODE in $LOAN/ns1:AgencyCode
                                            return
                                                <codigoAgencia>{ data($AGENCY_CODE) }</codigoAgencia>
                                        }
                                        {
                                            for $SUB_APPLICATION in $LOAN/ns1:SubApplication
                                            return
                                                <codigoSubAplicacion>{ data($SUB_APPLICATION) }</codigoSubAplicacion>
                                        }
                                        {
                                            for $PERIOD_DATE in $TRANSACTION/ns1:PeriodDate
                                            return
                                                <fechaCorte>{ data($PERIOD_DATE) }</fechaCorte>
                                        }
                                        {
                                            for $DUE_BALANCE in $TRANSACTION/ns1:DueBalance
                                            where xs:string(data($DUE_BALANCE)) != ''
                                            return
                                                <mora>{ data($DUE_BALANCE) }</mora>
                                        }
                                        {
                                            for $NUMBER in $LOAN/ns1:Number
                                            return
                                                <numeroPrestamo>{ data($NUMBER) }</numeroPrestamo>
                                        }
                                        <saldoActual>{ data($TRANSACTION/ns1:CapitalBalance) }</saldoActual>
                                    </transaccionesPrestamo>
                            }
                            {
			                if (fn:string-length(xs:string(data($LOAN/ns1:PaymentAmount))) > 0) then
			                (
			                	<valorCuota>{ data($LOAN/ns1:PaymentAmount) }</valorCuota>
			                )
			                else ()
			                }
                        </prestamos>
                }


               {
                       
                        for $REFERENCE in $getCreditOffersRequest/ns1:ReferencesDetails/ns1:ActiveReferences/ns1:Reference
                        return
                        <referencias>
                        	{
                        	if (fn:string-length(data($REFERENCE/ns1:Creditor)) > 0) then
                        	(
                        		<acreedor>{ data($REFERENCE/ns1:Creditor) }</acreedor>
                        	)
                        	else ()
                        	}
                           <conteoHistoricoDol>{ data($REFERENCE/ns1:HistoricalCountDol) }</conteoHistoricoDol>
                           <conteoHistoricoLoc>{ data($REFERENCE/ns1:HistoricalCountLoc) }</conteoHistoricoLoc>
                            {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:Installment))) > 0) then
			                (
			                	<cuota>{ data($REFERENCE/ns1:Installment) }</cuota>
			                )
			                else ()
			                }
                           <estado>{ data($REFERENCE/ns1:Status) }</estado>
                            {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:ExchangeFactor))) > 0) then
			                (
			                	<factorCambio>{ data($REFERENCE/ns1:ExchangeFactor) }</factorCambio>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/ns1:OpeningDate)) > 0) then
			                (
			                	<fechaApertura>{ data($REFERENCE/ns1:OpeningDate) }</fechaApertura>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/ns1:CancelationDate)) > 0) then
			                (
			                	<fechaCancelacion>{ data($REFERENCE/ns1:CancelationDate) }</fechaCancelacion>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/ns1:ExpirationDate)) > 0) then
			                (
			                	<fechaVencimiento>{ data($REFERENCE/ns1:ExpirationDate) }</fechaVencimiento>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(xs:string(data($REFERENCE/ns1:Limit))) > 0) then
                        	(
                        		<limiteMonto>{ data($REFERENCE/ns1:Limit) }</limiteMonto>
                        	)
                        	else ()
                        	}
                           <moneda>{ data($REFERENCE/ns1:Currency) }</moneda>
                           <moraHistorica>{ data($REFERENCE/ns1:HistoricalArrear) }</moraHistorica>
                           <nivelMora>{ data($REFERENCE/ns1:ArrearLevel) }</nivelMora>
                           <noReferencia>{ data($REFERENCE/ns1:ReferenceNumber) }</noReferencia>
                           <periodoInfo>{ data($REFERENCE/ns1:Period) }</periodoInfo>
                            {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:Term))) > 0) then
			                (
			                	<plazo>{ data($REFERENCE/ns1:Term) }</plazo>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:Balance))) > 0) then
			                (
			                	<saldoActual>{ data($REFERENCE/ns1:Balance) }</saldoActual>
			                )
			                else ()
			                }
                            {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:PunishedBalance))) > 0) then
			                (
			                	<saldoCastigado>{ data($REFERENCE/ns1:PunishedBalance) }</saldoCastigado>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:DueBalance))) > 0) then
			                (
			                	<saldoCobroJudicial>{ data($REFERENCE/ns1:DueBalance) }</saldoCobroJudicial>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:ArrearBalance))) > 0) then
			                (
			                	<saldoMora>{ data($REFERENCE/ns1:ArrearBalance) }</saldoMora>
			                )
			                else ()
			                }
                           <tipoGarantia>{ data($REFERENCE/ns1:GuaranteeType) }</tipoGarantia>
                           <tipoObligacion>{ data($REFERENCE/ns1:ObligationType) }</tipoObligacion>
                           <tipoPrestamo>{ data($REFERENCE/ns1:CreditType) }</tipoPrestamo>
                           <tipoReferencia>{ data($REFERENCE/ns1:Type) }</tipoReferencia>
                        </referencias>
                }
                {
                       
                        for $REFERENCE in $getCreditOffersRequest/ns1:ReferencesDetails/ns1:HistoricalReferences/ns1:Reference
                        return
                        <referencias>
                           <acreedor>{ data($REFERENCE/ns1:Creditor) }</acreedor>
                           <conteoHistoricoDol>{ data($REFERENCE/ns1:HistoricalCountDol) }</conteoHistoricoDol>
                           <conteoHistoricoLoc>{ data($REFERENCE/ns1:HistoricalCountLoc) }</conteoHistoricoLoc>
                           	{
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:Installment))) > 0) then
			                (
			                	<cuota>{ data($REFERENCE/ns1:Installment) }</cuota>
			                )
			                else ()
			                }
                           <estado>{ data($REFERENCE/ns1:Status) }</estado>
                           	{
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:ExchangeFactor))) > 0) then
			                (
			                	<factorCambio>{ data($REFERENCE/ns1:ExchangeFactor) }</factorCambio>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($REFERENCE/ns1:OpeningDate)) > 0) then
			                (
			                	<fechaApertura>{ data($REFERENCE/ns1:OpeningDate) }</fechaApertura>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/ns1:CancelationDate)) > 0) then
			                (
			                	<fechaCancelacion>{ data($REFERENCE/ns1:CancelationDate) }</fechaCancelacion>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(data($REFERENCE/ns1:ExpirationDate)) > 0) then
			                (
			                	<fechaVencimiento>{ data($REFERENCE/ns1:ExpirationDate) }</fechaVencimiento>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:Limit))) > 0) then
			                (
			                	<limiteMonto>{ data($REFERENCE/ns1:Limit) }</limiteMonto>
			                )
			                else ()
			                }
                           <moneda>{ data($REFERENCE/ns1:Currency) }</moneda>
                           <moraHistorica>{ data($REFERENCE/ns1:HistoricalArrear) }</moraHistorica>
			               <nivelMora>{ data($REFERENCE/ns1:ArrearLevel) }</nivelMora>
                           <noReferencia>{ data($REFERENCE/ns1:ReferenceNumber) }</noReferencia>
                           <periodoInfo>{ data($REFERENCE/ns1:Period) }</periodoInfo>
                           	{
			                if (fn:string-length(data($REFERENCE/ns1:Term)) > 0) then
			                (
			                	<plazo>{ data($REFERENCE/ns1:Term) }</plazo>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:Balance))) > 0) then
			                (
			                	<saldoActual>{ data($REFERENCE/ns1:Balance) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:PunishedBalance))) > 0) then
			                (
			                	<saldoCastigado>{data($REFERENCE/ns1:PunishedBalance) }</saldoCastigado>
			                )
			                else ()
			                }
                           	{
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:DueBalance))) > 0) then
			                (
			                	<saldoCobroJudicial>{ data($REFERENCE/ns1:DueBalance) }</saldoCobroJudicial>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($REFERENCE/ns1:ArrearBalance))) > 0) then
			                (
			                	<saldoMora>{ data($REFERENCE/ns1:ArrearBalance) }</saldoMora>
			                )
			                else ()
			                }
                           <tipoGarantia>{ data($REFERENCE/ns1:GuaranteeType) }</tipoGarantia>
                           <tipoObligacion>{ data($REFERENCE/ns1:ObligationType) }</tipoObligacion>
                           <tipoPrestamo>{ data($REFERENCE/ns1:CreditType) }</tipoPrestamo>
                           <tipoReferencia>{ data($REFERENCE/ns1:Type) }</tipoReferencia>
                        </referencias>
                }
                {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:CustomerInfo/ns1:TotalSalary))) > 0) then
                (
                	<salarioBruto>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:TotalSalary) }</salarioBruto>
                )
                else ()
                }
                {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:CustomerInfo/ns1:NetSalary))) > 0) then
                (
                	<salarioNeto>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:NetSalary) }</salarioNeto>
                )
                else ()
                }
                {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:CustomerInfo/ns1:PayrollSalary))) > 0) then
                (
                	<salarioPlanilla>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:PayrollSalary) }</salarioPlanilla>
                )
                else ()
                }
                <score>
                    {
                        for $QUALIFICATION in $getCreditOffersRequest/ns1:ScoreInfo/ns1:Qualification
                        return
                            <calificacionScore>{ data($QUALIFICATION) }</calificacionScore>
                    }
                    {
                        for $RISK_LEVEL in $getCreditOffersRequest/ns1:ScoreInfo/ns1:RiskLevel
                        return
                            <nivelRiesgo>{ data($RISK_LEVEL) }</nivelRiesgo>
                    }
                    {
	                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:ScoreInfo/ns1:ScoreCalculation))) > 0) then
	                (
	                	<score>{ data($getCreditOffersRequest/ns1:ScoreInfo/ns1:ScoreCalculation) }</score>
	                )
	                else ()
	                }
                </score>
                {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:ExternalScore))) > 0) then
                (
                	<scoreBuro>{ data($getCreditOffersRequest/ns1:ExternalScore) }</scoreBuro>
                )
                else ()
                }
                <segmentoCliente>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:Target) }</segmentoCliente>
                <sexo>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:Gender) }</sexo>
                {
                    for $CREDIT_CARD in $getCreditOffersRequest/ns1:Liabilities/ns1:CreditCardsInfo/ns1:CreditCard
                    return
                        <tarjetas>
                        	{
                        	if (fn:string-length(xs:string(data($CREDIT_CARD/ns1:BehaviorScore))) > 0) then
			                (
			                	<behaviorScore>{ data($CREDIT_CARD/ns1:BehaviorScore) }</behaviorScore>
			                )
			                else ()
			                }
                            {
                                for $QUALIFICATION_SCORE in $CREDIT_CARD/ns1:QualificationScore
                                return
                                    <calificacionScore>{ data($QUALIFICATION_SCORE) }</calificacionScore>
                            }
                            {
                                for $QUALIFICATION_CUSTOMER_SCORE in $CREDIT_CARD/ns1:QualificationCustomerScore
                                return
                                    <calificacionScoreCliente>{ data($QUALIFICATION_CUSTOMER_SCORE) }</calificacionScoreCliente>
                            }
                           {
                                for $LOCKCODE1 in $CREDIT_CARD/ns1:LockCode1
                                return
                                    <codbloqueo1>{ data($LOCKCODE1) }</codbloqueo1>
                            }
                            {
                                for $LOCKCODE2 in $CREDIT_CARD/ns1:LockCode2
                                return
                                    <codbloqueo2>{ data($LOCKCODE2) }</codbloqueo2>
                            }
                            {
                                for $LOGO in $CREDIT_CARD/ns1:Logo
                                return
                             		<grupoAfinidad>{ data($LOGO) }</grupoAfinidad>
                            }
                            {
                                for $AVAILABLE_CASH in $CREDIT_CARD/ns1:AvailableCash
                                return
                             		<cash_diponible>{ data($AVAILABLE_CASH) }</cash_diponible>
                            }
                            {
                                for $LOCK_DATE1 in $CREDIT_CARD/ns1:LockDate1
                                return
                             	<fechabloqueo1>{ data($LOCK_DATE1) }</fechabloqueo1>
							}
                            {
                                for $LOCK_DATE2 in $CREDIT_CARD/ns1:LockDate2
                                return
                             	<fechabloqueo2>{ data($LOCK_DATE2) }</fechabloqueo2>
                            }                            
                            {
                        	if (fn:string-length(xs:string(data($CREDIT_CARD/ns1:ActiveExtraInstallments))) > 0) then
			                (
			                	<cuotasExtraVigentes>{ data($CREDIT_CARD/ns1:ActiveExtraInstallments) }</cuotasExtraVigentes>
			                )
			                else ()
			                }
                            <estado>{ data($CREDIT_CARD/ns1:Status) }</estado>
                            {
                        	if (fn:string-length(data($CREDIT_CARD/ns1:OpeningDate)) > 0) then
			                (
			                	<fechaApertura>{ data($CREDIT_CARD/ns1:OpeningDate) }</fechaApertura>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(data($CREDIT_CARD/ns1:CancelationDate)) > 0) then
			                (
			                	<fechaCancelacion>{ data($CREDIT_CARD/ns1:CancelationDate) }</fechaCancelacion>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(data($CREDIT_CARD/ns1:CashDiscountDate)) > 0) then
			                (
			                	<fechaDescuentoContado>{ data($CREDIT_CARD/ns1:CashDiscountDate) }</fechaDescuentoContado>
			                )
			                else ()
			                }
			                {
                        	if (fn:string-length(data($CREDIT_CARD/ns1:LastExtraDate)) > 0) then
			                (
			                	<fechaUltimoExtra>{ data($CREDIT_CARD/ns1:LastExtraDate) }</fechaUltimoExtra>
			                )
			                else ()
			                }
                            {
                                for $AFFINITY_GROUP in $CREDIT_CARD/ns1:AffinityGroup
                                return
                                    <grupoAfinidad>{ data($AFFINITY_GROUP) }</grupoAfinidad>
                            }
                            {
                        	if (fn:string-length(xs:string(data($CREDIT_CARD/ns1:CurrentLimit))) > 0) then
			                (
			                	<limiteActual>{ data($CREDIT_CARD/ns1:CurrentLimit) }</limiteActual>
			                )
			                else ()
			                }
                            <modeloLiquidacion>{ data($CREDIT_CARD/ns1:ClearingModel) }</modeloLiquidacion>
                            {
			                if (fn:string-length(data($CREDIT_CARD/ns1:CurrentDue)) > 0) then
			                (
			                	<moraActual>{ data($CREDIT_CARD/ns1:CurrentDue) }</moraActual>
			                )
			                else ()
			                }
                            <numeroCuenta>{ data($CREDIT_CARD/ns1:Account) }</numeroCuenta>
                            {
                                for $PRODUCT in $CREDIT_CARD/ns1:Product
                                return
                                    <producto>{ data($PRODUCT) }</producto>
                            }
                            {
			                if (fn:string-length(xs:string(data($CREDIT_CARD/ns1:CurrentBalance))) > 0) then
			                (
			                	<saldoActual>{ data($CREDIT_CARD/ns1:CurrentBalance) }</saldoActual>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(data($CREDIT_CARD/ns1:ClosingBalance)) > 0) then
			                (
			                	<saldoCorte>{ data($CREDIT_CARD/ns1:ClosingBalance) }</saldoCorte>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($CREDIT_CARD/ns1:ExtraBalance))) > 0) then
			                (
			                	<saldoExtra>{ data($CREDIT_CARD/ns1:ExtraBalance) }</saldoExtra>
			                )
			                else ()
			                }
			                {
			                if (fn:string-length(xs:string(data($CREDIT_CARD/ns1:IntraBalance))) > 0) then
			                (
			                	<saldoIntra>{ data($CREDIT_CARD/ns1:IntraBalance) }</saldoIntra>
			                )
			                else ()
			                }
			                {
			                for $TRANSACTION in $CREDIT_CARD/ns1:TransactionCreditCardType/ns1:Transaction
                    		return
                    		<transaccionesTarjeta>
                            	<cuota_extra>{ data($TRANSACTION/ns1:ExtraFee) }</cuota_extra>
                            	<cuota_intra>{ data($TRANSACTION/ns1:IntraFee) }</cuota_intra>
                            	<saldo_extra>{ data($TRANSACTION/ns1:ExtraBalance) }</saldo_extra>
                            	<saldo_intra>{ data($TRANSACTION/ns1:IntraBalance) }</saldo_intra>
                            </transaccionesTarjeta>
					        }                                        
                        </tarjetas>
                }
                {
                if (fn:string-length(xs:string(data($getCreditOffersRequest/ns1:Agreement/ns1:Rate))) > 0) then
                (
                	<tasaConvenio>{ data($getCreditOffersRequest/ns1:Agreement/ns1:Rate) }</tasaConvenio>
                )
                else ()
                }
                <tipoCliente>{ data($getCreditOffersRequest/ns1:CustomerInfo/ns1:Type) }</tipoCliente>
                {
                    for $JOB_TYPE in $getCreditOffersRequest/ns1:CustomerInfo/ns1:JobType
                    return
                        <tipoTrabajo>{ data($JOB_TYPE) }</tipoTrabajo>
                }
            </arg0>
    </ns2:epOriginacionesHonduras>
};

local:func($getCreditOffersRequest)