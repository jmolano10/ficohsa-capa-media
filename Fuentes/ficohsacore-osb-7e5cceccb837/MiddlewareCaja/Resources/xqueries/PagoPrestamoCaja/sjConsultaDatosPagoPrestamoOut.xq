(:: pragma bea:global-element-parameter parameter="$consultadesaldodeprestamoResponse1" element="ns0:ConsultadesaldodeprestamoResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadepagodeprestamoAAResponse1" element="ns0:ConsultadepagodeprestamoAAResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaaplicacionpagoptmoResponse1" element="ns0:ConsultaaplicacionpagoptmoResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultabackofficepagoptmoAAResponse1" element="ns0:ConsultabackofficepagoptmoAAResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaPrestamoResponse" location="../../xsds/PagoPrestamoCaja/sjConsultaPrestamo.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/sjConsultaDatosPagoPrestamoOut/";

declare function xf:sjConsultaDatosPagoPrestamoOut($consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse),
    $consultadepagodeprestamoAAResponse1 as element(ns0:ConsultadepagodeprestamoAAResponse), 
    $consultaaplicacionpagoptmoResponse1 as element(ns0:ConsultaaplicacionpagoptmoResponse),
    $consultabackofficepagoptmoAAResponse1 as element(ns0:ConsultabackofficepagoptmoAAResponse),
    $transactionType as xs:string)
    as element(ns1:sjConsultaPrestamoResponse) {
        <ns1:sjConsultaPrestamoResponse>
            <ns1:sjConsultaPrestamoResponseType>
                <ns1:consultaDatosPrestamo>
                    {
                        for $successIndicator in $consultadesaldodeprestamoResponse1/Status/successIndicator
                        return
                            <SUCCESS_INDICATOR>{ data($successIndicator) }</SUCCESS_INDICATOR>
                    }
                    {
                        let $result :=
                            for $messages in $consultadesaldodeprestamoResponse1/Status/messages
                            return
                                <MESSAGES>{ data($messages) }</MESSAGES>
                        return
                            $result[1]
                    }
                    {
                        for $CUSTOMERNAME in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CUSTOMERNAME
                        return
                            <CUSTOMER_NAME>{ data($CUSTOMERNAME) }</CUSTOMER_NAME>
                    }
                    {
                        for $OPENINGDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/OPENINGDATE
                        return
                            <OPENING_DATE>{ data($OPENINGDATE) }</OPENING_DATE>
                    }
                    {
                        for $MATURITYDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/MATURITYDATE
                        return
                            <MATURITY_DATE>{ data($MATURITYDATE) }</MATURITY_DATE>
                    }
                    {
                        for $INTERESTRATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INTERESTRATE
                        return
                            <INTEREST_RATE>{ data($INTERESTRATE) }</INTEREST_RATE>
                    }
                    {
                        for $CURRENCY in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURRENCY
                        return
                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    }
                    {
                        for $INITPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INITPRINAMT
                        return
                            <INITIAL_PRIN_AMOUNT>{ data($INITPRINAMT) }</INITIAL_PRIN_AMOUNT>
                    }
                    {
                        for $CURPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURPRINAMT
                        return
                            <CURRENT_PRIN_AMOUNT>{ data($CURPRINAMT) }</CURRENT_PRIN_AMOUNT>
                    }
                    {
                        for $PASTDUEPRIN in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/PASTDUEPRIN
                        return
                            <PAST_DUE_PRINCIPAL>{ data($PASTDUEPRIN) }</PAST_DUE_PRINCIPAL>
                    }
                    {
                        for $INTERESTAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INTERESTAMOUNT
                        return
                            <INTEREST_AMOUNT>{ data($INTERESTAMOUNT) }</INTEREST_AMOUNT>
                    }
                    {
                        for $ARRINTAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/ARRINTAMOUNT
                        return
                            <ARRINT_AMOUNT>{ data($ARRINTAMOUNT) }</ARRINT_AMOUNT>
                    }
                    {
                        for $COMMAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/COMMAMOUNT
                        return
                            <COMMISSION_AMOUNT>{ data($COMMAMOUNT) }</COMMISSION_AMOUNT>
                    }
                    {
                        for $TOTDEBITAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/TOTDEBITAMOUNT
                        return
                            <TOTAL_DEBT_AMOUNT>{ data($TOTDEBITAMOUNT) }</TOTAL_DEBT_AMOUNT>
                    }
                    {
                        for $PAIDINSNO in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/PAIDINSNO
                        return
                            <PAID_INST_NO>{ data($PAIDINSNO) }</PAID_INST_NO>
                    }
                    {
                        for $INSTDUEDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INSTDUEDATE
                        return
                            <INST_DUE_DATE>{ data($INSTDUEDATE) }</INST_DUE_DATE>
                    }
                    {
                        for $UNPAIDINSTNO in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/UNPAIDINSTNO
                        return
                            <UNPAID_INST_NO>{ data($UNPAIDINSTNO) }</UNPAID_INST_NO>
                    }
                    {
                        for $CURINSPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSPRINAMT
                        return
                            <CURRENT_INST_PRINAMT>{ data($CURINSPRINAMT) }</CURRENT_INST_PRINAMT>
                    }
                    {
                        for $CURINSINTEREST in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSINTEREST
                        return
                            <CURRENT_INST_INTEREST>{ data($CURINSINTEREST) }</CURRENT_INST_INTEREST>
                    }
                    {
                        for $CURINSDEFAULT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSDEFAULT
                        return
                            <CURRENT_INST_DEFAULT>{ data($CURINSDEFAULT) }</CURRENT_INST_DEFAULT>
                    }
                    {
                        for $CURINSINSUR in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSINSUR
                        return
                            <CURRENT_INST_INSUR>{ data($CURINSINSUR) }</CURRENT_INST_INSUR>
                    }
                    {
                        for $CURINSTOTAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSTOTAMT
                        return
                            <CURRENT_INST_TOTAMT>{ data($CURINSTOTAMT) }</CURRENT_INST_TOTAMT>
                    }
                </ns1:consultaDatosPrestamo>
                {
		            if ($transactionType = "TELLER") then (
		                <ns1:consultaPagoPrestamo>
		                    {
		                        for $successIndicator in $consultadepagodeprestamoAAResponse1/Status/successIndicator
		                        return
		                            <SUCCESS_INDICATOR>{ data($successIndicator) }</SUCCESS_INDICATOR>
		                    }
		                    {
		                        let $result :=
		                            for $messages in $consultadepagodeprestamoAAResponse1/Status/messages
		                            return
		                                <MESSAGES>{ data($messages) }</MESSAGES>
		                        return
		                            $result[1]
		                    }
		                    {
		                        for $TRANSINDICATOR in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/TRANSINDICATOR
		                        return
		                            <TRANSACTION_INDICATOR>{ data($TRANSINDICATOR) }</TRANSACTION_INDICATOR>
		                    }
		                    {
		                        for $TRANSACTIONID in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/TRANSACTIONID
		                        return
		                            <TRANSACTION_ID>{ data($TRANSACTIONID) }</TRANSACTION_ID>
		                    }
		                    {
		                        for $PAYMENTDATE in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/PAYMENTDATE
		                        return
		                            <PAYMENT_DATE>{ data($PAYMENTDATE) }</PAYMENT_DATE>
		                    }
		                    {
		                        for $DATETIME in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/DATETIME
		                        return
		                            <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
		                    }
		                    {
		                        for $LOANNUMBER in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/LOANNUMBER
		                        return
		                            <LOAN_NUMBER>{ data($LOANNUMBER) }</LOAN_NUMBER>
		                    }
		                    {
		                        for $PAIDINSTALLMENTNO in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/PAIDINSTALLMENT
		                        return
		                            <PAID_INSTALLMENT_NO>{ data($PAIDINSTALLMENTNO) }</PAID_INSTALLMENT_NO>
		                    }
		                    {
		                        for $TOTALPAYMENT in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/TOTALPAYMENT
		                        return
		                            <TOTAL_PAYMENT>{ data($TOTALPAYMENT) }</TOTAL_PAYMENT>
		                    }
		                    <PAYMENT_DETAILS>
		                    	<PAYMENT_DETAIL>
		                    		<PAYMENT_TYPE>PRINCIPAL</PAYMENT_TYPE>
		                    		<PAYMENT_VALUE>{ fn:string($consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/CURPRINAMOUNT/text()) }</PAYMENT_VALUE>
		                    	</PAYMENT_DETAIL>
		                    	<PAYMENT_DETAIL>
		                    		<PAYMENT_TYPE>PRINCIPAL_INT</PAYMENT_TYPE>
		                    		<PAYMENT_VALUE>{ fn:string($consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/PRINCIPALINTEREST/text()) }</PAYMENT_VALUE>
		                    	</PAYMENT_DETAIL>		                    	
		                    	<PAYMENT_DETAIL>
		                    		<PAYMENT_TYPE>PENALTY_INT</PAYMENT_TYPE>
		                    		<PAYMENT_VALUE>{ fn:string($consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/PENALTYINTEREST/text()) }</PAYMENT_VALUE>
		                    	</PAYMENT_DETAIL>		                    	
		                    </PAYMENT_DETAILS>
		                    {
		                        for $PAYMENTTYPE in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/PAYMENTTYPE
		                        return
		                            <PAYMENT_TYPE>{ data($PAYMENTTYPE) }</PAYMENT_TYPE>
		                    }
		                    {
		                        for $PAYMENTAMOUNT in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/PAYMENTAMOUNT
		                        return
		                            <PAYMENT_AMOUNT>{ data($PAYMENTAMOUNT) }</PAYMENT_AMOUNT>
		                    }
		                    {
		                        for $DEBITACCOUNT in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/DEBITACCOUNT
		                        return
		                            <DEBIT_ACCOUNT>{ data($DEBITACCOUNT) }</DEBIT_ACCOUNT>
		                    }
		                    {
		                        for $CHEQUENUMER in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/CHEQUENUMER
		                        return
		                            <CHEQUE_NUMER>{ data($CHEQUENUMER) }</CHEQUE_NUMER>
		                    }
		                    {
		                        for $BANKCODE in $consultadepagodeprestamoAAResponse1/WSFICOPAYMENTDETAILSAAType[1]/gWSFICOPAYMENTDETAILSAADetailType/mWSFICOPAYMENTDETAILSAADetailType[1]/BANKCODE
		                        return
		                            <BANK_CODE>{ data($BANKCODE) }</BANK_CODE>
		                    }
		                </ns1:consultaPagoPrestamo>
		            ) else if ($transactionType = "DIRECT") then (
		            	<ns1:consultaPagoPrestamo>
		                    {
		                        for $successIndicator in $consultabackofficepagoptmoAAResponse1/Status/successIndicator
		                        return
		                            <SUCCESS_INDICATOR>{ data($successIndicator) }</SUCCESS_INDICATOR>
		                    }
		                    {
		                        let $result :=
		                            for $messages in $consultabackofficepagoptmoAAResponse1/Status/messages
		                            return
		                                <MESSAGES>{ data($messages) }</MESSAGES>
		                        return
		                            $result[1]
		                    }
							<TRANSACTION_INDICATOR/>
		                    {
		                        for $ID in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/ID
		                        return
		                            <TRANSACTION_ID>{ data($ID) }</TRANSACTION_ID>
		                    }
		                    {
		                        for $PAYMENTDATE in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTDATE
		                        return
		                            <PAYMENT_DATE>{ data($PAYMENTDATE) }</PAYMENT_DATE>
		                    }
		                    <DATETIME/>
		                    {
		                        for $LOANNUMBER in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/LOANNUMBER
		                        return
		                            <LOAN_NUMBER>{ data($LOANNUMBER) }</LOAN_NUMBER>
		                    }
		                    {
		                        for $INSTALLMENTNO in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/INSTALLMENTNO
		                        return
		                            <PAID_INSTALLMENT_NO>{ data($INSTALLMENTNO) }</PAID_INSTALLMENT_NO>
		                    }
		                    {
		                        for $PAYMENTAMOUNT in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTAMOUNT
		                        return
		                            <TOTAL_PAYMENT>{ data($PAYMENTAMOUNT) }</TOTAL_PAYMENT>
		                    }
		                    <PAYMENT_DETAILS>
		                    	{
		                    		let $PAYMENTTYPE1 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTTYPE1/text())
		                    		let $PAYMENTVALUE1 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTVALUE1/text())
		                    		let $PAYMENTTYPE2 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTTYPE2/text())
		                    		let $PAYMENTVALUE2 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTVALUE2/text())
		                    		let $PAYMENTTYPE3 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTTYPE3/text())
		                    		let $PAYMENTVALUE3 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTVALUE3/text())
		                    		let $PAYMENTTYPE4 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTTYPE4/text())
		                    		let $PAYMENTVALUE4 := fn:string($consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTVALUE4/text())
		                    		let $PAYMENTTYPE := fn:string-join(($PAYMENTTYPE1,$PAYMENTTYPE2,$PAYMENTTYPE3,$PAYMENTTYPE4),"||")
		                    		let $PAYMENTVALUE := fn:string-join(($PAYMENTVALUE1,$PAYMENTVALUE2,$PAYMENTVALUE3,$PAYMENTVALUE4),"||")
		                    		let $PAYMENTTYPE_LIST := fn:tokenize($PAYMENTTYPE,"\|\|")
		                    		let $PAYMENTVALUE_LIST := fn:tokenize($PAYMENTVALUE,"\|\|")
		                    		for $i in (1 to fn:count($PAYMENTTYPE_LIST))
		                    		return
		                    			if ($PAYMENTTYPE_LIST[$i] != "") then (
			                    			<PAYMENT_DETAIL>
			                    				<PAYMENT_TYPE>{ $PAYMENTTYPE_LIST[$i] }</PAYMENT_TYPE>
			                    				<PAYMENT_VALUE>{ $PAYMENTVALUE_LIST[$i] }</PAYMENT_VALUE>
			                    			</PAYMENT_DETAIL>
			                    		) else ()
		                    	}
		                    </PAYMENT_DETAILS>
		                    <PAYMENT_TYPE/>
		                    {
		                        for $PAYMENTAMOUNT in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PAYMENTAMOUNT
		                        return
		                            <PAYMENT_AMOUNT>{ data($PAYMENTAMOUNT) }</PAYMENT_AMOUNT>
		                    }
		                    {
		                        for $PREVIOUSPRINBALANCE in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/PREVIOUSPRINCIPALBAL
		                        return
		                            <PREVIOUS_PRINCIPAL_BALANCE>{ data($PREVIOUSPRINBALANCE) }</PREVIOUS_PRINCIPAL_BALANCE>
		                    }
		                    {
		                        for $CURRENTPRINBALANCE in $consultabackofficepagoptmoAAResponse1/WSFICOBOPAYMENTDETAILSType[1]/gWSFICOBOPAYMENTDETAILSDetailType/mWSFICOBOPAYMENTDETAILSDetailType[1]/CURRENTPRINCIPALBAL
		                        return
		                            <CURRENT_PRINCIPAL_BALANCE>{ data($CURRENTPRINBALANCE) }</CURRENT_PRINCIPAL_BALANCE>
		                    }		                    		
		                    <DEBIT_ACCOUNT/>            	
		                    <CHEQUE_NUMER/>
		                    <BANK_CODE/>
		                </ns1:consultaPagoPrestamo>
		            ) else (
		            	<ns1:consultaPagoPrestamo/>
		            )
	            }
                {
                	if ($transactionType = "TELLER") then (
		                <ns1:consultaAplicaPagoPrestamo>
		                    {
		                        let $successIndicator := fn:string($consultaaplicacionpagoptmoResponse1/Status/successIndicator/text())
		                        let $ZERORECORDS := fn:string($consultaaplicacionpagoptmoResponse1/WSFICOADVDEALSLIPENTRYType[1]/ZERORECORDS/text())
		                        let $ERRORMESSAGE := fn:string($consultaaplicacionpagoptmoResponse1/WSFICOADVDEALSLIPENTRYType[1]/gWSFICOADVDEALSLIPENTRYDetailType/mWSFICOADVDEALSLIPENTRYDetailType[1]/ERRORMESSAGE/text())
		                        return
		                            if ($ZERORECORDS = "") then (
		                            	if ($ERRORMESSAGE = "N/A") then (
		                            		<SUCCESS_INDICATOR>SUCCESS</SUCCESS_INDICATOR>
		                            	) else (
		                            		<SUCCESS_INDICATOR>ERROR</SUCCESS_INDICATOR>
		                            	)
		                           	) else (
		                           		<SUCCESS_INDICATOR>TIMEOUT</SUCCESS_INDICATOR>
		                           	)
		                    }
		                    {
		                        let $result :=
		                            for $messages in $consultaaplicacionpagoptmoResponse1/Status/messages
		                            return
		                                <MESSAGES>{ data($messages) }</MESSAGES>
		                        return
		                            $result[1]
		                    }               
		                    {
		                        for $ID in $consultaaplicacionpagoptmoResponse1/WSFICOADVDEALSLIPENTRYType[1]/gWSFICOADVDEALSLIPENTRYDetailType/mWSFICOADVDEALSLIPENTRYDetailType[1]/ID
		                        return
		                            <LOAN_ID>{ data($ID) }</LOAN_ID>
		                    }
		                    {
		                        for $ADVDATE in $consultaaplicacionpagoptmoResponse1/WSFICOADVDEALSLIPENTRYType[1]/gWSFICOADVDEALSLIPENTRYDetailType/mWSFICOADVDEALSLIPENTRYDetailType[1]/ADVDATE
		                        return
		                            <PAYMENT_DATE>{ data($ADVDATE) }</PAYMENT_DATE>
		                    }
		                    {
		                        for $DEALSLIPID in $consultaaplicacionpagoptmoResponse1/WSFICOADVDEALSLIPENTRYType[1]/gWSFICOADVDEALSLIPENTRYDetailType/mWSFICOADVDEALSLIPENTRYDetailType[1]/DEALSLIPID
		                        return
		                            <DEALSLIP_ID>{ data($DEALSLIPID) }</DEALSLIP_ID>
		                    }
		                    {
		                        for $ERRORMESSAGE in $consultaaplicacionpagoptmoResponse1/WSFICOADVDEALSLIPENTRYType[1]/gWSFICOADVDEALSLIPENTRYDetailType/mWSFICOADVDEALSLIPENTRYDetailType[1]/ERRORMESSAGE
		                        return
		                            <ERROR_MESSAGE>{ data($ERRORMESSAGE) }</ERROR_MESSAGE>
		                    }
		                </ns1:consultaAplicaPagoPrestamo>
		            ) else (
		            	<ns1:consultaAplicaPagoPrestamo/>
		            )
		    	}
            </ns1:sjConsultaPrestamoResponseType>
        </ns1:sjConsultaPrestamoResponse>
};

declare variable $consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse) external;
declare variable $consultadepagodeprestamoAAResponse1 as element(ns0:ConsultadepagodeprestamoAAResponse) external;
declare variable $consultaaplicacionpagoptmoResponse1 as element(ns0:ConsultaaplicacionpagoptmoResponse) external;
declare variable $consultabackofficepagoptmoAAResponse1 as element(ns0:ConsultabackofficepagoptmoAAResponse) external;
declare variable $transactionType as xs:string external;

xf:sjConsultaDatosPagoPrestamoOut($consultadesaldodeprestamoResponse1,
    $consultadepagodeprestamoAAResponse1,
    $consultaaplicacionpagoptmoResponse1,
    $consultabackofficepagoptmoAAResponse1,
    $transactionType
    )