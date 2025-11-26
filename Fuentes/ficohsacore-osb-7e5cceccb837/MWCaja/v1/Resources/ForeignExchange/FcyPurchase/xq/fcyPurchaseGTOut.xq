(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../BusinessServices/AbanksGT/CompraEfectivo/xsd/MCCompraEfectivo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns3:fcyPurchaseResponse" location="../../xsd/ForeignExchangeTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCompraEfectivo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/FcyPurchase/xq/fcyPurchaseGTOut/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";

declare function xf:fcyPurchaseGTOut($outputParameters as element(ns2:OutputParameters))
    as element(ns3:fcyPurchaseResponse) {
        <ns3:fcyPurchaseResponse>
            {
                for $PR_CUSTOMER_B in $outputParameters/ns2:PR_CUSTOMER_B
                return
                    <ns3:CUSTOMER>
                        {
                            let $LEGAL_ID_B := $PR_CUSTOMER_B/ns2:LEGAL_ID_B
                            return
                                <ns3:LEGAL_ID>
                                    <ns0:NAME>{ data($LEGAL_ID_B/ns2:NAME) }</ns0:NAME>
                                    <ns0:ID>{ data($LEGAL_ID_B/ns2:ID) }</ns0:ID>
                                </ns3:LEGAL_ID>
                        }
                    </ns3:CUSTOMER>
            }
            {
                for $PN_EXCHANGE_RATE in $outputParameters/ns2:PN_EXCHANGE_RATE
                return
                    <ns3:EXCHANGE_RATE>{ data($PN_EXCHANGE_RATE) }</ns3:EXCHANGE_RATE>
            }
            {
                for $PV_EXCHANGE_CURRENCY in $outputParameters/ns2:PV_EXCHANGE_CURRENCY
                return
                    <ns3:EXCHANGE_CURRENCY>{ data($PV_EXCHANGE_CURRENCY) }</ns3:EXCHANGE_CURRENCY>
            }
            {
                for $PN_LCY_AMOUNT in $outputParameters/ns2:PN_LCY_AMOUNT
                return
                	if($PN_LCY_AMOUNT/text() != '')then(
                		<ns3:LCY_AMOUNT>{ data($PN_LCY_AMOUNT) }</ns3:LCY_AMOUNT>
                	)else()
                    
            }
            {
                for $PN_FCY_AMOUNT in $outputParameters/ns2:PN_FCY_AMOUNT
                return
                	if($PN_FCY_AMOUNT/text() != '')then(
                		 <ns3:FCY_AMOUNT>{ data($PN_FCY_AMOUNT) }</ns3:FCY_AMOUNT>
                	)else()
                   
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns2:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	
                	)else(
	                    <ns3:TRANSACTION_INFO>
	                        {
	                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns2:DEALSLIP
	                            return
	                                <ns1:DEALSLIP>
	                                    {
	                                        for $DS_RECORD_ITEM in $DEALSLIP/ns2:DS_RECORD/ns2:DS_RECORD_ITEM
	                                        return
	                                            <ns1:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns1:DS_RECORD>
	                                    }
	                                </ns1:DEALSLIP>
	                        }
	                        <ns1:TXN_REF_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_REF_ID) }</ns1:TXN_REF_ID>
	                        <ns1:TXN_TYPE_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_TYPE_ID) }</ns1:TXN_TYPE_ID>
	                        <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns2:TXN_DATE) }</ns1:TXN_DATE>
	                        <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns2:CURRENCY) }</ns1:CURRENCY>
	                        <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns2:AMOUNT) }</ns1:AMOUNT>
	                        <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns2:DATE_TIME) }</ns1:DATE_TIME>
	                        <ns1:USER>{ data($PR_TRANSACTION_INFO/ns2:USER_TX) }</ns1:USER>
	                        <ns1:BRANCH_ID>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_ID) }</ns1:BRANCH_ID>
	                        <ns1:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_NAME) }</ns1:BRANCH_NAME>
	                        <ns1:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns2:REQUIRES_CTR) }</ns1:REQUIRES_CTR>
	                        {
	                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns2:DEALSLIP_URL
	                            return
	                                <ns1:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns1:DEALSLIP_URL>
	                        }
	                    </ns3:TRANSACTION_INFO>
	                 )
            }
        </ns3:fcyPurchaseResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:fcyPurchaseGTOut($outputParameters)
