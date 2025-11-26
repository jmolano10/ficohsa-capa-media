xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/loansTypes";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/loansTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_APERTURA_PRESTAMOS_V2/OSB_P_APERTURA_PRESTAMO_2/";
(:: import schema at "../../../../ProviderServices/XSD/CreateLoans/CreateLoan_sp.xsd " ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $createLoanRequest as element() (:: schema-element(ns2:createLoanRequest) ::) external;

declare function local:func($createLoanRequest as element() (:: schema-element(ns2:createLoanRequest) ::)) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns2:InputParameters>
        <ns3:PN_CODIGO_EMPRESA>1</ns3:PN_CODIGO_EMPRESA>
        {
            if ($createLoanRequest/ns2:AgencyCode)
            then <ns3:PN_CODIGO_AGENCIA>{fn:data($createLoanRequest/ns2:AgencyCode)}</ns3:PN_CODIGO_AGENCIA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:ProductCode)
            then <ns3:PN_CODIGO_SUB_APLICACION>{fn:data($createLoanRequest/ns2:ProductCode)}</ns3:PN_CODIGO_SUB_APLICACION>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CustomerId)
            then <ns3:PN_CODIGO_CLIENTE>{fn:data($createLoanRequest/ns2:CustomerId)}</ns3:PN_CODIGO_CLIENTE>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CustomerName)
            then <ns3:PV_NOMBRE_PRESTATARIO>{fn:data($createLoanRequest/ns2:CustomerName)}</ns3:PV_NOMBRE_PRESTATARIO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:AmortizationType)
            then <ns3:PV_CODIGO_TIPO_AMORTIZACION>{fn:data($createLoanRequest/ns2:AmortizationType)}</ns3:PV_CODIGO_TIPO_AMORTIZACION>
            else ()
        }
        {
            if ($createLoanRequest/ns2:Rate)
            then <ns3:PN_TASA>{fn:data($createLoanRequest/ns2:Rate)}</ns3:PN_TASA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:Term)
            then <ns3:PN_PLAZO>{fn:data($createLoanRequest/ns2:Term)}</ns3:PN_PLAZO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:Amount)
            then <ns3:PN_MONTO_INICIAL>{fn:data($createLoanRequest/ns2:Amount)}</ns3:PN_MONTO_INICIAL>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CalculateArrear)
            then <ns3:PV_CALCULAR_MORA>{fn:data($createLoanRequest/ns2:CalculateArrear)}</ns3:PV_CALCULAR_MORA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:ExecutiveId)
            then <ns3:PV_CODIGO_EJECUTIVO>{fn:data($createLoanRequest/ns2:ExecutiveId)}</ns3:PV_CODIGO_EJECUTIVO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:FinancialLineCode)
            then <ns3:PV_CODIGO_LINEA_FINANCIERA>{fn:data($createLoanRequest/ns2:FinancialLineCode)}</ns3:PV_CODIGO_LINEA_FINANCIERA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:PortfolioRateValueCode)
            then <ns3:PN_CODIGO_VALOR_TASA_CARTERA>{fn:data($createLoanRequest/ns2:PortfolioRateValueCode)}</ns3:PN_CODIGO_VALOR_TASA_CARTERA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:InvestmentCode)
            then <ns3:PN_CODIGO_INVERSION>{fn:data($createLoanRequest/ns2:InvestmentCode)}</ns3:PN_CODIGO_INVERSION>
            else ()
        }
        {
            if ($createLoanRequest/ns2:EconomicActivityCode)
            then <ns3:PN_CODIGO_ACTIVIDAD_ECONOMICA>{fn:data($createLoanRequest/ns2:EconomicActivityCode)}</ns3:PN_CODIGO_ACTIVIDAD_ECONOMICA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:ApprovalCode)
            then <ns3:PV_CODIGO_APROBACION>{fn:data($createLoanRequest/ns2:ApprovalCode)}</ns3:PV_CODIGO_APROBACION>
            else ()
        }
        {
            if ($createLoanRequest/ns2:LoanDestinationCode)
            then <ns3:PN_CODIGO_DESTINO>{fn:data($createLoanRequest/ns2:LoanDestinationCode)}</ns3:PN_CODIGO_DESTINO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:LoanDestinationDetailCode)
            then <ns3:PN_CODIGO_DESTINO_DETALLE>{fn:data($createLoanRequest/ns2:LoanDestinationDetailCode)}</ns3:PN_CODIGO_DESTINO_DETALLE>
            else ()
        }
        {
            if ($createLoanRequest/ns2:LoanTypeCode)
            then <ns3:PN_CODIGO_TIPO_PRESTAMO>{fn:data($createLoanRequest/ns2:LoanTypeCode)}</ns3:PN_CODIGO_TIPO_PRESTAMO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:SubinvestmentCode)
            then <ns3:PN_CODIGO_SUB_INVERSION>{fn:data($createLoanRequest/ns2:SubinvestmentCode)}</ns3:PN_CODIGO_SUB_INVERSION>
            else ()
        }
        {
            if ($createLoanRequest/ns2:PromoterCode)
            then <ns3:PV_CODIGO_PROMOTOR>{fn:data($createLoanRequest/ns2:PromoterCode)}</ns3:PV_CODIGO_PROMOTOR>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeHandling)
            then <ns3:PV_MANEJO_GARANTIAS>{fn:data($createLoanRequest/ns2:GuaranteeHandling)}</ns3:PV_MANEJO_GARANTIAS>
            else ()
        }
        {
            if ($createLoanRequest/ns2:FirstPaymentInterestDate)
            then <ns3:PD_FECHA_PRIMER_PAGO_INTERES>{fn:data($createLoanRequest/ns2:FirstPaymentInterestDate)}</ns3:PD_FECHA_PRIMER_PAGO_INTERES>
            else ()
        }
        {
            if ($createLoanRequest/ns2:FirstPaymentCapitalDate)
            then <ns3:PD_FECHA_PRIMER_PAGO_CAPITAL>{fn:data($createLoanRequest/ns2:FirstPaymentCapitalDate)}</ns3:PD_FECHA_PRIMER_PAGO_CAPITAL>
            else ()
        }
        {
            if ($createLoanRequest/ns2:InterestFrequency)
            then <ns3:PN_FRECUENCIA_INTERES>{fn:data($createLoanRequest/ns2:InterestFrequency)}</ns3:PN_FRECUENCIA_INTERES>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CapitalFrequency)
            then <ns3:PN_FRECUENCIA_CAPITAL>{fn:data($createLoanRequest/ns2:CapitalFrequency)}</ns3:PN_FRECUENCIA_CAPITAL>
            else ()
        }
        {
            if ($createLoanRequest/ns2:InterestFrequencyType)
            then <ns3:PN_TIPO_FRECUENCIA_INTERES>{fn:data($createLoanRequest/ns2:InterestFrequencyType)}</ns3:PN_TIPO_FRECUENCIA_INTERES>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CapitalFrequencyType)
            then <ns3:PN_TIPO_FRECUENCIA_CAPITAL>{fn:data($createLoanRequest/ns2:CapitalFrequencyType)}</ns3:PN_TIPO_FRECUENCIA_CAPITAL>
            else ()
        }
        {
            if ($createLoanRequest/ns2:RateType)
            then <ns3:PV_TIPO_TASA>{fn:data($createLoanRequest/ns2:RateType)}</ns3:PV_TIPO_TASA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:TotalRate)
            then <ns3:PN_TASA_TOTAL>{fn:data($createLoanRequest/ns2:TotalRate)}</ns3:PN_TASA_TOTAL>
            else ()
        }
        {
            if ($createLoanRequest/ns2:RateClass)
            then <ns3:PV_CLASE_TASA>{fn:data($createLoanRequest/ns2:RateClass)}</ns3:PV_CLASE_TASA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:ArrearGraceDays)
            then <ns3:PN_DIAS_GRACIA_MORA>{fn:data($createLoanRequest/ns2:ArrearGraceDays)}</ns3:PN_DIAS_GRACIA_MORA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:MonthlyClearingType)
            then <ns3:PV_TIPO_LIQUIDACION_MES>{fn:data($createLoanRequest/ns2:MonthlyClearingType)}</ns3:PV_TIPO_LIQUIDACION_MES>
            else ()
        }
        {
            if ($createLoanRequest/ns2:YearlyClearingType)
            then <ns3:PV_TIPO_LIQUIDACION_ANIO>{fn:data($createLoanRequest/ns2:YearlyClearingType)}</ns3:PV_TIPO_LIQUIDACION_ANIO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:ArrearRateValueCode)
            then <ns3:PN_CODIGO_VALOR_TASA_MORA>{fn:data($createLoanRequest/ns2:ArrearRateValueCode)}</ns3:PN_CODIGO_VALOR_TASA_MORA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:FundsOrigin)
            then <ns3:PN_CODIGO_ORIGEN_FONDO>{fn:data($createLoanRequest/ns2:FundsOrigin)}</ns3:PN_CODIGO_ORIGEN_FONDO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:FundsSuborigin)
            then <ns3:PN_CODIGO_SUB_ORIGEN_FONDO>{fn:data($createLoanRequest/ns2:FundsSuborigin)}</ns3:PN_CODIGO_SUB_ORIGEN_FONDO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:ObligationTypeCode)
            then <ns3:PV_CODIGO_TIPO_OBLIGACION>{fn:data($createLoanRequest/ns2:ObligationTypeCode)}</ns3:PV_CODIGO_TIPO_OBLIGACION>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CreditTypeCode)
            then <ns3:PV_CODIGO_TIPO_CREDITO>{fn:data($createLoanRequest/ns2:CreditTypeCode)}</ns3:PV_CODIGO_TIPO_CREDITO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:AgencyOriginCode)
            then <ns3:PN_AGENCIA_ORIGEN_PRESTAMO>{fn:data($createLoanRequest/ns2:AgencyOriginCode)}</ns3:PN_AGENCIA_ORIGEN_PRESTAMO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeTypeCode)
            then <ns3:PV_CODIGO_TIPO_GARANTIA>{fn:data($createLoanRequest/ns2:GuaranteeTypeCode)}</ns3:PV_CODIGO_TIPO_GARANTIA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:Inputter)
            then <ns3:PV_ADICIONADO_POR>{fn:data($createLoanRequest/ns2:Inputter)}</ns3:PV_ADICIONADO_POR>
            else ()
        }
        {
            if ($createLoanRequest/ns2:PayrollCode)
            then <ns3:PN_CODIGO_DE_PLANILLA>{fn:data($createLoanRequest/ns2:PayrollCode)}</ns3:PN_CODIGO_DE_PLANILLA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:DebitAccount)
            then <ns3:PV_CUENTA_DEBITA>{fn:data($createLoanRequest/ns2:DebitAccount)}</ns3:PV_CUENTA_DEBITA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:PaymentFrequencyType)
            then <ns3:PV_TIPO_FRECUENCIA_PAGO>{fn:data($createLoanRequest/ns2:PaymentFrequencyType)}</ns3:PV_TIPO_FRECUENCIA_PAGO>
            else ()
        }
        <ns3:PT_NUMERO_POLIZA>
            {
            for $InsuranceInfoList in $createLoanRequest/ns2:InsuranceInfoList
            return <ns3:PT_NUMERO_POLIZA_ITEM>{fn:data($InsuranceInfoList/ns2:InsurancePolicyNumber)}</ns3:PT_NUMERO_POLIZA_ITEM>
            }
        </ns3:PT_NUMERO_POLIZA>
        <ns3:PT_CODIGO_TIPO_POLIZA>
            {
            for $InsuranceInfoList in $createLoanRequest/ns2:InsuranceInfoList
            return <ns3:PT_CODIGO_TIPO_POLIZA_ITEM>{fn:data($InsuranceInfoList/ns2:InsurancePolicyType)}</ns3:PT_CODIGO_TIPO_POLIZA_ITEM>
            }
        </ns3:PT_CODIGO_TIPO_POLIZA>
        <ns3:PT_CODIGO_ASEGURADORA>
            {
            for $InsuranceInfoList in $createLoanRequest/ns2:InsuranceInfoList
            return <ns3:PT_CODIGO_ASEGURADORA_ITEM>{fn:data($InsuranceInfoList/ns2:InsuranceCompanyCode)}</ns3:PT_CODIGO_ASEGURADORA_ITEM>
            }
        </ns3:PT_CODIGO_ASEGURADORA>
        <ns3:PT_PRIMA_MENSUAL>
            {
            for $InsuranceInfoList in $createLoanRequest/ns2:InsuranceInfoList
            return <ns3:PT_PRIMA_MENSUAL_ITEM>{fn:data($InsuranceInfoList/ns2:MonthlyPrime)}</ns3:PT_PRIMA_MENSUAL_ITEM>
            }
        </ns3:PT_PRIMA_MENSUAL>
        <ns3:PT_PRIMA_ANUAL>
            {
            for $InsuranceInfoList in $createLoanRequest/ns2:InsuranceInfoList
            return <ns3:PT_PRIMA_MENSUAL_ITEM>{fn:data($InsuranceInfoList/ns2:YearlyPrime)}</ns3:PT_PRIMA_MENSUAL_ITEM>
            }
        </ns3:PT_PRIMA_ANUAL>
        <ns3:PT_FECHA_FINAL_SEG>
            {
            for $InsuranceInfoList in $createLoanRequest/ns2:InsuranceInfoList
            return <ns3:PT_FECHA_FINAL_SEG_ITEM>{fn:data($InsuranceInfoList/ns2:InsuranceEndDate)}</ns3:PT_FECHA_FINAL_SEG_ITEM>
            }
        </ns3:PT_FECHA_FINAL_SEG>
        <ns3:PT_COBERTURA_POLIZA>
            {
            for $InsuranceInfoList in $createLoanRequest/ns2:InsuranceInfoList
            return <ns3:PT_PRIMA_MENSUAL_ITEM>{fn:data($InsuranceInfoList/ns2:InsuranceCoverageAmount)}</ns3:PT_PRIMA_MENSUAL_ITEM>
            }
        </ns3:PT_COBERTURA_POLIZA>
        {
            if ($createLoanRequest/ns2:AgencyCode)
            then <ns3:PN_AGENCIA_GARANTIA>{fn:data($createLoanRequest/ns2:AgencyCode)}</ns3:PN_AGENCIA_GARANTIA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:ProductCode)
            then <ns3:PN_COD_SUBAPL_GARANTIA>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:ProductCode)}</ns3:PN_COD_SUBAPL_GARANTIA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:AppraisalValue)
            then <ns3:PN_VALOR_AVALUO>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:AppraisalValue)}</ns3:PN_VALOR_AVALUO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:CreditValue)
            then <ns3:PN_VALOR_CREDITICIO>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:CreditValue)}</ns3:PN_VALOR_CREDITICIO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:Amount)
            then <ns3:PN_MONTO_MONEDA_LOCAL>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:Amount)}</ns3:PN_MONTO_MONEDA_LOCAL>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:CoveragePercentage)
            then <ns3:PN_PORCENTAJE_COBERTURA>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:CoveragePercentage)}</ns3:PN_PORCENTAJE_COBERTURA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:TypeCode)
            then <ns3:PN_TIPO_GARANTIA>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:TypeCode)}</ns3:PN_TIPO_GARANTIA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:Description)
            then <ns3:PV_DESCRIPCION_GARANTIA>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:Description)}</ns3:PV_DESCRIPCION_GARANTIA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:PrimeAmount)
            then <ns3:PN_PRIMA>{fn:data($createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:PrimeAmount)}</ns3:PN_PRIMA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CreditTypeCode)
            then <ns3:PV_TIPO_CREDITO>{fn:data($createLoanRequest/ns2:CreditTypeCode)}</ns3:PV_TIPO_CREDITO>
            else ()
        }
        <ns3:PT_ID_CODEUDOR>
            {
            for $CodebtorsList in $createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:CodebtorsList
            return <ns3:PT_ID_CODEUDOR_ITEM>{fn:data($CodebtorsList/ns2:CustomerId)}</ns3:PT_ID_CODEUDOR_ITEM>
            }
        </ns3:PT_ID_CODEUDOR>
        <ns3:PT_NAME_CODEUDOR>
            {
            for $CodebtorsList in $createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:CodebtorsList
            return <ns3:PT_NAME_CODEUDOR_ITEM>{fn:data($CodebtorsList/ns2:Name)}</ns3:PT_NAME_CODEUDOR_ITEM>
            }
        </ns3:PT_NAME_CODEUDOR>
        <ns3:PT_ID_FIADOR>
            {
            for $GuarantorsList in $createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:GuarantorsList
            return <ns3:PT_ID_CODEUDOR_ITEM>{fn:data($GuarantorsList/ns2:CustomerId)}</ns3:PT_ID_CODEUDOR_ITEM>
            }
        </ns3:PT_ID_FIADOR>
        <ns3:PT_NAME_FIADOR>
            {
            for $GuarantorsList in $createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:GuarantorsList
            return <ns3:PT_NAME_CODEUDOR_ITEM>{fn:data($GuarantorsList/ns2:Name)}</ns3:PT_NAME_CODEUDOR_ITEM>
            }
        </ns3:PT_NAME_FIADOR>
        <ns3:PT_NOMBRE_ITEM_FAUTO>
            {
            for $AdditionalInfoList in $createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:AdditionalInfoList
            return <ns3:PT_NOMBRE_ITEM_FAUTO_ITEM>{fn:data($AdditionalInfoList/ns2:KeyValue)}</ns3:PT_NOMBRE_ITEM_FAUTO_ITEM>
            }
        </ns3:PT_NOMBRE_ITEM_FAUTO>
        <ns3:PT_VALOR_ITEM_FAUTO>
            {
            for $AdditionalInfoList in $createLoanRequest/ns2:GuaranteeInfoList[1]/ns2:AdditionalInfoList
            return <ns3:PT_VALOR_ITEM_FAUTO_ITEM>{fn:data($AdditionalInfoList/ns2:Value)}</ns3:PT_VALOR_ITEM_FAUTO_ITEM>
            }
        </ns3:PT_VALOR_ITEM_FAUTO>
        {
            if ($createLoanRequest/ns2:CategoriaRAS/ns2:DeptCode)
            then <ns3:PV_CODIGO_DEPTO>{fn:data($createLoanRequest/ns2:CategoriaRAS/ns2:DeptCode)}</ns3:PV_CODIGO_DEPTO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CategoriaRAS/ns2:MunicipalityCode)
            then <ns3:PV_CODIGO_MUNICIPIO>{fn:data($createLoanRequest/ns2:CategoriaRAS/ns2:MunicipalityCode)}</ns3:PV_CODIGO_MUNICIPIO>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CategoriaRAS/ns2:VillagueCode)
            then <ns3:PV_CODIGO_ALDEA>{fn:data($createLoanRequest/ns2:CategoriaRAS/ns2:VillagueCode)}</ns3:PV_CODIGO_ALDEA>
            else ()
        }
        {
            if ($createLoanRequest/ns2:CategoriaRAS/ns2:CategoryRAS)
            then <ns3:PV_CATEGORIA_RAS>{fn:data($createLoanRequest/ns2:CategoriaRAS/ns2:CategoryRAS)}</ns3:PV_CATEGORIA_RAS>
            else ()
        }
        {
            if ($createLoanRequest/ns2:GeneralInfo/com:GlobalId)
            then <ns3:PV_GLOBAL_ID>{fn:data($createLoanRequest/ns2:GeneralInfo/com:GlobalId)}</ns3:PV_GLOBAL_ID>
            else ()
        }
    </ns2:InputParameters>
};

local:func($createLoanRequest)