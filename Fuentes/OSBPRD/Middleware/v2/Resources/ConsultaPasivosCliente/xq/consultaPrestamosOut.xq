xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$PrestamosInput" type="xs:anyType" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/";
declare namespace con = "ConsultaPrestamosCliente";

declare function xf:consultaPrestamosOut2($PrestamosInput as element(*))
    as element(*) {
        <Prestamos>                
	        {
	        for $ConsultaPrestamoTypeResponse in $PrestamosInput/con:LOAN_DETAILS/con:LOAN_DETAIL
        	return
        	let $loanId := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:LOAN_ID)
		    let $customerName := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:LOAN_CUSTOMER_NAME)
		    let $moneda := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:CURRENCY)
	    	let $capitalCuota  := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:NEXT_PAYMNT_PRINCIPAL_AMT)
	    	let $interesCuota  := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:NEXT_PAYMNT_INTEREST_AMT)
	    	let $seguroCuota   := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:NEXT_PAYMNT_INSURANCE_AMT)
	    	let $interesYSegurocuota   := fn-bea:format-number(fn:round-half-to-even(number($interesCuota) + number($seguroCuota), 2),"######0.00")
	    	let $totalCuota	 := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:NEXT_PAYMNT_TOTAL_AMT)    	
	    	let $fechaMaxima := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:NEXT_PAYMNT_MATURITY_DATE)
		    let $totalBalance := data($ConsultaPrestamoTypeResponse/con:RESPONSE_BODY/con:TOTAL_DEBT)
		    return		    
		        <Prestamo>
					<LOAN_ID>{ $loanId }</LOAN_ID>   
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
		    		<TOTAL_DEBT>{ $totalBalance }</TOTAL_DEBT>
		    		<MATURITY_DATE>{ $fechaMaxima }</MATURITY_DATE>
        		</Prestamo>
	        }        
        </Prestamos>
};

declare variable $PrestamosInput as element(*) external;

xf:consultaPrestamosOut2($PrestamosInput)