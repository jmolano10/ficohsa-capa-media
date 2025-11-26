(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse1" element="ns0:ConsultadetransaccionTTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleTransaccionResponse" location="consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionTTOut/";

declare function xf:consultaDetalleTransaccionTTOut($consultadetransaccionTTResponse1 as element(ns0:ConsultadetransaccionTTResponse))
    as element(ns1:consultaDetalleTransaccionResponse) {
        <ns1:consultaDetalleTransaccionResponse>
            <TYPE>TT</TYPE>
            {
                for $TRANSACTIONNAME in $consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/TRANSACTIONNAME
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTIONNAME) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $NARRATIVE in $consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/NARRATIVE
                return
                    <CUSTOMER_DESCRIPTION>{ data($NARRATIVE) }</CUSTOMER_DESCRIPTION>
            }
            {
                for $DATETIME in $consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/DATETIME
                return
                	if(exists($DATETIME/text())) then (
                    <BOOKING_DATE>{ concat("20",data($DATETIME)) }</BOOKING_DATE>
                    )
                    else(<BOOKING_DATE></BOOKING_DATE>)
            }
            {
                for $VALUEDATE in $consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/VALUEDATE
                return
                    <VALUE_DATE>{ data($VALUEDATE) }</VALUE_DATE>
            }
            {
                for $CHEQUENUMBER in $consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CHEQUENUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
            }
            {
            	let $DRCRMARKER := fn:string($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/DRCRMARKER/text())
            	return
	            	if ($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY2 = "HNL") then (
	            		if ($DRCRMARKER = "DEBIT") then (
	            			<AMOUNT>{ data($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL2)*-1 }</AMOUNT>
	            		) else (
	            			<AMOUNT>{ data($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL2) }</AMOUNT>
	            		)
	            	) else (
	            		if ($DRCRMARKER = "DEBIT") then (
	            			<AMOUNT>{ data($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY2)*-1 }</AMOUNT>
						) else (
							<AMOUNT>{ data($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY2) }</AMOUNT>
						)	            			
	            	)
            }
            {
                for $INPUTTER in $consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORISER in $consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AUTHORISER
                return
                    <AUTHORIZER>{ data($AUTHORISER) }</AUTHORIZER>
            }
            {
            	let $CURRENCY1 := fn:string($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY1/text())
                let $AMOUNTLOCAL1 := fn:string($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL1/text())
                let $AMOUNTFCY1 := fn:string($consultadetransaccionTTResponse1/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY1/text())
                return
	                if($CURRENCY1 = "HNL") then (
                		<TRANSACTION_AMOUNT>{ data($AMOUNTLOCAL1) }</TRANSACTION_AMOUNT>
                	) else (
                		<TRANSACTION_AMOUNT>{ data($AMOUNTFCY1) }</TRANSACTION_AMOUNT>
                	)
             }

        </ns1:consultaDetalleTransaccionResponse>
};

declare variable $consultadetransaccionTTResponse1 as element(ns0:ConsultadetransaccionTTResponse) external;

xf:consultaDetalleTransaccionTTOut($consultadetransaccionTTResponse1)