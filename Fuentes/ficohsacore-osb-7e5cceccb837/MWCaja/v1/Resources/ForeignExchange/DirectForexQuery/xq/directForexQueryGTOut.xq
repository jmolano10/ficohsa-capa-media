(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/CONSFXEfectivo/xsd/MCCONSFXEfectivo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:directForexQueryResponse" location="../../xsd/ForeignExchangeTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCONSFXEfectivo";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/DirectForexQuery/xq/directForexQueryGTOut/";

declare function xf:directForexQueryGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns2:directForexQueryResponse) {
        <ns2:directForexQueryResponse>
            {
                for $PR_CUSTOMER_B in $outputParameters/ns0:PR_CUSTOMER_B
                return
                    <ns2:CUSTOMER>
                        {
                            let $LEGAL_ID_B := $PR_CUSTOMER_B/ns0:LEGAL_ID_B
                            return
                                <ns2:LEGAL_ID>
                                    <ns1:NAME>{ data($LEGAL_ID_B/ns0:NAME) }</ns1:NAME>
                                    <ns1:ID>{ data($LEGAL_ID_B/ns0:ID) }</ns1:ID>
                                </ns2:LEGAL_ID>
                        }
                        <ns2:NAME>{ data($PR_CUSTOMER_B/ns0:NAME) }</ns2:NAME>
                    </ns2:CUSTOMER>
            }
            {
                for $PN_EXCHANGE_RATE in $outputParameters/ns0:PN_EXCHANGE_RATE
                return
                    <ns2:EXCHANGE_RATE>{ data($PN_EXCHANGE_RATE) }</ns2:EXCHANGE_RATE>
            }
            {
                for $PV_EXCHANGE_CURRENCY in $outputParameters/ns0:PV_EXCHANGE_CURRENCY
                return
                    <ns2:EXCHANGE_CURRENCY>{ data($PV_EXCHANGE_CURRENCY) }</ns2:EXCHANGE_CURRENCY>
            }
            {
                for $PN_LCY_AMOUNT in $outputParameters/ns0:PN_LCY_AMOUNT
                return
                    <ns2:LCY_AMOUNT>{ data($PN_LCY_AMOUNT) }</ns2:LCY_AMOUNT>
            }
            {
                for $PN_FCY_AMOUNT in $outputParameters/ns0:PN_FCY_AMOUNT
                return
                    <ns2:FCY_AMOUNT>{ data($PN_FCY_AMOUNT) }</ns2:FCY_AMOUNT>
            }
        </ns2:directForexQueryResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:directForexQueryGTOut($outputParameters)
