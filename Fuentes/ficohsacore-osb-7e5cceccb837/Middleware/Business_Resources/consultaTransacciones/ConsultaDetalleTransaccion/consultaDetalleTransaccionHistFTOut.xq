(:: pragma bea:global-element-parameter parameter="$consultadetransaccionhistFTResponse" element="ns0:ConsultadetransaccionhistFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleTransaccionResponse" location="consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionHistFTOut/";

declare function xf:consultaDetalleTransaccionHistFTOut($consultadetransaccionhistFTResponse as element(ns0:ConsultadetransaccionhistFTResponse),
    $account as xs:string)
    as element(ns1:consultaDetalleTransaccionResponse) {
        <ns1:consultaDetalleTransaccionResponse>
            <TYPE>FT</TYPE>
            {
                for $TRANSACTIONNAME in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/TRANSACTIONNAME
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTIONNAME) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $PAYMENTDETAILS in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/PAYMENTDETAILS
                return
                    <CUSTOMER_DESCRIPTION>{ fn:replace($PAYMENTDETAILS,'\.\|\|','') }</CUSTOMER_DESCRIPTION>
            }
            {
                for $DATETIME in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/DATETIME
                return
                	if(exists($DATETIME/text())) then(
                    <BOOKING_DATE>{ concat("20",data($DATETIME)) }</BOOKING_DATE>
                    )
                    else(<BOOKING_DATE></BOOKING_DATE>)
            }
            {
                for $VALUEDATE in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/VALUEDATE
                return
                    <VALUE_DATE>{ data($VALUEDATE) }</VALUE_DATE>
            }
            {
                for $CHEQUENUMBER in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/CHEQUENUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
            }
            {
            	if ( number($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/DEBITACCOUNT) = number($account) or
            	     data($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/DEBITACCTALTID) = $account) then (
            		<AMOUNT>{ number(substring(data($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/AMOUNTDEBITED), 4))*-1 }</AMOUNT>
            	) else (
            		<AMOUNT>{ number(substring(data($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/AMOUNTCREDITED), 4)) }</AMOUNT>
            	)
            }
            {
                for $INPUTTER in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORISER in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/AUTHORISER
                return
                    <AUTHORIZER>{ data($AUTHORISER) }</AUTHORIZER>
            }
            {
                for $DEBITAMOUNT in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/DEBITAMOUNT
                return
                    <TRANSACTION_AMOUNT>{ data($DEBITAMOUNT) }</TRANSACTION_AMOUNT>
            }
           {
                for $COMMISSIONAMOUNT in $consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/gWSFTTRANSACTIONHISTDetailType/mWSFTTRANSACTIONHISTDetailType[1]/COMMISSIONAMOUNT
                return
                    <COMMISSION_AMOUNT>{ data($COMMISSIONAMOUNT) }</COMMISSION_AMOUNT>
            }
        </ns1:consultaDetalleTransaccionResponse>
};

declare variable $consultadetransaccionhistFTResponse as element(ns0:ConsultadetransaccionhistFTResponse) external;
declare variable $account as xs:string external;

xf:consultaDetalleTransaccionHistFTOut($consultadetransaccionhistFTResponse,
	$account)