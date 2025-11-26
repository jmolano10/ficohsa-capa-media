(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamoResponse" element="ns0:consultaGeneralPrestamoResponse" location="../../consultaGeneralPrestamo/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaSaldosPrestamoOut/";

declare function xf:consultaSaldosPrestamoOut($consultaGeneralPrestamoResponse as element(ns0:consultaGeneralPrestamoResponse))
    as element(*)* {
        let $customerName := data($consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/LOAN_CUSTOMER_NAME)
        let $moneda := data($consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/CURRENCY)
    	let $capitalCuota  := data($consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_PRINCIPAL_AMT)
    	let $interesCuota  := data($consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_INTEREST_AMT)
    	let $seguroCuota   := data($consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_INSURANCE_AMT)
    	let $interesYSegurocuota   := fn-bea:format-number(fn:round-half-to-even(number($interesCuota) + number($seguroCuota), 2),"######0.00")
    	let $totalCuota	 := data($consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_TOTAL_AMT)
    	return
    	<Prestamo>
    		<LOAN_CUSTOMER_NAME>{ $customerName }</LOAN_CUSTOMER_NAME>
    		<CURRENCY>{ $moneda }</CURRENCY>
    		<PRINCIPAL_AMOUNT>{ $capitalCuota }</PRINCIPAL_AMOUNT>
    		{
    			if (fn:string($interesYSegurocuota) != "NaN") then (
    				<INTEREST_AND_COMISSION_AMOUNT>{ $interesYSegurocuota }</INTEREST_AND_COMISSION_AMOUNT>
    			) else (
    				<INTEREST_AND_COMISSION_AMOUNT>-0.0</INTEREST_AND_COMISSION_AMOUNT>
    			)
        	}
    		<TOTAL_AMOUNT>{ $totalCuota }</TOTAL_AMOUNT>
        </Prestamo>
};

declare variable $consultaGeneralPrestamoResponse as element(ns0:consultaGeneralPrestamoResponse) external;

xf:consultaSaldosPrestamoOut($consultaGeneralPrestamoResponse)