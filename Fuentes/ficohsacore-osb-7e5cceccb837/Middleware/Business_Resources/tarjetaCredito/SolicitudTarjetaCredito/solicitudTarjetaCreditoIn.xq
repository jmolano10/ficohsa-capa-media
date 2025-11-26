(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaCredito" element="ns1:solicitudTarjetaCredito" location="solicitudTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/SolicitudTarjetaCreditoT24/xsd/ORA_BANK_OSB_SOL_TC_T24.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_SOL_TC_T24/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudTarjetaCredito/solicitudTarjetaCreditoIn/";

declare function xf:solicitudTarjetaCreditoIn($solicitudTarjetaCredito as element(ns1:solicitudTarjetaCredito),
    $customer_name as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:USER_ID>{ data($solicitudTarjetaCredito/USER_ID) }</ns0:USER_ID>
            <ns0:EMAIL_ADDRESS>{ data($solicitudTarjetaCredito/EMAIL_ADDRESS) }</ns0:EMAIL_ADDRESS>
            <ns0:CUSTOMER_ID>{ data($solicitudTarjetaCredito/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            {
                for $INTERFACE_REFERENCE_NO in $solicitudTarjetaCredito/INTERFACE_REFERENCE_NO
                return
                    <ns0:INTERFACE_REFERENCE_NO>{ data($INTERFACE_REFERENCE_NO) }</ns0:INTERFACE_REFERENCE_NO>
            }
            <ns0:G1_CARD_TYPE>{ data($solicitudTarjetaCredito/CREDIT_CARD_TYPE/CARD_TYPE) }</ns0:G1_CARD_TYPE>
            <ns0:G1_FIRST_GIVEN_NAME>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/FIRST_GIVEN_NAME) }</ns0:G1_FIRST_GIVEN_NAME>
            <ns0:G1_SECOND_GIVEN_NAME>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/SECOND_GIVEN_NAME) }</ns0:G1_SECOND_GIVEN_NAME>
            <ns0:G1_FIRST_FAMILY_NAME>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/FIRST_FAMILY_NAME) }</ns0:G1_FIRST_FAMILY_NAME>
            <ns0:G1_SECOND_FAMILY_NAME>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/SECOND_FAMILY_NAME) }</ns0:G1_SECOND_FAMILY_NAME>
            <ns0:G1_MARRIED_LAST_NAME>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/MARRIED_LAST_NAME) }</ns0:G1_MARRIED_LAST_NAME>
            <ns0:G1_ID_NUMBER>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/ID_NUMBER) }</ns0:G1_ID_NUMBER>
            <ns0:G1_NATIONALITY>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/NATIONALITY) }</ns0:G1_NATIONALITY>
            <ns0:G1_PROFESSION_OR_TRADE>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/PROFESSION_OR_TRADE) }</ns0:G1_PROFESSION_OR_TRADE>
            <ns0:G1_HOUSEHOLD_STATUS>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOUSEHOLD_STATUS) }</ns0:G1_HOUSEHOLD_STATUS>
            <ns0:G1_NUMBER_OF_DEPENDANTS>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/NUMBER_OF_DEPENDANTS) }</ns0:G1_NUMBER_OF_DEPENDANTS>
            <ns0:G1_GENDER>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/GENDER) }</ns0:G1_GENDER>
            <ns0:G1_MARITAL_STATUS>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/MARITAL_STATUS) }</ns0:G1_MARITAL_STATUS>
            <ns0:G1_BIRTH_DATE>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/BIRTH_DATE) }</ns0:G1_BIRTH_DATE>
            <ns0:G1_HOME_ADDRESS>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOME_ADDRESS) }</ns0:G1_HOME_ADDRESS>
            <ns0:G1_STREET>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/STREET) }</ns0:G1_STREET>
            <ns0:G1_AVENUE>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/AVENUE) }</ns0:G1_AVENUE>
            <ns0:G1_HOME_HOUSE_NUMBER>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOME_HOUSE_NUMBER) }</ns0:G1_HOME_HOUSE_NUMBER>
            <ns0:G1_HOME_CITY>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOME_CITY) }</ns0:G1_HOME_CITY>
            <ns0:G1_HOME_STATE>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOME_STATE) }</ns0:G1_HOME_STATE>
            <ns0:G1_HOME_POSTAL_CODE>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOME_POSTAL_CODE) }</ns0:G1_HOME_POSTAL_CODE>
            <ns0:G1_HOME_PHONE_NUMBER>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOME_PHONE_NUMBER) }</ns0:G1_HOME_PHONE_NUMBER>
            <ns0:G1_HOME_FAX>{ data($solicitudTarjetaCredito/PERSONAL_INFORMATION/HOME_FAX) }</ns0:G1_HOME_FAX>
            <ns0:G2_FIRST_GIVEN_NAME>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/FIRST_GIVEN_NAME) }</ns0:G2_FIRST_GIVEN_NAME>
            <ns0:G2_SECOND_GIVEN_NAME>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/SECOND_GIVEN_NAME) }</ns0:G2_SECOND_GIVEN_NAME>
            <ns0:G2_FIRST_FAMILY_NAME>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/FIRST_FAMILY_NAME) }</ns0:G2_FIRST_FAMILY_NAME>
            <ns0:G2_SECOND_FAMILY_NAME>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/SECOND_FAMILY_NAME) }</ns0:G2_SECOND_FAMILY_NAME>
            <ns0:G2_MARRIED_LAST_NAME>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/MARRIED_LAST_NAME) }</ns0:G2_MARRIED_LAST_NAME>
            <ns0:G2_ID_NUMBER>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/ID_NUMBER) }</ns0:G2_ID_NUMBER>
            <ns0:G2_PROFESSION_OR_TRADE>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/PROFESSION_OR_TRADE) }</ns0:G2_PROFESSION_OR_TRADE>
            <ns0:G2_NAME_OF_EMPLOYMENT>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/NAME_OF_EMPLOYMENT) }</ns0:G2_NAME_OF_EMPLOYMENT>
            <ns0:G2_SENIORITY>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/SENIORITY) }</ns0:G2_SENIORITY>
            <ns0:G2_JOB_TITLE>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/JOB_TITLE) }</ns0:G2_JOB_TITLE>
            <ns0:G2_WORK_PHONE_NUMBER>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/WORK_PHONE_NUMBER) }</ns0:G2_WORK_PHONE_NUMBER>
            <ns0:G2_WORK_FAX>{ data($solicitudTarjetaCredito/SPOUSE_INFORMATION/WORK_FAX) }</ns0:G2_WORK_FAX>
            <ns0:G3_NAME_OF_EMPLOYMENT>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/NAME_OF_EMPLOYMENT) }</ns0:G3_NAME_OF_EMPLOYMENT>
            <ns0:G3_EMPLOYMENT_ENTRY_DATE>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/EMPLOYMENT_ENTRY_DATE) }</ns0:G3_EMPLOYMENT_ENTRY_DATE>
            <ns0:G3_JOB_TITLE>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/JOB_TITLE) }</ns0:G3_JOB_TITLE>
            <ns0:G3_WORK_PHONE_NUMBER>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_PHONE_NUMBER) }</ns0:G3_WORK_PHONE_NUMBER>
            <ns0:G3_WORK_FAX>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_FAX) }</ns0:G3_WORK_FAX>
            <ns0:G3_MONTHLY_INCOME>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/MONTHLY_INCOME) }</ns0:G3_MONTHLY_INCOME>
            <ns0:G3_WORK_ADDRESS>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_ADDRESS) }</ns0:G3_WORK_ADDRESS>
            <ns0:G3_WORK_STREET>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_STREET) }</ns0:G3_WORK_STREET>
            <ns0:G3_WORK_AVENUE>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_AVENUE) }</ns0:G3_WORK_AVENUE>
            <ns0:G3_WORK_HOUSE_NUMBER>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_HOUSE_NUMBER) }</ns0:G3_WORK_HOUSE_NUMBER>
            <ns0:G3_WORK_CITY>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_CITY) }</ns0:G3_WORK_CITY>
            <ns0:G3_WORK_STATE>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_STATE) }</ns0:G3_WORK_STATE>
            <ns0:G3_WORK_POSTAL_CODE>{ data($solicitudTarjetaCredito/SOURCE_OF_INCOME/WORK_POSTAL_CODE) }</ns0:G3_WORK_POSTAL_CODE>
            <ns0:G4_NAME>{ data($solicitudTarjetaCredito/PROPERTIES/NAME) }</ns0:G4_NAME>
            <ns0:G4_VALUE>{ data($solicitudTarjetaCredito/PROPERTIES/VALUE) }</ns0:G4_VALUE>
            <ns0:G4_ASSESSMENT>{ data($solicitudTarjetaCredito/PROPERTIES/ASSESSMENT) }</ns0:G4_ASSESSMENT>
            <ns0:G4_BENEFICIARY>{ data($solicitudTarjetaCredito/PROPERTIES/BENEFICIARY) }</ns0:G4_BENEFICIARY>
            <ns0:G5_FIN_INSTITUTE_NAME>{ data($solicitudTarjetaCredito/BANK_REFERENCES/FIN_INSTITUTE_NAME) }</ns0:G5_FIN_INSTITUTE_NAME>
            <ns0:G5_ACCOUNT_TYPE>{ data($solicitudTarjetaCredito/BANK_REFERENCES/ACCOUNT_TYPE) }</ns0:G5_ACCOUNT_TYPE>
            <ns0:G5_ACCOUNT_NUMBER>{ data($solicitudTarjetaCredito/BANK_REFERENCES/ACCOUNT_NUMBER) }</ns0:G5_ACCOUNT_NUMBER>
            <ns0:G5_AVERAGE_BALANCE>{ data($solicitudTarjetaCredito/BANK_REFERENCES/AVERAGE_BALANCE) }</ns0:G5_AVERAGE_BALANCE>
            <ns0:G6_FIN_INSTITUTE_NAME>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[1]/FIN_INSTITUTE_NAME) }</ns0:G6_FIN_INSTITUTE_NAME>
            <ns0:G6_CREDIT_LIMIT>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[1]/CREDIT_LIMIT) }</ns0:G6_CREDIT_LIMIT>
            <ns0:G6_CARD_NUMBER>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[1]/CARD_NUMBER) }</ns0:G6_CARD_NUMBER>
            <ns0:G6_EXPIRATION_DATE>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[1]/EXPIRATION_DATE) }</ns0:G6_EXPIRATION_DATE>
            <ns0:G6_FIN_INSTITUTE_NAME_2>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[2]/FIN_INSTITUTE_NAME) }</ns0:G6_FIN_INSTITUTE_NAME_2>
            <ns0:G6_CREDIT_LIMIT_2>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[2]/CREDIT_LIMIT) }</ns0:G6_CREDIT_LIMIT_2>
            <ns0:G6_CARD_NUMBER_2>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[2]/CARD_NUMBER) }</ns0:G6_CARD_NUMBER_2>
            <ns0:G6_EXPIRATION_DATE_2>{ data($solicitudTarjetaCredito/OTHER_CREDIT_CARDS/OTHER_CREDIT_CARDS_RECORD[2]/EXPIRATION_DATE) }</ns0:G6_EXPIRATION_DATE_2>
            <ns0:G7_NON_HOME_RELATIVE>{ data($solicitudTarjetaCredito/REFERENCES/NON_HOME_RELATIVE) }</ns0:G7_NON_HOME_RELATIVE>
            <ns0:G7_KINSHIP>{ data($solicitudTarjetaCredito/REFERENCES/KINSHIP) }</ns0:G7_KINSHIP>
            <ns0:G7_ADDRESS>{ data($solicitudTarjetaCredito/REFERENCES/ADDRESS) }</ns0:G7_ADDRESS>
            <ns0:G7_WORK_PHONE_NUMBER_1>{ data($solicitudTarjetaCredito/REFERENCES/WORK_PHONE_NUMBER_1) }</ns0:G7_WORK_PHONE_NUMBER_1>
            <ns0:G7_HOME_PHONE_NUMBER_1>{ data($solicitudTarjetaCredito/REFERENCES/HOME_PHONE_NUMBER_1) }</ns0:G7_HOME_PHONE_NUMBER_1>
            <ns0:G7_FICOHSA_REFERENCE>{ data($solicitudTarjetaCredito/REFERENCES/FICOHSA_REFERENCE) }</ns0:G7_FICOHSA_REFERENCE>
            <ns0:G7_BRANCH_OR_DEPARTMENT>{ data($solicitudTarjetaCredito/REFERENCES/BRANCH_OR_DEPARTMENT) }</ns0:G7_BRANCH_OR_DEPARTMENT>
            <ns0:G7_WORK_PHONE_NUMBER_2>{ data($solicitudTarjetaCredito/REFERENCES/WORK_PHONE_NUMBER_2) }</ns0:G7_WORK_PHONE_NUMBER_2>
            <ns0:G7_HOME_PHONE_NUMBER_2>{ data($solicitudTarjetaCredito/REFERENCES/HOME_PHONE_NUMBER_2) }</ns0:G7_HOME_PHONE_NUMBER_2>
            <ns0:G8_FIRST_GIVEN_NAME>{ data($solicitudTarjetaCredito/ADDITIONAL_CARD/FIRST_GIVEN_NAME) }</ns0:G8_FIRST_GIVEN_NAME>
            <ns0:G8_SECOND_GIVEN_NAME>{ data($solicitudTarjetaCredito/ADDITIONAL_CARD/SECOND_GIVEN_NAME) }</ns0:G8_SECOND_GIVEN_NAME>
            <ns0:G8_FIRST_FAMILY_NAME>{ data($solicitudTarjetaCredito/ADDITIONAL_CARD/FIRST_FAMILY_NAME) }</ns0:G8_FIRST_FAMILY_NAME>
            <ns0:G8_SECOND_FAMILY_NAME>{ data($solicitudTarjetaCredito/ADDITIONAL_CARD/SECOND_FAMILY_NAME) }</ns0:G8_SECOND_FAMILY_NAME>
            <ns0:G8_AGE>{ data($solicitudTarjetaCredito/ADDITIONAL_CARD/AGE) }</ns0:G8_AGE>
            <ns0:G8_ID_NUMBER>{ data($solicitudTarjetaCredito/ADDITIONAL_CARD/ID_NUMBER) }</ns0:G8_ID_NUMBER>
            <ns0:G8_KINSHIP>{ data($solicitudTarjetaCredito/ADDITIONAL_CARD/KINSHIP) }</ns0:G8_KINSHIP>
            <ns0:G9_ADDRESS_TYPE>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/ADDRESS_TYPE) }</ns0:G9_ADDRESS_TYPE>
            <ns0:G9_COMPANY>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/COMPANY) }</ns0:G9_COMPANY>
            <ns0:G9_WORK_STREET>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/WORK_STREET) }</ns0:G9_WORK_STREET>
            <ns0:G9_WORK_AVENUE>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/WORK_AVENUE) }</ns0:G9_WORK_AVENUE>
            <ns0:G9_WORK_HOUSE_NUMBER>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/WORK_HOUSE_NUMBER) }</ns0:G9_WORK_HOUSE_NUMBER>
            <ns0:G9_WORK_CITY>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/WORK_CITY) }</ns0:G9_WORK_CITY>
            <ns0:G9_WORK_STATE>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/WORK_STATE) }</ns0:G9_WORK_STATE>
            <ns0:G9_WORK_PHONE_NUMBER>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/WORK_PHONE_NUMBER) }</ns0:G9_WORK_PHONE_NUMBER>
            <ns0:G9_HOME_NEIGHBORHOOD>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/HOME_NEIGHBORHOOD) }</ns0:G9_HOME_NEIGHBORHOOD>
            <ns0:G9_HOME_STREET>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/HOME_STREET) }</ns0:G9_HOME_STREET>
            <ns0:G9_HOME_AVENUE>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/HOME_AVENUE) }</ns0:G9_HOME_AVENUE>
            <ns0:G9_HOME_HOUSE_NUMBER>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/HOME_HOUSE_NUMBER) }</ns0:G9_HOME_HOUSE_NUMBER>
            <ns0:G9_HOME_CITY>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/HOME_CITY) }</ns0:G9_HOME_CITY>
            <ns0:G9_HOME_STATE>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/HOME_STATE) }</ns0:G9_HOME_STATE>
            <ns0:G9_HOME_PHONE_NUMBER>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/HOME_PHONE_NUMBER) }</ns0:G9_HOME_PHONE_NUMBER>
            <ns0:G9_POSTAL_CODE_NUMBER>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/POSTAL_CODE_NUMBER) }</ns0:G9_POSTAL_CODE_NUMBER>
            <ns0:G9_POSTAL_CODE_CITY>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/POSTAL_CODE_CITY) }</ns0:G9_POSTAL_CODE_CITY>
            <ns0:G9_POSTAL_CODE_DEPARTMENT>{ data($solicitudTarjetaCredito/ACCOUNT_STMT_DELIVERY/POSTAL_CODE_DEPARTMENT) }</ns0:G9_POSTAL_CODE_DEPARTMENT>
            <ns0:G10_FIRST_GIVEN_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/FIRST_GIVEN_NAME) }</ns0:G10_FIRST_GIVEN_NAME>
            <ns0:G10_SECOND_GIVEN_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/SECOND_GIVEN_NAME) }</ns0:G10_SECOND_GIVEN_NAME>
            <ns0:G10_FIRST_FAMILY_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/FIRST_FAMILY_NAME) }</ns0:G10_FIRST_FAMILY_NAME>
            <ns0:G10_SECOND_FAMILY_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/SECOND_FAMILY_NAME) }</ns0:G10_SECOND_FAMILY_NAME>
            <ns0:G10_MARRIED_LAST_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/MARRIED_LAST_NAME) }</ns0:G10_MARRIED_LAST_NAME>
            <ns0:G10_ID_NUMBER>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/ID_NUMBER) }</ns0:G10_ID_NUMBER>
            <ns0:G10_NATIONALITY>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/NATIONALITY) }</ns0:G10_NATIONALITY>
            <ns0:G10_PROFESSION_OR_TRADE>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/PROFESSION_OR_TRADE) }</ns0:G10_PROFESSION_OR_TRADE>
            <ns0:G10_HOUSEHOLD_STATUS>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/HOUSEHOLD_STATUS) }</ns0:G10_HOUSEHOLD_STATUS>
            <ns0:G10_NUMBER_OF_DEPENDANTS>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/NUMBER_OF_DEPENDANTS) }</ns0:G10_NUMBER_OF_DEPENDANTS>
            <ns0:G10_GENDER>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/GENDER) }</ns0:G10_GENDER>
            <ns0:G10_MARITAL_STATUS>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/MARITAL_STATUS) }</ns0:G10_MARITAL_STATUS>
            <ns0:G10_BIRTH_DATE>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/BIRTH_DATE) }</ns0:G10_BIRTH_DATE>
            <ns0:G10_HOME_ADDRESS>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/HOME_ADDRESS) }</ns0:G10_HOME_ADDRESS>
            <ns0:G10_STREET>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/STREET) }</ns0:G10_STREET>
            <ns0:G10_AVENUE>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/AVENUE) }</ns0:G10_AVENUE>
            <ns0:G10_HOME_HOUSE_NUMBER>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/HOME_HOUSE_NUMBER) }</ns0:G10_HOME_HOUSE_NUMBER>
            <ns0:G10_HOME_CITY>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/HOME_CITY) }</ns0:G10_HOME_CITY>
            <ns0:G10_HOME_STATE>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/HOME_STATE) }</ns0:G10_HOME_STATE>
            <ns0:G10_HOME_POSTAL_CODE>{ data($solicitudTarjetaCredito/COLLATERAL_PERSONAL_INFO/HOME_POSTAL_CODE) }</ns0:G10_HOME_POSTAL_CODE>
            <ns0:G11_FIRST_GIVEN_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/FIRST_GIVEN_NAME) }</ns0:G11_FIRST_GIVEN_NAME>
            <ns0:G11_SECOND_GIVEN_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/SECOND_GIVEN_NAME) }</ns0:G11_SECOND_GIVEN_NAME>
            <ns0:G11_FIRST_FAMILY_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/FIRST_FAMILY_NAME) }</ns0:G11_FIRST_FAMILY_NAME>
            <ns0:G11_SECOND_FAMILY_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/SECOND_FAMILY_NAME) }</ns0:G11_SECOND_FAMILY_NAME>
            <ns0:G11_MARRIED_LAST_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/MARRIED_LAST_NAME) }</ns0:G11_MARRIED_LAST_NAME>
            <ns0:G11_PROFESSION_OR_TRADE>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/PROFESSION_OR_TRADE) }</ns0:G11_PROFESSION_OR_TRADE>
            <ns0:G11_NAME_OF_EMPLOYMENT>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/NAME_OF_EMPLOYMENT) }</ns0:G11_NAME_OF_EMPLOYMENT>
            <ns0:G11_SENIORITY>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/SENIORITY) }</ns0:G11_SENIORITY>
            <ns0:G11_JOB_TITLE>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/JOB_TITLE) }</ns0:G11_JOB_TITLE>
            <ns0:G11_HOME_PHONE_NUMBER>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/PHONE_NUMBER) }</ns0:G11_HOME_PHONE_NUMBER>
            <ns0:G11_HOME_FAX>{ data($solicitudTarjetaCredito/COLLATERAL_SPOUSE_INFO/FAX) }</ns0:G11_HOME_FAX>
            <ns0:G12_NAME_OF_EMPLOYMENT>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/NAME_OF_EMPLOYMENT) }</ns0:G12_NAME_OF_EMPLOYMENT>
            <ns0:G12_EMPLOYMENT_ENTRY_DATE>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/EMPLOYMENT_ENTRY_DATE) }</ns0:G12_EMPLOYMENT_ENTRY_DATE>
            <ns0:G12_JOB_TITLE>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/JOB_TITLE) }</ns0:G12_JOB_TITLE>
            <ns0:G12_WORK_PHONE_NUMBER>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_PHONE_NUMBER) }</ns0:G12_WORK_PHONE_NUMBER>
            <ns0:G12_WORK_FAX>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_FAX) }</ns0:G12_WORK_FAX>
            <ns0:G12_MONTHLY_INCOME>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/MONTHLY_INCOME) }</ns0:G12_MONTHLY_INCOME>
            <ns0:G12_WORK_ADDRESS>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_ADDRESS) }</ns0:G12_WORK_ADDRESS>
            <ns0:G12_WORK_STREET>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_STREET) }</ns0:G12_WORK_STREET>
            <ns0:G12_WORK_AVENUE>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_AVENUE) }</ns0:G12_WORK_AVENUE>
            <ns0:G12_WORK_HOUSE_NUMBER>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_HOUSE_NUMBER) }</ns0:G12_WORK_HOUSE_NUMBER>
            <ns0:G12_WORK_CITY>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_CITY) }</ns0:G12_WORK_CITY>
            <ns0:G12_WORK_STATE>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_STATE) }</ns0:G12_WORK_STATE>
            <ns0:G12_WORK_POSTAL_CODE>{ data($solicitudTarjetaCredito/COLLATERAL_SRC_OF_INCOME/WORK_POSTAL_CODE) }</ns0:G12_WORK_POSTAL_CODE>
            <ns0:G13_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_PROPERTIES/NAME) }</ns0:G13_NAME>
            <ns0:G13_VALUE>{ data($solicitudTarjetaCredito/COLLATERAL_PROPERTIES/VALUE) }</ns0:G13_VALUE>
            <ns0:G13_ASSESSMENT>{ data($solicitudTarjetaCredito/COLLATERAL_PROPERTIES/ASSESSMENT) }</ns0:G13_ASSESSMENT>
            <ns0:G13_BENEFICIARY>{ data($solicitudTarjetaCredito/COLLATERAL_PROPERTIES/BENEFICIARY) }</ns0:G13_BENEFICIARY>
            <ns0:G14_FIN_INSTITUTE_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_BANK_REFERENCES/FIN_INSTITUTE_NAME) }</ns0:G14_FIN_INSTITUTE_NAME>
            <ns0:G14_ACCOUNT_TYPE>{ data($solicitudTarjetaCredito/COLLATERAL_BANK_REFERENCES/ACCOUNT_TYPE) }</ns0:G14_ACCOUNT_TYPE>
            <ns0:G14_ACCOUNT_NUMBER>{ data($solicitudTarjetaCredito/COLLATERAL_BANK_REFERENCES/ACCOUNT_NUMBER) }</ns0:G14_ACCOUNT_NUMBER>
            <ns0:G14_AVERAGE_BALANCE>{ data($solicitudTarjetaCredito/COLLATERAL_BANK_REFERENCES/AVERAGE_BALANCE) }</ns0:G14_AVERAGE_BALANCE>
            <ns0:G15_FIN_INSTITUTE_NAME>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[1]/FIN_INSTITUTE_NAME) }</ns0:G15_FIN_INSTITUTE_NAME>
            <ns0:G15_CREDIT_LIMIT>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[1]/CREDIT_LIMIT) }</ns0:G15_CREDIT_LIMIT>
            <ns0:G15_CARD_NUMBER>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[1]/CARD_NUMBER) }</ns0:G15_CARD_NUMBER>
            <ns0:G15_EXPIRATION_DATE>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[1]/EXPIRATION_DATE) }</ns0:G15_EXPIRATION_DATE>
            <ns0:G15_FIN_INSTITUTE_NAME2>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[2]/FIN_INSTITUTE_NAME) }</ns0:G15_FIN_INSTITUTE_NAME2>
            <ns0:G15_CREDIT_LIMIT2>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[2]/CREDIT_LIMIT) }</ns0:G15_CREDIT_LIMIT2>
            <ns0:G15_CARD_NUMBER2>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[2]/CARD_NUMBER) }</ns0:G15_CARD_NUMBER2>
            <ns0:G15_EXPIRATION_DATE2>{ data($solicitudTarjetaCredito/COLLATERAL_OTHER_CRD_CARDS/COLLATERAL_OTHER_CRD_CARDS_RECORD[2]/EXPIRATION_DATE) }</ns0:G15_EXPIRATION_DATE2>
            <ns0:G16_NON_HOME_RELATIVE>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/NON_HOME_RELATIVE) }</ns0:G16_NON_HOME_RELATIVE>
            <ns0:G16_KINSHIP>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/KINSHIP) }</ns0:G16_KINSHIP>
            <ns0:G16_ADDRESS>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/ADDRESS) }</ns0:G16_ADDRESS>
            <ns0:G16_WORK_PHONE_NUMBER_1>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/WORK_PHONE_NUMBER_1) }</ns0:G16_WORK_PHONE_NUMBER_1>
            <ns0:G16_HOME_PHONE_NUMBER_1>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/HOME_PHONE_NUMBER_1) }</ns0:G16_HOME_PHONE_NUMBER_1>
            <ns0:G16_FICOHSA_REFERENCE>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/FICOHSA_REFERENCE) }</ns0:G16_FICOHSA_REFERENCE>
            <ns0:G16_BRANCH_OR_DEPARTMENT>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/BRANCH_OR_DEPARTMENT) }</ns0:G16_BRANCH_OR_DEPARTMENT>
            <ns0:G16_WORK_PHONE_NUMBER_2>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/WORK_PHONE_NUMBER_2) }</ns0:G16_WORK_PHONE_NUMBER_2>
            <ns0:G16_HOME_PHONE_NUMBER_2>{ data($solicitudTarjetaCredito/COLLATERAL_REFERENCES/HOME_PHONE_NUMBER_2) }</ns0:G16_HOME_PHONE_NUMBER_2>
            <ns0:CUSTOMER_NAME>{ $customer_name }</ns0:CUSTOMER_NAME>
        </ns0:InputParameters>
};

declare variable $solicitudTarjetaCredito as element(ns1:solicitudTarjetaCredito) external;
declare variable $customer_name as xs:string external;

xf:solicitudTarjetaCreditoIn($solicitudTarjetaCredito,
    $customer_name)