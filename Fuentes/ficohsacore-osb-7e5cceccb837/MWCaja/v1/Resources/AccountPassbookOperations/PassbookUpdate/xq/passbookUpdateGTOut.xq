(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/ActualizaLibreta/xsd/MCActualizaLibreta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:passbookUpdateResponse" location="../../xsd/AccountPassbookOperationsTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCActualizaLibreta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/accountPassbookOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountPassbookOperations/PassbookUpdate/xq/passbookUpdateGTOut/";

declare function xf:passbookUpdateGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:passbookUpdateResponse) {
        <ns1:passbookUpdateResponse>
            {
                for $PV_ACCOUNT_NUMBER in $outputParameters/ns0:PV_ACCOUNT_NUMBER
                return
                    <ns1:ACCOUNT_NUMBER>{ data($PV_ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            }
            {
                for $PV_NAME in $outputParameters/ns0:PV_NAME
                return
                    <ns1:NAME>{ data($PV_NAME) }</ns1:NAME>
            }
            {
                for $PN_PENDING_TRANSACTIONS in $outputParameters/ns0:PN_PENDING_TRANSACTIONS
                return
                    <ns1:PENDING_TRANSACTIONS>{ xs:decimal(data($PN_PENDING_TRANSACTIONS)) }</ns1:PENDING_TRANSACTIONS>
            }
            {
                for $PR_PRINTABLE_RECORDS in $outputParameters/ns0:PR_PRINTABLE_RECORDS
                return
                    <ns1:PRINTABLE_RECORDS>
                        {
                            for $PRINTABLE_RECORD_ITEM in $PR_PRINTABLE_RECORDS/ns0:PRINTABLE_RECORD/ns0:PRINTABLE_RECORD_ITEM
                            return
                            		if( empty($PRINTABLE_RECORD_ITEM/*) )then(
                            	
                            		)else(
		                                <ns1:PRINTABLE_RECORD>
		                                    <ns1:ID>{ xs:integer(data($PRINTABLE_RECORD_ITEM/ns0:ID)) }</ns1:ID>
		                                    <ns1:RECORD>{ data($PRINTABLE_RECORD_ITEM/ns0:RECORD) }</ns1:RECORD>
		                                </ns1:PRINTABLE_RECORD>
		                             )
                        }
                    </ns1:PRINTABLE_RECORDS>
            }
        </ns1:passbookUpdateResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:passbookUpdateGTOut($outputParameters)
