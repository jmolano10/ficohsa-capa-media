(:: pragma bea:global-element-parameter parameter="$consultadetransaccionhistTTResponse" element="ns0:ConsultadetransaccionhistTTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleTransaccionResponse" location="consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetalleTransferencia/consultaDetalleTransaccion/consultaDetalleTransaccionHistTTOut/";

declare function xf:consultaDetalleTransaccionHistTTOut($consultadetransaccionhistTTResponse as element(ns0:ConsultadetransaccionhistTTResponse))
    as element(ns1:consultaDetalleTransaccionResponse) {
        <ns1:consultaDetalleTransaccionResponse>
            <TYPE>TT</TYPE>
            {
                for $TRANSACTIONNAME in $consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/TRANSACTIONNAME
                return
                    <TRANSACTION_DESCRIPTION>{ data($TRANSACTIONNAME) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $NARRATIVE in $consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/NARRATIVE
                return
                    <CUSTOMER_DESCRIPTION>{ data($NARRATIVE) }</CUSTOMER_DESCRIPTION>
            }
            {
                for $DATETIME in $consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/DATETIME
                return
                	if(exists($DATETIME/text())) then (
                    <BOOKING_DATE>{ concat("20",data($DATETIME)) }</BOOKING_DATE>
                    )
                    else(<BOOKING_DATE></BOOKING_DATE>)
            }
            {
                for $VALUEDATE in $consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/VALUEDATE
                return
                    <VALUE_DATE>{ data($VALUEDATE) }</VALUE_DATE>
            }
            {
                for $CHEQUENUMBER in $consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/CHEQUENUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
            }
            {
            	let $DRCRMARKER := fn:string($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/DRCRMARKER/text())
            	return
	            	if ($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/CURRENCY2 = "HNL") then (
	            		if ($DRCRMARKER = "DEBIT") then (
	            			<AMOUNT>{ data($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/AMOUNTLOCAL2)*-1 }</AMOUNT>
	            		) else (
	            			<AMOUNT>{ data($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/AMOUNTLOCAL2) }</AMOUNT>
	            		)
	            	) else (
	            		if ($DRCRMARKER = "DEBIT") then (
	            			<AMOUNT>{ data($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/AMOUNTFCY2)*-1 }</AMOUNT>
						) else (
							<AMOUNT>{ data($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/AMOUNTFCY2) }</AMOUNT>
						)	            			
	            	)
            }
            {
                for $INPUTTER in $consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORISER in $consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/AUTHORISER
                return
                    <AUTHORIZER>{ data($AUTHORISER) }</AUTHORIZER>
            }
            {
            	let $CURRENCY1 := fn:string($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/CURRENCY1/text())
                let $AMOUNTLOCAL1 := fn:string($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/AMOUNTLOCAL1/text())
                let $AMOUNTFCY1 := fn:string($consultadetransaccionhistTTResponse/WSTTTRANSACTIONHISTType[1]/gWSTTTRANSACTIONHISTDetailType/mWSTTTRANSACTIONHISTDetailType[1]/AMOUNTFCY1/text())
                return
	                if($CURRENCY1 = "HNL") then (
                		<TRANSACTION_AMOUNT>{ data($AMOUNTLOCAL1) }</TRANSACTION_AMOUNT>
                	) else (
                		<TRANSACTION_AMOUNT>{ data($AMOUNTFCY1) }</TRANSACTION_AMOUNT>
                	)
             }

        </ns1:consultaDetalleTransaccionResponse>
};

declare variable $consultadetransaccionhistTTResponse as element(ns0:ConsultadetransaccionhistTTResponse) external;

xf:consultaDetalleTransaccionHistTTOut($consultadetransaccionhistTTResponse)