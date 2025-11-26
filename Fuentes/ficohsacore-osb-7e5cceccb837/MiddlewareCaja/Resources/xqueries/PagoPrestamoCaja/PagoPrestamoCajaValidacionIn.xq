(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoCajaValidacionIn/";

declare function xf:PagoPrestamoCajaValidacionIn($pagoPrestamo as element(ns0:pagoPrestamo))
    as xs:string? {
    	let $loan_number := fn:string($pagoPrestamo/LOAN_NUMBER/text())
    	let $payment_amount := fn:string($pagoPrestamo/PAYMENT_AMOUNT/text())
    	let $payment_type := fn:string($pagoPrestamo/PAYMENT_TYPE/text())
    	let $debit_account := fn:string($pagoPrestamo/DEBIT_ACCOUNT/text())
    	let $cheque_number := fn:string($pagoPrestamo/CHEQUE_NUMBER/text())
    	let $bank_code := fn:string($pagoPrestamo/BANK_CODE/text())
    	return
    	(: Si no se ingresó tipo de pago o número de préstamo o monto a pagar:)
    	if ($payment_type = "" or $loan_number = "" or $payment_amount = "") then (
    		"REQUIRED FIELDS NOT SUPPLIED"
    		
    		
    	(: Si es pago de préstamo con debito a cuenta :)
    	) else if ($payment_type = "ACCOUNT_DEBIT") then (
    		(: Campos requeridos :)
    		if ($debit_account = "") then (
    			"REQUIRED FIELDS NOT SUPPLIED"
    		) else ("")
    		
    		
    	(: Si es pago de préstamos en efectivo :)
    	) else if ($payment_type = "CASH") then (
    		""
    	
    	(: Si es pago de préstamo con Cheque Propio :)
    	) else if ($payment_type = "OWN_CHEQUE") then (
    		(: Campos requeridos :)
    		if ($cheque_number = "" or $debit_account = "") then (
    			"REQUIRED FIELDS NOT SUPPLIED"
    		) else ("") 
    		
    		
    	(: Si es pago de préstamo con Cheque de otros banco :)
    	) else if ($payment_type = "OTHER_BANK_CHEQUE") then (
    		(: Campos requeridos :)
    		if ($cheque_number = "" or $bank_code = "") then (
    			"REQUIRED FIELDS NOT SUPPLIED"
    		) else ("")    	
    	
    	(: Si es pago de préstamo con Cheque de otros banco internacional:)
    	) else if ($payment_type = "INTL_CHQ_US") then (
    		(: Campos requeridos :)
    		if ($cheque_number = "" or $bank_code = "") then (
    			"REQUIRED FIELDS NOT SUPPLIED"
    		) else ("") 
    		     	
    	(: Si es un tipo de pago no soportado :)
    	) else (
    		"PAYMENT TYPE NOT SUPPORTED"
    	)
};

declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;

xf:PagoPrestamoCajaValidacionIn($pagoPrestamo)