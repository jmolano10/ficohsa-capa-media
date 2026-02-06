xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ingresaAcuerdoPagoRequest" element="ns2:ingresaAcuerdoPagoRequest" location="../../GestionesCarteraCrediticia/xsd/gestionesCarteraCrediticiaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RecordManagement" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/GestionesCarteraCrediticia";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaAcuerdoPago/xq/CreditForceRecordManagementIn/";

declare function xf:CreditForceRecordManagementIn($token as xs:string,
    $type as xs:string,
    $userName as xs:string,
    $ingresaAcuerdoPagoRequest as element(ns2:ingresaAcuerdoPagoRequest))
    as element(ns0:RecordManagement) {
        <ns0:RecordManagement>
            <ns0:recordReq>
                <ns1:Record>
                    <ns1:Action_Cod>{ data($ingresaAcuerdoPagoRequest/ACTION_CODE) }</ns1:Action_Cod>
                    <ns1:Client_Id>{ data($ingresaAcuerdoPagoRequest/CUSTOMER_ID) }</ns1:Client_Id>
                    <ns1:Comment>{ data($ingresaAcuerdoPagoRequest/DESCRIPTION) }</ns1:Comment>
                    { 
                    	if ($type != '0') then (
		                    <ns1:Hmr>
		                    	{ 
		                    		if ($type = '3') then
			                    		if (data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'USD']/AMOUNT) != '')then
			                        		<ns1:Foreign_AmountPay_LIQ>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'USD']/AMOUNT)}</ns1:Foreign_AmountPay_LIQ>
			                    		else(
			                    			<ns1:Foreign_AmountPay_LIQ>0</ns1:Foreign_AmountPay_LIQ>
			                    		)		                        		
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '1') then
		                    			if (data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'USD']/MAX_PAYMENT_DATE) != '')then
		                        			<ns1:Foreign_Date_DPM>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'USD']/MAX_PAYMENT_DATE)}</ns1:Foreign_Date_DPM>
		                    			else(
		                        			<ns1:Foreign_Date_DPM>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'NIO']/MAX_PAYMENT_DATE)}</ns1:Foreign_Date_DPM>
		                        			)
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '3') then
		                    			if (data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'USD']/MAX_PAYMENT_DATE) != '') then 
		                        				<ns1:Foreign_Date_LIQ>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'USD']/MAX_PAYMENT_DATE)}</ns1:Foreign_Date_LIQ>
		                        			else(
		                        				<ns1:Foreign_Date_LIQ>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'NIO']/MAX_PAYMENT_DATE)}</ns1:Foreign_Date_LIQ>
		                        			)
		                        	else ()
		                        }
		                        <ns1:Foreign_Number_Payments_LIQ>1</ns1:Foreign_Number_Payments_LIQ>
		                        { 
		                    		if ($type = '1' and (data($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY/PAYMENT_DETAILS/PAYMENT_DETAIL[CURRENCY = 'USD']))) then
		                        		<ns1:Foreign_Porcentaje_DPM>{ data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'USD']/PERCENT) }</ns1:Foreign_Porcentaje_DPM>
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '1') then
		                        		<ns1:Is_Exception_DPM>false</ns1:Is_Exception_DPM>
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '3') then
		                        		<ns1:Is_Exception_LIQ>false</ns1:Is_Exception_LIQ>
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '3') then
		                        		<ns1:Is_Parcial_LIQ>false</ns1:Is_Parcial_LIQ>
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '2') then
		                        		<ns1:Is_Ref_Ley>false</ns1:Is_Ref_Ley>
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '3') then
		                    			if (data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'NIO']/AMOUNT) != '') then
		                    				<ns1:Local_AmountPay_LIQ>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'NIO']/AMOUNT)}</ns1:Local_AmountPay_LIQ>
		                        		else(
		                    				<ns1:Local_AmountPay_LIQ>0</ns1:Local_AmountPay_LIQ>
		                    			)
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '1') then 
		                    			if (data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'NIO']/MAX_PAYMENT_DATE) != '') then
		                        			<ns1:Local_Date_DPM>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'NIO']/MAX_PAYMENT_DATE)}</ns1:Local_Date_DPM>
		                        		else(
		                        			<ns1:Local_Date_DPM>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'USD']/MAX_PAYMENT_DATE)}</ns1:Local_Date_DPM>
		                        		)
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '3') then
		                    			if (data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'NIO']/MAX_PAYMENT_DATE) != '') then 
		                        			<ns1:Local_Date_LIQ>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'NIO']/MAX_PAYMENT_DATE)}</ns1:Local_Date_LIQ>
		                        		else (
		                        			<ns1:Local_Date_LIQ>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'USD']/MAX_PAYMENT_DATE)}</ns1:Local_Date_LIQ>
		                        		)
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '3') then
		                        		<ns1:Local_Number_Payments_LIQ>1</ns1:Local_Number_Payments_LIQ>
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '1' and (data($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY/PAYMENT_DETAILS/PAYMENT_DETAIL[CURRENCY = 'NIO']))) then
		                        		<ns1:Local_Porcentaje_DPM>{ data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/DISCOUNTS/DISCOUNT[CURRENCY = 'NIO']/PERCENT) }</ns1:Local_Porcentaje_DPM>
		                        	else ()
		                        }
		                        { 
		                    		if ($type = '3') then
		                        		<ns1:Local_Porcentaje_LIQ>{data($ingresaAcuerdoPagoRequest/OPTIONS_TO_PAY/LIQUIDATIONS/LIQUIDATION[CURRENCY = 'NIO']/PERCENT)}</ns1:Local_Porcentaje_LIQ>
		                        	else ()
		                        }
		                        <ns1:Type>{ $type }</ns1:Type>
		                    </ns1:Hmr>
                    	) else 
                    	(
                    	)
                    }
                    <ns1:Is_Recall>false</ns1:Is_Recall>
                    <ns1:Operation_Id>{ data($ingresaAcuerdoPagoRequest/PRODUCT_ID) }</ns1:Operation_Id>
                    <ns1:Phone>{ data($ingresaAcuerdoPagoRequest/PHONE_NUMBER) }</ns1:Phone>
                    {
                    	if ($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY != '') then (
	                    <ns1:Promises>
	                    	{ 
	                    		if ($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY/PAYMENT_DETAILS/PAYMENT_DETAIL[CURRENCY = 'USD']/AMOUNT) then
	                    			<ns1:Foreign_Amount>{ data($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY/PAYMENT_DETAILS/PAYMENT_DETAIL[CURRENCY = 'USD']/AMOUNT) }</ns1:Foreign_Amount>
	                    		else
	                    			<ns1:Foreign_Amount>0</ns1:Foreign_Amount>
	                    	}
	                    	{
	                    		if (data($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY/PAYMENT_DETAILS/PAYMENT_DETAIL[CURRENCY = 'NIO']/AMOUNT))then
	                    			<ns1:Local_Amount>{ data($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY/PAYMENT_DETAILS/PAYMENT_DETAIL[CURRENCY = 'NIO']/AMOUNT) }</ns1:Local_Amount>
	                    		else
	                    		<ns1:Local_Amount>0</ns1:Local_Amount>
	                    	}
	                    	
	                    	<ns1:Promise_Date>{ data($ingresaAcuerdoPagoRequest/PROMISE_TO_PAY/PAYMENT_DETAILS/PAYMENT_DETAIL[1]/PROMISE_DATE) }</ns1:Promise_Date>
	                    </ns1:Promises>
	                    ) else ()
                    }
                    
                    <ns1:Result_Cod>{ data($ingresaAcuerdoPagoRequest/RESULT_CODE) }</ns1:Result_Cod>
                    <ns1:User_Name>{ $userName }</ns1:User_Name>
                </ns1:Record>
                <ns1:Token>{ $token }</ns1:Token>
            </ns0:recordReq>
        </ns0:RecordManagement>
};

declare variable $token as xs:string external;
declare variable $type as xs:string external;
declare variable $userName as xs:string external;
declare variable $ingresaAcuerdoPagoRequest as element(ns2:ingresaAcuerdoPagoRequest) external;

xf:CreditForceRecordManagementIn($token,
    $type,
    $userName,
    $ingresaAcuerdoPagoRequest)