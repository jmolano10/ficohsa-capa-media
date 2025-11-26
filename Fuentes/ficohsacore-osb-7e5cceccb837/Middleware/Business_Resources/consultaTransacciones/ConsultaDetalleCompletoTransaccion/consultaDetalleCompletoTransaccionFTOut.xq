(:: pragma bea:global-element-parameter parameter="$consultadetransaccionFTResponse" element="ns1:ConsultadetransaccionFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionFTOut/";

(: Retorna el total de comisiones de una transaccion, omitiendo la comision por venta de divisas :)
declare function commissionTotal($commType as xs:string , $commAmount as xs:string)  
	as xs:double {
	  let $COMM_TYPE := fn:tokenize($commType, "\|\|")
	  let $COMM_AMOUNT := fn:tokenize($commAmount, "\|\|")
	  let $TOTAL := fn:sum(

	  for $i in (1 to max((count($COMM_TYPE), count($COMM_AMOUNT))))
	  return
	  	if ($COMM_TYPE[$i] != "" or $COMM_AMOUNT[$i] != "") then (
	  		if ($COMM_TYPE[$i] != "FICOCOMMM") then (
	  			xs:double(substring($COMM_AMOUNT[$i], 4))
	  		) else ()
	  	) else()
	)
	return $TOTAL
};

declare function xf:consultaDetalleCompletoTransaccionFTOut($consultadetransaccionFTResponse as element(ns1:ConsultadetransaccionFTResponse))
    as element(ns0:consultaDetalleCompletoTransaccionResponse) {
        <ns0:consultaDetalleCompletoTransaccionResponse>
            <TYPE>FT</TYPE>
            {
                for $TRANSACTIONNAME in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/TRANSACTIONNAME
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTIONNAME) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $PAYMENTDETAILS in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/PAYMENTDETAILS
                return
                    <CUSTOMER_DESCRIPTION>{ fn:replace($PAYMENTDETAILS,'\.\|\|','') }</CUSTOMER_DESCRIPTION>
            }
            {
                for $DATETIME in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DATETIME
                return
                	if(exists($DATETIME/text())) then(
                    <BOOKING_DATE>{ concat("20",data($DATETIME)) }</BOOKING_DATE>
                    )
                    else(<BOOKING_DATE></BOOKING_DATE>)
            }
            {
                for $VALUEDATE in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/VALUEDATE
                return
                    <VALUE_DATE>{ data($VALUEDATE) }</VALUE_DATE>
            }
            {
                for $CHEQUENUMBER in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CHEQUENUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
            }
            {
                let $DEBITACCOUNT := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITACCOUNT/text())
                let $DEBITACCTALTID := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITACCTALTID/text())
                return
                	if($DEBITACCTALTID != "") then (
                    	<DEBIT_ACCOUNT>{ data($DEBITACCTALTID) }</DEBIT_ACCOUNT>
                    ) else (
                    	<DEBIT_ACCOUNT>{ data($DEBITACCOUNT) }</DEBIT_ACCOUNT>
                    )
            }
            {
                for $AMOUNTDEBITED in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/AMOUNTDEBITED
                return
                    <DEBIT_AMOUNT>{ substring($AMOUNTDEBITED, 4) }</DEBIT_AMOUNT>
            }
            {
                for $DEBITCURRENCY in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                let $CREDITACCOUNT := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CREDITACCOUNT/text())
                let $CREDITACCTALTID := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CREDITACCTALTID/text())
                return
                	if($CREDITACCTALTID != "") then (
                    	<CREDIT_ACCOUNT>{ data($CREDITACCTALTID) }</CREDIT_ACCOUNT>
                    ) else (
                    	<CREDIT_ACCOUNT>{ data($CREDITACCOUNT) }</CREDIT_ACCOUNT>
                    )
            }
            {
                for $AMOUNTCREDITED in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring($AMOUNTCREDITED, 4) }</CREDIT_AMOUNT>
            }
            {
                for $CREDITCURRENCY in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $INPUTTER in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORISER in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/AUTHORISER
                return
                    <AUTHORIZER>{ data($AUTHORISER) }</AUTHORIZER>
            }
            {
                for $EXTERNALBENACCOUNT in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/EXTERNALBENACCOUNT
                return
                    <EXTERNAL_BEN_ACCOUNT>{ data($EXTERNALBENACCOUNT) }</EXTERNAL_BEN_ACCOUNT>
            }      
                              {
                for $CONTRACTID in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CONTRACTID
                return
                    <CONTRACT_ID>{ data($CONTRACTID) }</CONTRACT_ID>
            } 
            {
                for $DEBITAMOUNT in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITAMOUNT
                return
                    <TRANSACTION_AMOUNT>{ data($DEBITAMOUNT) }</TRANSACTION_AMOUNT>
            }
			{
			    let $DEBITCURRENCY := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITCURRENCY/text())
			    let $COMMAMOUNT := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/COMMAMOUNT/text())		    
			    let $COMMTYPE := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/COMMTYPE/text())
			    let $CHRGAMOUNT := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CHRGAMOUNT/text())		    
			    let $CHRGTYPE := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CHRGTYPE/text())
			    let $COMM_TOTAL := commissionTotal($COMMTYPE,$COMMAMOUNT)
			    let $CHRG_TOTAL := commissionTotal($CHRGTYPE,$CHRGAMOUNT)
			    return
			        <COMMISSION_AMOUNT>{ concat($DEBITCURRENCY,$COMM_TOTAL+$CHRG_TOTAL) } </COMMISSION_AMOUNT>
			}
            {
                for $REMITTANCEID in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/REMITTANCEID
                return
                    <REMITTANCE_ID>{ data($REMITTANCEID) }</REMITTANCE_ID>
            } 
            {
                for $COLLPAYCODE in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/COLLPAYCODE
                return
                    <COLL_PAY_CODE>{ data($COLLPAYCODE) }</COLL_PAY_CODE>
            } 
            {
                for $CREDITCARDNUMBER in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CREDITCARDNUMBER
                return
                    <CREDIT_CARD_NUMBER>{ data($CREDITCARDNUMBER) }</CREDIT_CARD_NUMBER>
            } 
            {
                let $PARENTREFERENCE := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/PARENTREFERENCE/text())
                let $T24LOANTXNREF := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/T24LOANTXNREF/text())
                return
                	if ($T24LOANTXNREF != "" ) then (
                    	<PARENT_REFERENCE>{ $T24LOANTXNREF }</PARENT_REFERENCE>
                    ) else (
                    	<PARENT_REFERENCE>{ $PARENTREFERENCE }</PARENT_REFERENCE>
                    )
            }
            {
                let $PAYMENTDETAILS := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/PAYMENTDETAILS/text())
                let $T24LOANNUMBER := fn:string($consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/T24LOANNUMBER/text())
                return
                    if ($T24LOANNUMBER != "") then (
                    	<LOAN_NUMBER>{ $T24LOANNUMBER }</LOAN_NUMBER>
                    ) else (
                    	<LOAN_NUMBER>{ $PAYMENTDETAILS }</LOAN_NUMBER>
                    )
            }
            {
                for $ORDERINGCUST in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/ORDERINGCUST
                return
                    <EXTERNAL_REMITTER_INFO>{ data(fn:replace($ORDERINGCUST,"\|\|","")) }</EXTERNAL_REMITTER_INFO>
            }                
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $consultadetransaccionFTResponse as element(ns1:ConsultadetransaccionFTResponse) external;

xf:consultaDetalleCompletoTransaccionFTOut($consultadetransaccionFTResponse)