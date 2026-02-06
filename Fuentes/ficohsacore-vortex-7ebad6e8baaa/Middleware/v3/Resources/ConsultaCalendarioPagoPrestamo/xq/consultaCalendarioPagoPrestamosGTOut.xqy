xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$loanScheduleInquiryResponse" element="ns0:LoanScheduleInquiryResponse" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCalendarioPagoPrestamoResponse" location="../xsd/consultaCalendarioPagoPrestamoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCalendarioPagoPrestamo/xq/consultaCalendarioPagoPrestamosGTOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:consultaCalendarioPagoPrestamosGTOut($loanScheduleInquiryResponse as element(ns0:LoanScheduleInquiryResponse))
    as element(ns1:consultaCalendarioPagoPrestamoResponse) {
          <ns1:consultaCalendarioPagoPrestamoResponse>
            {
                for $AZXLSO-INITIAL-LOAN in $loanScheduleInquiryResponse/AZXLSO-INITIAL-LOAN
                return
                	if(string($AZXLSO-INITIAL-LOAN/text()) != '')then(
                		<INITIAL_AMOUNT>{ data($AZXLSO-INITIAL-LOAN) }</INITIAL_AMOUNT>
                	)else()
                    
            }
            {
                for $AZXLSO-INITIAL-PRIN in $loanScheduleInquiryResponse/AZXLSO-INITIAL-PRIN
                return
                	if(string($AZXLSO-INITIAL-PRIN/text()) != '')then(
                		<PRINCIPAL_AMOUNT>{ data($AZXLSO-INITIAL-PRIN) }</PRINCIPAL_AMOUNT>
                	)else()
                    
            }
            {
                for $AZXLSO-INITIAL-INT in $loanScheduleInquiryResponse/AZXLSO-INITIAL-INT
                return
                	if(string($AZXLSO-INITIAL-INT/text()) != '')then(
                		 <INTEREST_AMOUNT>{ data($AZXLSO-INITIAL-INT) }</INTEREST_AMOUNT>
                	)else()
                   
            }
            {
                for $AZXLSO-INITIAL-INS in $loanScheduleInquiryResponse/AZXLSO-INITIAL-INS
                return
                	if(string($AZXLSO-INITIAL-INS/text()) != '')then(
                		<INSURANCE_AMOUNT>{ data($AZXLSO-INITIAL-INS) }</INSURANCE_AMOUNT>
                	)else()
                    
            }
            {
                for $AZXLSO-INITIAL-USER1 in $loanScheduleInquiryResponse/AZXLSO-INITIAL-USER1
                return
                	if(string($AZXLSO-INITIAL-USER1/text())!= '')then(
                		<PENALTY_AMOUNT>{ data($AZXLSO-INITIAL-USER1) }</PENALTY_AMOUNT>
                	)else()
                    
            }
            {
                for $AZXLSO-INITIAL-USER3 in $loanScheduleInquiryResponse/AZXLSO-INITIAL-USER3
                return
                	if(string($AZXLSO-INITIAL-USER3/text())!= '')then(
                		 <DISBURSEMENT_COMMISSION>{ data($AZXLSO-INITIAL-USER3) }</DISBURSEMENT_COMMISSION>
                	)else()
                   
            }
            {
                for $AZXLSO-ORIG-TERM in $loanScheduleInquiryResponse/AZXLSO-ORIG-TERM
                return
                	if(string($AZXLSO-ORIG-TERM/text())!= '')then (
                		<ORIGINAL_LOAN_TERMS>{ data($AZXLSO-ORIG-TERM) }</ORIGINAL_LOAN_TERMS>
                	)else()
                    
            }
            {
                for $AZXLSO-CURR-TERM in $loanScheduleInquiryResponse/AZXLSO-CURR-TERM
                return
                	if(string($AZXLSO-CURR-TERM/text())!= '')then(
                		 <NEXT_PAYMNT_ID>{ data($AZXLSO-CURR-TERM) }</NEXT_PAYMNT_ID>
                	)else()
                  
            }
            {
                for $AZXLSO-REM-TERM in $loanScheduleInquiryResponse/AZXLSO-REM-TERM
                return
                	if(string($AZXLSO-REM-TERM/text())!= '')then(
                		<PENDING_LOAN_TERMS>{ data($AZXLSO-REM-TERM) }</PENDING_LOAN_TERMS>
                	)else()
                    
            }
            {
                for $AZXLSO-EARNED-PRIN in $loanScheduleInquiryResponse/AZXLSO-EARNED-PRIN
                return
                	if(string($AZXLSO-EARNED-PRIN/text()) != '')then (
                		<PAID_PRINCIPAL_AMOUNT>{ data($AZXLSO-EARNED-PRIN) }</PAID_PRINCIPAL_AMOUNT>
                	)else()
                    
            }
            {
                for $AZXLSO-EARNED-INT in $loanScheduleInquiryResponse/AZXLSO-EARNED-INT
                return
                	if(string($AZXLSO-EARNED-INT/text()) != '')then(
                	<PAID_INTEREST_AMOUNT>{ data($AZXLSO-EARNED-INT) }</PAID_INTEREST_AMOUNT>
                	)else()
                 
            }
            {
                for $AZXLSO-EARNED-INS in $loanScheduleInquiryResponse/AZXLSO-EARNED-INS
                return
                	if(string($AZXLSO-EARNED-INS/text()) != '')then(
                	<PAID_INSURANCE_AMOUNT>{ data($AZXLSO-EARNED-INS) }</PAID_INSURANCE_AMOUNT>
                	)else()
                    
            }
            {
                for $AZXLSO-EARNED-USER1 in $loanScheduleInquiryResponse/AZXLSO-EARNED-USER1
                return
                	if(string($AZXLSO-EARNED-USER1/text()) != '')then(
                	  <PAID_PENALTY_AMOUNT>{ data($AZXLSO-EARNED-USER1) }</PAID_PENALTY_AMOUNT>
                	)else()
                  
            }
            {
                for $AZXLSO-EARNED-USER3 in $loanScheduleInquiryResponse/AZXLSO-EARNED-USER3
                return
                	if(string($AZXLSO-EARNED-USER3/text()) != '')then(
                	  <PAID_DISBURSEMENT_COMMISSION>{ data($AZXLSO-EARNED-USER3) }</PAID_DISBURSEMENT_COMMISSION>
                	)else()
                    
            }
            {
                for $AZXLSO-BILLING-CYCLE in $loanScheduleInquiryResponse/AZXLSO-BILLING-CYCLE
                return
                	if(string($AZXLSO-BILLING-CYCLE/text()) != '')then(
                	  <ACCOUNT_CYCLE>{ data($AZXLSO-BILLING-CYCLE) }</ACCOUNT_CYCLE>
                	)else()
                    
            }
            {
            let $AZXLSO-INT-RATE := $loanScheduleInquiryResponse/AZXLSO-INT-RATE
            	return
            	if(string($AZXLSO-INT-RATE/text()) != '')then(
            		 <INTEREST_RATE>{ data($loanScheduleInquiryResponse/AZXLSO-INT-RATE) }</INTEREST_RATE>
            	)else()
           
            }
            {
                for $AZXLSO-LOAN-SCHEDULE-ENTRY in $loanScheduleInquiryResponse/AZXLSO-LOAN-SCHEDULE-DATA/AZXLSO-LOAN-SCHEDULE-ENTRY 
                	where data($AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-PMT-NBR) > 0
                return
                    <LOAN_SCHEDULE>
	                     {
				            let $AZXLSO-PMT-NBR := $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-PMT-NBR
				            	return
				            	if(string($AZXLSO-PMT-NBR/text()) != '')then(
				            		 <BILL_NUMBER>{ data($AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-PMT-NBR) }</BILL_NUMBER> 
				            	)else()
	           
	           			 }
                       
                        {
                        	 for $bill_date in data($AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-PMT-DATE)
               				 return
               				 	if(fn-bea:trim($bill_date) != "") then(
               				 			<BILL_DATE>{ fn-bea:date-from-string-with-format('dd/MM/yyyy',$bill_date) }</BILL_DATE>
               				 	)else()
	 
                        } 
                        {
			                for $AZXLSO-PRIN in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-PRIN
			                return
			                	if(string($AZXLSO-PRIN/text()) != '')then(
			                	   <BILL_PRINCIPAL_AMOUNT>{ data($AZXLSO-PRIN) }</BILL_PRINCIPAL_AMOUNT>
			                )else()
                    
           				 }
           				 
           				 {
			                for $AZXLSO-INT in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-INT
			                return
			                	if(string($AZXLSO-INT/text()) != '')then(
			                	   <BILL_INTEREST_AMOUNT>{ data($AZXLSO-INT) }</BILL_INTEREST_AMOUNT>
			                )else()
                    
           				 }              
                        
                         {
			                for $AZXLSO-PMT-AMT in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-PMT-AMT
			                return
			                	if(string($AZXLSO-PMT-AMT/text()) != '')then(
			                	 <BILL_TOTAL_AMOUNT>{ data($AZXLSO-PMT-AMT) }</BILL_TOTAL_AMOUNT>
			                )else()
                    
           				 }  
                       	   
                       	 {
			                for $AZXLSO-INS in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-INS
			                return
			                	if(string($AZXLSO-INS/text()) != '')then(
			                	 <BILL_INSURANCE_AMOUNT>{ data($AZXLSO-INS) }</BILL_INSURANCE_AMOUNT>
			                )else()
                    
           				 } 
           				 
           				 {
			                for $AZXLSO-USER-FEE1 in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-USER-FEE1
			                return
			                	if(string($AZXLSO-USER-FEE1/text()) != '')then(
			                	 <BILL_PENALTY_AMOUNT>{ data($AZXLSO-USER-FEE1) }</BILL_PENALTY_AMOUNT>
			                )else()
                    
           				 } 
                        
                        {
			                for $AZXLSO-USER-FEE3 in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-USER-FEE3
			                return
			                	if(string($AZXLSO-USER-FEE3/text()) != '')then(
			                	 <BILL_DISBURSEMENT_COMMISSION>{ data($AZXLSO-USER-FEE3) }</BILL_DISBURSEMENT_COMMISSION>
			                )else()
                    
           				 } 
           				 
           				 {
			                for $AZXLSO-USER-FEE6 in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-USER-FEE6
			                return
			                	if(string($AZXLSO-USER-FEE6/text()) != '')then(
			                	 <BILL_ITBMS_AMOUNT>{ data($AZXLSO-USER-FEE6) }</BILL_ITBMS_AMOUNT>
			                )else()
                    
           				 } 
           				 
           				  {
			                for $AZXLSO-FECI in $AZXLSO-LOAN-SCHEDULE-ENTRY/AZXLSO-FECI
			                return
			                	if(string($AZXLSO-FECI/text()) != '')then(
			                	 <BILL_FECI_AMOUNT>{ data($AZXLSO-FECI) }</BILL_FECI_AMOUNT>
			                )else()
                    
           				 }
  
                    </LOAN_SCHEDULE>
            }
        </ns1:consultaCalendarioPagoPrestamoResponse>
};

declare variable $loanScheduleInquiryResponse as element(ns0:LoanScheduleInquiryResponse) external;

xf:consultaCalendarioPagoPrestamosGTOut($loanScheduleInquiryResponse)