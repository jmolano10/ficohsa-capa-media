xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse" element="ns1:ConsultadetransaccionTTResponse" location="../../../../Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="../xsd/consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionTTOut/";

declare function xf:consultaDetalleCompletoTransaccionTTOut($consultadetransaccionTTResponse as element(ns1:ConsultadetransaccionTTResponse))
    as element(ns0:consultaDetalleCompletoTransaccionResponse) {
        <ns0:consultaDetalleCompletoTransaccionResponse>
            <TYPE>TT</TYPE>
            {
                for $TRANSACTIONCODE in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/TRANSACTIONCODE
                return
                    <TRANSACTION_CODE>{ data($TRANSACTIONCODE) }</TRANSACTION_CODE>
            }
            {
                for $TRANSACTIONNAME in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/TRANSACTIONNAME
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTIONNAME) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $NARRATIVE in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/NARRATIVE
                return
                    <CUSTOMER_DESCRIPTION>{ fn:replace(fn:replace(data($NARRATIVE),"\|\|",""),"!!","-") }</CUSTOMER_DESCRIPTION>
            }
            {
                for $DATETIME in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/DATETIME
                return
                	if(exists($DATETIME/text())) then(
                    <BOOKING_DATE>{ concat("20",data($DATETIME)) }</BOOKING_DATE>
                    )
                    else(<BOOKING_DATE></BOOKING_DATE>)
            }            
            {
                for $VALUEDATE in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/VALUEDATE
                return
                    <VALUE_DATE>{ data($VALUEDATE) }</VALUE_DATE>
            }
            {
                for $CHEQUENUMBER in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CHEQUENUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
            }
            {
                let $DRCRMARKER := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/DRCRMARKER/text())
                let $ACCOUNT1 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/ACCOUNT1/text())
                let $CURRENCY1 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY1/text())
                let $AMOUNTLOCAL1 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL1/text())
                let $AMOUNTFCY1 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY1/text())
                let $ACCOUNT2 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/ACCOUNT2/text())
                let $ACCOUNT2ALTID := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/ACCOUNT2ALTID/text())
                let $CURRENCY2 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY2/text())
                let $AMOUNTLOCAL2 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL2/text())
                let $AMOUNTFCY2 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY2/text())
                let $NETAMOUNT := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/NETAMOUNT/text())
                return
                	if($DRCRMARKER = "CREDIT") then (
                    	<DEBIT_ACCOUNT>{ data($ACCOUNT1) }</DEBIT_ACCOUNT>,
                    	<DEBIT_AMOUNT>{ data($NETAMOUNT) }</DEBIT_AMOUNT>,
                    	<DEBIT_CURRENCY>{ data($CURRENCY1) }</DEBIT_CURRENCY>,
                    	if($ACCOUNT2ALTID != "") then (
                    		<CREDIT_ACCOUNT>{ data($ACCOUNT2ALTID) }</CREDIT_ACCOUNT>
                    	) else (
                    		<CREDIT_ACCOUNT>{ data($ACCOUNT2) }</CREDIT_ACCOUNT>
                    	),
                    	if($CURRENCY2 = "HNL") then (
                    		<CREDIT_AMOUNT>{ data($AMOUNTLOCAL2) }</CREDIT_AMOUNT>
                    	) else (
                    		<CREDIT_AMOUNT>{ data($AMOUNTFCY2) }</CREDIT_AMOUNT>
                    	),
                    	<CREDIT_CURRENCY>{ data($CURRENCY2) }</CREDIT_CURRENCY>                    	
                    ) else (
                    	if($ACCOUNT2ALTID != "") then (
                    		<DEBIT_ACCOUNT>{ data($ACCOUNT2ALTID) }</DEBIT_ACCOUNT>
                    	) else (
                    		<DEBIT_ACCOUNT>{ data($ACCOUNT2) }</DEBIT_ACCOUNT>
                    	),
                    	<DEBIT_AMOUNT>{ data($NETAMOUNT) }</DEBIT_AMOUNT>,
                    	<DEBIT_CURRENCY>{ data($CURRENCY2) }</DEBIT_CURRENCY>,
                    	<CREDIT_ACCOUNT>{ data($ACCOUNT1) }</CREDIT_ACCOUNT>,
                    	if($CURRENCY1 = "HNL") then (
                    		<CREDIT_AMOUNT>{ data($AMOUNTLOCAL1) }</CREDIT_AMOUNT>
                    	) else (
                    		<CREDIT_AMOUNT>{ data($AMOUNTFCY1) }</CREDIT_AMOUNT>
                    	),
                    	<CREDIT_CURRENCY>{ data($CURRENCY1) }</CREDIT_CURRENCY> 
                    )
            }
            {
                for $INPUTTER in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORISER in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AUTHORISER
                return
                    <AUTHORIZER>{ data($AUTHORISER) }</AUTHORIZER>
            }
            {
            	let $CURRENCY1 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY1/text())
                let $AMOUNTLOCAL1 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL1/text())
                let $AMOUNTFCY1 := fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY1/text())
                return
	                if($CURRENCY1 = "HNL") then (
                		<TRANSACTION_AMOUNT>{ data($AMOUNTLOCAL1) }</TRANSACTION_AMOUNT>
                	) else (
                		<TRANSACTION_AMOUNT>{ data($AMOUNTFCY1) }</TRANSACTION_AMOUNT>
                	)
            }
            {
                for $REMITTANCEID in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/REMITTANCEID
                return
                    <REMITTANCE_ID>{ data($REMITTANCEID) }</REMITTANCE_ID>
            } 
            {
                for $COLLPAYCODE in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/COLLPAYCODE
                return
                    <COLL_PAY_CODE>{ data($COLLPAYCODE) }</COLL_PAY_CODE>
            } 
            {
                for $CREDITCARDNUMBER in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CREDITCARDNUMBER
                return
                    <CREDIT_CARD_NUMBER>{ data($CREDITCARDNUMBER) }</CREDIT_CARD_NUMBER>
            } 
            {
                for $PARENTREFERENCE in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/PARENTREFERENCE
                return
                    <PARENT_REFERENCE>{ data($PARENTREFERENCE) }</PARENT_REFERENCE>
            }
            {
                for $LOANNUMBER in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/LOANNUMBER
                return
                    <LOAN_NUMBER>{ data($LOANNUMBER) }</LOAN_NUMBER>
            }  
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $consultadetransaccionTTResponse as element(ns1:ConsultadetransaccionTTResponse) external;

xf:consultaDetalleCompletoTransaccionTTOut($consultadetransaccionTTResponse)