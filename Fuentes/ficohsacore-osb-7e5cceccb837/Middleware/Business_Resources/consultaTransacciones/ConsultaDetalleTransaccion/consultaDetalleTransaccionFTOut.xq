(:: pragma bea:global-element-parameter parameter="$consultadetransaccionFTResponse1" element="ns0:ConsultadetransaccionFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleTransaccionResponse" location="consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionFTOut/";

declare function xf:consultaDetalleTransaccionFTOut($consultadetransaccionFTResponse1 as element(ns0:ConsultadetransaccionFTResponse),
	$account as xs:string)
    as element(ns1:consultaDetalleTransaccionResponse) {
        <ns1:consultaDetalleTransaccionResponse>
            <TYPE>FT</TYPE>
            {
                for $TRANSACTIONNAME in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/TRANSACTIONNAME
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTIONNAME) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $PAYMENTDETAILS in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/PAYMENTDETAILS
                return
                    <CUSTOMER_DESCRIPTION>{ fn:replace($PAYMENTDETAILS,'\.\|\|','') }</CUSTOMER_DESCRIPTION>
            }
            {
                for $DATETIME in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DATETIME
                return
                	if(exists($DATETIME/text())) then(
                    <BOOKING_DATE>{ concat("20",data($DATETIME)) }</BOOKING_DATE>
                    )
                    else(<BOOKING_DATE></BOOKING_DATE>)
            }
            {
                for $VALUEDATE in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/VALUEDATE
                return
                    <VALUE_DATE>{ data($VALUEDATE) }</VALUE_DATE>
            }
            {
                for $CHEQUENUMBER in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/CHEQUENUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
            } 
            {
            	if ( number($consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITACCOUNT) = number($account) or
            	     data($consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITACCTALTID) = $account) then (
            		<AMOUNT>{ number(substring(data($consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/AMOUNTDEBITED), 4))*-1 }</AMOUNT>
            	) else (
            		<AMOUNT>{ number(substring(data($consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/AMOUNTCREDITED), 4)) }</AMOUNT>
            	)
            }           
            {
                for $INPUTTER in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORISER in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/AUTHORISER
                return
                    <AUTHORIZER>{ data($AUTHORISER) }</AUTHORIZER>
            }
            {
                for $DEBITAMOUNT in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/DEBITAMOUNT
                return
                    <TRANSACTION_AMOUNT>{ data($DEBITAMOUNT) }</TRANSACTION_AMOUNT>
            }
           {
                for $COMMISSIONAMOUNT in $consultadetransaccionFTResponse1/WSFTTRANSACTIONType[1]/gWSFTTRANSACTIONDetailType/mWSFTTRANSACTIONDetailType[1]/COMMISSIONAMOUNT
                return
                    <COMMISSION_AMOUNT>{ data($COMMISSIONAMOUNT) }</COMMISSION_AMOUNT>
            }

        </ns1:consultaDetalleTransaccionResponse>
};

declare variable $consultadetransaccionFTResponse1 as element(ns0:ConsultadetransaccionFTResponse) external;
declare variable $account as xs:string external;

xf:consultaDetalleTransaccionFTOut($consultadetransaccionFTResponse1,
	$account)