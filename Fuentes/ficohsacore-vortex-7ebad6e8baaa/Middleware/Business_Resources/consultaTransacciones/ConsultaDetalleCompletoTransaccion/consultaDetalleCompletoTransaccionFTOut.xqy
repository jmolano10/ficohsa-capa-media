xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionFTResponse" element="ns1:ConsultadetransaccionFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionFTOut/";

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
                for $COMMISSIONAMOUNT in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/COMMISSIONAMOUNT
                return
                    <COMMISSION_AMOUNT>{ data($COMMISSIONAMOUNT) }</COMMISSION_AMOUNT>
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
                for $PARENTREFERENCE in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/PARENTREFERENCE
                return
                    <PARENT_REFERENCE>{ data($PARENTREFERENCE) }</PARENT_REFERENCE>
            }
            {
                for $PAYMENTDETAILS in $consultadetransaccionFTResponse/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/PAYMENTDETAILS
                return
                    <LOAN_NUMBER>{ data($PAYMENTDETAILS) }</LOAN_NUMBER>
            }   
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $consultadetransaccionFTResponse as element(ns1:ConsultadetransaccionFTResponse) external;

xf:consultaDetalleCompletoTransaccionFTOut($consultadetransaccionFTResponse)