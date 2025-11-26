(:: pragma bea:global-element-parameter parameter="$actualizaEstadoTransferenciaSwift" element="ns1:actualizaEstadoTransferenciaSwift" location="../xsd/actualizaEstadoTransferenciaSwiftTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:updatePaymentStatusRequest" location="../../../BusinessServices/SWIFT/OIC/xsd/updatePaymentStatusTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/updatePaymentStatus";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoTransferenciaSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTransferenciaSwift/xq/updatePaymentStatusIn/";

declare function xf:updatePaymentStatusIn($actualizaEstadoTransferenciaSwift as element(ns1:actualizaEstadoTransferenciaSwift))
    as element(ns0:updatePaymentStatusRequest) {
        <ns0:updatePaymentStatusRequest>
            <ns0:from>{ data($actualizaEstadoTransferenciaSwift/RECEIVER_BIC) }</ns0:from>
            <ns0:businessService>{ data($actualizaEstadoTransferenciaSwift/GPI_INDICATOR) }</ns0:businessService>
            <ns0:updatePaymentScenario>{ data($actualizaEstadoTransferenciaSwift/PAYMENT_TYPE) }</ns0:updatePaymentScenario>
            <ns0:uetr>{ data($actualizaEstadoTransferenciaSwift/UETR) }</ns0:uetr>
            <ns0:instructionIdentification>{ data($actualizaEstadoTransferenciaSwift/INSTRUCTION_IDENTIFICATION) }</ns0:instructionIdentification>
            <ns0:paymentStatus>
                <ns0:detailedStatus>
                    <ns0:originator>{ data($actualizaEstadoTransferenciaSwift/REMITTER_BIC) }</ns0:originator>
                    <ns0:fundsAvailable>{ fn:adjust-dateTime-to-timezone(current-dateTime(), xdt:dayTimeDuration('PT0H')) }</ns0:fundsAvailable>
                    <ns0:settlementMethod>{ data($actualizaEstadoTransferenciaSwift/SETTLEMENT_METHOD) }</ns0:settlementMethod>
                    <ns0:forwardedToAgent>{ data($actualizaEstadoTransferenciaSwift/FORWARDED_TO_AGENT) }</ns0:forwardedToAgent>
                    <ns0:transactionStatus>
                        <ns0:status>{ data($actualizaEstadoTransferenciaSwift/TRANSACTION_STATUS) }</ns0:status>
                        <ns0:reason>{ data($actualizaEstadoTransferenciaSwift/REJECTION_CODE) }</ns0:reason>
                    </ns0:transactionStatus>
                    <ns0:return>{ data($actualizaEstadoTransferenciaSwift/RETURN) }</ns0:return>
                    <ns0:confirmedAmount>
                        <ns0:currency>{ data($actualizaEstadoTransferenciaSwift/TRANSACTION_CURRENCY) }</ns0:currency>
                        <ns0:amount>{ data($actualizaEstadoTransferenciaSwift/TRANSACTION_AMOUNT) }</ns0:amount>
                    </ns0:confirmedAmount>
                    {
                        for $TRANSACTION_CHARGE in $actualizaEstadoTransferenciaSwift/TRANSACTION_CHARGES/TRANSACTION_CHARGE
                        return
                            <ns0:chargeAmount>
                                <ns0:currency>{ data($TRANSACTION_CHARGE/CURRENCY) }</ns0:currency>
                                <ns0:amount>{ data($TRANSACTION_CHARGE/AMOUNT) }</ns0:amount>
                            </ns0:chargeAmount>
                    }
                    <ns0:chargeBearer>{ data($actualizaEstadoTransferenciaSwift/CHARGE_BEARER) }</ns0:chargeBearer>
                    <ns0:foreignExchangeDetails>
                        <ns0:sourceCurrency>{ data($actualizaEstadoTransferenciaSwift/EXCHANGE_RATE_DETAILS/SOURCE_CURRENCY) }</ns0:sourceCurrency>
                        <ns0:targetCurrency>{ data($actualizaEstadoTransferenciaSwift/EXCHANGE_RATE_DETAILS/TARGET_CURRENCY) }</ns0:targetCurrency>
                        <ns0:exchangeRate>{ data($actualizaEstadoTransferenciaSwift/EXCHANGE_RATE_DETAILS/EXCHANGE_RATE) }</ns0:exchangeRate>
                    </ns0:foreignExchangeDetails>
                </ns0:detailedStatus>
            </ns0:paymentStatus>
        </ns0:updatePaymentStatusRequest>
};

declare variable $actualizaEstadoTransferenciaSwift as element(ns1:actualizaEstadoTransferenciaSwift) external;

xf:updatePaymentStatusIn($actualizaEstadoTransferenciaSwift)