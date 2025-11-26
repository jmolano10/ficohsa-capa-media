xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://package.name.in.reverse.order";
(:: import schema at "../../../../../ProviderServices/WSDL/GetCustomerOffers/RuleServiceDefinitionOriginacionesGTService.wsdl" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/creditManagement";
(:: import schema at "../../../../../../MWBanking/CreditManagement/RequestorServices/XSD/creditManagement.xsd" ::)

declare variable $getCreditOffersRequest as element() (:: schema-element(ns1:getCreditOffersRequest) ::) external;

declare function local:func($getCreditOffersRequest as element() (:: schema-element(ns1:getCreditOffersRequest) ::)) as element() (:: schema-element(ns2:epOriginacionesGuatemala) ::) {
    <ns2:epOriginacionesGuatemala>
        <arg0>
            {
                for $canalDeVenta in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:ProductCampaing
                return
                <canalDeVenta>{fn:data($canalDeVenta)}</canalDeVenta>
            }
            {
                for $cargo in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:JobCharge
                return
                <cargo>{fn:data($cargo)}</cargo>
            }
            {
                for $codigoTipoCliente in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:CustomerCode
                return
                <codigoTipoCliente>{fn:data($codigoTipoCliente)}</codigoTipoCliente>
            }
            {
                for $QueryItem in $getCreditOffersRequest/ns1:LoanOriginations/ns1:ReferencesDetails/ns1:Queries/ns1:QueryItem
                return(
                    <consultasTuca>
                    {
                        for $fechaConsulta in $QueryItem/ns1:Date
                        return
                        if(fn:string($fechaConsulta/text()) != "") then (
                            <fechaConsulta>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaConsulta))}</fechaConsulta>
                        ) else ()
                    }
                    {
                        for $motivo in $QueryItem/ns1:Motive
                        return
                        <motivo>{fn:data($motivo)}</motivo>
                    }
                    {
                        for $tipoConsulta in $QueryItem/ns1:QueryType
                        return
                        <tipoConsulta>{fn:data($tipoConsulta)}</tipoConsulta>
                    }
                    </consultasTuca>
                )
            }
            {
                for $destino in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:ProductDestiny
                return
                <destino>{fn:data($destino)}</destino>
            }
            {
                for $fechaInicioLaboral in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:JobStartDate
                return
                if(fn:string($fechaInicioLaboral/text()) != "") then (
                    <fechaInicioLaboral>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaInicioLaboral))}</fechaInicioLaboral>
                ) else ()
            }
            {
                for $fechaNacimiento in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:DateOfBirth
                return
                if(fn:string($fechaNacimiento/text()) != "") then (
                    <fechaNacimiento>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaNacimiento))}</fechaNacimiento>
                ) else ()
            }
            {
                for $genero in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:Gender
                return
                <genero>{fn:data($genero)}</genero>
            }
            {
                for $identidad in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:Id
                return
                <identidad>{fn:data($identidad)}</identidad>
            }
            {
                for $naturalezaProducto in $getCreditOffersRequest/ns1:ProductNature
                return
                <naturalezaProducto>{fn:data($naturalezaProducto)}</naturalezaProducto>
            }
            {
                for $noSolicitud in $getCreditOffersRequest/ns1:CaseId
                return
                <noSolicitud>{fn:data($noSolicitud)}</noSolicitud>
            }
            {
                for $numeroEvaluacionSirc in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:EvaluationNumberSirc
                return
                <numeroEvaluacionSirc>{fn:data($numeroEvaluacionSirc)}</numeroEvaluacionSirc>
            }
            {
                for $numeroEvaluacionTuca in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:EvaluationNumberTuca
                return
                <numeroEvaluacionTuca>{fn:data($numeroEvaluacionTuca)}</numeroEvaluacionTuca>
            }
            {
                for $otrosIngresos in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:OtherIncome
                return
                <otrosIngresos>{fn:data($otrosIngresos)}</otrosIngresos>
            }
            {
                for $Loan in $getCreditOffersRequest/ns1:LoansInfo/ns1:Loan
                return(
                    <prestamo>
                        {
                            for $cantidadCuotasPagadas in $Loan/ns1:PaidPayments
                            return
                            <cantidadCuotasPagadas>{fn:data($cantidadCuotasPagadas)}</cantidadCuotasPagadas>
                        }
                        {
                            for $cargos in $Loan/ns1:Charges
                            return
                            <cargos>{fn:data($cargos)}</cargos>
                        }
                        {
                            for $codigo1 in $Loan/ns1:Code1
                            return
                            <codigo1>{fn:data($codigo1)}</codigo1>
                        }
                        {
                            for $codigo2 in $Loan/ns1:Code2
                            return
                            <codigo2>{fn:data($codigo2)}</codigo2>
                        }
                        {
                            for $codigoAgencia in $Loan/ns1:AgencyCode
                            return
                            <codigoAgencia>{fn:data($codigoAgencia)}</codigoAgencia>
                        }
                        {
                            for $codigoDestino in $Loan/ns1:DestinationCode
                            return
                            <codigoDestino>{fn:data($codigoDestino)}</codigoDestino>
                        }
                        {
                            for $codigoSubAplicacion in $Loan/ns1:SubApplicaton
                            return
                            <codigoSubAplicacion>{fn:data($codigoSubAplicacion)}</codigoSubAplicacion>
                        }
                        {
                            for $codigotipogarantia in $Loan/ns1:GuaranteeType
                            return
                            <codigotipogarantia>{fn:data($codigotipogarantia)}</codigotipogarantia>
                        }
                        {
                            for $codigotipoprestamo in $Loan/ns1:CodeType
                            return
                            <codigotipoprestamo>{fn:data($codigotipoprestamo)}</codigotipoprestamo>
                        }
                        {
                            for $fechaApertura in $Loan/ns1:OpeningDate
                            return
                            if(fn:string($fechaApertura/text()) != "") then (
                                <fechaApertura>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaApertura))}</fechaApertura>
                            ) else ()
                        }
                        {
                            for $fechaCancelacion in $Loan/ns1:CancelationDate
                            return
                            if(fn:string($fechaCancelacion/text()) != "") then (
                                <fechaCancelacion>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaCancelacion))}</fechaCancelacion>
                            ) else ()
                        }
                        {
                            for $fechaPrimerPagoCapital in $Loan/ns1:FirstCapitalPaymentDate
                            return
                            if(fn:string($fechaPrimerPagoCapital/text()) != "") then (
                                <fechaPrimerPagoCapital>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaPrimerPagoCapital))}</fechaPrimerPagoCapital>
                            ) else ()
                        }
                        {
                            for $fechaUltimoPago in $Loan/ns1:LastPaymentDate
                            return
                            if(fn:string($fechaUltimoPago/text()) != "") then (
                                <fechaUltimoPago>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaUltimoPago))}</fechaUltimoPago>
                            ) else ()
                        }
                        {
                            for $frecuenciaCapital in $Loan/ns1:CapitalFrequency
                            return
                            <frecuenciaCapital>{fn:data($frecuenciaCapital)}</frecuenciaCapital>
                        }
                        {
                            for $interes in $Loan/ns1:Interest
                            return
                            <interes>{fn:data($interes)}</interes>
                        }
                        {
                            for $montoInicial in $Loan/ns1:InitialAmount
                            return
                            <montoInicial>{fn:data($montoInicial)}</montoInicial>
                        }
                        {
                            for $moraActual in $Loan/ns1:CurrentDue
                            return
                            <moraActual>{fn:data($moraActual)}</moraActual>
                        }
                        {
                            for $numeroCuenta in $Loan/ns1:Account
                            return
                            <numeroCuenta>{fn:data($numeroCuenta)}</numeroCuenta>
                        }
                        {
                            for $numeroCuotas in $Loan/ns1:PaymentNumber
                            return
                            <numeroCuotas>{fn:data($numeroCuotas)}</numeroCuotas>
                        }
                        {
                            for $numeroPrestamo in $Loan/ns1:Number
                            return
                            <numeroPrestamo>{fn:data($numeroPrestamo)}</numeroPrestamo>
                        }
                        {
                            for $numerocontrato in $Loan/ns1:ContractNumber
                            return
                            <numerocontrato>{fn:data($numerocontrato)}</numerocontrato>
                        }
                        {
                            for $otrosCargos in $Loan/ns1:OtherCharges
                            return
                            <otrosCargos>{fn:data($otrosCargos)}</otrosCargos>
                        }
                        {
                            for $plazo in $Loan/ns1:Term
                            return
                            <plazo>{fn:data($plazo)}</plazo>
                        }
                        {
                            for $primaMensual in $Loan/ns1:MonthlyPrime
                            return
                            <primaMensual>{fn:data($primaMensual)}</primaMensual>
                        }
                        {
                            for $saldoActual in $Loan/ns1:CurrentBalance
                            return
                            <saldoActual>{fn:data($saldoActual)}</saldoActual>
                        }
                        {
                            for $seguros in $Loan/ns1:Insurance
                            return
                            <seguros>{fn:data($seguros)}</seguros>
                        }
                        {
                            for $tasa in $Loan/ns1:Rate
                            return
                            <tasa>{fn:data($tasa)}</tasa>
                        }
                        {
                            for $tipoDeudor in $Loan/ns1:DebtorType
                            return
                            <tipoDeudor>{fn:data($tipoDeudor)}</tipoDeudor>
                        }
                        {
                            for $valorCuota in $Loan/ns1:PaymentAmount
                            return
                            <valorCuota>{fn:data($valorCuota)}</valorCuota>
                        }
                    </prestamo>
                )
            }
            {
                for $ReferencesBureauSirc in $getCreditOffersRequest/ns1:LoanOriginations/ns1:ReferencesDetails/ns1:ReferencesBureauSirc/ns1:Reference
                return(
                    <referenciasSirc>
                        {
                            for $capitalOriginal in $ReferencesBureauSirc/ns1:Amount
                            return
                            <capitalOriginal>{fn:data($capitalOriginal)}</capitalOriginal>
                        }
                        {
                            for $categoria in $ReferencesBureauSirc/ns1:Category
                            return
                            <categoria>{fn:data($categoria)}</categoria>
                        }
                        {
                            for $comportamiento in $ReferencesBureauSirc/ns1:HistoricalArrear
                            return
                            <comportamiento>{fn:data($comportamiento)}</comportamiento>
                        }
                        {
                            for $entidad in $ReferencesBureauSirc/ns1:Creditor
                            return
                            <entidad>{fn:data($entidad)}</entidad>
                        }
                        {
                            for $estadoCredito in $ReferencesBureauSirc/ns1:Status
                            return
                            <estadoCredito>{fn:data($estadoCredito)}</estadoCredito>
                        }
                        {
                            for $fechaActivo in $ReferencesBureauSirc/ns1:OpeningDate
                            return
                            if(fn:string($fechaActivo/text()) != "") then (
                                <fechaActivo>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaActivo))}</fechaActivo>
                            ) else ()
                        }
                        {
                            for $fechaCancelacion in $ReferencesBureauSirc/ns1:CancelationDate
                            return
                            if(fn:string($fechaCancelacion/text()) != "") then (
                                <fechaCancelacion>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaCancelacion))}</fechaCancelacion>
                            ) else ()
                        }
                        {
                            for $fechaConcesion in $ReferencesBureauSirc/ns1:ConsessionDate
                            return
                            if(fn:string($fechaConcesion/text()) != "") then (
                                <fechaConcesion>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaConcesion))}</fechaConcesion>
                            ) else ()
                        }
                        {
                            for $fechaVencimiento in $ReferencesBureauSirc/ns1:ExpirationDate
                            return
                            if(fn:string($fechaVencimiento/text()) != "") then (
                                <fechaVencimiento>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaVencimiento))}</fechaVencimiento>
                            ) else ()
                        }
                        {
                            for $moneda in $ReferencesBureauSirc/ns1:Currency
                            return
                            <moneda>{fn:data($moneda)}</moneda>
                        }
                        {
                            for $numeroEvaluacionSirc in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:EvaluationNumberSirc
                            return
                            <numeroEvaluacionSirc>{fn:data($numeroEvaluacionSirc)}</numeroEvaluacionSirc>
                        }
                        {
                            for $saldoCapital in $ReferencesBureauSirc/ns1:Balance
                            return
                            <saldoCapital>{fn:data($saldoCapital)}</saldoCapital>
                        }
                        {
                            for $tipoActivo in $ReferencesBureauSirc/ns1:AsssetType
                            return
                            <tipoActivo>{fn:data($tipoActivo)}</tipoActivo>
                        }
                        {
                            for $tipoGarantia in $ReferencesBureauSirc/ns1:WarrantyType
                            return
                            <tipoGarantia>{fn:data($tipoGarantia)}</tipoGarantia>
                        }
                        {
                            for $tipoReferencia in $ReferencesBureauSirc/ns1:Type
                            return
                            <tipoReferencia>{fn:data($tipoReferencia)}</tipoReferencia>
                        }
                        {
                            for $vencido in $ReferencesBureauSirc/ns1:DueBalance
                            return
                            <vencido>{fn:data($vencido)}</vencido>
                        }
                    </referenciasSirc>
                )
            }
            {
                for $ReferenceBureauTuca in $getCreditOffersRequest/ns1:LoanOriginations/ns1:ReferencesDetails/ns1:ReferenceBureauTuca/ns1:Reference
                return(
                    <referenciasTuca>
                        {
                            for $calificacion in $ReferenceBureauTuca/ns1:Category
                            return
                            <calificacion>{fn:data($calificacion)}</calificacion>
                        }
                        {
                            for $codigoObligacion in $ReferenceBureauTuca/ns1:ObligationCode
                            return
                            <codigoObligacion>{fn:data($codigoObligacion)}</codigoObligacion>
                        }
                        {
                            for $comportamiento in $ReferenceBureauTuca/ns1:HistoricalArrear
                            return
                            <comportamiento>{fn:data($comportamiento)}</comportamiento>
                        }
                        {
                            for $cuota in $ReferenceBureauTuca/ns1:Installment
                            return
                            <cuota>{fn:data($cuota)}</cuota>
                        }
                        {
                            for $entidad in $ReferenceBureauTuca/ns1:Creditor
                            return
                            <entidad>{fn:data($entidad)}</entidad>
                        }
                        {
                            for $estadoCredito in $ReferenceBureauTuca/ns1:CreditStatus
                            return
                            <estadoCredito>{fn:data($estadoCredito)}</estadoCredito>
                        }
                        {
                            for $estatus in $ReferenceBureauTuca/ns1:Status
                            return
                            <estatus>{fn:data($estatus)}</estatus>
                        }
                        {
                            for $externalScore in $ReferenceBureauTuca/ns1:ExternalScore
                            return
                            <externalScore>{fn:data($externalScore)}</externalScore>
                        }
                        {
                            for $fechaActualizacion in $ReferenceBureauTuca/ns1:InformationDate
                            return
                            if(fn:string($fechaActualizacion/text()) != "") then (
                                <fechaActualizacion>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaActualizacion))}</fechaActualizacion>
                            ) else ()
                        }
                        {
                            for $fechaApertura in $ReferenceBureauTuca/ns1:OpeningDate
                            return
                            if(fn:string($fechaApertura/text()) != "") then (
                                <fechaApertura>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaApertura))}</fechaApertura>
                            ) else ()
                        }
                        {
                            for $fechaVencimiento in $ReferenceBureauTuca/ns1:CancelationDate
                            return
                            if(fn:string($fechaVencimiento/text()) != "") then (
                                <fechaVencimiento>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaVencimiento))}</fechaVencimiento>
                            ) else ()
                        }
                        {
                            for $IDEvaluacion in $ReferenceBureauTuca/ns1:ReferenceNumber
                            return
                            <IDEvaluacion>{fn:data($IDEvaluacion)}</IDEvaluacion>
                        }
                        {
                            for $limiteCredito in $ReferenceBureauTuca/ns1:Limit
                            return
                            <limiteCredito>{fn:data($limiteCredito)}</limiteCredito>
                        }
                        {
                            for $moneda in $ReferenceBureauTuca/ns1:Currency
                            return
                            <moneda>{fn:data($moneda)}</moneda>
                        }
                        {
                            for $numeroEvaluacionTuca in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:EvaluationNumberTuca
                            return
                            <numeroEvaluacionTuca>{fn:data($numeroEvaluacionTuca)}</numeroEvaluacionTuca>
                        }
                        {
                            for $periodo in $ReferenceBureauTuca/ns1:Period
                            return
                            <periodo>{fn:data($periodo)}</periodo>
                        }
                        {
                            for $saldoActual in $ReferenceBureauTuca/ns1:Balance
                            return
                            <saldoActual>{fn:data($saldoActual)}</saldoActual>
                        }
                        {
                            for $saldoCastigo in $ReferenceBureauTuca/ns1:PunishedBalance
                            return
                            <saldoCastigo>{fn:data($saldoCastigo)}</saldoCastigo>
                        }
                        {
                            for $saldoEjecucion in $ReferenceBureauTuca/ns1:InExecution
                            return
                            <saldoEjecucion>{fn:data($saldoEjecucion)}</saldoEjecucion>
                        }
                        {
                            for $saldoMora in $ReferenceBureauTuca/ns1:ArrearBalance
                            return
                            <saldoMora>{fn:data($saldoMora)}</saldoMora>
                        }
                        {
                            for $saldoVencido in $ReferenceBureauTuca/ns1:DueBalance
                            return
                            <saldoVencido>{fn:data($saldoVencido)}</saldoVencido>
                        }
                        {
                            for $sectorObligacion in $ReferenceBureauTuca/ns1:ObligationSector
                            return
                            <sectorObligacion>{fn:data($sectorObligacion)}</sectorObligacion>
                        }
                        {
                            for $tipoActivo in $ReferenceBureauTuca/ns1:CreditType
                            return
                            <tipoActivo>{fn:data($tipoActivo)}</tipoActivo>
                        }
                        {
                            for $tipoGarantia in $ReferenceBureauTuca/ns1:GuaranteeType
                            return
                            <tipoGarantia>{fn:data($tipoGarantia)}</tipoGarantia>
                        }
                        {
                            for $tipoObligacion in $ReferenceBureauTuca/ns1:ObligationType
                            return
                            <tipoObligacion>{fn:data($tipoObligacion)}</tipoObligacion>
                        }
                        {
                            for $tipoReferencia in $ReferenceBureauTuca/ns1:Type
                            return
                            <tipoReferencia>{fn:data($tipoReferencia)}</tipoReferencia>
                        }
                        {
                            for $ultMovAnio in $ReferenceBureauTuca/ns1:LastMovementYear
                            return
                            <ultMovAnio>{fn:data($ultMovAnio)}</ultMovAnio>
                        }
                        {
                            for $ultMovMes in $ReferenceBureauTuca/ns1:LastMovementMonth
                            return
                            <ultMovMes>{fn:data($ultMovMes)}</ultMovMes>
                        }
                    </referenciasTuca>
                )
            }
            {
                for $salarioBuro in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:TotalSalary
                return
                <salarioBuro>{fn:data($salarioBuro)}</salarioBuro>
            }
            {
                for $salarioNeto in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:NetSalary
                return
                <salarioNeto>{fn:data($getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:NetSalary)}</salarioNeto>
            }
            {
                for $scoreBuro in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:ExternalScore
                return
                <scoreBuro>{fn:data($scoreBuro)}</scoreBuro>
            }
            {
                for $CreditCard in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:Liabilities/ns1:CreditCardsInfo/ns1:CreditCard
                return(
                    <tarjeta>
                        {
                            for $behaviorScore in $CreditCard/ns1:BehaviorScore
                            return
                            <behaviorScore>{fn:data($behaviorScore)}</behaviorScore>
                        }
                        {
                            for $bloqueoPlastico in $CreditCard/ns1:PlasticBlockCode
                            return
                            <bloqueoPlastico>{fn:data($bloqueoPlastico)}</bloqueoPlastico>
                        }
                        {
                            for $calificacionScore in $CreditCard/ns1:QualificationScore
                            return
                            <calificacionScore>{fn:data($calificacionScore)}</calificacionScore>
                        }
                        {
                            for $calificacionScoreCliente in $CreditCard/ns1:QualificationCustomerScore
                            return
                            <calificacionScoreCliente>{fn:data($calificacionScoreCliente)}</calificacionScoreCliente>
                        }
                        {
                            for $cashSaneado in $CreditCard/ns1:ChargeOffCash
                            return
                            <cashSaneado>{fn:data($cashSaneado)}</cashSaneado>
                        }
                        {
                            for $codbloqueo1 in $CreditCard/ns1:LockCode1
                            return
                            <codbloqueo1>{fn:data($codbloqueo1)}</codbloqueo1>
                        }
                        {
                            for $codbloqueo2 in $CreditCard/ns1:LockCode2
                            return
                            <codbloqueo2>{fn:data($codbloqueo2)}</codbloqueo2>
                        }
                        {
                            for $diponibleCompras in $CreditCard/ns1:AvailableCash
                            return
                            <diponibleCompras>{fn:data($diponibleCompras)}</diponibleCompras>
                        }
                        {
                            for $estado in $CreditCard/ns1:Status
                            return
                            <estado>{fn:data($estado)}</estado>
                        }
                        {
                            for $estadoSaneado in $CreditCard/ns1:ChargeOffStatus
                            return
                            <estadoSaneado>{fn:data($estadoSaneado)}</estadoSaneado>
                        }
                        {
                            for $fechaApertura in $CreditCard/ns1:OpeningDate
                            return
                            <fechaApertura>{fn:data($fechaApertura)}</fechaApertura>
                        }
                        {
                            for $fechaBloqueo1 in $CreditCard/ns1:LockDate1
                            return
                            if(fn:string($fechaBloqueo1/text()) != "") then (
                                <fechaBloqueo1>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaBloqueo1))}</fechaBloqueo1>
                            ) else ()
                        }
                        {
                            for $fechaBloqueo2 in $CreditCard/ns1:LockDate2
                            return
                            if(fn:string($fechaBloqueo2/text()) != "") then (
                                <fechaBloqueo2>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaBloqueo2))}</fechaBloqueo2>
                            ) else ()
                        }
                        {
                            for $fechaLimite in $CreditCard/ns1:LimitDate
                            return
                            if(fn:string($fechaLimite/text()) != "") then (
                                <fechaLimite>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaLimite))}</fechaLimite>
                            ) else ()
                        }
                        {
                            for $fechaMaximaPago in $CreditCard/ns1:MaxPaymentDate
                            return
                            if(fn:string($fechaMaximaPago/text()) != "") then (
                                <fechaMaximaPago>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaMaximaPago))}</fechaMaximaPago>
                            ) else ()
                        }
                        {
                            for $fechaSaneado in $CreditCard/ns1:ChargeOffDate
                            return
                            if(fn:string($fechaSaneado/text()) != "") then (
                                <fechaSaneado>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaSaneado))}</fechaSaneado>
                            ) else ()
                        }
                        {
                            for $fechaUltimoAdelanto in $CreditCard/ns1:LastWithdrawalDate
                            return
                            if(fn:string($fechaUltimoAdelanto/text()) != "") then (
                                <fechaUltimoAdelanto>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaUltimoAdelanto))}</fechaUltimoAdelanto>
                            ) else ()
                        }
                        {
                            for $fechaUltimoConsumo in $CreditCard/ns1:LastPurchaseDate
                            return
                            if(fn:string($fechaUltimoConsumo/text()) != "") then (
                                <fechaUltimoConsumo>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaUltimoConsumo))}</fechaUltimoConsumo>
                            ) else ()
                        }
                        {
                            for $fechaUltimoLimite in $CreditCard/ns1:LastLimitDate
                            return
                            if(fn:string($fechaUltimoLimite/text()) != "") then (
                                <fechaUltimoLimite>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaUltimoLimite))}</fechaUltimoLimite>
                            ) else ()
                        }
                        {
                            for $fechaUltimoPago in $CreditCard/ns1:LastPaymentDate
                            return
                            if(fn:string($fechaUltimoPago/text()) != "") then (
                                <fechaUltimoPago>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaUltimoPago))}</fechaUltimoPago>
                            ) else ()
                        }
                        {
                            for $Negotiation in $CreditCard/ns1:Negotiations/ns1:Negotiation
                            return(
                                <gestiones>
                                    {
                                        for $estadoGestion in $Negotiation/ns1:NegotiationStatus
                                        return
                                        <estadoGestion>{fn:data($estadoGestion)}</estadoGestion>
                                    }
                                    {
                                        for $etapa in $Negotiation/ns1:NegotiationStage
                                        return
                                        <etapa>{fn:data($etapa)}</etapa>
                                    }
                                    {
                                        for $fechaFinalizacion in $Negotiation/ns1:NegotiationEndDate
                                        return
                                        if(fn:string($fechaFinalizacion/text()) != "") then (
                                            <fechaFinalizacion>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaFinalizacion))}</fechaFinalizacion>
                                        ) else ()
                                    }
                                    {
                                        for $fechaGestion in $Negotiation/ns1:NegotiationDate
                                        return
                                        if(fn:string($fechaGestion/text()) != "") then (
                                            <fechaGestion>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fechaGestion))}</fechaGestion>
                                        ) else ()
                                    }
                                    {
                                        for $flujo in $Negotiation/ns1:NegotiationFlow
                                        return
                                        <flujo>{fn:data($flujo)}</flujo>
                                    }
                                    {
                                        for $logoActual in $Negotiation/ns1:NegotiationActualLogo
                                        return
                                        <logoActual>{fn:data($logoActual)}</logoActual>
                                    }
                                    {
                                        for $motivoGestion in $Negotiation/ns1:NegotiationReason
                                        return
                                        <motivoGestion>{fn:data($motivoGestion)}</motivoGestion>
                                    }
                                    {
                                        for $nombreGestion in $Negotiation/ns1:NegotiationName
                                        return
                                        <nombreGestion>{fn:data($nombreGestion)}</nombreGestion>
                                    }
                                    {
                                        for $numGestion in $Negotiation/ns1:NegotiationNumber
                                        return
                                        <numGestion>{fn:data($numGestion)}</numGestion>
                                    }
                                    {
                                        for $numeroCuenta in $Negotiation/ns1:Account
                                        return
                                        <numeroCuenta>{fn:data($numeroCuenta)}</numeroCuenta>
                                    }
                                </gestiones>
                            )
                        }
                        {
                            for $limite in $CreditCard/ns1:CurrentLimit
                            return
                            <limite>{fn:data($limite)}</limite>
                        }
                        {
                            for $limitePrevio in $CreditCard/ns1:PriorLimit
                            return
                            <limitePrevio>{fn:data($limitePrevio)}</limitePrevio>
                        }
                        {
                            for $logo in $CreditCard/ns1:Logo
                            return
                            <logo>{fn:data($logo)}</logo>
                        }
                        {
                            for $miscUser3 in $CreditCard/ns1:MiscUser3
                            return
                            <miscUser3>{fn:data($miscUser3)}</miscUser3>
                        }
                        {
                            for $moraActual in $CreditCard/ns1:CurrentDue
                            return
                            <moraActual>{fn:data($moraActual)}</moraActual>
                        }
                        {
                            for $morosidadVida120 in $CreditCard/ns1:Pmt120Days
                            return
                            <morosidadVida120>{fn:data($morosidadVida120)}</morosidadVida120>
                        }
                        {
                            for $morosidadVida150 in $CreditCard/ns1:Pmt150Days
                            return
                            <morosidadVida150>{fn:data($morosidadVida150)}</morosidadVida150>
                        }
                        {
                            for $morosidadVida180 in $CreditCard/ns1:Pmt180Days
                            return
                            <morosidadVida180>{fn:data($morosidadVida180)}</morosidadVida180>
                        }
                        {
                            for $morosidadVida210 in $CreditCard/ns1:Pmt210Days
                            return
                            <morosidadVida210>{fn:data($morosidadVida210)}</morosidadVida210>
                        }
                        {
                            for $morosidadVida29 in $CreditCard/ns1:Pmt29Days
                            return
                            <morosidadVida29>{fn:data($morosidadVida29)}</morosidadVida29>
                        }
                        {
                            for $morosidadVida30 in $CreditCard/ns1:Pmt30Days
                            return
                            <morosidadVida30>{fn:data($morosidadVida30)}</morosidadVida30>
                        }
                        {
                            for $morosidadVida60 in $CreditCard/ns1:Pmt60Days
                            return
                            <morosidadVida60>{fn:data($morosidadVida60)}</morosidadVida60>
                        }
                        {
                            for $morosidadVida90 in $CreditCard/ns1:Pmt90Days
                            return
                            <morosidadVida90>{fn:data($morosidadVida90)}</morosidadVida90>
                        }
                        {
                            for $numeroCuenta in $CreditCard/ns1:Account
                            return
                            <numeroCuenta>{fn:data($numeroCuenta)}</numeroCuenta>
                        }
                        {
                            for $ofertaExtra in $CreditCard/ns1:ExtraOffer
                            return
                            <ofertaExtra>{fn:data($ofertaExtra)}</ofertaExtra>
                        }
                        {
                            for $ofertaPilTurbo in $CreditCard/ns1:PilTurboOffer
                            return
                            <ofertaPilTurbo>{fn:data($ofertaPilTurbo)}</ofertaPilTurbo>
                        }
                        {
                            for $ofertaSegundaCuenta in $CreditCard/ns1:SecondAccountOffer
                            return
                            <ofertaSegundaCuenta>{fn:data($ofertaSegundaCuenta)}</ofertaSegundaCuenta>
                        }
                        {
                            for $org in $CreditCard/ns1:Org
                            return
                            <org>{fn:data($org)}</org>
                        }
                        {
                            for $Plan in $CreditCard/ns1:CreditPlans/ns1:Plan
                            return(
                                <planesTarjeta>
                                    {
                                        for $balanceActual in $Plan/ns1:ActualBalance
                                        return
                                        <balanceActual>{fn:data($balanceActual)}</balanceActual>
                                    }
                                    {
                                        for $balanceInicial in $Plan/ns1:InitialBalance
                                        return
                                        <balanceInicial>{fn:data($balanceInicial)}</balanceInicial>
                                    }
                                    {
                                        for $balancePrin in $Plan/ns1:ActualBalance
                                        return
                                        <balancePrin>{fn:data($balancePrin)}</balancePrin>
                                    }
                                    {
                                        for $collBnp in $Plan/ns1:CollectionFees
                                        return
                                        <collBnp>{fn:data($collBnp)}</collBnp>
                                    }
                                    {
                                        for $cuenta in $Plan/ns1:Account
                                        return
                                        <cuenta>{fn:data($cuenta)}</cuenta>
                                    }
                                    {
                                        for $fecPlan in $Plan/ns1:PlanDate
                                        return
                                        if(fn:string($fecPlan/text()) != "") then (
                                            <fecPlan>{fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($fecPlan))}</fecPlan>
                                        ) else ()
                                    }
                                    {
                                        for $fxdPmtAmt in $Plan/ns1:PlanInstallment
                                        return
                                        <fxdPmtAmt>{fn:data($fxdPmtAmt)}</fxdPmtAmt>
                                    }
                                    {
                                        for $insBnp in $Plan/ns1:Insurance
                                        return
                                        <insBnp>{fn:data($insBnp)}</insBnp>
                                    }
                                    {
                                        for $intRate in $Plan/ns1:Interest
                                        return
                                        <intBnp>{fn:data($intRate)}</intBnp>
                                    }
                                    {
                                        for $intRate in $Plan/ns1:PlanRate
                                        return
                                        <intRate>{fn:data($intRate)}</intRate>
                                    }
                                    {
                                        for $lateChgBnp in $Plan/ns1:LateChargeBnp
                                        return
                                        <lateChgBnp>{fn:data($lateChgBnp)}</lateChgBnp>
                                    }
                                    {
                                        for $loanPlanInd in $Plan/ns1:PlanIndicador
                                        return
                                        <loanPlanInd>{fn:data($loanPlanInd)}</loanPlanInd>
                                    }
                                    {
                                        for $logo in $Plan/ns1:Logo
                                        return
                                        <logo>{fn:data($logo)}</logo>
                                    }
                                    {
                                        for $memberBnp in $Plan/ns1:AnualFees
                                        return
                                        <memberBnp>{fn:data($memberBnp)}</memberBnp>
                                    }
                                    {
                                        for $nsfBnp in $Plan/ns1:NsfFees
                                        return
                                        <nsfBnp>{fn:data($nsfBnp)}</nsfBnp>
                                    }
                                    {
                                        for $numPlan in $Plan/ns1:PlanNumber
                                        return
                                        <numPlan>{fn:data($numPlan)}</numPlan>
                                    }
                                    {
                                        for $org in $Plan/ns1:Org
                                        return
                                        <org>{fn:data($org)}</org>
                                    }
                                    {
                                        for $ovlmBnp in $Plan/ns1:OverlimitFees
                                        return
                                        <ovlmBnp>{fn:data($ovlmBnp)}</ovlmBnp>
                                    }
                                    {
                                        for $planStatus in $Plan/ns1:PlanStatus
                                        return
                                        <planStatus>{fn:data($planStatus)}</planStatus>
                                    }
                                    {
                                        for $recvBnp in $Plan/ns1:RecoveryFees
                                        return
                                        <recvBnp>{fn:data($recvBnp)}</recvBnp>
                                    }
                                    {
                                        for $svcBnp in $Plan/ns1:ServiceCharges
                                        return
                                        <svcBnp>{fn:data($svcBnp)}</svcBnp>
                                    }
                                    {
                                        for $tipoCambio in $Plan/ns1:ChangeFactor
                                        return
                                        <tipoCambio>{fn:data($tipoCambio)}</tipoCambio>
                                    }
                                    {
                                        for $tipoPlan in $Plan/ns1:PlanType
                                        return
                                        <tipoPlan>{fn:data($tipoPlan)}</tipoPlan>
                                    }
                                    {
                                        for $user1Bnp in $Plan/ns1:User1Bnp
                                        return
                                        <user1Bnp>{fn:data($user1Bnp)}</user1Bnp>
                                    }
                                    {
                                        for $user2Bnp in $Plan/ns1:User2Bnp
                                        return
                                        <user2Bnp>{fn:data($user2Bnp)}</user2Bnp>
                                    }
                                    {
                                        for $user3Bnp in $Plan/ns1:User3Bnp
                                        return
                                        <user3Bnp>{fn:data($user3Bnp)}</user3Bnp>
                                    }
                                    {
                                        for $user4Bnp in $Plan/ns1:User4Bnp
                                        return
                                        <user4Bnp>{fn:data($user4Bnp)}</user4Bnp>
                                    }
                                    {
                                        for $user5Bnp in $Plan/ns1:User5Bnp
                                        return
                                        <user5Bnp>{fn:data($user5Bnp)}</user5Bnp>
                                    }
                                    {
                                        for $user6Bnp in $Plan/ns1:User6Bnp
                                        return
                                        <user6Bnp>{fn:data($user6Bnp)}</user6Bnp>
                                    }
                                </planesTarjeta>
                            )
                        }
                        {
                            for $rechazos in $CreditCard/ns1:ResolutionTc
                            return
                            <rechazos>{fn:data($rechazos)}</rechazos>
                        }
                        {
                            for $rechazosPilTurbo in $CreditCard/ns1:ResolutionPilTurbo
                            return
                            <rechazosPilTurbo>{fn:data($rechazosPilTurbo)}</rechazosPilTurbo>
                        }
                        {
                            for $saldoActual in $CreditCard/ns1:CurrentBalance
                            return
                            <saldoActual>{fn:data($saldoActual)}</saldoActual>
                        }
                        {
                            for $saldoCorte in $CreditCard/ns1:ClosingBalance
                            return
                            <saldoCorte>{fn:data($saldoCorte)}</saldoCorte>
                        }
                        {
                            for $saldoSaneado in $CreditCard/ns1:ChargeOffBalance
                            return
                            <saldoSaneado>{fn:data($saldoSaneado)}</saldoSaneado>
                        }
                        {
                            for $saldoTotal in $CreditCard/ns1:TotalBalance
                            return
                            <saldoTotal>{fn:data($saldoTotal)}</saldoTotal>
                        }
                        {
                            for $stateIssue in $CreditCard/ns1:StateIssue
                            return
                            <stateIssue>{fn:data($stateIssue)}</stateIssue>
                        }
                        {
                            for $tasaExtra in $CreditCard/ns1:ExtraRate
                            return
                            <tasaExtra>{fn:data($tasaExtra)}</tasaExtra>
                        }
                        {
                            for $tasaPilTurbo in $CreditCard/ns1:PilTurboRate
                            return
                            <tasaPilTurbo>{fn:data($tasaPilTurbo)}</tasaPilTurbo>
                        }
                    </tarjeta>
                )
            }
            {
                for $tiempoResidenciaActual in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:ResidenceTime
                return
                <tiempoResidenciaActual>{fn:data($tiempoResidenciaActual)}</tiempoResidenciaActual>
            }
            {
                for $tipoCambio in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:ExchangeFactor
                return
                <tipoCambio>{fn:data($tipoCambio)}</tipoCambio>
            }
            {
                for $tipoCliente in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:Type
                return
                <tipoCliente>{fn:data($tipoCliente)}</tipoCliente>
            }
            {
                for $tipoEmpleo in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:JobCompany
                return
                <tipoEmpleo>{fn:data($tipoEmpleo)}</tipoEmpleo>
            }
            {
                for $tipoIdentificacion in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:IdType
                return
                <tipoIdentificacion>{fn:data($tipoIdentificacion)}</tipoIdentificacion>
            }
            {
                for $tipoTrabajo in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:JobType
                return
                <tipoTrabajo>{fn:data($tipoTrabajo)}</tipoTrabajo>
            }
            {
                for $tipodeVivienda in $getCreditOffersRequest/ns1:LoanMaintenace/ns1:CustomerInfo/ns1:ResidenceType
                return
                <tipodeVivienda>{fn:data($tipodeVivienda)}</tipodeVivienda>
            }
        </arg0>
    </ns2:epOriginacionesGuatemala>
};

local:func($getCreditOffersRequest)
