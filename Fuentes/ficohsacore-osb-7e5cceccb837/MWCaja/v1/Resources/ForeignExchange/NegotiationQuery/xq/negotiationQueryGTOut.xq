(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/CONSNegociacionFX/xsd/MCCONSNegociacionFX_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:negotiationQueryResponse" location="../../xsd/ForeignExchangeTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCONSNegociacionFX";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/NegotiationQuery/xq/negotiationQueryGTOut/";

declare function xf:negotiationQueryGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns2:negotiationQueryResponse) {
        <ns2:negotiationQueryResponse>
            {
                for $PV_FOREX_TYPE in $outputParameters/ns0:PV_FOREX_TYPE
                return
                    <ns2:FOREX_TYPE>{ data($PV_FOREX_TYPE) }</ns2:FOREX_TYPE>
            }
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
                for $PN_LCY_AMOUNT in $outputParameters/ns0:PN_LCY_AMOUNT
                return
                    <ns2:LCY_AMOUNT>{ data($PN_LCY_AMOUNT) }</ns2:LCY_AMOUNT>
            }
            {
                for $PN_FCY_AMOUNT in $outputParameters/ns0:PN_FCY_AMOUNT
                return
                    <ns2:FCY_AMOUNT>{ data($PN_FCY_AMOUNT) }</ns2:FCY_AMOUNT>
            }
            {
                for $PV_FCY_ID in $outputParameters/ns0:PV_FCY_ID
                return
                    <ns2:FCY_ID>{ data($PV_FCY_ID) }</ns2:FCY_ID>
            }
            {
                for $PN_EXCHANGE_RATE in $outputParameters/ns0:PN_EXCHANGE_RATE
                return
                    <ns2:EXCHANGE_RATE>{ data($PN_EXCHANGE_RATE) }</ns2:EXCHANGE_RATE>
            }
        </ns2:negotiationQueryResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:negotiationQueryGTOut($outputParameters)
