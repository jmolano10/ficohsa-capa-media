(:: pragma bea:global-element-parameter parameter="$evaluacionSolicitudPrestamoTarjetaCredito" element="ns0:evaluacionSolicitudPrestamoTarjetaCredito" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:LoanApplicationReception" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/XMLSchema_779244201.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.FicohsaServices";
declare namespace ns1 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluacionSolicitudPrestamoTarjetaCredito/xq/loanApplicationReceptionIn/";

declare function xf:loanApplicationReceptionIn($evaluacionSolicitudPrestamoTarjetaCredito as element(ns0:evaluacionSolicitudPrestamoTarjetaCredito),
    $login as xs:string,
    $token as xs:string,
    $serviceId as xs:string,
    $idCompany as xs:long)
    as element(ns1:LoanApplicationReception) {
        <ns1:LoanApplicationReception>
            <ns1:loanApplication>
                {
                    for $CHANNEL_CODE in $evaluacionSolicitudPrestamoTarjetaCredito/CHANNEL_CODE
                    return
                        <ns2:IdChannel>{ data($CHANNEL_CODE) }</ns2:IdChannel>
                }
                <ns2:IdCompany>{ $idCompany }</ns2:IdCompany>
                <ns2:Login>{ $login }</ns2:Login>
                <ns2:ServiceId>{ $serviceId }</ns2:ServiceId>
                <ns2:Token>{ $token }</ns2:Token>
                <ns2:UserName>{ data($evaluacionSolicitudPrestamoTarjetaCredito/USERNAME) }</ns2:UserName>
                <ns2:AlternateAddress1>{ data($evaluacionSolicitudPrestamoTarjetaCredito/ALTERNATE_ADDRESS/ALTERNATE_ADDRESS_1) }</ns2:AlternateAddress1>
                <ns2:AlternateAddress2>{ data($evaluacionSolicitudPrestamoTarjetaCredito/ALTERNATE_ADDRESS/ALTERNATE_ADDRESS_2) }</ns2:AlternateAddress2>
                <ns2:AlternateAddress3>{ data($evaluacionSolicitudPrestamoTarjetaCredito/ALTERNATE_ADDRESS/ALTERNATE_ADDRESS_3) }</ns2:AlternateAddress3>
                <ns2:AlternateEmail>{ data($evaluacionSolicitudPrestamoTarjetaCredito/ALTERNATE_CLIENT_EMAIL) }</ns2:AlternateEmail>
                {
                    for $ALTERNATE_PHONE in $evaluacionSolicitudPrestamoTarjetaCredito/ALTERNATE_PHONE
                    return
                        <ns2:AlternatePhone>{ data($ALTERNATE_PHONE) }</ns2:AlternatePhone>
                }
                {
                    let $BANK_REFERENCES_INFO := $evaluacionSolicitudPrestamoTarjetaCredito/BANK_REFERENCES_INFO
                    return
                        <ns2:BankReferences>
                            {
                                for $BANK_REFERENCE in $BANK_REFERENCES_INFO/BANK_REFERENCE
                                return
                                    <ns2:BankReference>
                                        {
                                            for $BANK_REFERENCES in $BANK_REFERENCE/BANK_REFERENCES
                                            return
                                                <ns2:BankReferences>{ data($BANK_REFERENCES) }</ns2:BankReferences>
                                        }
                                        {
                                            for $BANK_REFERENCES_TYPE in $BANK_REFERENCE/BANK_REFERENCES_TYPE
                                            return
                                                <ns2:TypeBankReferences>{ data($BANK_REFERENCES_TYPE) }</ns2:TypeBankReferences>
                                        }
                                    </ns2:BankReference>
                            }
                        </ns2:BankReferences>
                }
                {
                    for $BENEFICIARY_LEGAL_ID in $evaluacionSolicitudPrestamoTarjetaCredito/BENEFICIARY_LEGAL_ID
                    return
                        <ns2:BeneficiaryIdentification>{ data($BENEFICIARY_LEGAL_ID) }</ns2:BeneficiaryIdentification>
                }
                {
                    for $BENEFICIARY_NAME in $evaluacionSolicitudPrestamoTarjetaCredito/BENEFICIARY_NAME
                    return
                        <ns2:BeneficiaryName>{ data($BENEFICIARY_NAME) }</ns2:BeneficiaryName>
                }
                {
                    for $BENEFICIARY_PERCENTAGE in $evaluacionSolicitudPrestamoTarjetaCredito/BENEFICIARY_PERCENTAGE
                    return
                        <ns2:BeneficiaryPercentage>{ data($BENEFICIARY_PERCENTAGE) }</ns2:BeneficiaryPercentage>
                }
                {
                    for $BENEFICIARY_RELATIONSHIP in $evaluacionSolicitudPrestamoTarjetaCredito/BENEFICIARY_RELATIONSHIP
                    return
                        <ns2:BeneficiaryRelationship>{ data($BENEFICIARY_RELATIONSHIP) }</ns2:BeneficiaryRelationship>
                }
                <ns2:BirthDate>{ data($evaluacionSolicitudPrestamoTarjetaCredito/BIRTH_DATE) }</ns2:BirthDate>
                {
                    for $BIRTH_DATE_SPOUSE in $evaluacionSolicitudPrestamoTarjetaCredito/BIRTH_DATE_SPOUSE
                    return
                        <ns2:BirthDateSpouse>{ data($BIRTH_DATE_SPOUSE) }</ns2:BirthDateSpouse>
                }
                {
                    for $CELL_PHONE in $evaluacionSolicitudPrestamoTarjetaCredito/CELL_PHONE
                    return
                        <ns2:CellPhone>{ data($CELL_PHONE) }</ns2:CellPhone>
                }
                <ns2:CivilStatus>{ data($evaluacionSolicitudPrestamoTarjetaCredito/CIVIL_STATUS) }</ns2:CivilStatus>
                {
                    for $COMMENTS in $evaluacionSolicitudPrestamoTarjetaCredito/COMMENTS
                    return
                        <ns2:Comments>{ data($COMMENTS) }</ns2:Comments>
                }
                {
                    for $COMPANY_PHONE in $evaluacionSolicitudPrestamoTarjetaCredito/COMPANY_PHONE
                    return
                        <ns2:CompanyPhone>{ data($COMPANY_PHONE) }</ns2:CompanyPhone>
                }
                {
                    for $COUNTRY in $evaluacionSolicitudPrestamoTarjetaCredito/COUNTRY
                    return
                        <ns2:Country>{ data($COUNTRY) }</ns2:Country>
                }
                {
                    for $COUNTRY_OF_BIRTH in $evaluacionSolicitudPrestamoTarjetaCredito/COUNTRY_OF_BIRTH
                    return
                        <ns2:CountryBirth>{ data($COUNTRY_OF_BIRTH) }</ns2:CountryBirth>
                }
                {
                    for $CREATION_DATE in $evaluacionSolicitudPrestamoTarjetaCredito/CREATION_DATE
                    return
                        <ns2:CreationDate>{ data($CREATION_DATE) }</ns2:CreationDate>
                }
                {
                    let $CREDIT_CONSOLIDATION_INFO := $evaluacionSolicitudPrestamoTarjetaCredito/CREDIT_CONSOLIDATION_INFO
                    return
                        <ns2:CreditConsolidationInformation>
                            {
                                for $CONSOLIDATION_INFO in $CREDIT_CONSOLIDATION_INFO/CONSOLIDATION_INFO
                                return
                                    <ns2:ConsolidationInformation>
                                        {
                                            for $ACCOUNT_NUMBER in $CONSOLIDATION_INFO/ACCOUNT_NUMBER
                                            return
                                                <ns2:AccountNumber>{ data($ACCOUNT_NUMBER) }</ns2:AccountNumber>
                                        }
                                        {
                                            for $AMOUNT in $CONSOLIDATION_INFO/AMOUNT
                                            return
                                                <ns2:Amount>{ data($AMOUNT) }</ns2:Amount>
                                        }
                                        {
                                            for $CURRENCY in $CONSOLIDATION_INFO/CURRENCY
                                            return
                                                <ns2:Currency>{ data($CURRENCY) }</ns2:Currency>
                                        }
                                        {
                                            for $INSTITUTION in $CONSOLIDATION_INFO/INSTITUTION
                                            return
                                                <ns2:Institution>{ data($INSTITUTION) }</ns2:Institution>
                                        }
                                        {
                                            for $PRODUCT in $CONSOLIDATION_INFO/PRODUCT
                                            return
                                                <ns2:Product>{ data($PRODUCT) }</ns2:Product>
                                        }
                                        {
                                            for $REAL_FEE in $CONSOLIDATION_INFO/REAL_FEE
                                            return
                                                <ns2:RealFee>{ data($REAL_FEE) }</ns2:RealFee>
                                        }
                                    </ns2:ConsolidationInformation>
                            }
                        </ns2:CreditConsolidationInformation>
                }
                <ns2:Currency>{ data($evaluacionSolicitudPrestamoTarjetaCredito/CURRENCY) }</ns2:Currency>
                <ns2:CustomerCampaign>{ data($evaluacionSolicitudPrestamoTarjetaCredito/CUSTOMER_CAMPAIGN) }</ns2:CustomerCampaign>                
                <ns2:CustomerEconomicActivity>{ data($evaluacionSolicitudPrestamoTarjetaCredito/CLIENT_ECONOMIC_ACTIVITY) }</ns2:CustomerEconomicActivity>                
                {
                    for $CARD_HOLDER_NAME in $evaluacionSolicitudPrestamoTarjetaCredito/CARD_HOLDER_NAME
                    return
                        <ns2:CustomerNameOnCard>{ data($CARD_HOLDER_NAME) }</ns2:CustomerNameOnCard>
                }
                {
                    for $DEPARTMENT in $evaluacionSolicitudPrestamoTarjetaCredito/DEPARTMENT
                    return
                        <ns2:Department>{ data($DEPARTMENT) }</ns2:Department>
                }
                {
                    for $DEPENDENTS_NUMBER in $evaluacionSolicitudPrestamoTarjetaCredito/DEPENDENTS_NUMBER
                    return
                        <ns2:DependentNumber>{ data($DEPENDENTS_NUMBER) }</ns2:DependentNumber>
                }
                <ns2:DisbursementAccountNumber>{ data($evaluacionSolicitudPrestamoTarjetaCredito/DISBURSEMENT_ACCOUNT_NUMBER) }</ns2:DisbursementAccountNumber>
                <ns2:DisbursementCommission>{ data($evaluacionSolicitudPrestamoTarjetaCredito/DISBURSEMENT_COMMISSION) }</ns2:DisbursementCommission>
                {
                    for $DISBURSEMENT_TYPE in $evaluacionSolicitudPrestamoTarjetaCredito/DISBURSEMENT_TYPE
                    return
                        <ns2:DisbursementType>{ data($DISBURSEMENT_TYPE) }</ns2:DisbursementType>
                }
                {
                    let $DOCUMENTS := $evaluacionSolicitudPrestamoTarjetaCredito/DOCUMENTS
                    return
                        <ns2:Documents>
                            {
                                for $DOCUMENT in $DOCUMENTS/DOCUMENT
                                return
                                    <ns2:DocumentCommerce>
                                        {
                                            for $CONTENT_BYTES in $DOCUMENT/CONTENT_BYTES
                                            return
                                                <ns2:ContentBytes>{ data($CONTENT_BYTES) }</ns2:ContentBytes>
                                        }
                                        {
                                            for $FILE_EXTENSION in $DOCUMENT/FILE_EXTENSION
                                            return
                                                <ns2:FileExtension>{ data($FILE_EXTENSION) }</ns2:FileExtension>
                                        }
                                        {
                                            for $FILE_NAME in $DOCUMENT/FILE_NAME
                                            return
                                                <ns2:FileName>{ data($FILE_NAME) }</ns2:FileName>
                                        }
                                        {
                                            for $FILE_TYPE in $DOCUMENT/FILE_TYPE
                                            return
                                                <ns2:FileType>{ data($FILE_TYPE) }</ns2:FileType>
                                        }
                                    </ns2:DocumentCommerce>
                            }
                        </ns2:Documents>
                }
                {
                    for $ECONOMIC_ACTIVITY in $evaluacionSolicitudPrestamoTarjetaCredito/ECONOMIC_ACTIVITY
                    return
                        <ns2:EconomicActivity>{ data($ECONOMIC_ACTIVITY) }</ns2:EconomicActivity>
                }
                {
                    for $EDUCATION_LEVEL in $evaluacionSolicitudPrestamoTarjetaCredito/EDUCATION_LEVEL
                    return
                        <ns2:EducationLevel>{ data($EDUCATION_LEVEL) }</ns2:EducationLevel>
                }
                <ns2:Email>{ data($evaluacionSolicitudPrestamoTarjetaCredito/EMAIL) }</ns2:Email>
                <ns2:EmailSpouse>{ data($evaluacionSolicitudPrestamoTarjetaCredito/EMAIL_SPOUSE) }</ns2:EmailSpouse>
                {
                    for $EXPIRATION_DATE_1 in $evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_EXPIRATION_DATE_1
                    return
                        <ns2:ExpirationDateIdentification1>{ data($EXPIRATION_DATE_1) }</ns2:ExpirationDateIdentification1>
                }
                {
                    for $EXPIRATION_DATE_2 in $evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_EXPIRATION_DATE_2
                    return
                        <ns2:ExpirationDateIdentification2>{ data($EXPIRATION_DATE_2) }</ns2:ExpirationDateIdentification2>
                }
                {
                    for $EXTENSION in $evaluacionSolicitudPrestamoTarjetaCredito/EXTENSION
                    return
                        <ns2:Extension>{ data($EXTENSION) }</ns2:Extension>
                }
                <ns2:FirstName>{ data($evaluacionSolicitudPrestamoTarjetaCredito/FIRST_NAME) }</ns2:FirstName>
                {
                    for $FIRST_NAME_SPOUSE in $evaluacionSolicitudPrestamoTarjetaCredito/FIRST_NAME_SPOUSE
                    return
                        <ns2:FirstNameSpouse>{ data($FIRST_NAME_SPOUSE) }</ns2:FirstNameSpouse>
                }
                <ns2:Gender>{ data($evaluacionSolicitudPrestamoTarjetaCredito/GENDER) }</ns2:Gender>
                <ns2:HomeAddressLine1>{ data($evaluacionSolicitudPrestamoTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_1) }</ns2:HomeAddressLine1>
                <ns2:HomeAddressLine2>{ data($evaluacionSolicitudPrestamoTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_2) }</ns2:HomeAddressLine2>
                <ns2:HomeAddressLine3>{ data($evaluacionSolicitudPrestamoTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_3) }</ns2:HomeAddressLine3>
                <ns2:HomeAddressLine4>{ data($evaluacionSolicitudPrestamoTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_4) }</ns2:HomeAddressLine4>
                {
                    for $HOME_PHONE_NUMBER in $evaluacionSolicitudPrestamoTarjetaCredito/HOME_PHONE_NUMBER
                    return
                        <ns2:HomePhoneNumber>{ data($HOME_PHONE_NUMBER) }</ns2:HomePhoneNumber>
                }
                <ns2:IdCreditRequest>{ data($evaluacionSolicitudPrestamoTarjetaCredito/CREDIT_REQUEST_ID) }</ns2:IdCreditRequest>
                <ns2:IdSaleForceRequest>{ data($evaluacionSolicitudPrestamoTarjetaCredito/REQUEST_ID) }</ns2:IdSaleForceRequest>
                <ns2:Identification1>{ data($evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_1) }</ns2:Identification1>
                <ns2:Identification2>{ data($evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_2) }</ns2:Identification2>
                {
                    for $LEGAL_ID_SPOUSE in $evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_SPOUSE
                    return
                        <ns2:IdentificationSpouse>{ data($LEGAL_ID_SPOUSE) }</ns2:IdentificationSpouse>
                }
                {
                    for $LEGAL_ID_TYPE_1 in $evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_TYPE_1
                    return
                        <ns2:IdentificationType1>{ data($LEGAL_ID_TYPE_1) }</ns2:IdentificationType1>
                }
                {
                    for $LEGAL_ID_TYPE_2 in $evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_TYPE_2
                    return
                        <ns2:IdentificationType2>{ data($LEGAL_ID_TYPE_2) }</ns2:IdentificationType2>
                }
                {
                    for $LEGAL_ID_TYPE_SPOUSE in $evaluacionSolicitudPrestamoTarjetaCredito/LEGAL_ID_TYPE_SPOUSE
                    return
                        <ns2:IdentificationTypeSpouse>{ data($LEGAL_ID_TYPE_SPOUSE) }</ns2:IdentificationTypeSpouse>
                }                                
                {
                    for $SALARY_RANGE in $evaluacionSolicitudPrestamoTarjetaCredito/SALARY_RANGE
                    return
                        <ns2:IncomeRange>{ data($SALARY_RANGE) }</ns2:IncomeRange>
                }                                                
                {
                    for $INSURANCE_CARRIER in $evaluacionSolicitudPrestamoTarjetaCredito/INSURANCE_CARRIER
                    return
                        <ns2:InsuranceCarrier>{ data($INSURANCE_CARRIER) }</ns2:InsuranceCarrier>
                }
                {
                    for $INSURANCE_TYPE in $evaluacionSolicitudPrestamoTarjetaCredito/INSURANCE_TYPE
                    return
                        <ns2:InsuranceType>{ data($INSURANCE_TYPE) }</ns2:InsuranceType>
                }                
                {
                    for $ISSUE_DATE_CLIENT_ID in $evaluacionSolicitudPrestamoTarjetaCredito/ISSUE_DATE_CLIENT_ID
                    return
                        <ns2:IssueDateIdentification1>{ data($ISSUE_DATE_CLIENT_ID) }</ns2:IssueDateIdentification1>
                }
                {
                    for $ISSUE_DATE_CLIENT_ID2 in $evaluacionSolicitudPrestamoTarjetaCredito/ISSUE_DATE_CLIENT_ID2
                    return
                        <ns2:IssueDateIdentification2>{ data($ISSUE_DATE_CLIENT_ID2) }</ns2:IssueDateIdentification2>
                }                                                 
                {
                    for $ISSUING_COUNTRY_1 in $evaluacionSolicitudPrestamoTarjetaCredito/ISSUING_COUNTRY_1
                    return
                        <ns2:IssuingCountryIdentification1>{ data($ISSUING_COUNTRY_1) }</ns2:IssuingCountryIdentification1>
                }
                {
                    for $ISSUING_COUNTRY_2 in $evaluacionSolicitudPrestamoTarjetaCredito/ISSUING_COUNTRY_2
                    return
                        <ns2:IssuingCountryIdentification2>{ data($ISSUING_COUNTRY_2) }</ns2:IssuingCountryIdentification2>
                }
                <ns2:JobAddressLine1>{ data($evaluacionSolicitudPrestamoTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_1) }</ns2:JobAddressLine1>
                <ns2:JobAddressLine2>{ data($evaluacionSolicitudPrestamoTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_2) }</ns2:JobAddressLine2>
                <ns2:JobAddressLine3>{ data($evaluacionSolicitudPrestamoTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_3) }</ns2:JobAddressLine3>
                <ns2:JobAddressLine4>{ data($evaluacionSolicitudPrestamoTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_4) }</ns2:JobAddressLine4>
                {
                    for $JOB_COUNTRY in $evaluacionSolicitudPrestamoTarjetaCredito/JOB_COUNTRY
                    return
                        <ns2:JobCountry>{ data($JOB_COUNTRY) }</ns2:JobCountry>
                }
                <ns2:JobDepartment>{ data($evaluacionSolicitudPrestamoTarjetaCredito/JOB_DEPARTMENT) }</ns2:JobDepartment>
                {
                    for $JOB_MUNICIPALITY in $evaluacionSolicitudPrestamoTarjetaCredito/JOB_MUNICIPALITY
                    return
                        <ns2:JobMunicipality>{ data($JOB_MUNICIPALITY) }</ns2:JobMunicipality>
                }
                {
                    for $LAST_NAME_SPOUSE in $evaluacionSolicitudPrestamoTarjetaCredito/LAST_NAME_SPOUSE
                    return
                        <ns2:LastNameSpouse>{ data($LAST_NAME_SPOUSE) }</ns2:LastNameSpouse>
                }
                {
                    for $LOAN_DESTINATION in $evaluacionSolicitudPrestamoTarjetaCredito/LOAN_DESTINATION
                    return
                        <ns2:LoanDestination>{ data($LOAN_DESTINATION) }</ns2:LoanDestination>
                }
                <ns2:LoanType>{ data($evaluacionSolicitudPrestamoTarjetaCredito/LOAN_TYPE) }</ns2:LoanType>
                {
                    for $MARRIED_SURENAME in $evaluacionSolicitudPrestamoTarjetaCredito/MARRIED_SURNAME
                    return
                        <ns2:MarriedSurname>{ data($MARRIED_SURENAME) }</ns2:MarriedSurname>
                }
                <ns2:MonthlyIncome>{ data($evaluacionSolicitudPrestamoTarjetaCredito/MONTHLY_INCOME) }</ns2:MonthlyIncome>
                {
                    for $RESIDENCIE_CURRENT_MONTH in $evaluacionSolicitudPrestamoTarjetaCredito/RESIDENCIE_CURRENT_MONTH
                    return
                        <ns2:MonthsCurrentAddress>{ data($RESIDENCIE_CURRENT_MONTH) }</ns2:MonthsCurrentAddress>
                }
                {
                    for $MONTHS_CURRENT_JOB in $evaluacionSolicitudPrestamoTarjetaCredito/MONTHS_CURRENT_JOB
                    return
                        <ns2:MonthsCurrentJob>{ data($MONTHS_CURRENT_JOB) }</ns2:MonthsCurrentJob>
                }
                {
                    for $MUNICIPALITY in $evaluacionSolicitudPrestamoTarjetaCredito/MUNICIPALITY
                    return
                        <ns2:Municipality>{ data($MUNICIPALITY) }</ns2:Municipality>
                }
                {
                    for $NACIONALITY in $evaluacionSolicitudPrestamoTarjetaCredito/NACIONALITY
                    return
                        <ns2:Nacionality>{ data($NACIONALITY) }</ns2:Nacionality>
                }
                {
                    for $BUSINESS_OF_NATURE in $evaluacionSolicitudPrestamoTarjetaCredito/BUSINESS_OF_NATURE
                    return
                        <ns2:NatureBusiness>{ data($BUSINESS_OF_NATURE) }</ns2:NatureBusiness>
                }
                <ns2:Occupation>{ data($evaluacionSolicitudPrestamoTarjetaCredito/OCCUPATION) }</ns2:Occupation>
                {
                    for $OTHER_ANUAL_INCOME in $evaluacionSolicitudPrestamoTarjetaCredito/OTHER_ANUAL_INCOME
                    return
                        <ns2:OtherAnnualIncome>{ data($OTHER_ANUAL_INCOME) }</ns2:OtherAnnualIncome>
                }
                {
                    for $PEP_CUSTOMER in $evaluacionSolicitudPrestamoTarjetaCredito/PEP_CUSTOMER
                    return
                        <ns2:PepCustomer>{ data($PEP_CUSTOMER) }</ns2:PepCustomer>
                }
                {
                    let $PERSONAL_REFERENCES := $evaluacionSolicitudPrestamoTarjetaCredito/PERSONAL_REFERENCES
                    return
                        <ns2:PersonalReferences>
                            {
                                for $PERSONAL_REFERENCE in $PERSONAL_REFERENCES/PERSONAL_REFERENCE
                                return
                                    <ns2:PersonalReference>
                                        {
                                            for $PERSONAL_REFERENCE_NAME in $PERSONAL_REFERENCE/PERSONAL_REFERENCE_NAME
                                            return
                                                <ns2:PersonalReferenceName>{ data($PERSONAL_REFERENCE_NAME) }</ns2:PersonalReferenceName>
                                        }
                                        {
                                            for $PHONE_REFERENCE in $PERSONAL_REFERENCE/PHONE_REFERENCE
                                            return
                                                <ns2:PhoneReference>{ data($PHONE_REFERENCE) }</ns2:PhoneReference>
                                        }
                                        {
                                            for $RELATIONSHIP_TYPE_REFERENCE in $PERSONAL_REFERENCE/RELATIONSHIP_TYPE_REFERENCE
                                            return
                                                <ns2:TypeRelationshipReference>{ data($RELATIONSHIP_TYPE_REFERENCE) }</ns2:TypeRelationshipReference>
                                        }
                                    </ns2:PersonalReference>
                            }
                        </ns2:PersonalReferences>
                }
                {
                    for $PLACE_BIRTH in $evaluacionSolicitudPrestamoTarjetaCredito/PLACE_BIRTH
                    return
                        <ns2:PlaceBirth>{ data($PLACE_BIRTH) }</ns2:PlaceBirth>
                }
                {
                    for $POLICY_NUMBER in $evaluacionSolicitudPrestamoTarjetaCredito/POLICY_NUMBER
                    return
                        <ns2:PolicyNumber>{ data($POLICY_NUMBER) }</ns2:PolicyNumber>
                }
                <ns2:Position>{ data($evaluacionSolicitudPrestamoTarjetaCredito/POSITION) }</ns2:Position>
                {
                    for $POSITION_DESCRIPTION in $evaluacionSolicitudPrestamoTarjetaCredito/POSITION_DESCRIPTION
                    return
                        <ns2:PositionDescription>{ data($POSITION_DESCRIPTION) }</ns2:PositionDescription>
                }
                {
                    for $RATE in $evaluacionSolicitudPrestamoTarjetaCredito/RATE
                    return
                        <ns2:Rate>{ data($RATE) }</ns2:Rate>
                }
                {
                    for $REQUESTED_AMOUNT in $evaluacionSolicitudPrestamoTarjetaCredito/REQUESTED_AMOUNT
                    return
                        <ns2:RequestedAmount>{ data($REQUESTED_AMOUNT) }</ns2:RequestedAmount>
                }
                {
                    for $REQUESTED_TERM in $evaluacionSolicitudPrestamoTarjetaCredito/REQUESTED_TERM
                    return
                        <ns2:RequestedTerm>{ data($REQUESTED_TERM) }</ns2:RequestedTerm>
                }
                {
                    for $SECOND_NAME in $evaluacionSolicitudPrestamoTarjetaCredito/SECOND_NAME
                    return
                        <ns2:SecondName>{ data($SECOND_NAME) }</ns2:SecondName>
                }
                {
                    for $SECOND_NAME_SPOUSE in $evaluacionSolicitudPrestamoTarjetaCredito/SECOND_NAME_SPOUSE
                    return
                        <ns2:SecondNameSpouse>{ data($SECOND_NAME_SPOUSE) }</ns2:SecondNameSpouse>
                }
                {
                    for $SECOND_SURENAME in $evaluacionSolicitudPrestamoTarjetaCredito/SECOND_SURNAME
                    return
                        <ns2:SecondSurname>{ data($SECOND_SURENAME) }</ns2:SecondSurname>
                }
                {
                    for $SECOND_SURNAME_SPOUSE in $evaluacionSolicitudPrestamoTarjetaCredito/SECOND_SURNAME_SPOUSE
                    return
                        <ns2:SecondSurnameSpouse>{ data($SECOND_SURNAME_SPOUSE) }</ns2:SecondSurnameSpouse>
                }
                {
                    for $SECONDARY_EMAIL in $evaluacionSolicitudPrestamoTarjetaCredito/SECONDARY_EMAIL
                    return
                        <ns2:SecondaryEmail>{ data($SECONDARY_EMAIL) }</ns2:SecondaryEmail>
                }
                <ns2:SellerCode>{ data($evaluacionSolicitudPrestamoTarjetaCredito/SELLER_CODE) }</ns2:SellerCode>
                {
                    for $SHIPPING_STATE in $evaluacionSolicitudPrestamoTarjetaCredito/SHIPPING_STATE
                    return
                        <ns2:ShippingStateAccount>{ data($SHIPPING_STATE) }</ns2:ShippingStateAccount>
                }
                {
                    for $SOURCE_OTHER_INCOME in $evaluacionSolicitudPrestamoTarjetaCredito/SOURCE_OTHER_INCOME
                    return
                        <ns2:SourceOtherIncome>{ data($SOURCE_OTHER_INCOME) }</ns2:SourceOtherIncome>
                }
                {
                    for $SPOUSE_PHONE in $evaluacionSolicitudPrestamoTarjetaCredito/SPOUSE_PHONE
                    return
                        <ns2:SpousePhone>{ data($SPOUSE_PHONE) }</ns2:SpousePhone>
                }                                
                <ns2:SupervisorCode>{ data($evaluacionSolicitudPrestamoTarjetaCredito/SUPERVISOR_CODE) }</ns2:SupervisorCode>
                <ns2:Surname>{ data($evaluacionSolicitudPrestamoTarjetaCredito/SURNAME) }</ns2:Surname>
                {
                    for $THIRD_NAME in $evaluacionSolicitudPrestamoTarjetaCredito/THIRD_NAME
                    return
                        <ns2:ThirdName>{ data($THIRD_NAME) }</ns2:ThirdName>
                }
                {
                    for $RESIDENCE_TYPE in $evaluacionSolicitudPrestamoTarjetaCredito/RESIDENCE_TYPE
                    return
                        <ns2:TypeResidence>{ data($RESIDENCE_TYPE) }</ns2:TypeResidence>
                }
                {
                    for $UNIQUE_NUMBER in $evaluacionSolicitudPrestamoTarjetaCredito/UNIQUE_NUMBER
                    return
                        <ns2:UniqueNumber>{ data($UNIQUE_NUMBER) }</ns2:UniqueNumber>
                }
                {
                    for $INSURANCE_VALIDITY_FROM in $evaluacionSolicitudPrestamoTarjetaCredito/INSURANCE_VALIDITY_FROM
                    return
                        <ns2:ValidSince>{ data($INSURANCE_VALIDITY_FROM) }</ns2:ValidSince>
                }
                {
                    for $INSURANCE_VALIDITY_UP_TO in $evaluacionSolicitudPrestamoTarjetaCredito/INSURANCE_VALIDITY_UP_TO
                    return
                        <ns2:ValidUntil>{ data($INSURANCE_VALIDITY_UP_TO) }</ns2:ValidUntil>
                }                
                {
                    for $WORK_PHONE_EXTENSION in $evaluacionSolicitudPrestamoTarjetaCredito/WORK_PHONE_EXTENSION
                    return
                        <ns2:WorkPhoneExtension>{ data($WORK_PHONE_EXTENSION) }</ns2:WorkPhoneExtension>
                }                                                
                <ns2:Workplace>{ data($evaluacionSolicitudPrestamoTarjetaCredito/WORKPLACE) }</ns2:Workplace>
                {
                    for $RESIDENCIE_CURRENT_YEARS in $evaluacionSolicitudPrestamoTarjetaCredito/RESIDENCIE_CURRENT_YEARS
                    return
                        <ns2:YearsCurrentAddress>{ data($RESIDENCIE_CURRENT_YEARS) }</ns2:YearsCurrentAddress>
                }
                {
                    for $YEARS_CURRENT_JOB in $evaluacionSolicitudPrestamoTarjetaCredito/YEARS_CURRENT_JOB
                    return
                        <ns2:YearsCurrentJob>{ data($YEARS_CURRENT_JOB) }</ns2:YearsCurrentJob>
                }
            </ns1:loanApplication>
        </ns1:LoanApplicationReception>
};

declare variable $evaluacionSolicitudPrestamoTarjetaCredito as element(ns0:evaluacionSolicitudPrestamoTarjetaCredito) external;
declare variable $login as xs:string external;
declare variable $token as xs:string external;
declare variable $serviceId as xs:string external;
declare variable $idCompany as xs:long external;

xf:loanApplicationReceptionIn($evaluacionSolicitudPrestamoTarjetaCredito,
    $login,
    $token,
    $serviceId,
    $idCompany)