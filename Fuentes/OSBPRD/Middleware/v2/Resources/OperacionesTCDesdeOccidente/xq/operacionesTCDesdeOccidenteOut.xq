(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoResponse" element="ns1:pagoTarjetaCreditoResponse" location="../../../../v3/Resources/PagoTarjetaCredito/xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:operacionesTCDesdeOccidenteResponse" location="../xsd/OperacionesTCDesdeOccidenteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTCDesdeOccidenteTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/OperacionesTCDesdeOccidente/operacionesTCDesdeOccidenteOut/";

declare function xf:operacionesTCDesdeOccidenteOut($requestType as xs:string,
    $cardHolderName as xs:string,
    $pagoTarjetaCreditoResponse as element(ns1:pagoTarjetaCreditoResponse))
    as element(ns0:operacionesTCDesdeOccidenteResponse) {
        <ns0:operacionesTCDesdeOccidenteResponse>
            {
        	if($requestType  = "QRY")then(
					<CARD_HOLDER_NAME>{ $cardHolderName }</CARD_HOLDER_NAME>
        		)else if($requestType  = "PMT")then(
					<CARD_HOLDER_NAME>{ $cardHolderName }</CARD_HOLDER_NAME>,
					for $LCY_PAYMENT in $pagoTarjetaCreditoResponse/LCY_PAYMENT
					return
						<LCY_PAYMENT>{ data($LCY_PAYMENT) }</LCY_PAYMENT>,
					for $PAYMENT_CURRENCY in $pagoTarjetaCreditoResponse/PAYMENT_CURRENCY
					return
						<PAYMENT_CURRENCY>{ data($PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>,
					for $BALANCE_PAYMENT in $pagoTarjetaCreditoResponse/BALANCE_PAYMENT
					return
						<BALANCE_PAYMENT>{ data($BALANCE_PAYMENT) }</BALANCE_PAYMENT>,
					for $BALANCE_CURRENCY in $pagoTarjetaCreditoResponse/BALANCE_CURRENCY
					return
						<BALANCE_CURRENCY>{ data($BALANCE_CURRENCY) }</BALANCE_CURRENCY>,
					for $EXCHANGE_RATE in $pagoTarjetaCreditoResponse/EXCHANGE_RATE
					return
						<EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>,
					for $DEBIT_ACCOUNT in $pagoTarjetaCreditoResponse/DEBIT_ACCOUNT
					return
						<DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>,
					for $DATE_TIME in $pagoTarjetaCreditoResponse/DATE_TIME
					return
					for $TRANSACTION_CURRENCY in $pagoTarjetaCreditoResponse/TRANSACTION_CURRENCY
					return
						<TRANSACTION_CURRENCY>{ data($TRANSACTION_CURRENCY) }</TRANSACTION_CURRENCY>,
					for $DEBIT_CURRENCY in $pagoTarjetaCreditoResponse/DEBIT_CURRENCY
					return
						<DEBIT_CURRENCY>{ data($DEBIT_CURRENCY) }</DEBIT_CURRENCY>,
					for $DEBIT_AMOUNT in $pagoTarjetaCreditoResponse/DEBIT_AMOUNT
					return
						<DEBIT_AMOUNT>{ data($DEBIT_AMOUNT) }</DEBIT_AMOUNT>
        		)else()
			}            
        </ns0:operacionesTCDesdeOccidenteResponse>
};

declare variable $requestType as xs:string external;
declare variable $cardHolderName as xs:string external;
declare variable $pagoTarjetaCreditoResponse as element(ns1:pagoTarjetaCreditoResponse) external;

xf:operacionesTCDesdeOccidenteOut($requestType,
    $cardHolderName,
    $pagoTarjetaCreditoResponse)