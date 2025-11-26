(:: pragma bea:global-element-parameter parameter="$cashTransactionRecord" element="ns2:cashTransactionRecord" location="../../xsd/CashTxnRecordOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/AbanksGT/RegistroIVE/xsd/MC_REGISTRO_IVE_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/cashTxnRecordOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MC_REGISTRO_IVE";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CashTxnRecordOperations/CashTransactionRecord/xq/mcRegistroIVEGTIn/";

declare function xf:mcRegistroIVEGTIn($cashTransactionRecord as element(ns2:cashTransactionRecord))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_TXN_TYPE>{ data($cashTransactionRecord/ns2:TXN_TYPE) }</ns1:PN_TXN_TYPE>
            <ns1:PV_ORIGINAL_CURRENCY>{ data($cashTransactionRecord/ns2:ORIGINAL_CURRENCY) }</ns1:PV_ORIGINAL_CURRENCY>
            <ns1:PN_ORIGINAL_AMOUNT>{ data($cashTransactionRecord/ns2:ORIGINAL_AMOUNT) }</ns1:PN_ORIGINAL_AMOUNT>
            <ns1:PN_USD_AMOUNT>{ data($cashTransactionRecord/ns2:USD_AMOUNT) }</ns1:PN_USD_AMOUNT>
            <ns1:PV_FUNDS_SOURCE>{ data($cashTransactionRecord/ns2:FUNDS_SOURCE) }</ns1:PV_FUNDS_SOURCE>
            <ns1:PV_FUNDS_TARGET>{ data($cashTransactionRecord/ns2:FUNDS_TARGET) }</ns1:PV_FUNDS_TARGET>
            {
                let $PERSONS := $cashTransactionRecord/ns2:PERSONS
                return
                    <ns1:PR_PERSONS>
                        {
                            let $INSTRUCTOR := $PERSONS/ns2:INSTRUCTOR
                            return
                                <ns1:INSTRUCTOR>
                                    <ns1:ID_TYPE>{ data($INSTRUCTOR/ns2:ID_TYPE) }</ns1:ID_TYPE>
                                    <ns1:ID_NUMBER>{ data($INSTRUCTOR/ns2:ID_NUMBER) }</ns1:ID_NUMBER>
                                    <ns1:CITY_OF_ISSUANCE>{ data($INSTRUCTOR/ns2:CITY_OF_ISSUANCE) }</ns1:CITY_OF_ISSUANCE>
                                    <ns1:STATE_OF_ISSUANCE>{ data($INSTRUCTOR/ns2:STATE_OF_ISSUANCE) }</ns1:STATE_OF_ISSUANCE>
                                    <ns1:COUNTRY_OF_ISSUANCE>{ data($INSTRUCTOR/ns2:COUNTRY_OF_ISSUANCE) }</ns1:COUNTRY_OF_ISSUANCE>
                                    <ns1:FIRST_FAMILY_NAME>{ data($INSTRUCTOR/ns2:FIRST_FAMILY_NAME) }</ns1:FIRST_FAMILY_NAME>
                                    {
                                        for $LAST_FAMILY_NAME in $INSTRUCTOR/ns2:LAST_FAMILY_NAME
                                        return
                                            <ns1:LAST_FAMILY_NAME>{ data($LAST_FAMILY_NAME) }</ns1:LAST_FAMILY_NAME>
                                    }
                                    <ns1:FIRST_GIVEN_NAME>{ data($INSTRUCTOR/ns2:FIRST_GIVEN_NAME) }</ns1:FIRST_GIVEN_NAME>
                                    {
                                        for $LAST_GIVEN_NAME in $INSTRUCTOR/ns2:LAST_GIVEN_NAME
                                        return
                                            <ns1:LAST_GIVEN_NAME>{ data($LAST_GIVEN_NAME) }</ns1:LAST_GIVEN_NAME>
                                    }
                                    <ns1:FULL_LEGAL_NAME>{ data($INSTRUCTOR/ns2:FULL_LEGAL_NAME) }</ns1:FULL_LEGAL_NAME>
                                    <ns1:GENDER>{ data($INSTRUCTOR/ns2:GENDER) }</ns1:GENDER>
                                    {
                                    	for $ACCOUNT_NUMBER in $INSTRUCTOR/ns2:ACCOUNT_NUMBER
                                    	return
                                    		if(string($ACCOUNT_NUMBER/text()) != "") then(
                                    			<ns1:ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns1:ACCOUNT_NUMBER>
                                    		)else()
                                    }                                    
                                    <ns1:DATE_OF_BIRTH>{ data($INSTRUCTOR/ns2:DATE_OF_BIRTH) }</ns1:DATE_OF_BIRTH>
                                    <ns1:NATIONALITY>{ data($INSTRUCTOR/ns2:NATIONALITY) }</ns1:NATIONALITY>
                                    <ns1:ADDRESS>{ data($INSTRUCTOR/ns2:ADDRESS) }</ns1:ADDRESS>
                                    {
                                        let $PHONE_NUMBERS := $INSTRUCTOR/ns2:PHONE_NUMBERS
                                        return
                                            <ns1:PHONE_NUMBERS>
                                                <ns1:PHONE_NUMBER_ITEM>
                                                    {
                                                        for $PHONE_NUMBER_ITEM in $PHONE_NUMBERS/ns2:PHONE_NUMBER_ITEM
                                                        return
                                                            <ns1:PHONE_NUMBER_ITEM_ITEM>
                                                                <ns1:LOCATION>{ data($PHONE_NUMBER_ITEM/ns2:LOCATION) }</ns1:LOCATION>
                                                                {
                                                                    for $TYPE in $PHONE_NUMBER_ITEM/ns2:TYPE
                                                                    return
                                                                        <ns1:TYPE>{ data($TYPE) }</ns1:TYPE>
                                                                }
                                                                {
                                                                    for $AREA_CODE in $PHONE_NUMBER_ITEM/ns2:AREA_CODE
                                                                    return
                                                                        <ns1:AREA_CODE>{ data($AREA_CODE) }</ns1:AREA_CODE>
                                                                }
                                                                <ns1:PHONE_NUMBER>{ data($PHONE_NUMBER_ITEM/ns2:PHONE_NUMBER) }</ns1:PHONE_NUMBER>
                                                            </ns1:PHONE_NUMBER_ITEM_ITEM>
                                                    }
                                                </ns1:PHONE_NUMBER_ITEM>
                                            </ns1:PHONE_NUMBERS>
                                    }
                                    {
                                        for $EXTRA_INFO in $INSTRUCTOR/ns2:EXTRA_INFO
                                        return
                                            <ns1:EXTRA_INFO>
                                                <ns1:KV_PAIR>
                                                    {
                                                        for $KV_PAIR in $EXTRA_INFO/ns2:KV_PAIR
                                                        return
                                                            <ns1:KV_PAIR_ITEM>
                                                                <ns1:KEY>{ data($KV_PAIR/ns2:KEY) }</ns1:KEY>
                                                                <ns1:VALUE>{ data($KV_PAIR/ns2:VALUE) }</ns1:VALUE>
                                                            </ns1:KV_PAIR_ITEM>
                                                    }
                                                </ns1:KV_PAIR>
                                            </ns1:EXTRA_INFO>
                                    }
                                </ns1:INSTRUCTOR>
                        }
                        <ns1:OTHER>
                            {
                                for $OTHER in $PERSONS/ns2:OTHER
                                return
                                    <ns1:OTHER_ITEM>
                                        <ns1:CUSTOMER_TYPE>{ data($OTHER/ns2:CUSTOMER_TYPE) }</ns1:CUSTOMER_TYPE>
                                        <ns1:SAME_AS_PAYER>{ data($OTHER/ns2:SAME_AS_PAYER) }</ns1:SAME_AS_PAYER>
                                        <ns1:ID_TYPE>{ data($OTHER/ns2:ID_TYPE) }</ns1:ID_TYPE>
                                        <ns1:ID_NUMBER>{ data($OTHER/ns2:ID_NUMBER) }</ns1:ID_NUMBER>
                                        <ns1:PLACE_OF_ISSUANCE>{ data($OTHER/ns2:CITY_OF_ISSUANCE) }</ns1:PLACE_OF_ISSUANCE>
                                        <ns1:STATE_OF_ISSUANCE>{ data($OTHER/ns2:STATE_OF_ISSUANCE) }</ns1:STATE_OF_ISSUANCE>
                                        <ns1:COUNTRY_OF_ISSUANCE>{ data($OTHER/ns2:COUNTRY_OF_ISSUANCE) }</ns1:COUNTRY_OF_ISSUANCE>
                                        <ns1:FIRST_FAMILY_NAME>{ data($OTHER/ns2:FIRST_FAMILY_NAME) }</ns1:FIRST_FAMILY_NAME>
                                        {
                                            for $LAST_FAMILY_NAME in $OTHER/ns2:LAST_FAMILY_NAME
                                            return
                                                <ns1:LAST_FAMILY_NAME>{ data($LAST_FAMILY_NAME) }</ns1:LAST_FAMILY_NAME>
                                        }
                                        <ns1:FIRST_GIVEN_NAME>{ data($OTHER/ns2:FIRST_GIVEN_NAME) }</ns1:FIRST_GIVEN_NAME>
                                        {
                                            for $LAST_GIVEN_NAME in $OTHER/ns2:LAST_GIVEN_NAME
                                            return
                                                <ns1:LAST_GIVEN_NAME>{ data($LAST_GIVEN_NAME) }</ns1:LAST_GIVEN_NAME>
                                        }
                                        <ns1:FULL_LEGAL_NAME>{ data($OTHER/ns2:FULL_LEGAL_NAME) }</ns1:FULL_LEGAL_NAME>
                                        <ns1:GENDER>{ data($OTHER/ns2:GENDER) }</ns1:GENDER>
                                        {
                                        	for $ACCOUNT_NUMBER in $OTHER/ns2:ACCOUNT_NUMBER
                                        	return
                                        		if(string($ACCOUNT_NUMBER/text()) != "") then(
                                        			<ns1:ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns1:ACCOUNT_NUMBER>
                                        		)else()	
                                        }                                        
                                        <ns1:DATE_OF_BIRTH>{ data($OTHER/ns2:DATE_OF_BIRTH) }</ns1:DATE_OF_BIRTH>
                                        <ns1:NATIONALITY>{ data($OTHER/ns2:NATIONALITY) }</ns1:NATIONALITY>
                                        {
                                            for $ADDRESS in $OTHER/ns2:ADDRESS
                                            return
                                                <ns1:ADDRESS>{ data($ADDRESS) }</ns1:ADDRESS>
                                        }
                                        {
                                            let $PHONE_NUMBERS := $OTHER/ns2:PHONE_NUMBERS
                                            return
                                                <ns1:PHONE_NUMBERS>
                                                    <ns1:PHONE_NUMBER_ITEM>
                                                        {
                                                            for $PHONE_NUMBER_ITEM in $PHONE_NUMBERS/ns2:PHONE_NUMBER_ITEM
                                                            return
                                                                <ns1:PHONE_NUMBER_ITEM_ITEM>
                                                                    <ns1:LOCATION>{ data($PHONE_NUMBER_ITEM/ns2:LOCATION) }</ns1:LOCATION>
                                                                    {
                                                                        for $TYPE in $PHONE_NUMBER_ITEM/ns2:TYPE
                                                                        return
                                                                            <ns1:TYPE>{ data($TYPE) }</ns1:TYPE>
                                                                    }
                                                                    {
                                                                        for $AREA_CODE in $PHONE_NUMBER_ITEM/ns2:AREA_CODE
                                                                        return
                                                                            <ns1:AREA_CODE>{ data($AREA_CODE) }</ns1:AREA_CODE>
                                                                    }
                                                                    <ns1:PHONE_NUMBER>{ data($PHONE_NUMBER_ITEM/ns2:PHONE_NUMBER) }</ns1:PHONE_NUMBER>
                                                                </ns1:PHONE_NUMBER_ITEM_ITEM>
                                                        }
                                                    </ns1:PHONE_NUMBER_ITEM>
                                                </ns1:PHONE_NUMBERS>
                                        }
                                        {
                                            for $EXTRA_INFO in $OTHER/ns2:EXTRA_INFO
                                            return
                                                <ns1:EXTRA_INFO>
                                                    <ns1:KV_PAIR>
                                                        {
                                                            for $KV_PAIR in $EXTRA_INFO/ns2:KV_PAIR
                                                            return
                                                                <ns1:KV_PAIR_ITEM>
                                                                    <ns1:KEY>{ data($KV_PAIR/ns2:KEY) }</ns1:KEY>
                                                                    <ns1:VALUE>{ data($KV_PAIR/ns2:VALUE) }</ns1:VALUE>
                                                                </ns1:KV_PAIR_ITEM>
                                                        }
                                                    </ns1:KV_PAIR>
                                                </ns1:EXTRA_INFO>
                                        }                                    
                                    </ns1:OTHER_ITEM>
                            }
                        </ns1:OTHER>
                    </ns1:PR_PERSONS>
            }
        	{
                let $NSO_INFO := $cashTransactionRecord/ns2:NSO_INFO
                return
                    <ns1:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns0:TRACE
                            return
                                <ns1:TRACE>
                                    <ns1:TELLER_ID>{  xs:decimal(data($TRACE/ns0:TELLER_ID)) }</ns1:TELLER_ID>
                                    <ns1:BRANCH_ID>{  xs:decimal(data($TRACE/ns0:BRANCH_ID)) }</ns1:BRANCH_ID>
                                    <ns1:CHANNEL_CODE>{  xs:decimal(data($TRACE/ns0:CHANNEL_CODE)) }</ns1:CHANNEL_CODE>
                                    <ns1:DATE_TIME>{ data($TRACE/ns0:DATE_TIME) }</ns1:DATE_TIME>
                                    {
                                    	for $QUEUE_TICKET_ID in $TRACE/ns0:QUEUE_TICKET_ID
                                    	return
                                    		<ns1:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns1:QUEUE_TICKET_ID>
                                    }
                                    {
                                    	for $TXN_REF_NO in $TRACE/ns0:TXN_REF_NO
                                    	return
                                    		<ns1:TXN_REF_NO>{ data($TXN_REF_NO) }</ns1:TXN_REF_NO>
                                    }
                                    {
                                    	for $DEALSLIP_ID in $TRACE/ns0:DEALSLIP_ID
                                    	return
                                    		<ns1:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns1:DEALSLIP_ID>
                                    }                                    
                                </ns1:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns0:AUTHORIZATION
                            return
                                <ns1:AUTHORIZATION>
                                    <ns1:TYPE>{ data($AUTHORIZATION/ns0:TYPE) }</ns1:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns0:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                <ns1:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns0:PAIR
                                                        return
                                                            <ns1:PAIR_ITEM>
                                                                <ns1:KEY>{ data($PAIR/ns0:KEY) }</ns1:KEY>
                                                                <ns1:VALUE>{ data($PAIR/ns0:VALUE) }</ns1:VALUE>
                                                            </ns1:PAIR_ITEM>
                                                    }
                                                </ns1:PAIR>
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns0:BANKNOTE_BREAKDOWN
                            return
                                <ns1:BANKNOTE_BREAKDOWN>
                                    <ns1:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns0:BANKNOTE
                                            return
                                                <ns1:BANKNOTE_ITEM>
                                                    <ns1:CURRENCY>{ data($BANKNOTE/ns0:CURRENCY) }</ns1:CURRENCY>
                                                    <ns1:BANKNOTE_VALUE>{ data($BANKNOTE/ns0:VALUE) }</ns1:BANKNOTE_VALUE>
                                                    <ns1:QUANTITY>{ xs:decimal(data($BANKNOTE/ns0:QUANTITY)) }</ns1:QUANTITY>
                                                    <ns1:TOTAL>{ data($BANKNOTE/ns0:TOTAL) }</ns1:TOTAL>
                                                </ns1:BANKNOTE_ITEM>
                                        }
                                    </ns1:BANKNOTE>
                                </ns1:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns0:ADDITIONAL_INFO
                            return
                                <ns1:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns0:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns0:PAIR
                                                    return
                                                        <ns1:PAIR_ITEM>
                                                            <ns1:KEY>{ data($PAIR/ns0:KEY) }</ns1:KEY>
                                                            <ns1:VALUE>{ data($PAIR/ns0:VALUE) }</ns1:VALUE>
                                                        </ns1:PAIR_ITEM>
                                                }
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:ADDITIONAL_INFO>
                        }
                        {
                        	for $CTR_REFERENCE in $NSO_INFO/ns1:CTR_REFERENCE
                        	return
                        		<ns1:CTR_REFERENCE>{ data($CTR_REFERENCE) }</ns1:CTR_REFERENCE>
                        }                        
                    </ns1:PR_NSO_INFO>
            }
        </ns1:InputParameters>
};

declare variable $cashTransactionRecord as element(ns2:cashTransactionRecord) external;

xf:mcRegistroIVEGTIn($cashTransactionRecord)
