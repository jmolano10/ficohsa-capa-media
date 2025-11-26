(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse" element="ns0:ConsultadetransaccionTTResponse" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaReciboTransaccionRTEResponse" location="../../xsds/ConsultaReciboTransaccionRTE/ConsultaReciboTransaccionRTE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboTransaccionRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboTransaccionRTE/ConsultaDetalleTransaccionTTOut/";

declare function xf:ConsultaDetalleTransaccionTTOut($consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse))
    as element(ns1:consultaReciboTransaccionRTEResponse) {
        <ns1:consultaReciboTransaccionRTEResponse>
            {
                for $ID in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/ID
                return
                    <TRANSACTION_ID>{ data($ID) }</TRANSACTION_ID>
            }
            {
                for $TRANSACTIONNAME in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/TRANSACTIONNAME
                return
                    <TRANSACTION_NAME>{ data($TRANSACTIONNAME) }</TRANSACTION_NAME>
            }            
            {
                for $DATETIME in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/DATETIME
                return
                    <DATE_TIME>{ concat("20", $DATETIME) }</DATE_TIME>
            }
            {
                for $CURRENCY2 in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY2
                return
                    <CURRENCY>{ data($CURRENCY2) }</CURRENCY>
            }
            <AMOUNT>
                {
                    if (fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/CURRENCY2/text()) = "HNL") then (
                    	fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTLOCAL2/text())
                    	
                    ) else (
                    	fn:string($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/AMOUNTFCY2/text())
                    )
                }
			</AMOUNT>
        </ns1:consultaReciboTransaccionRTEResponse>
};

declare variable $consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse) external;

xf:ConsultaDetalleTransaccionTTOut($consultadetransaccionTTResponse)