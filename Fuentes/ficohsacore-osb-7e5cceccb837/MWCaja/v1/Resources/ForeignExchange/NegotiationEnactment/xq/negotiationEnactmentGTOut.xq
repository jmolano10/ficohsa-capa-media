(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns3:OutputParameters" location="../../../../BusinessServices/AbanksGT/ProcesamientoNegociacion/xsd/MCProcNegociacionFX_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:negotiationEnactmentResponse" location="../../xsd/ForeignExchangeTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/NegotiationEnactment/xq/negotiationEnactmentGTOut/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCProcNegociacionFX";

declare function xf:negotiationEnactmentGTOut($outputParameters as element(ns3:OutputParameters))
    as element(ns2:negotiationEnactmentResponse) {
        <ns2:negotiationEnactmentResponse>
            {
                for $PV_FOREX_TYPE in $outputParameters/ns3:PV_FOREX_TYPE
                return
                    <ns2:FOREX_TYPE>{ data($PV_FOREX_TYPE) }</ns2:FOREX_TYPE>
            }
            {
                for $PR_CUSTOMER_B in $outputParameters/ns3:PR_CUSTOMER_B
                return
                    <ns2:CUSTOMER>
                        {
                            let $LEGAL_ID_B := $PR_CUSTOMER_B/ns3:LEGAL_ID_B
                            return
                                <ns2:LEGAL_ID>
                                    <ns0:NAME>{ data($LEGAL_ID_B/ns3:NAME) }</ns0:NAME>
                                    <ns0:ID>{ data($LEGAL_ID_B/ns3:ID) }</ns0:ID>
                                </ns2:LEGAL_ID>
                        }
                    </ns2:CUSTOMER>
            }
            {
                for $PN_LCY_AMOUNT in $outputParameters/ns3:PN_LCY_AMOUNT
                return
	                if($PN_LCY_AMOUNT/text() != '')then(
	                	 <ns2:LCY_AMOUNT>{ data($PN_LCY_AMOUNT) }</ns2:LCY_AMOUNT>
	                )else()
                   
            }
            {
                for $PN_FCY_AMOUNT in $outputParameters/ns3:PN_FCY_AMOUNT
                return
                	if($PN_FCY_AMOUNT/text() != '')then(
                	 <ns2:FCY_AMOUNT>{ data($PN_FCY_AMOUNT) }</ns2:FCY_AMOUNT>
                )else()
                    
            }
            {
                for $PV_FCY_ID in $outputParameters/ns3:PV_FCY_ID
                return
                    <ns2:FCY_ID>{ data($PV_FCY_ID) }</ns2:FCY_ID>
            }
            {
                for $PN_EXCHANGE_RATE in $outputParameters/ns3:PN_EXCHANGE_RATE
                return
                    <ns2:EXCHANGE_RATE>{ data($PN_EXCHANGE_RATE) }</ns2:EXCHANGE_RATE>
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns3:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	
                	)else(
	                    <ns2:TRANSACTION_INFO>
	                        {
	                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns3:DEALSLIP
	                            return
	                                <ns1:DEALSLIP>
	                                    {
	                                        for $DS_RECORD_ITEM in $DEALSLIP/ns3:DS_RECORD/ns3:DS_RECORD_ITEM
	                                        return
	                                            <ns1:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns1:DS_RECORD>
	                                    }
	                                </ns1:DEALSLIP>
	                        }
	                        <ns1:TXN_REF_ID>{ data($PR_TRANSACTION_INFO/ns3:TXN_REF_ID) }</ns1:TXN_REF_ID>
	                        <ns1:TXN_TYPE_ID>{ data($PR_TRANSACTION_INFO/ns3:TXN_TYPE_ID) }</ns1:TXN_TYPE_ID>
	                        <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns3:TXN_DATE) }</ns1:TXN_DATE>
	                        <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns3:CURRENCY) }</ns1:CURRENCY>
	                        <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns3:AMOUNT) }</ns1:AMOUNT>
	                        <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns3:DATE_TIME) }</ns1:DATE_TIME>
	                        <ns1:USER>{ data($PR_TRANSACTION_INFO/ns3:USER_TX) }</ns1:USER>
	                        <ns1:BRANCH_ID>{ data($PR_TRANSACTION_INFO/ns3:BRANCH_ID) }</ns1:BRANCH_ID>
	                        <ns1:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns3:BRANCH_NAME) }</ns1:BRANCH_NAME>
	                        <ns1:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns3:REQUIRES_CTR) }</ns1:REQUIRES_CTR>
	                        {
	                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns3:DEALSLIP_URL
	                            return
	                                <ns1:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns1:DEALSLIP_URL>
	                        }
	                    </ns2:TRANSACTION_INFO>
	                 )
            }
        </ns2:negotiationEnactmentResponse>
};

declare variable $outputParameters as element(ns3:OutputParameters) external;

xf:negotiationEnactmentGTOut($outputParameters)
