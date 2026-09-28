(:: pragma bea:global-element-parameter parameter="$registraClienteDesembolsoLineaCredito" element="ns0:registraClienteDesembolsoLineaCredito" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ServiciosEmpresariales/registraClienteSolEmprendedor/xsd/registraClienteSolEmprendedor_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraClienteSolEmprendedor";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraClienteDesembolsoLineaCredito/xq/registraClienteSolEmprendedorHNIn/";

declare function xf:registraClienteSolEmprendedorHNIn($registraClienteDesembolsoLineaCredito as element(ns0:registraClienteDesembolsoLineaCredito))
    as element(ns1:InputParameters) {
    	let $GENERAL_INFO := $registraClienteDesembolsoLineaCredito/CUSTOMERS/CUSTOMER/GENERAL_INFO
    	let $PRODUCT_INFO := $registraClienteDesembolsoLineaCredito/CUSTOMERS/CUSTOMER/PRODUCT_INFO
    	return
        <ns1:InputParameters>
            <ns1:P_CUSTOMER_ID>{ data($GENERAL_INFO/BASIC[1]/ID) }</ns1:P_CUSTOMER_ID>
            <ns1:P_CUSTOMER_NAME>{ data($GENERAL_INFO/BASIC[1]/NAME) }</ns1:P_CUSTOMER_NAME>
            <ns1:P_LEGAL_ID>{ data($GENERAL_INFO/BASIC[1]/LEGAL_ID) }</ns1:P_LEGAL_ID>
            <ns1:P_TARGET_ID>{ data($GENERAL_INFO/BASIC[1]/TARGET_ID) }</ns1:P_TARGET_ID>
            <ns1:P_TARGET_DESCRIPTION>{ data($GENERAL_INFO/BASIC[1]/TARGET_DESCRIPTION) }</ns1:P_TARGET_DESCRIPTION>
            <ns1:P_BRANCH_CODE>{ data($GENERAL_INFO/BASIC[1]/BRANCH_CODE) }</ns1:P_BRANCH_CODE>
            <ns1:P_EXPIRATION_DAY>{ data($GENERAL_INFO/BASIC[1]/EXPIRATION_DAY) }</ns1:P_EXPIRATION_DAY>
            <ns1:P_FINANCIAL_STMT_DATE>{ data($GENERAL_INFO/FINANCIAL[1]/FINANCIAL_STMT_DATE) }</ns1:P_FINANCIAL_STMT_DATE>
            <ns1:P_NEXT_FINANCIAL_STMT_DATE>{ data($GENERAL_INFO/FINANCIAL[1]/NEXT_FINANCIAL_STMT_DATE) }</ns1:P_NEXT_FINANCIAL_STMT_DATE>
            <ns1:P_ACTIVE>{ data($PRODUCT_INFO/ACTIVE) }</ns1:P_ACTIVE>
            <ns1:P_AUTO_DEBIT>{ data($PRODUCT_INFO/REPAYMENT_DETAILS[1]/AUTO_DEBIT) }</ns1:P_AUTO_DEBIT>
            <ns1:P_USER>{ data($GENERAL_INFO/BASIC[1]/REQUEST_USER) }</ns1:P_USER>
            <ns1:P_USER_AUTORIZA>{ data($GENERAL_INFO/BASIC[1]/AUTHORIZATION_USER) }</ns1:P_USER_AUTORIZA>
            <ns1:P_EMAILS>
        	{
        		for $EMAIL in $GENERAL_INFO/CONTACT[1]/EMAILS[1]/EMAIL
				return
					<ns1:P_EMAILS_ITEM>{ data($EMAIL/ID) }</ns1:P_EMAILS_ITEM>
        	}                
            </ns1:P_EMAILS>
            <ns1:P_LOAN_LIMITS>
            {
            	for $LOAN_LIMIT in $PRODUCT_INFO/LOAN_LIMITS/LOAN_LIMIT
            	return
            		<ns1:P_LOAN_LIMITS_ITEM>
	                    <ns1:CURRENCY>{ data($LOAN_LIMIT/CURRENCY) }</ns1:CURRENCY>
	                    <ns1:MAX_AMOUNT>{ data($LOAN_LIMIT/MAX_AMOUNT) }</ns1:MAX_AMOUNT>
	                    <ns1:ENABLED>{ data($LOAN_LIMIT/ENABLED) }</ns1:ENABLED>
	                </ns1:P_LOAN_LIMITS_ITEM>
            }
            </ns1:P_LOAN_LIMITS>
            <ns1:P_DESTINATION_PRODUCTS>
            {
            	for $PRODUCT in $PRODUCT_INFO/DESTINATION_PRODUCTS/PRODUCT
            	return
	                <ns1:P_DESTINATION_PRODUCTS_ITEM>
	                    <ns1:PRODUCT_ID>{ data($PRODUCT/ID) }</ns1:PRODUCT_ID>
	                    <ns1:CURRENCY>{ data($PRODUCT/CURRENCY) }</ns1:CURRENCY>
	                    <ns1:TYPE>{ data($PRODUCT/TYPE) }</ns1:TYPE>
	                </ns1:P_DESTINATION_PRODUCTS_ITEM>
            }
            </ns1:P_DESTINATION_PRODUCTS>
            <ns1:P_DEBIT_ACCOUNTS>
            {
            	for $ACCOUNT in $PRODUCT_INFO/REPAYMENT_DETAILS[1]/DEBIT_ACCOUNTS[1]/ACCOUNT
            	return
	                <ns1:P_DEBIT_ACCOUNTS_ITEM>
	                    <ns1:ACCOUNT_ID>{ data($ACCOUNT/ID) }</ns1:ACCOUNT_ID>
	                    <ns1:CURRENCY>{ data($ACCOUNT/CURRENCY) }</ns1:CURRENCY>
	                    <ns1:TYPE>{ data($ACCOUNT/TYPE) }</ns1:TYPE>
	                </ns1:P_DEBIT_ACCOUNTS_ITEM>
            }
            </ns1:P_DEBIT_ACCOUNTS>
            <ns1:P_CREDIT_LINES>
            {
            	for $CREDIT_LINE in $PRODUCT_INFO/CREDIT_LINES/CREDIT_LINE
            	return
	                <ns1:P_CREDIT_LINES_ITEM>
	                    <ns1:ID>{ data($CREDIT_LINE/ID) }</ns1:ID>
	                    <ns1:ECONOMIC_ACTIVITY_CODE>{ data($CREDIT_LINE/ECONOMIC_ACTIVITY_CODE) }</ns1:ECONOMIC_ACTIVITY_CODE>
	                    <ns1:EXPIRY_DATE>{ data($CREDIT_LINE/EXPIRY_DATE) }</ns1:EXPIRY_DATE>
	                    <ns1:INVESTMENT_CODE>{ data($CREDIT_LINE/INVESTMENT_CODE) }</ns1:INVESTMENT_CODE>
	                    <ns1:INVESTMENT_SUB_CODE>{ data($CREDIT_LINE/INVESTMENT_SUBCODE) }</ns1:INVESTMENT_SUB_CODE>
	                    <ns1:DESTINATION_CODE>{ data($CREDIT_LINE/DESTINATION_CODE) }</ns1:DESTINATION_CODE>
	                    <ns1:APPROVAL_CODE>{ data($CREDIT_LINE/APPROVAL_CODE) }</ns1:APPROVAL_CODE>
	                    <ns1:OFFICER>{ data($CREDIT_LINE/OFFICER) }</ns1:OFFICER>
	                    <ns1:OFFICER_BRANCH_CODE>{ data($CREDIT_LINE/OFFICER_BRANCH_CODE) }</ns1:OFFICER_BRANCH_CODE>
	                    <ns1:SUB_ORIGIN>{ data($CREDIT_LINE/SUB_ORIGIN) }</ns1:SUB_ORIGIN>
	                    <ns1:REVISION_RATE_TYPE>{ data($CREDIT_LINE/REVISION_RATE_TYPE) }</ns1:REVISION_RATE_TYPE>
	                    <ns1:MONTHLY_SETTLEMENT>{ data($CREDIT_LINE/MONTHLY_SETTLEMENT) }</ns1:MONTHLY_SETTLEMENT>
	                    <ns1:YEARLY_SETTLEMENT>{ data($CREDIT_LINE/YEARLY_SETTLEMENT) }</ns1:YEARLY_SETTLEMENT>
	                    <ns1:GRACE_PERIOD>{ data($CREDIT_LINE/GRACE_PERIOD) }</ns1:GRACE_PERIOD>                  
	                    <ns1:MAX_PAYMENT_PERIOD>{ data($CREDIT_LINE/MAX_PAYMENT_PERIOD) }</ns1:MAX_PAYMENT_PERIOD>
	                    <ns1:LOAN_PRODUCTS_DLC>
	                    {
			            	for $LOAN_PRODUCT in $CREDIT_LINE/LOAN_PRODUCT_DETAILS/LOAN_PRODUCT
			            	return
		                        <ns1:LOAN_PRODUCTS_DLC_ITEM>
		                            <ns1:ID>{ data($LOAN_PRODUCT/ID) }</ns1:ID>
		                            <ns1:CURRENCY>{ data($LOAN_PRODUCT/CURRENCY) }</ns1:CURRENCY>
		                            <ns1:OBLIGATION_TYPE>{ data($LOAN_PRODUCT/OBLIGATION_TYPE) }</ns1:OBLIGATION_TYPE>
		                            <ns1:OBLIGATION_DESCRIPTION>{ data($LOAN_PRODUCT/OBLIGATION_DESCRIPTION) }</ns1:OBLIGATION_DESCRIPTION>
		                            <ns1:GUARANTEE_TYPE>{ data($LOAN_PRODUCT/GUARANTEE_TYPE) }</ns1:GUARANTEE_TYPE>
		                            <ns1:GUARANTEE_DESCRIPTION>{ data($LOAN_PRODUCT/GUARANTEE_DESCRIPTION) }</ns1:GUARANTEE_DESCRIPTION>
		                            <ns1:REPAYMENT_TYPE>
		                            {
						            	for $REPAYMENT_TYPE in $LOAN_PRODUCT/REPAYMENT_TYPES/REPAYMENT_TYPE
						            	return
			                                <ns1:REPAYMENT_TYPE_ITEM>
			                                    <ns1:CODE>{ data($REPAYMENT_TYPE/CODE) }</ns1:CODE>
			                                    <ns1:DESCRIPTION>{ data($REPAYMENT_TYPE/DESCRIPTION) }</ns1:DESCRIPTION>
			                                    <ns1:FRECUENCY>{ data($REPAYMENT_TYPE/FREQUENCY) }</ns1:FRECUENCY>
			                                    <ns1:MAX_PAYMENT_TERM>{ data($REPAYMENT_TYPE/MAX_PAYMENT_TERM) }</ns1:MAX_PAYMENT_TERM>
			                                </ns1:REPAYMENT_TYPE_ITEM>
		                            }
		                            </ns1:REPAYMENT_TYPE>
									<ns1:RATE>
										{
											for $RATE in $LOAN_PRODUCT/RATES/RATE
											return
												<ns1:RATE_ITEM>
													<ns1:RATE_CLASS>{ data($RATE/CLASS) }</ns1:RATE_CLASS>
													<ns1:RATE_GROUP>{ data($RATE/GROUP) }</ns1:RATE_GROUP>
													<ns1:TERM_IN_MONTHS>{ data($RATE/TERM_IN_MONTHS) }</ns1:TERM_IN_MONTHS>
													<ns1:LOAN_RATE>{ data($RATE/LOAN_RATE) }</ns1:LOAN_RATE>
												</ns1:RATE_ITEM>
										}
									</ns1:RATE>
									<ns1:CHARGE>
										{
											for $CHARGE in $LOAN_PRODUCT/CHARGES/CHARGE
											return
												<ns1:CHARGE_ITEM>
													<ns1:CHARGES_NAME>{ data($CHARGE/NAME) }</ns1:CHARGES_NAME>
													<ns1:CHARGES_TYPE>{ data($CHARGE/TYPE) }</ns1:CHARGES_TYPE>
													<ns1:CHARGES_RANGE>
														{
															for $RANGE in $CHARGE/RANGES/RANGE
															return
																 <ns1:CHARGES_RANGE_ITEM>
																	 <ns1:RANGE_INITIAL>{ data($RANGE/INITIAL) }</ns1:RANGE_INITIAL>
																	 <ns1:RANGE_FINAL>{ data($RANGE/FINAL) }</ns1:RANGE_FINAL>
																	 <ns1:RANGE_VALUE>{ data($RANGE/VALUE) }</ns1:RANGE_VALUE>
																 </ns1:CHARGES_RANGE_ITEM>
														}
													</ns1:CHARGES_RANGE>
													
													<ns1:CHARGES_VALUE>{ data($CHARGE/VALUE) }</ns1:CHARGES_VALUE>
												</ns1:CHARGE_ITEM>
										}
									</ns1:CHARGE>
		                        </ns1:LOAN_PRODUCTS_DLC_ITEM>
	                    }
	                    </ns1:LOAN_PRODUCTS_DLC>
	                </ns1:P_CREDIT_LINES_ITEM>
            }
            </ns1:P_CREDIT_LINES>
        </ns1:InputParameters>
};

declare variable $registraClienteDesembolsoLineaCredito as element(ns0:registraClienteDesembolsoLineaCredito) external;

xf:registraClienteSolEmprendedorHNIn($registraClienteDesembolsoLineaCredito)