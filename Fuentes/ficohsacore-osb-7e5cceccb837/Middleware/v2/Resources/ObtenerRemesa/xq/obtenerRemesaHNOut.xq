(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/INTFC/sincronizacionRemesasT24/xsd/sincronizacionRemesasT24_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:obtenerRemesaResponse" location="../xsd/obtenerRemesaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/sincronizacionRemesasT24";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/obtenerRemesaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerRemesa/xq/obtenerRemesaHNOut/";

declare function xf:obtenerRemesaHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:obtenerRemesaResponse) {
        <ns1:obtenerRemesaResponse>
            {
                for $PV_DEBIT_ACCOUNT in $outputParameters/ns0:PV_DEBIT_ACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($PV_DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $PV_BENEFICIARY_NAMES in $outputParameters/ns0:PV_BENEFICIARY_NAMES
                return
                    <BENEFICIARY_NAMES>{ data($PV_BENEFICIARY_NAMES) }</BENEFICIARY_NAMES>
            }
            {
                for $PV_BENEFICIARY_SURNAMES in $outputParameters/ns0:PV_BENEFICIARY_SURNAMES
                return
                    <BENEFICIARY_SURNAMES>{ data($PV_BENEFICIARY_SURNAMES) }</BENEFICIARY_SURNAMES>
            }
            {
                for $PV_DESTINATION_COUNTRY in $outputParameters/ns0:PV_DESTINATION_COUNTRY
                return
                    <DESTINATION_COUNTRY>{ data($PV_DESTINATION_COUNTRY) }</DESTINATION_COUNTRY>
            }
            {
                for $PV_DESTINATION_STATE in $outputParameters/ns0:PV_DESTINATION_STATE
                return
                    <DESTINATION_STATE>{ data($PV_DESTINATION_STATE) }</DESTINATION_STATE>
            }
            {
                for $PV_DESTINATION_CITY in $outputParameters/ns0:PV_DESTINATION_CITY
                return
                    <DESTINATION_CITY>{ data($PV_DESTINATION_CITY) }</DESTINATION_CITY>
            }
            {
                for $PV_REMITTER_NAMES in $outputParameters/ns0:PV_REMITTER_NAMES
                return
                    <REMITTER_NAMES>{ data($PV_REMITTER_NAMES) }</REMITTER_NAMES>
            }
            {
                for $PV_REMITTER_SURNAMES in $outputParameters/ns0:PV_REMITTER_SURNAMES
                return
                    <REMITTER_SURNAMES>{ data($PV_REMITTER_SURNAMES) }</REMITTER_SURNAMES>
            }
            {
                for $PV_REMITTER_ID_TYPE in $outputParameters/ns0:PV_REMITTER_ID_TYPE
                return
                    <REMITTER_ID_TYPE>{ data($PV_REMITTER_ID_TYPE) }</REMITTER_ID_TYPE>
            }
            {
                for $PV_REMITTER_ID_NUMBER in $outputParameters/ns0:PV_REMITTER_ID_NUMBER
                return
                    <REMITTER_ID_NUMBER>{ data($PV_REMITTER_ID_NUMBER) }</REMITTER_ID_NUMBER>
            }
            {
                for $PV_REMITTER_ADDRESS in $outputParameters/ns0:PV_REMITTER_ADDRESS
                return
                    <REMITTER_ADDRESS>{ data($PV_REMITTER_ADDRESS) }</REMITTER_ADDRESS>
            }
            {
                for $PV_REMITTER_PHONE in $outputParameters/ns0:PV_REMITTER_PHONE
                return
                    <REMITTER_PHONE>{ data($PV_REMITTER_PHONE) }</REMITTER_PHONE>
            }
            {
                for $PV_EXCHANGE_RATE in $outputParameters/ns0:PV_EXCHANGE_RATE
                return
                    <EXCHANGE_RATE>{ data($PV_EXCHANGE_RATE) }</EXCHANGE_RATE>
            }
            {
                for $PV_ORIGIN_CURRENCY in $outputParameters/ns0:PV_ORIGIN_CURRENCY
                return
                    <ORIGIN_CURRENCY>{ data($PV_ORIGIN_CURRENCY) }</ORIGIN_CURRENCY>
            }
            {
                for $PN_SHIPPING_AMOUNT in $outputParameters/ns0:PN_SHIPPING_AMOUNT
                return
                    <SHIPPING_AMOUNT>{ data($PN_SHIPPING_AMOUNT) }</SHIPPING_AMOUNT>
            }
            {
                for $PN_CHARGE_APPLIED in $outputParameters/ns0:PN_CHARGE_APPLIED
                return
                    <CHARGE_APPLIED>{ data($PN_CHARGE_APPLIED) }</CHARGE_APPLIED>
            }
            {
                for $PV_GENERIC1 in $outputParameters/ns0:PV_GENERIC1
                return
                    <GENERIC1>{ data($PV_GENERIC1) }</GENERIC1>
            }
            {
                for $PV_GENERIC2 in $outputParameters/ns0:PV_GENERIC2
                return
                    <GENERIC2>{ data($PV_GENERIC2) }</GENERIC2>
            }
        </ns1:obtenerRemesaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:obtenerRemesaHNOut($outputParameters)