(:: pragma bea:global-element-parameter parameter="$consultaClienteResponse" element="ns0:consultaClienteResponse" location="../../ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaClienteResponse" location="../../ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteBatch/xq/consultaClienteBatchBodyOut/";

declare function xf:consultaClienteBatchBodyOut($consultaClienteResponse as element(ns0:consultaClienteResponse))
    as element(ns0:consultaClienteResponse) {
        <ns0:consultaClienteResponse>
            {
                for $CUSTOMER_ID in $consultaClienteResponse/ns0:CUSTOMER_ID
                return
                    <ns0:CUSTOMER_ID>{ data($CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            }
            {
                for $MNEMONIC in $consultaClienteResponse/ns0:MNEMONIC
                return
                    <ns0:MNEMONIC>{ data($MNEMONIC) }</ns0:MNEMONIC>
            }
            {
                for $IDENTIFICATION_INFO in $consultaClienteResponse/ns0:IDENTIFICATION_INFO
                return
                    <ns0:IDENTIFICATION_INFO>{ $IDENTIFICATION_INFO/@* , $IDENTIFICATION_INFO/node() }</ns0:IDENTIFICATION_INFO>
            }
            {
                for $GIVEN_NAMES in $consultaClienteResponse/ns0:GIVEN_NAMES
                return
                    <ns0:GIVEN_NAMES>{ data($GIVEN_NAMES) }</ns0:GIVEN_NAMES>
            }
            {
                for $FAMILY_NAME in $consultaClienteResponse/ns0:FAMILY_NAME
                return
                    <ns0:FAMILY_NAME>{ data($FAMILY_NAME) }</ns0:FAMILY_NAME>
            }
            {
                for $FULL_NAME in $consultaClienteResponse/ns0:FULL_NAME
                return
                    <ns0:FULL_NAME>{ data($FULL_NAME) }</ns0:FULL_NAME>
            }
            {
                for $NAME_OF_BUSINESS in $consultaClienteResponse/ns0:NAME_OF_BUSINESS
                return
                    <ns0:NAME_OF_BUSINESS>{ data($NAME_OF_BUSINESS) }</ns0:NAME_OF_BUSINESS>
            }
            {
                for $COMMERCIAL_NAME in $consultaClienteResponse/ns0:COMMERCIAL_NAME
                return
                    <ns0:COMMERCIAL_NAME>{ data($COMMERCIAL_NAME) }</ns0:COMMERCIAL_NAME>
            }
            {
                for $LEGAL_HOLDER_NAME in $consultaClienteResponse/ns0:LEGAL_HOLDER_NAME
                return
                    <ns0:LEGAL_HOLDER_NAME>{ data($LEGAL_HOLDER_NAME) }</ns0:LEGAL_HOLDER_NAME>
            }
            {
                for $SHORT_NAME in $consultaClienteResponse/ns0:SHORT_NAME
                return
                    <ns0:SHORT_NAME>{ data($SHORT_NAME) }</ns0:SHORT_NAME>
            }
            {
                for $DATE_OF_BIRTH in $consultaClienteResponse/ns0:DATE_OF_BIRTH
                return
                    <ns0:DATE_OF_BIRTH>{ data($DATE_OF_BIRTH) }</ns0:DATE_OF_BIRTH>
            }
            {
                for $GENDER in $consultaClienteResponse/ns0:GENDER
                return
                    <ns0:GENDER>{ data($GENDER) }</ns0:GENDER>
            }
            {
                for $NATIONALITY in $consultaClienteResponse/ns0:NATIONALITY
                return
                    <ns0:NATIONALITY>{ data($NATIONALITY) }</ns0:NATIONALITY>
            }
            {
                for $RESIDENCE in $consultaClienteResponse/ns0:RESIDENCE
                return
                    <ns0:RESIDENCE>{ data($RESIDENCE) }</ns0:RESIDENCE>
            }
            {
                for $SECTOR in $consultaClienteResponse/ns0:SECTOR
                return
                    <ns0:SECTOR>{ data($SECTOR) }</ns0:SECTOR>
            }
            {
                for $SECTOR_DESCRIPTION in $consultaClienteResponse/ns0:SECTOR_DESCRIPTION
                return
                    <ns0:SECTOR_DESCRIPTION>{ data($SECTOR_DESCRIPTION) }</ns0:SECTOR_DESCRIPTION>
            }
            {
                for $INDUSTRY in $consultaClienteResponse/ns0:INDUSTRY
                return
                    <ns0:INDUSTRY>{ data($INDUSTRY) }</ns0:INDUSTRY>
            }
            {
                for $INDUSTRY_DESCRIPTION in $consultaClienteResponse/ns0:INDUSTRY_DESCRIPTION
                return
                    <ns0:INDUSTRY_DESCRIPTION>{ data($INDUSTRY_DESCRIPTION) }</ns0:INDUSTRY_DESCRIPTION>
            }
            {
                for $FGN_CCY_GEN_TYP in $consultaClienteResponse/ns0:FGN_CCY_GEN_TYP
                return
                    <ns0:FGN_CCY_GEN_TYP>{ data($FGN_CCY_GEN_TYP) }</ns0:FGN_CCY_GEN_TYP>
            }
            {
                for $TARGET in $consultaClienteResponse/ns0:TARGET
                return
                    <ns0:TARGET>{ data($TARGET) }</ns0:TARGET>
            }
            {
                for $TARGET_DESCRIPTION in $consultaClienteResponse/ns0:TARGET_DESCRIPTION
                return
                    <ns0:TARGET_DESCRIPTION>{ data($TARGET_DESCRIPTION) }</ns0:TARGET_DESCRIPTION>
            }
            {
                for $MARITAL_STATUS in $consultaClienteResponse/ns0:MARITAL_STATUS
                return
                    <ns0:MARITAL_STATUS>{ data($MARITAL_STATUS) }</ns0:MARITAL_STATUS>
            }
            {
                for $CUSTOMER_TYPE in $consultaClienteResponse/ns0:CUSTOMER_TYPE
                return
                    <ns0:CUSTOMER_TYPE>{ data($CUSTOMER_TYPE) }</ns0:CUSTOMER_TYPE>
            }
            {
                for $CUSTOMER_STATUS in $consultaClienteResponse/ns0:CUSTOMER_STATUS
                return
                    <ns0:CUSTOMER_STATUS>{ data($CUSTOMER_STATUS) }</ns0:CUSTOMER_STATUS>
            }
            {
                for $LANGUAGE in $consultaClienteResponse/ns0:LANGUAGE
                return
                    <ns0:LANGUAGE>{ data($LANGUAGE) }</ns0:LANGUAGE>
            }
            {
                for $OCCUPATION in $consultaClienteResponse/ns0:OCCUPATION
                return
                    <ns0:OCCUPATION>{ data($OCCUPATION) }</ns0:OCCUPATION>
            }
            {
                for $EMPLOYMENT_STATUS in $consultaClienteResponse/ns0:EMPLOYMENT_STATUS
                return
                    <ns0:EMPLOYMENT_STATUS>{ data($EMPLOYMENT_STATUS) }</ns0:EMPLOYMENT_STATUS>
            }
            {
                for $EMPLOYERS_NAME in $consultaClienteResponse/ns0:EMPLOYERS_NAME
                return
                    <ns0:EMPLOYERS_NAME>{ data($EMPLOYERS_NAME) }</ns0:EMPLOYERS_NAME>
            }
            {
                for $MARRIED_LAST_NAME in $consultaClienteResponse/ns0:MARRIED_LAST_NAME
                return
                    <ns0:MARRIED_LAST_NAME>{ data($MARRIED_LAST_NAME) }</ns0:MARRIED_LAST_NAME>
            }
            {
                for $LEGAL_REP_NAME in $consultaClienteResponse/ns0:LEGAL_REP_NAME
                return
                    <ns0:LEGAL_REP_NAME>{ data($LEGAL_REP_NAME) }</ns0:LEGAL_REP_NAME>
            }
            {
                for $LEGAL_REP_ID in $consultaClienteResponse/ns0:LEGAL_REP_ID
                return
                    <ns0:LEGAL_REP_ID>{ data($LEGAL_REP_ID) }</ns0:LEGAL_REP_ID>
            }
            {
                for $TYPE_OF_COMPANY in $consultaClienteResponse/ns0:TYPE_OF_COMPANY
                return
                    <ns0:TYPE_OF_COMPANY>{ data($TYPE_OF_COMPANY) }</ns0:TYPE_OF_COMPANY>
            }
            {
                for $PROFESSION in $consultaClienteResponse/ns0:PROFESSION
                return
                    <ns0:PROFESSION>{ data($PROFESSION) }</ns0:PROFESSION>
            }
            {
                for $NUMBER_OF_DEED in $consultaClienteResponse/ns0:NUMBER_OF_DEED
                return
                    <ns0:NUMBER_OF_DEED>{ data($NUMBER_OF_DEED) }</ns0:NUMBER_OF_DEED>
            }
            {
                for $LEGAL_REP_HOME_PHONE in $consultaClienteResponse/ns0:LEGAL_REP_HOME_PHONE
                return
                    <ns0:LEGAL_REP_HOME_PHONE>{ data($LEGAL_REP_HOME_PHONE) }</ns0:LEGAL_REP_HOME_PHONE>
            }
            {
                for $TYPE_OF_PERSON in $consultaClienteResponse/ns0:TYPE_OF_PERSON
                return
                    <ns0:TYPE_OF_PERSON>{ data($TYPE_OF_PERSON) }</ns0:TYPE_OF_PERSON>
            }
            {
                for $INPUT_USER in $consultaClienteResponse/ns0:INPUT_USER
                return
                    <ns0:INPUT_USER>{ data($INPUT_USER) }</ns0:INPUT_USER>
            }
            {
                for $DATE_TIME in $consultaClienteResponse/ns0:DATE_TIME
                return
                    <ns0:DATE_TIME>{ data($DATE_TIME) }</ns0:DATE_TIME>
            }
            {
                for $ACCOUNT_OFFICER in $consultaClienteResponse/ns0:ACCOUNT_OFFICER
                return
                    <ns0:ACCOUNT_OFFICER>{ data($ACCOUNT_OFFICER) }</ns0:ACCOUNT_OFFICER>
            }
            {
                for $BRANCH_CODE in $consultaClienteResponse/ns0:BRANCH_CODE
                return
                    <ns0:BRANCH_CODE>{ data($BRANCH_CODE) }</ns0:BRANCH_CODE>
            }
            {
                for $NO_OF_DEPENDENTS in $consultaClienteResponse/ns0:NO_OF_DEPENDENTS
                return
                    <ns0:NO_OF_DEPENDENTS>{ data($NO_OF_DEPENDENTS) }</ns0:NO_OF_DEPENDENTS>
            }
            {
                for $EDUCATION_LEVEL in $consultaClienteResponse/ns0:EDUCATION_LEVEL
                return
                    <ns0:EDUCATION_LEVEL>{ data($EDUCATION_LEVEL) }</ns0:EDUCATION_LEVEL>
            }
            {
                for $SPOUSE_NAME in $consultaClienteResponse/ns0:SPOUSE_NAME
                return
                    <ns0:SPOUSE_NAME>{ data($SPOUSE_NAME) }</ns0:SPOUSE_NAME>
            }
            {
                for $CUSTOMER_SINCE in $consultaClienteResponse/ns0:CUSTOMER_SINCE
                return
                    <ns0:CUSTOMER_SINCE>{ data($CUSTOMER_SINCE) }</ns0:CUSTOMER_SINCE>
            }
            {
                for $ECONOMIC_GROUP_ID in $consultaClienteResponse/ns0:ECONOMIC_GROUP_ID
                return
                    <ns0:ECONOMIC_GROUP_ID>{ data($ECONOMIC_GROUP_ID) }</ns0:ECONOMIC_GROUP_ID>
            }
            {
                for $ECONOMIC_GROUP_NAME in $consultaClienteResponse/ns0:ECONOMIC_GROUP_NAME
                return
                    <ns0:ECONOMIC_GROUP_NAME>{ data($ECONOMIC_GROUP_NAME) }</ns0:ECONOMIC_GROUP_NAME>
            }
            <ns0:PHONE_INFO>
                {
                    for $PHONE_NUMBER_ITEM at $j in $consultaClienteResponse/ns0:PHONE_INFO/ns0:PHONE_NUMBER_ITEM
                    return
                        <ns0:PHONE_NUMBER_ITEM>
                            {
                                for $PHONE_LOCATION in $PHONE_NUMBER_ITEM/ns0:PHONE_LOCATION
                                return
                                    <ns0:PHONE_LOCATION>{ data($PHONE_LOCATION) }</ns0:PHONE_LOCATION>
                            }
                            {
                                for $PHONE_TYPE in $PHONE_NUMBER_ITEM/ns0:PHONE_TYPE
                                return
                                    <ns0:PHONE_TYPE>{ data($PHONE_TYPE) }</ns0:PHONE_TYPE>
                            }
                            {
                                for $PHONE_AREA_CODE in $PHONE_NUMBER_ITEM/ns0:PHONE_AREA_CODE
                                return
                                    <ns0:PHONE_AREA_CODE>{ data($PHONE_AREA_CODE) }</ns0:PHONE_AREA_CODE>
                            }
                            {
                                for $PHONE_NUMBER in $PHONE_NUMBER_ITEM/ns0:PHONE_NUMBER
                                return
                                    <ns0:PHONE_NUMBER>{ data($PHONE_NUMBER) }</ns0:PHONE_NUMBER>
                            }
                            {
                                for $IS_DEFAULT in $PHONE_NUMBER_ITEM/ns0:IS_DEFAULT
                                return
                                    <ns0:IS_DEFAULT>{ data($IS_DEFAULT) }</ns0:IS_DEFAULT>
                            }
                            {
                                for $PHONE_ORDER in $PHONE_NUMBER_ITEM/ns0:PHONE_ORDER
                                return
                                    <ns0:PHONE_ORDER>{ data($j) }</ns0:PHONE_ORDER>
                            }
                            {
                                for $PHONE_EXTENSION in $PHONE_NUMBER_ITEM/ns0:PHONE_EXTENSION
                                return
                                    <ns0:PHONE_EXTENSION>{ data($PHONE_EXTENSION) }</ns0:PHONE_EXTENSION>
                            }
                            {
                                for $PHONE_REFERRENCE in $PHONE_NUMBER_ITEM/ns0:PHONE_REFERRENCE
                                return
                                    <ns0:PHONE_REFERRENCE>{ data($PHONE_REFERRENCE) }</ns0:PHONE_REFERRENCE>
                            }
                        </ns0:PHONE_NUMBER_ITEM>
                }
            </ns0:PHONE_INFO>
            {
                for $ADDRESS_INFO in $consultaClienteResponse/ns0:ADDRESS_INFO
                return
                    <ns0:ADDRESS_INFO>{ $ADDRESS_INFO/@* , $ADDRESS_INFO/node() }</ns0:ADDRESS_INFO>
            }
            {
                for $EMAIL_INFO in $consultaClienteResponse/ns0:EMAIL_INFO
                return
                    <ns0:EMAIL_INFO>{ $EMAIL_INFO/@* , $EMAIL_INFO/node() }</ns0:EMAIL_INFO>
            }
            {
                for $JOB_INFO in $consultaClienteResponse/ns0:JOB_INFO
                return
                    <ns0:JOB_INFO>{ $JOB_INFO/@* , $JOB_INFO/node() }</ns0:JOB_INFO>
            }
            {
                for $SECTORIZATION_INFO in $consultaClienteResponse/ns0:SECTORIZATION_INFO
                return
                    <ns0:SECTORIZATION_INFO>{ $SECTORIZATION_INFO/@* , $SECTORIZATION_INFO/node() }</ns0:SECTORIZATION_INFO>
            }
            {
                for $CONSTITUTION_DATE in $consultaClienteResponse/ns0:CONSTITUTION_DATE
                return
                    <ns0:CONSTITUTION_DATE>{ data($CONSTITUTION_DATE) }</ns0:CONSTITUTION_DATE>
            }
            {
                for $OPERATION_COUNTRY_INFO in $consultaClienteResponse/ns0:OPERATION_COUNTRY_INFO
                return
                    <ns0:OPERATION_COUNTRY_INFO>{ $OPERATION_COUNTRY_INFO/@* , $OPERATION_COUNTRY_INFO/node() }</ns0:OPERATION_COUNTRY_INFO>
            }
            {
                for $IS_LOCAL_OPERATION in $consultaClienteResponse/ns0:IS_LOCAL_OPERATION
                return
                    <ns0:IS_LOCAL_OPERATION>{ data($IS_LOCAL_OPERATION) }</ns0:IS_LOCAL_OPERATION>
            }
            {
                for $OPERATION_DEPARTMENTS_INFO in $consultaClienteResponse/ns0:OPERATION_DEPARTMENTS_INFO
                return
                    <ns0:OPERATION_DEPARTMENTS_INFO>{ $OPERATION_DEPARTMENTS_INFO/@* , $OPERATION_DEPARTMENTS_INFO/node() }</ns0:OPERATION_DEPARTMENTS_INFO>
            }
            {
                for $RESOURCE_ORIGIN in $consultaClienteResponse/ns0:RESOURCE_ORIGIN
                return
                    <ns0:RESOURCE_ORIGIN>{ data($RESOURCE_ORIGIN) }</ns0:RESOURCE_ORIGIN>
            }
            {
                for $IS_ECONOMIC_GROUP in $consultaClienteResponse/ns0:IS_ECONOMIC_GROUP
                return
                    <ns0:IS_ECONOMIC_GROUP>{ data($IS_ECONOMIC_GROUP) }</ns0:IS_ECONOMIC_GROUP>
            }
            {
                for $IS_PUBLIC_CHARGE in $consultaClienteResponse/ns0:IS_PUBLIC_CHARGE
                return
                    <ns0:IS_PUBLIC_CHARGE>{ data($IS_PUBLIC_CHARGE) }</ns0:IS_PUBLIC_CHARGE>
            }
            {
                for $PUBLIC_CHARGE_DESCRIPTION_INFO in $consultaClienteResponse/ns0:PUBLIC_CHARGE_DESCRIPTION_INFO
                return
                    <ns0:PUBLIC_CHARGE_DESCRIPTION_INFO>{ $PUBLIC_CHARGE_DESCRIPTION_INFO/@* , $PUBLIC_CHARGE_DESCRIPTION_INFO/node() }</ns0:PUBLIC_CHARGE_DESCRIPTION_INFO>
            }
            {
                for $PUBLIC_CHARGE_INSTITUTION in $consultaClienteResponse/ns0:PUBLIC_CHARGE_INSTITUTION
                return
                    <ns0:PUBLIC_CHARGE_INSTITUTION>{ data($PUBLIC_CHARGE_INSTITUTION) }</ns0:PUBLIC_CHARGE_INSTITUTION>
            }
            {
                for $LEGAL_IDENTIFICATION_EXPIRATION_DATE in $consultaClienteResponse/ns0:LEGAL_IDENTIFICATION_EXPIRATION_DATE
                return
                    <ns0:LEGAL_IDENTIFICATION_EXPIRATION_DATE>{ data($LEGAL_IDENTIFICATION_EXPIRATION_DATE) }</ns0:LEGAL_IDENTIFICATION_EXPIRATION_DATE>
            }
            {
                for $OTHER_NATIONALITIES_INFO in $consultaClienteResponse/ns0:OTHER_NATIONALITIES_INFO
                return
                    <ns0:OTHER_NATIONALITIES_INFO>{ $OTHER_NATIONALITIES_INFO/@* , $OTHER_NATIONALITIES_INFO/node() }</ns0:OTHER_NATIONALITIES_INFO>
            }
            {
                for $DEPENDENCY_ID in $consultaClienteResponse/ns0:DEPENDENCY_ID
                return
                    <ns0:DEPENDENCY_ID>{ data($DEPENDENCY_ID) }</ns0:DEPENDENCY_ID>
            }
            {
                for $DEPENDENCY_NAME in $consultaClienteResponse/ns0:DEPENDENCY_NAME
                return
                    <ns0:DEPENDENCY_NAME>{ data($DEPENDENCY_NAME) }</ns0:DEPENDENCY_NAME>
            }
            {
                for $DEPENDENCY_LASTNAME in $consultaClienteResponse/ns0:DEPENDENCY_LASTNAME
                return
                    <ns0:DEPENDENCY_LASTNAME>{ data($DEPENDENCY_LASTNAME) }</ns0:DEPENDENCY_LASTNAME>
            }
            {
                for $TOTAL_INCOME in $consultaClienteResponse/ns0:TOTAL_INCOME
                return
                    <ns0:TOTAL_INCOME>{ data($TOTAL_INCOME) }</ns0:TOTAL_INCOME>
            }
            {
                for $GIRO_NEGOCIO in $consultaClienteResponse/ns0:GIRO_NEGOCIO
                return
                    <ns0:GIRO_NEGOCIO>{ data($GIRO_NEGOCIO) }</ns0:GIRO_NEGOCIO>
            }
            {
                for $ECONOMICGROUP in $consultaClienteResponse/ns0:ECONOMICGROUP
                return
                    <ns0:ECONOMICGROUP>{ data($ECONOMICGROUP) }</ns0:ECONOMICGROUP>
            }
            {
                for $LEGAL_ISSUE_DATE in $consultaClienteResponse/ns0:LEGAL_ISSUE_DATE
                return
                    <ns0:LEGAL_ISSUE_DATE>{ data($LEGAL_ISSUE_DATE) }</ns0:LEGAL_ISSUE_DATE>
            }
            {
                for $RTN in $consultaClienteResponse/ns0:RTN
                return
                    <ns0:RTN>{ data($RTN) }</ns0:RTN>
            }
            {
                for $PLACE_OF_BIRTH in $consultaClienteResponse/ns0:PLACE_OF_BIRTH
                return
                    <ns0:PLACE_OF_BIRTH>{ data($PLACE_OF_BIRTH) }</ns0:PLACE_OF_BIRTH>
            }
            {
                for $PLACE_OF_BIRTH_DESC in $consultaClienteResponse/ns0:PLACE_OF_BIRTH_DESC
                return
                    <ns0:PLACE_OF_BIRTH_DESC>{ data($PLACE_OF_BIRTH_DESC) }</ns0:PLACE_OF_BIRTH_DESC>
            }
            {
                for $TOWN_COUNTRY in $consultaClienteResponse/ns0:TOWN_COUNTRY
                return
                    <ns0:TOWN_COUNTRY>{ data($TOWN_COUNTRY) }</ns0:TOWN_COUNTRY>
            }
            {
                for $COUNTRY in $consultaClienteResponse/ns0:COUNTRY
                return
                    <ns0:COUNTRY>{ data($COUNTRY) }</ns0:COUNTRY>
            }
            {
                for $DNFBP in $consultaClienteResponse/ns0:DNFBP
                return
                    <ns0:DNFBP>{ data($DNFBP) }</ns0:DNFBP>
            }
            {
                for $DNFBP_PROFESSION in $consultaClienteResponse/ns0:DNFBP_PROFESSION
                return
                    <ns0:DNFBP_PROFESSION>{ data($DNFBP_PROFESSION) }</ns0:DNFBP_PROFESSION>
            }
            {
                for $DEPENDENT_INFO in $consultaClienteResponse/ns0:DEPENDENT_INFO
                return
                    <ns0:DEPENDENT_INFO>{ $DEPENDENT_INFO/@* , $DEPENDENT_INFO/node() }</ns0:DEPENDENT_INFO>
            }
            {
                for $INCOME_CURRENCY in $consultaClienteResponse/ns0:INCOME_CURRENCY
                return
                    <ns0:INCOME_CURRENCY>{ $INCOME_CURRENCY/@* , $INCOME_CURRENCY/node() }</ns0:INCOME_CURRENCY>
            }
            {
                for $OTHERS_INCOME in $consultaClienteResponse/ns0:OTHERS_INCOME
                return
                    <ns0:OTHERS_INCOME>{ $OTHERS_INCOME/@* , $OTHERS_INCOME/node() }</ns0:OTHERS_INCOME>
            }
            {
                for $LEGALISED_NAME in $consultaClienteResponse/ns0:LEGALISED_NAME
                return
                    <ns0:LEGALISED_NAME>{ data($LEGALISED_NAME) }</ns0:LEGALISED_NAME>
            }
            {
                for $LEGALISED_NAME_DESC in $consultaClienteResponse/ns0:LEGALISED_NAME_DESC
                return
                    <ns0:LEGALISED_NAME_DESC>{ data($LEGALISED_NAME_DESC) }</ns0:LEGALISED_NAME_DESC>
            }
            {
                for $PROFESION_TRADE in $consultaClienteResponse/ns0:PROFESION_TRADE
                return
                    <ns0:PROFESION_TRADE>{ data($PROFESION_TRADE) }</ns0:PROFESION_TRADE>
            }
            {
                for $PROFESION_TRADE_DESC in $consultaClienteResponse/ns0:PROFESION_TRADE_DESC
                return
                    <ns0:PROFESION_TRADE_DESC>{ data($PROFESION_TRADE_DESC) }</ns0:PROFESION_TRADE_DESC>
            }
            {
                for $REFERENCES_INFO in $consultaClienteResponse/ns0:REFERENCES_INFO
                return
                    <ns0:REFERENCES_INFO>{ $REFERENCES_INFO/@* , $REFERENCES_INFO/node() }</ns0:REFERENCES_INFO>
            }
            {
                for $INTERFACE_USER in $consultaClienteResponse/ns0:INTERFACE_USER
                return
                    <ns0:INTERFACE_USER>{ data($INTERFACE_USER) }</ns0:INTERFACE_USER>
            }
            {
                for $TYPE_MERCHANT in $consultaClienteResponse/ns0:TYPE_MERCHANT
                return
                    <ns0:TYPE_MERCHANT>{ data($TYPE_MERCHANT) }</ns0:TYPE_MERCHANT>
            }
            {
                for $SME_NAME in $consultaClienteResponse/ns0:SME_NAME
                return
                    <ns0:SME_NAME>{ data($SME_NAME) }</ns0:SME_NAME>
            }
            {
                for $IS_MERCHANT_COMPANY in $consultaClienteResponse/ns0:IS_MERCHANT_COMPANY
                return
                    <ns0:IS_MERCHANT_COMPANY>{ data($IS_MERCHANT_COMPANY) }</ns0:IS_MERCHANT_COMPANY>
            }
            {
                for $BELONGS_USA_BOARD in $consultaClienteResponse/ns0:BELONGS_USA_BOARD
                return
                    <ns0:BELONGS_USA_BOARD>{ data($BELONGS_USA_BOARD) }</ns0:BELONGS_USA_BOARD>
            }
            {
                for $DESIGNATED_NON_FINANCIAL_PROFESSION in $consultaClienteResponse/ns0:DESIGNATED_NON_FINANCIAL_PROFESSION
                return
                    <ns0:DESIGNATED_NON_FINANCIAL_PROFESSION>{ data($DESIGNATED_NON_FINANCIAL_PROFESSION) }</ns0:DESIGNATED_NON_FINANCIAL_PROFESSION>
            }
            {
                for $FISCAL_CLOSING_SALES in $consultaClienteResponse/ns0:FISCAL_CLOSING_SALES
                return
                    <ns0:FISCAL_CLOSING_SALES>{ $FISCAL_CLOSING_SALES/@* , $FISCAL_CLOSING_SALES/node() }</ns0:FISCAL_CLOSING_SALES>
            }
            {
                for $NEW_PRODUCTS_DETAILS in $consultaClienteResponse/ns0:NEW_PRODUCTS_DETAILS
                return
                    <ns0:NEW_PRODUCTS_DETAILS>{ $NEW_PRODUCTS_DETAILS/@* , $NEW_PRODUCTS_DETAILS/node() }</ns0:NEW_PRODUCTS_DETAILS>
            }
            {
                for $IS_RENEWING_PRODUCT in $consultaClienteResponse/ns0:IS_RENEWING_PRODUCT
                return
                    <ns0:IS_RENEWING_PRODUCT>{ data($IS_RENEWING_PRODUCT) }</ns0:IS_RENEWING_PRODUCT>
            }
            {
                for $RENEWAL_DETAILS in $consultaClienteResponse/ns0:RENEWAL_DETAILS
                return
                    <ns0:RENEWAL_DETAILS>{ $RENEWAL_DETAILS/@* , $RENEWAL_DETAILS/node() }</ns0:RENEWAL_DETAILS>
            }
            {
                for $INHERITANCE_DETAILS in $consultaClienteResponse/ns0:INHERITANCE_DETAILS
                return
                    <ns0:INHERITANCE_DETAILS>{ $INHERITANCE_DETAILS/@* , $INHERITANCE_DETAILS/node() }</ns0:INHERITANCE_DETAILS>
            }
            {
                for $IS_STATE_CONTRACTOR in $consultaClienteResponse/ns0:IS_STATE_CONTRACTOR
                return
                    <ns0:IS_STATE_CONTRACTOR>{ data($IS_STATE_CONTRACTOR) }</ns0:IS_STATE_CONTRACTOR>
            }
            {
                for $CONTRACT_DETAILS in $consultaClienteResponse/ns0:CONTRACT_DETAILS
                return
                    <ns0:CONTRACT_DETAILS>{ $CONTRACT_DETAILS/@* , $CONTRACT_DETAILS/node() }</ns0:CONTRACT_DETAILS>
            }
            {
                for $IS_NGO_NPO in $consultaClienteResponse/ns0:IS_NGO_NPO
                return
                    <ns0:IS_NGO_NPO>{ data($IS_NGO_NPO) }</ns0:IS_NGO_NPO>
            }
            {
                for $DONATIONS_DETAILS in $consultaClienteResponse/ns0:DONATIONS_DETAILS
                return
                    <ns0:DONATIONS_DETAILS>{ $DONATIONS_DETAILS/@* , $DONATIONS_DETAILS/node() }</ns0:DONATIONS_DETAILS>
            }
            {
                for $MONTHLY_SALES in $consultaClienteResponse/ns0:MONTHLY_SALES
                return
                    <ns0:MONTHLY_SALES>{ $MONTHLY_SALES/@* , $MONTHLY_SALES/node() }</ns0:MONTHLY_SALES>
            }
            {
                for $OTHER_INCOME_DETAILS in $consultaClienteResponse/ns0:OTHER_INCOME_DETAILS
                return
                    <ns0:OTHER_INCOME_DETAILS>{ $OTHER_INCOME_DETAILS/@* , $OTHER_INCOME_DETAILS/node() }</ns0:OTHER_INCOME_DETAILS>
            }
            {
                for $IS_PEP_BY_RELATION in $consultaClienteResponse/ns0:IS_PEP_BY_RELATION
                return
                    <ns0:IS_PEP_BY_RELATION>{ data($IS_PEP_BY_RELATION) }</ns0:IS_PEP_BY_RELATION>
            }
            {
                for $PEP_DETAILS in $consultaClienteResponse/ns0:PEP_DETAILS
                return
                    <ns0:PEP_DETAILS>{ $PEP_DETAILS/@* , $PEP_DETAILS/node() }</ns0:PEP_DETAILS>
            }
            {
                for $CLIENT_RISK in $consultaClienteResponse/ns0:CLIENT_RISK
                return
                    <ns0:CLIENT_RISK>{ data($CLIENT_RISK) }</ns0:CLIENT_RISK>
            }
            {
                for $FAXES_INFO in $consultaClienteResponse/ns0:FAXES_INFO
                return
                    <ns0:FAXES_INFO>{ $FAXES_INFO/@* , $FAXES_INFO/node() }</ns0:FAXES_INFO>
            }
            {
                for $RECORD_STATUS in $consultaClienteResponse/ns0:RECORD_STATUS
                return
                    <ns0:RECORD_STATUS>{ data($RECORD_STATUS) }</ns0:RECORD_STATUS>
            }
            {
                for $COSTUMER_TYPE in $consultaClienteResponse/ns0:COSTUMER_TYPE
                return
                    <ns0:COSTUMER_TYPE>{ data($COSTUMER_TYPE) }</ns0:COSTUMER_TYPE>
            }
        </ns0:consultaClienteResponse>
};

declare variable $consultaClienteResponse as element(ns0:consultaClienteResponse) external;

xf:consultaClienteBatchBodyOut($consultaClienteResponse)