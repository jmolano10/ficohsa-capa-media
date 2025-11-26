(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/ConsInfoCliente/xsd/MCConsInfoCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:customerQueryResponse" location="../../xsd/CashTxnRecordOperationsTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/cashTxnRecordOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsInfoCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CashTxnRecordOperations/CustomerQuery/xq/customerQueryGTOut/";

declare function xf:customerQueryGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns2:customerQueryResponse) {
        <ns2:customerQueryResponse>
            {
                for $PR_GENERAL in $outputParameters/ns1:PR_GENERAL
                return
                    <ns0:GENERAL>
                        {
                            let $GN_LEGAL_IDS := $PR_GENERAL/ns1:GN_LEGAL_IDS
                            return
                                <ns0:LEGAL_IDS>
                                    {
                                        for $GN_LEGAL_ID_ITEM in $GN_LEGAL_IDS/ns1:GN_LEGAL_ID/ns1:GN_LEGAL_ID_ITEM
                                        return
                                            <ns0:LEGAL_ID>
                                                <ns0:NAME>{ data($GN_LEGAL_ID_ITEM/ns1:NAME) }</ns0:NAME>
                                                <ns0:ID>{ data($GN_LEGAL_ID_ITEM/ns1:ID) }</ns0:ID>
                                                {
                                                	for $EXPIRATION_DATE in $GN_LEGAL_ID_ITEM/ns1:EXPIRATION_DATE
                                                	return
                                                	if(string( $EXPIRATION_DATE ) != "")then(
                                                	
                                                		<ns0:EXPIRATION_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($EXPIRATION_DATE)), ()) }</ns0:EXPIRATION_DATE>
                                                		
                                                	)else()
                                                }
                                                
                                                {
                                                    for $ISSUER in $GN_LEGAL_ID_ITEM/ns1:ISSUER
                                                    return
                                                        <ns0:ISSUER>{ data($ISSUER) }</ns0:ISSUER>
                                                }
                                                <ns0:CITY_OF_ISSUANCE>{ data($GN_LEGAL_ID_ITEM/ns1:CITY_OF_ISSUANCE) }</ns0:CITY_OF_ISSUANCE>
                                                <ns0:STATE_OF_ISSUANCE>{ data($GN_LEGAL_ID_ITEM/ns1:STATE_OF_ISSUANCE) }</ns0:STATE_OF_ISSUANCE>
                                                <ns0:COUNTRY_OF_ISSUANCE>{ data($GN_LEGAL_ID_ITEM/ns1:COUNTRY_OF_ISSUANCE) }</ns0:COUNTRY_OF_ISSUANCE>
                                            </ns0:LEGAL_ID>
                                    }
                                </ns0:LEGAL_IDS>
                        }
                        {
                            for $FIRST_GIVEN_NAME in $PR_GENERAL/ns1:FIRST_GIVEN_NAME
                            return
                                <ns0:FIRST_GIVEN_NAME>{ data($FIRST_GIVEN_NAME) }</ns0:FIRST_GIVEN_NAME>
                        }
                        {
                            for $SECOND_GIVEN_NAME in $PR_GENERAL/ns1:SECOND_GIVEN_NAME
                            return
                                <ns0:SECOND_GIVEN_NAME>{ data($SECOND_GIVEN_NAME) }</ns0:SECOND_GIVEN_NAME>
                        }
                        {
                            for $FIRST_FAMILY_NAME in $PR_GENERAL/ns1:FIRST_FAMILY_NAME
                            return
                                <ns0:FIRST_FAMILY_NAME>{ data($FIRST_FAMILY_NAME) }</ns0:FIRST_FAMILY_NAME>
                        }
                        {
                            for $SECOND_FAMILY_NAME in $PR_GENERAL/ns1:SECOND_FAMILY_NAME
                            return
                                <ns0:SECOND_FAMILY_NAME>{ data($SECOND_FAMILY_NAME) }</ns0:SECOND_FAMILY_NAME>
                        }
                        <ns0:LEGAL_FULL_NAME>{ data($PR_GENERAL/ns1:LEGAL_FULL_NAME) }</ns0:LEGAL_FULL_NAME>
                        {
                            for $GENDER in $PR_GENERAL/ns1:GENDER
                            return
                                <ns0:GENDER>{ data($GENDER) }</ns0:GENDER>
                        }
                        {
                        	for $DATE_OF_BIRTH in $PR_GENERAL/ns1:DATE_OF_BIRTH
                        	return
                        		if(string($DATE_OF_BIRTH) != "")then(
                        		
                        			<ns0:DATE_OF_BIRTH>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($DATE_OF_BIRTH)), ()) }</ns0:DATE_OF_BIRTH>
                        			
                        		)else()
                        }
                        
                        <ns0:NATIONALITY>{ data($PR_GENERAL/ns1:NATIONALITY) }</ns0:NATIONALITY>
                    </ns0:GENERAL>
            }
            {
                for $PR_PHONE_NUMBERS in $outputParameters/ns1:PR_PHONE_NUMBERS
                return
                    <ns0:PHONE_NUMBERS>
                        {
                            for $PHONE_NUMBER_ITEM_ITEM in $PR_PHONE_NUMBERS/ns1:PHONE_NUMBER_ITEM/ns1:PHONE_NUMBER_ITEM_ITEM
                            return
                                <ns0:PHONE_NUMBER_ITEM>
                                    <ns0:LOCATION>{ data($PHONE_NUMBER_ITEM_ITEM/ns1:LOCATION) }</ns0:LOCATION>
                                    <ns0:TYPE>{ data($PHONE_NUMBER_ITEM_ITEM/ns1:TYPE) }</ns0:TYPE>
                                    {
                                        for $AREA_CODE in $PHONE_NUMBER_ITEM_ITEM/ns1:AREA_CODE
                                        return
                                            <ns0:AREA_CODE>{ data($AREA_CODE) }</ns0:AREA_CODE>
                                    }
                                    <ns0:PHONE_NUMBER>{ data($PHONE_NUMBER_ITEM_ITEM/ns1:PHONE_NUMBER) }</ns0:PHONE_NUMBER>
                                    <ns0:IS_DEFAULT>{ data($PHONE_NUMBER_ITEM_ITEM/ns1:IS_DEFAULT) }</ns0:IS_DEFAULT>
                                </ns0:PHONE_NUMBER_ITEM>
                        }
                    </ns0:PHONE_NUMBERS>
            }
            {
                for $PR_ADDRESSES in $outputParameters/ns1:PR_ADDRESSES
                return
                    <ns0:ADDRESSES>
                        {
                            for $ADDRESS_ITEM_ITEM in $PR_ADDRESSES/ns1:ADDRESS_ITEM/ns1:ADDRESS_ITEM_ITEM
                            return
                                <ns0:ADDRESS_ITEM>
                                    {
                                        for $ADDRESS_CODE in $ADDRESS_ITEM_ITEM/ns1:ADDRESS_CODE
                                        return
                                            <ns0:ADDRESS_CODE>{ data($ADDRESS_CODE) }</ns0:ADDRESS_CODE>
                                    }
                                    <ns0:ADDRESS_TYPE>{ data($ADDRESS_ITEM_ITEM/ns1:ADDRESS_TYPE) }</ns0:ADDRESS_TYPE>
                                    {
                                        for $POSTAL_CODE in $ADDRESS_ITEM_ITEM/ns1:POSTAL_CODE
                                        return
                                            <ns0:POSTAL_CODE>{ data($POSTAL_CODE) }</ns0:POSTAL_CODE>
                                    }
                                    {
                                        for $COUNTRY_CODE in $ADDRESS_ITEM_ITEM/ns1:COUNTRY_CODE
                                        return
                                            <ns0:COUNTRY_CODE>{ data($COUNTRY_CODE) }</ns0:COUNTRY_CODE>
                                    }
                                    {
                                        for $DEPARTMENT_CODE in $ADDRESS_ITEM_ITEM/ns1:DEPARTMENT_CODE
                                        return
                                            <ns0:DEPARTMENT_CODE>{ data($DEPARTMENT_CODE) }</ns0:DEPARTMENT_CODE>
                                    }
                                    {
                                        for $MUNICIPALITY_CODE in $ADDRESS_ITEM_ITEM/ns1:MUNICIPALITY_CODE
                                        return
                                            <ns0:MUNICIPALITY_CODE>{ data($MUNICIPALITY_CODE) }</ns0:MUNICIPALITY_CODE>
                                    }
                                    {
                                        for $CITY_CODE in $ADDRESS_ITEM_ITEM/ns1:CITY_CODE
                                        return
                                            <ns0:CITY_CODE>{ data($CITY_CODE) }</ns0:CITY_CODE>
                                    }
                                    {
                                        for $DISTRICT_CODE in $ADDRESS_ITEM_ITEM/ns1:DISTRICT_CODE
                                        return
                                            <ns0:DISTRICT_CODE>{ data($DISTRICT_CODE) }</ns0:DISTRICT_CODE>
                                    }
                                    {
                                        for $ADDRESS_LINE_1 in $ADDRESS_ITEM_ITEM/ns1:ADDRESS_LINE_1
                                        return
                                            <ns0:ADDRESS_LINE_1>{ data($ADDRESS_LINE_1) }</ns0:ADDRESS_LINE_1>
                                    }
                                    {
                                        for $ADDRESS_LINE_2 in $ADDRESS_ITEM_ITEM/ns1:ADDRESS_LINE_2
                                        return
                                            <ns0:ADDRESS_LINE_2>{ data($ADDRESS_LINE_2) }</ns0:ADDRESS_LINE_2>
                                    }
                                    {
                                        for $ADDRESS_LINE_3 in $ADDRESS_ITEM_ITEM/ns1:ADDRESS_LINE_3
                                        return
                                            <ns0:ADDRESS_LINE_3>{ data($ADDRESS_LINE_3) }</ns0:ADDRESS_LINE_3>
                                    }
                                    {
                                        for $ADDRESS_LINE_4 in $ADDRESS_ITEM_ITEM/ns1:ADDRESS_LINE_4
                                        return
                                            <ns0:ADDRESS_LINE_4>{ data($ADDRESS_LINE_4) }</ns0:ADDRESS_LINE_4>
                                    }
                                    {
                                        for $ADDRESS_LINE_5 in $ADDRESS_ITEM_ITEM/ns1:ADDRESS_LINE_5
                                        return
                                            <ns0:ADDRESS_LINE_5>{ data($ADDRESS_LINE_5) }</ns0:ADDRESS_LINE_5>
                                    }
                                    {
                                        for $IS_MAIN_ADDRESS in $ADDRESS_ITEM_ITEM/ns1:IS_MAIN_ADDRESS
                                        return
                                            <ns0:IS_MAIN_ADDRESS>{ data($IS_MAIN_ADDRESS) }</ns0:IS_MAIN_ADDRESS>
                                    }
                                </ns0:ADDRESS_ITEM>
                        }
                    </ns0:ADDRESSES>
            }
        </ns2:customerQueryResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:customerQueryGTOut($outputParameters)
