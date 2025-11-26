xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizaEstadoTransferenciaSwift" location="../../ActualizaEstadoTransferenciaSwift/xsd/actualizaEstadoTransferenciaSwiftTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTransferenciaSwift/xq/actualizaEstadoTransferenciaSwiftIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoTransferenciaSwiftTypes";

declare function xf:actualizaEstadoTransferenciaSwiftIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:actualizaEstadoTransferenciaSwift) {
        <ns1:actualizaEstadoTransferenciaSwift>
        {
	            let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	            let $messageListVM := fn:tokenize(data($messageListFM[16]),"@VM")
	            return (
					<GPI_INDICATOR>{ $messageListFM[1] }</GPI_INDICATOR>,
					<PAYMENT_TYPE>{ $messageListFM[2] }</PAYMENT_TYPE>,
					<UETR>{ $messageListFM[3] }</UETR>,
					<TRANSACTION_ID>{ $messageListFM[4] }</TRANSACTION_ID>,
					<RECEIVER_BIC>{ $messageListFM[5] }</RECEIVER_BIC>,
					<REMITTER_BIC>{ $messageListFM[6] }</REMITTER_BIC>,
					<APPROVAL_TIME>{ $messageListFM[7] }</APPROVAL_TIME>,
					<SETTLEMENT_METHOD>{ $messageListFM[8] }</SETTLEMENT_METHOD>,
					<FORWARDED_TO_AGENT>{ $messageListFM[9] }</FORWARDED_TO_AGENT>,
					<TRANSACTION_STATUS>{ $messageListFM[10] }</TRANSACTION_STATUS>,
					<RETURN>{ $messageListFM[11] }</RETURN>,
					<REJECTION_CODE>{ $messageListFM[12] }</REJECTION_CODE>,
					<INSTRUCTION_IDENTIFICATION>{ $messageListFM[13] }</INSTRUCTION_IDENTIFICATION>,
					<TRANSACTION_CURRENCY>{ $messageListFM[14] }</TRANSACTION_CURRENCY>,
					<TRANSACTION_AMOUNT>{ $messageListFM[15] }</TRANSACTION_AMOUNT>,
					<TRANSACTION_CHARGES>
					{
						for $index in (1 to fn:count($messageListVM))
						return
							let $messageListPipe := fn:tokenize(data($messageListVM[$index]),"@SM")
							return
								<TRANSACTION_CHARGE>
								{
										<AMOUNT>{ $messageListPipe[1] }</AMOUNT>,
										<CURRENCY>{ $messageListPipe[2] }</CURRENCY>
								}
								</TRANSACTION_CHARGE>
					}
					</TRANSACTION_CHARGES>,
					<CHARGE_BEARER>{ $messageListFM[17] }</CHARGE_BEARER>,
					<EXCHANGE_RATE_DETAILS>
						<SOURCE_CURRENCY>{ $messageListFM[18] }</SOURCE_CURRENCY>
						<TARGET_CURRENCY>{ $messageListFM[19] }</TARGET_CURRENCY>
						<EXCHANGE_RATE>{ $messageListFM[20] }</EXCHANGE_RATE>
					</EXCHANGE_RATE_DETAILS>
		        )
	     } 
        </ns1:actualizaEstadoTransferenciaSwift>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:actualizaEstadoTransferenciaSwiftIn($procesaMensajeGenericoT24)