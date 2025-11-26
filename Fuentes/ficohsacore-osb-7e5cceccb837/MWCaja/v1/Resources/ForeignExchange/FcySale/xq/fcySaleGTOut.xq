(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/VentaEfectivo/xsd/MCVentaEfectivo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns3:fcySaleResponse" location="../../xsd/ForeignExchangeTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCVentaEfectivo";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/FcySale/xq/fcySaleGTOut/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";

declare function xf:fcySaleGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns3:fcySaleResponse) {
        <ns3:fcySaleResponse>
            {
                for $PR_CUSTOMER_B in $outputParameters/ns0:PR_CUSTOMER_B
                return
                    <ns3:CUSTOMER>
                        {
                            let $LEGAL_ID_B := $PR_CUSTOMER_B/ns0:LEGAL_ID_B
                            return
                                <ns3:LEGAL_ID>
                                    <ns1:NAME>{ data($LEGAL_ID_B/ns0:NAME) }</ns1:NAME>
                                    <ns1:ID>{ data($LEGAL_ID_B/ns0:ID) }</ns1:ID>
                                </ns3:LEGAL_ID>
                        }
                    </ns3:CUSTOMER>
            }
            {
                for $PN_EXCHANGE_RATE in $outputParameters/ns0:PN_EXCHANGE_RATE
                return
                    <ns3:EXCHANGE_RATE>{ data($PN_EXCHANGE_RATE) }</ns3:EXCHANGE_RATE>
            }
            {
                for $PV_EXCHANGE_CURRENCY in $outputParameters/ns0:PV_EXCHANGE_CURRENCY
                return
                    <ns3:EXCHANGE_CURRENCY>{ data($PV_EXCHANGE_CURRENCY) }</ns3:EXCHANGE_CURRENCY>
            }
            {
                for $PN_LCY_AMOUNT in $outputParameters/ns0:PN_LCY_AMOUNT
                return
                    <ns3:LCY_AMOUNT>{ data($PN_LCY_AMOUNT) }</ns3:LCY_AMOUNT>
            }
            {
                for $PN_FCY_AMOUNT in $outputParameters/ns0:PN_FCY_AMOUNT
                return
                    <ns3:FCY_AMOUNT>{ data($PN_FCY_AMOUNT) }</ns3:FCY_AMOUNT>
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns0:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*))then(
                	
                	)else(
	                    <ns3:TRANSACTION_INFO>
	                        {
	                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns0:DEALSLIP
	                            return
	                                <ns2:DEALSLIP>
	                                    {
	                                        for $DS_RECORD_ITEM in $DEALSLIP/ns0:DS_RECORD/ns0:DS_RECORD_ITEM
	                                        return
	                                            <ns2:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns2:DS_RECORD>
	                                    }
	                                </ns2:DEALSLIP>
	                        }
	                        <ns2:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:TXN_REF_ID)) }</ns2:TXN_REF_ID>
	                        <ns2:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:TXN_TYPE_ID)) }</ns2:TXN_TYPE_ID>
	                        <ns2:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns0:TXN_DATE) }</ns2:TXN_DATE>
	                        <ns2:CURRENCY>{ data($PR_TRANSACTION_INFO/ns0:CURRENCY) }</ns2:CURRENCY>
	                        <ns2:AMOUNT>{ data($PR_TRANSACTION_INFO/ns0:AMOUNT) }</ns2:AMOUNT>
	                        <ns2:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns0:DATE_TIME) }</ns2:DATE_TIME>
	                        <ns2:USER>{ data($PR_TRANSACTION_INFO/ns0:USER_TX) }</ns2:USER>
	                        <ns2:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:BRANCH_ID)) }</ns2:BRANCH_ID>
	                        <ns2:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns0:BRANCH_NAME) }</ns2:BRANCH_NAME>
	                        <ns2:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns0:REQUIRES_CTR) }</ns2:REQUIRES_CTR>
	                        {
	                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns0:DEALSLIP_URL
	                            return
	                                <ns2:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns2:DEALSLIP_URL>
	                        }
	                    </ns3:TRANSACTION_INFO>
	                 )
            }
        </ns3:fcySaleResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:fcySaleGTOut($outputParameters)
