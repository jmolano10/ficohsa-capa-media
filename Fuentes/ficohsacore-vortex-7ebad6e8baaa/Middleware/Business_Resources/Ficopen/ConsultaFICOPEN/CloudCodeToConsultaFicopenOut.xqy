xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
(:: import schema at "consultaFICOPENTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../v2/BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:cuentasRelacionesPeriodosResponse) ::) external;

declare function local:func($response as element() (:: schema-element(ns1:cuentasRelacionesPeriodosResponse) ::)) as element() (:: schema-element(ns2:consultaFICOPENResponse) ::) {
    <ns2:consultaFICOPENResponse>
	 <CUSTOMER_LEGAL_ID>{fn:data($response/ns1:datos/ns1:cuenta/ns1:numeroIdentificacionAfiliado)}</CUSTOMER_LEGAL_ID>
        <CUSTOMER_NAME>{fn:data($response/ns1:datos/ns1:cuenta/ns1:nombreCliente)}</CUSTOMER_NAME>
        <ACCOUNT_NUMBER>{fn:data($response/ns1:datos/ns1:cuenta/ns1:codigoCuenta)}</ACCOUNT_NUMBER>       
        <CONTRACT_NUMBER>{fn:data($response/ns1:datos/ns1:cuenta/ns1:numeroSolicitudVinculacion)}</CONTRACT_NUMBER>
        <CONTRACT_TYPE>{fn:data($response/ns1:datos/ns1:cuenta/ns1:lineaProducto)}</CONTRACT_TYPE>
        <COMPANY>{fn:data($response/ns1:datos/ns1:cuenta/ns1:patrocinador)}</COMPANY>
        <START_DATE>{fn:data($response/ns1:datos/ns1:cuenta/ns1:fechaAperturaCuenta)}</START_DATE>
        <ns2:consultaFICOPENResponseType>
		    {
             for $item in $response/ns1:datos/ns1:cuenta/ns1:saldosSubcuenta
             return
               <ns2:consultaFICOPENResponseRecordType>
                   <BALANCE_TYPE>{fn:data($item/ns1:subcuenta)}</BALANCE_TYPE>
                   <PREVIOUS_BALANCE>{fn:data($item/ns1:saldoInicial)}</PREVIOUS_BALANCE>
                   <GROSS_CONTRIBUTIONS_AMOUNT>{fn:data($item/ns1:aportes)}</GROSS_CONTRIBUTIONS_AMOUNT>
                   <INTEREST_AMOUNT>{fn:data($item/ns1:rendimientos)}</INTEREST_AMOUNT>
                   <WITHDRAWALS_AMOUNT>{fn:data($item/ns1:retiros)}</WITHDRAWALS_AMOUNT>
                   <FEE_AMOUNT>{fn:data($item/ns1:comisiones)}</FEE_AMOUNT>
                   <INSURANCE_AMOUNT>{fn:data($item/ns1:seguros)}</INSURANCE_AMOUNT>
                   <CURRENT_BALANCE>{fn:data($item/ns1:saldoActual)}</CURRENT_BALANCE>
               </ns2:consultaFICOPENResponseRecordType>
			}
        </ns2:consultaFICOPENResponseType>
	</ns2:consultaFICOPENResponse>
};

local:func($response)