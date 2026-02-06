xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$evaluacionSolicitudTarjetaCredito" element="ns0:evaluacionSolicitudTarjetaCredito" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreditCardApplicationReception" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/XMLSchema_779244201.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.FicohsaServices";
declare namespace ns1 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluacionSolicitudTarjetaCredito/xq/evaluacionSolicitudTarjetaCreditoIn/";

declare function xf:creditCardApplicationReceptionIn($evaluacionSolicitudTarjetaCredito as element(ns0:evaluacionSolicitudTarjetaCredito),
    $login as xs:string,
    $token as xs:string,
    $serviceId as xs:string,
    $idCompany as xs:long)
    as element(ns1:CreditCardApplicationReception) {
        <ns1:CreditCardApplicationReception>
            <ns1:creditCardApplication>
                {
                    for $CHANNEL_CODE in $evaluacionSolicitudTarjetaCredito/CHANNEL_CODE
                    return
                        <ns2:IdChannel>{ data($CHANNEL_CODE) }</ns2:IdChannel>
                }
                <ns2:IdCompany>{ $idCompany }</ns2:IdCompany>
                <ns2:Login>{ $login }</ns2:Login>
                <ns2:ServiceId>{ $serviceId }</ns2:ServiceId>
                <ns2:Token>{ $token }</ns2:Token>
                <ns2:UserName>{ data($evaluacionSolicitudTarjetaCredito/USERNAME) }</ns2:UserName>
                {
                    let $ADDITIONAL_CREDIT_CARDS_INFO := $evaluacionSolicitudTarjetaCredito/ADDITIONAL_CREDIT_CARDS_INFO
                    return
                        <ns2:AdditionalCreditCards>
                            {
                                for $ADDITIONAL_CREDIT_CARD in $ADDITIONAL_CREDIT_CARDS_INFO/ADDITIONAL_CREDIT_CARD
                                return
                                    <ns2:AdditionalCreditCard>
                                        {
                                            for $ALTERNATE_PHONE_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/ALTERNATE_PHONE_ADDITIONAL_CARD
                                            return
                                                <ns2:AlternatePhoneAdditionalCard>{ data($ALTERNATE_PHONE_ADDITIONAL_CARD) }</ns2:AlternatePhoneAdditionalCard>
                                        }
                                        {
                                            for $BIRTH_DATE_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/BIRTH_DATE_ADDITIONAL_CARD
                                            return
                                                <ns2:BirthDateAdditionalCard>{ data($BIRTH_DATE_ADDITIONAL_CARD) }</ns2:BirthDateAdditionalCard>
                                        }
                                        {
                                            for $CELL_PHONE_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/CELL_PHONE_ADDITIONAL_CARD
                                            return
                                                <ns2:CellPhoneAdditionalCard>{ data($CELL_PHONE_ADDITIONAL_CARD) }</ns2:CellPhoneAdditionalCard>
                                        }
                                        {
                                            for $CIVIL_STATUS_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/CIVIL_STATUS_ADDITIONAL_CARD
                                            return
                                                <ns2:CivilStatusAdditionalCard>{ data($CIVIL_STATUS_ADDITIONAL_CARD) }</ns2:CivilStatusAdditionalCard>
                                        }
                                        {
                                            for $CREDIT_LIMIT_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/CREDIT_LIMIT_ADDITIONAL_CARD
                                            return
                                                <ns2:CreditLimitAdditionalCard>{ data($CREDIT_LIMIT_ADDITIONAL_CARD) }</ns2:CreditLimitAdditionalCard>
                                        }
                                        {
                                            for $CUSTOMER_RELATIONSHIP_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/CUSTOMER_RELATIONSHIP_ADDITIONAL_CARD
                                            return
                                                <ns2:CustomerRelationshipAdditionalCard>{ data($CUSTOMER_RELATIONSHIP_ADDITIONAL_CARD) }</ns2:CustomerRelationshipAdditionalCard>
                                        }
                                        {
                                            for $EMAIL_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/EMAIL_ADDITIONAL_CARD
                                            return
                                                <ns2:EmailAdditionalCard>{ data($EMAIL_ADDITIONAL_CARD) }</ns2:EmailAdditionalCard>
                                        }
                                        {
                                            for $FAST_PLASTIC_EMISSION_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/FAST_PLASTIC_EMISSION_ADDITIONAL_CARD
                                            return
                                                <ns2:FastPlasticEmissionAdditionalCard>{ data($FAST_PLASTIC_EMISSION_ADDITIONAL_CARD) }</ns2:FastPlasticEmissionAdditionalCard>
                                        }
                                        {
                                            for $FULL_NAME_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/FULL_NAME_ADDITIONAL_CARD
                                            return
                                                <ns2:FullNameAdditionalCard>{ data($FULL_NAME_ADDITIONAL_CARD) }</ns2:FullNameAdditionalCard>
                                        }
                                        {
                                            for $GENDER_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/GENDER_ADDITIONAL_CARD
                                            return
                                                <ns2:GenderAdditionalCard>{ data($GENDER_ADDITIONAL_CARD) }</ns2:GenderAdditionalCard>
                                        }
                                        {
                                            for $HOME_PHONE_NUMBER_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/HOME_PHONE_NUMBER_ADDITIONAL_CARD
                                            return
                                                <ns2:HomePhoneNumberAdditionalCard>{ data($HOME_PHONE_NUMBER_ADDITIONAL_CARD) }</ns2:HomePhoneNumberAdditionalCard>
                                        }
                                        {
                                            for $IDENTIFICATION_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/IDENTIFICATION_ADDITIONAL_CARD
                                            return
                                                <ns2:IdentificationAdditionalCard>{ data($IDENTIFICATION_ADDITIONAL_CARD) }</ns2:IdentificationAdditionalCard>
                                        }
                                        {
                                            for $MEMO_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/MEMO_ADDITIONAL_CARD
                                            return
                                                <ns2:MemoAdditionalCard>{ data($MEMO_ADDITIONAL_CARD) }</ns2:MemoAdditionalCard>
                                        }
                                        {
                                            for $NAME_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/NAME_ADDITIONAL_CARD
                                            return
                                                <ns2:NameAdditionalCard>{ data($NAME_ADDITIONAL_CARD) }</ns2:NameAdditionalCard>
                                        }
                                        {
                                            for $PEP_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/PEP_ADDITIONAL_CARD
                                            return
                                                <ns2:PEPAdditionalCard>{ data($PEP_ADDITIONAL_CARD) }</ns2:PEPAdditionalCard>
                                        }
                                        {
                                            for $PRODUCT_TYPE_ADDITIONAL_CARD in $ADDITIONAL_CREDIT_CARD/PRODUCT_TYPE_ADDITIONAL_CARD
                                            return
                                                <ns2:ProductTypeAdditionalCard>{ data($PRODUCT_TYPE_ADDITIONAL_CARD) }</ns2:ProductTypeAdditionalCard>
                                        }
                                    </ns2:AdditionalCreditCard>
                            }
                        </ns2:AdditionalCreditCards>
                }
                <ns2:AlternateAddress1>{ data($evaluacionSolicitudTarjetaCredito/ALTERNATE_ADDRESS/ALTERNATE_ADDRESS_1) }</ns2:AlternateAddress1>
                <ns2:AlternateAddress2>{ data($evaluacionSolicitudTarjetaCredito/ALTERNATE_ADDRESS/ALTERNATE_ADDRESS_2) }</ns2:AlternateAddress2>
                <ns2:AlternateAddress3>{ data($evaluacionSolicitudTarjetaCredito/ALTERNATE_ADDRESS/ALTERNATE_ADDRESS_3) }</ns2:AlternateAddress3>
                <ns2:AlternateEmail>{ data($evaluacionSolicitudTarjetaCredito/ALTERNATE_CLIENT_EMAIL) }</ns2:AlternateEmail>
                {
                    for $ALTERNATE_PHONE in $evaluacionSolicitudTarjetaCredito/ALTERNATE_PHONE
                    return
                        <ns2:AlternatePhone>{ data($ALTERNATE_PHONE) }</ns2:AlternatePhone>
                }
                <ns2:ApprovedLimit>{ data($evaluacionSolicitudTarjetaCredito/APPROVED_LIMIT) }</ns2:ApprovedLimit>
                {
                    let $BANK_REFERENCES_INFO := $evaluacionSolicitudTarjetaCredito/BANK_REFERENCES_INFO
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
                    for $BENEFIT_CASHBACK in $evaluacionSolicitudTarjetaCredito/BENEFIT_CASHBACK
                    return
                        <ns2:BenefitCashBack>{ data($BENEFIT_CASHBACK) }</ns2:BenefitCashBack>
                }
                <ns2:BirthDate>{ data($evaluacionSolicitudTarjetaCredito/BIRTHDATE) }</ns2:BirthDate>
                {
                    for $BIRTHDATE_SPOUSE in $evaluacionSolicitudTarjetaCredito/BIRTHDATE_SPOUSE
                    return
                        <ns2:BirthDateSpouse>{ data($BIRTHDATE_SPOUSE) }</ns2:BirthDateSpouse>
                }
                <ns2:CellPhone>{ data($evaluacionSolicitudTarjetaCredito/CELLPHONE) }</ns2:CellPhone>
                <ns2:CivilStatus>{ data($evaluacionSolicitudTarjetaCredito/CIVIL_STATUS) }</ns2:CivilStatus>
                {
                    for $COMMENTS in $evaluacionSolicitudTarjetaCredito/COMMENTS
                    return
                        <ns2:Comments>{ data($COMMENTS) }</ns2:Comments>
                }
                {
                    for $COMPANY_PHONE in $evaluacionSolicitudTarjetaCredito/COMPANY_PHONE
                    return
                        <ns2:CompanyPhone>{ data($COMPANY_PHONE) }</ns2:CompanyPhone>
                }
                {
                    for $COUNTRY in $evaluacionSolicitudTarjetaCredito/COUNTRY
                    return
                        <ns2:Country>{ data($COUNTRY) }</ns2:Country>
                }
                {
                    for $COUNTRY_BIRTH in $evaluacionSolicitudTarjetaCredito/COUNTRY_BIRTH
                    return
                        <ns2:CountryBirth>{ data($COUNTRY_BIRTH) }</ns2:CountryBirth>
                }
                {
                    for $CREATION_DATE in $evaluacionSolicitudTarjetaCredito/CREATION_DATE
                    return
                        <ns2:CreationDate>{ data($CREATION_DATE) }</ns2:CreationDate>
                }
                <ns2:CustomerCampaign>{ data($evaluacionSolicitudTarjetaCredito/CUSTOMER_CAMPAIGN) }</ns2:CustomerCampaign>
                <ns2:CustomerEconomicActivity>{ data($evaluacionSolicitudTarjetaCredito/CLIENT_ECONOMIC_ACTIVITY) }</ns2:CustomerEconomicActivity>
                {
                    for $CUSTOMER_NAME_ONCARD in $evaluacionSolicitudTarjetaCredito/CUSTOMER_NAME_ONCARD
                    return
                        <ns2:CustomerNameOnCard>{ data($CUSTOMER_NAME_ONCARD) }</ns2:CustomerNameOnCard>
                }
                <ns2:Department>{ data($evaluacionSolicitudTarjetaCredito/DEPARTMENT) }</ns2:Department>
                {
                    for $DEPENDENT_NUMBER in $evaluacionSolicitudTarjetaCredito/DEPENDENT_NUMBER
                    return
                        <ns2:DependentNumber>{ data($DEPENDENT_NUMBER) }</ns2:DependentNumber>
                }
                {
                    let $DOCUMENTS := $evaluacionSolicitudTarjetaCredito/DOCUMENTS
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
                    for $ECONOMIC_ACTIVITY in $evaluacionSolicitudTarjetaCredito/ECONOMIC_ACTIVITY
                    return
                        <ns2:EconomicActivity>{ data($ECONOMIC_ACTIVITY) }</ns2:EconomicActivity>
                }
                {
                    for $EDUCATION_LEVEL in $evaluacionSolicitudTarjetaCredito/EDUCATION_LEVEL
                    return
                        <ns2:EducationLevel>{ data($EDUCATION_LEVEL) }</ns2:EducationLevel>
                }
                <ns2:Email>{ data($evaluacionSolicitudTarjetaCredito/EMAIL) }</ns2:Email>
                {
                    for $EMAIL_SPOUSE in $evaluacionSolicitudTarjetaCredito/EMAIL_SPOUSE
                    return
                        <ns2:EmailSpouse>{ data($EMAIL_SPOUSE) }</ns2:EmailSpouse>
                }
                {
                    for $LEGAL_ID_EXPIRATION_DATE_1 in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_EXPIRATION_DATE_1
                    return
                        <ns2:ExpirationDateIdentification1>{ data($LEGAL_ID_EXPIRATION_DATE_1) }</ns2:ExpirationDateIdentification1>
                }
                {
                    for $LEGAL_ID_EXPIRATION_DATE_2 in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_EXPIRATION_DATE_2
                    return
                        <ns2:ExpirationDateIdentification2>{ data($LEGAL_ID_EXPIRATION_DATE_2) }</ns2:ExpirationDateIdentification2>
                }
                {
                    for $EXTENSION in $evaluacionSolicitudTarjetaCredito/EXTENSION
                    return
                        <ns2:Extension>{ data($EXTENSION) }</ns2:Extension>
                }
                {
                    for $FAST_PLASTIC_EMISSION in $evaluacionSolicitudTarjetaCredito/FAST_PLASTIC_EMISSION
                    return
                        <ns2:FastPlasticEmission>{ data($FAST_PLASTIC_EMISSION) }</ns2:FastPlasticEmission>
                }
                <ns2:FirstName>{ data($evaluacionSolicitudTarjetaCredito/FIRST_NAME) }</ns2:FirstName>
                {
                    for $FIRST_NAME_SPOUSE in $evaluacionSolicitudTarjetaCredito/FIRST_NAME_SPOUSE
                    return
                        <ns2:FirstNameSpouse>{ data($FIRST_NAME_SPOUSE) }</ns2:FirstNameSpouse>
                }
                {
                    for $FRECUENT_TRAVELER_NUMBER in $evaluacionSolicitudTarjetaCredito/FRECUENT_TRAVELER_NUMBER
                    return
                        <ns2:FrecuentTravelerNumber>{ data($FRECUENT_TRAVELER_NUMBER) }</ns2:FrecuentTravelerNumber>
                }
                <ns2:Gender>{ data($evaluacionSolicitudTarjetaCredito/GENDER) }</ns2:Gender>
                <ns2:HomeAddressLine1>{ data($evaluacionSolicitudTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_1) }</ns2:HomeAddressLine1>
                <ns2:HomeAddressLine2>{ data($evaluacionSolicitudTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_2) }</ns2:HomeAddressLine2>
                <ns2:HomeAddressLine3>{ data($evaluacionSolicitudTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_3) }</ns2:HomeAddressLine3>
                <ns2:HomeAddressLine4>{ data($evaluacionSolicitudTarjetaCredito/HOME_ADDRESSES/HOME_ADDRESS_4) }</ns2:HomeAddressLine4>
                {
                    for $HOME_PHONE_NUMBER in $evaluacionSolicitudTarjetaCredito/HOME_PHONE_NUMBER
                    return
                        <ns2:HomePhoneNumber>{ data($HOME_PHONE_NUMBER) }</ns2:HomePhoneNumber>
                }
                <ns2:IdCreditRequest>{ data($evaluacionSolicitudTarjetaCredito/CREDIT_REQUEST_ID) }</ns2:IdCreditRequest>
                <ns2:IdSaleForceRequest>{ data($evaluacionSolicitudTarjetaCredito/REQUEST_ID) }</ns2:IdSaleForceRequest>
                <ns2:Identification1>{ data($evaluacionSolicitudTarjetaCredito/LEGAL_ID_1) }</ns2:Identification1>
                {
                    for $LEGAL_ID_2 in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_2
                    return
                        <ns2:Identification2>{ data($LEGAL_ID_2) }</ns2:Identification2>
                }
                {
                    for $LEGAL_ID_SPOUSE in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_SPOUSE
                    return
                        <ns2:IdentificationSpouse>{ data($LEGAL_ID_SPOUSE) }</ns2:IdentificationSpouse>
                }
                <ns2:IdentificationType1>{ data($evaluacionSolicitudTarjetaCredito/LEGAL_ID_TYPE_1) }</ns2:IdentificationType1>
                {
                    for $LEGAL_ID_TYPE_2 in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_TYPE_2
                    return
                        <ns2:IdentificationType2>{ data($LEGAL_ID_TYPE_2) }</ns2:IdentificationType2>
                }
                {
                    for $LEGAL_ID_TYPE_SPOUSE in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_TYPE_SPOUSE
                    return
                        <ns2:IdentificationTypeSpouse>{ data($LEGAL_ID_TYPE_SPOUSE) }</ns2:IdentificationTypeSpouse>
                }                
                {
                    for $SALARY_RANGE in $evaluacionSolicitudTarjetaCredito/SALARY_RANGE
                    return
                        <ns2:IncomeRange>{ data($SALARY_RANGE) }</ns2:IncomeRange>
                }  
                {
                    for $ISSUE_DATE_CLIENT_ID in $evaluacionSolicitudTarjetaCredito/ISSUE_DATE_CLIENT_ID
                    return
                        <ns2:IssueDateIdentification1>{ data($ISSUE_DATE_CLIENT_ID) }</ns2:IssueDateIdentification1>
                }
                {
                    for $ISSUE_DATE_CLIENT_ID2 in $evaluacionSolicitudTarjetaCredito/ISSUE_DATE_CLIENT_ID2
                    return
                        <ns2:IssueDateIdentification2>{ data($ISSUE_DATE_CLIENT_ID2) }</ns2:IssueDateIdentification2>
                }                
                {
                    for $LEGAL_ID_ISSUING_COUNTRY_1 in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_ISSUING_COUNTRY_1
                    return
                        <ns2:IssuingCountryIdentification1>{ data($LEGAL_ID_ISSUING_COUNTRY_1) }</ns2:IssuingCountryIdentification1>
                }
                {
                    for $LEGAL_ID_ISSUING_COUNTRY_2 in $evaluacionSolicitudTarjetaCredito/LEGAL_ID_ISSUING_COUNTRY_2
                    return
                        <ns2:IssuingCountryIdentification2>{ data($LEGAL_ID_ISSUING_COUNTRY_2) }</ns2:IssuingCountryIdentification2>
                }
                <ns2:JobAddressLine1>{ data($evaluacionSolicitudTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_1) }</ns2:JobAddressLine1>
                <ns2:JobAddressLine2>{ data($evaluacionSolicitudTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_2) }</ns2:JobAddressLine2>
                <ns2:JobAddressLine3>{ data($evaluacionSolicitudTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_3) }</ns2:JobAddressLine3>
                <ns2:JobAddressLine4>{ data($evaluacionSolicitudTarjetaCredito/JOB_ADDRESES/JOB_ADDRESS_4) }</ns2:JobAddressLine4>
                {
                    for $JOB_COUNTRY in $evaluacionSolicitudTarjetaCredito/JOB_COUNTRY
                    return
                        <ns2:JobCountry>{ data($JOB_COUNTRY) }</ns2:JobCountry>
                }
                <ns2:JobDepartment>{ data($evaluacionSolicitudTarjetaCredito/JOB_DEPARTMENT) }</ns2:JobDepartment>
                <ns2:JobMunicipality>{ data($evaluacionSolicitudTarjetaCredito/JOB_MUNICIPALITY) }</ns2:JobMunicipality>
                {
                    for $LAST_NAME_SPOUSE in $evaluacionSolicitudTarjetaCredito/LAST_NAME_SPOUSE
                    return
                        <ns2:LastNameSpouse>{ data($LAST_NAME_SPOUSE) }</ns2:LastNameSpouse>
                }
                {
                    for $MARRIED_SURNAME in $evaluacionSolicitudTarjetaCredito/MARRIED_SURNAME
                    return
                        <ns2:MarriedSurname>{ data($MARRIED_SURNAME) }</ns2:MarriedSurname>
                }
                <ns2:MonthlyIncome>{ data($evaluacionSolicitudTarjetaCredito/MONTHLY_INCOME) }</ns2:MonthlyIncome>
                {
                    for $MONTHS_CURRENT_ADDRESS in $evaluacionSolicitudTarjetaCredito/MONTHS_CURRENT_ADDRESS
                    return
                        <ns2:MonthsCurrentAddress>{ data($MONTHS_CURRENT_ADDRESS) }</ns2:MonthsCurrentAddress>
                }
                {
                    for $MONTHS_CURRENT_JOB in $evaluacionSolicitudTarjetaCredito/MONTHS_CURRENT_JOB
                    return
                        <ns2:MonthsCurrentJob>{ data($MONTHS_CURRENT_JOB) }</ns2:MonthsCurrentJob>
                }
                <ns2:Municipality>{ data($evaluacionSolicitudTarjetaCredito/MUNICIPALITY) }</ns2:Municipality>
                {
                    for $NACIONALITY in $evaluacionSolicitudTarjetaCredito/NACIONALITY
                    return
                        <ns2:Nacionality>{ data($NACIONALITY) }</ns2:Nacionality>
                }
                {
                    for $NATURE_BUSINESS in $evaluacionSolicitudTarjetaCredito/NATURE_BUSINESS
                    return
                        <ns2:NatureBusiness>{ data($NATURE_BUSINESS) }</ns2:NatureBusiness>
                }
                <ns2:Occupation>{ data($evaluacionSolicitudTarjetaCredito/OCCUPATION) }</ns2:Occupation>
                {
                    for $OTHER_ANNUAL_INCOME in $evaluacionSolicitudTarjetaCredito/OTHER_ANNUAL_INCOME
                    return
                        <ns2:OtherAnnualIncome>{ data($OTHER_ANNUAL_INCOME) }</ns2:OtherAnnualIncome>
                }
                {
                    for $PEP_CUSTOMER in $evaluacionSolicitudTarjetaCredito/PEP_CUSTOMER
                    return
                        <ns2:PepCustomer>{ data($PEP_CUSTOMER) }</ns2:PepCustomer>
                }
                {
                    let $PERSONAL_REFERENCES := $evaluacionSolicitudTarjetaCredito/PERSONAL_REFERENCES
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
                    for $PLACE_OF_BIRTH in $evaluacionSolicitudTarjetaCredito/PLACE_OF_BIRTH
                    return
                        <ns2:PlaceBirth>{ data($PLACE_OF_BIRTH) }</ns2:PlaceBirth>
                }
                <ns2:Position>{ data($evaluacionSolicitudTarjetaCredito/POSITION) }</ns2:Position>
                {
                    for $POSITION_DESCRIPTION in $evaluacionSolicitudTarjetaCredito/POSITION_DESCRIPTION
                    where data($POSITION_DESCRIPTION) = data($POSITION_DESCRIPTION)
                    return
                        <ns2:PositionDescription>{ data($POSITION_DESCRIPTION) }</ns2:PositionDescription>
                }
                <ns2:ProductType>{ data($evaluacionSolicitudTarjetaCredito/PRODUCT_TYPE) }</ns2:ProductType>
                {
                    for $REQUIRES_ADDITIONAL_CARD in $evaluacionSolicitudTarjetaCredito/REQUIRES_ADDITIONAL_CARD
                    return
                        <ns2:RequiresAdditionalCard>{ data($REQUIRES_ADDITIONAL_CARD) }</ns2:RequiresAdditionalCard>
                }
                {
                    for $REQUIRE_SCARD_SPOUSE in $evaluacionSolicitudTarjetaCredito/REQUIRE_SCARD_SPOUSE
                    return
                        <ns2:RequiresCardSpouse>{ data($REQUIRE_SCARD_SPOUSE) }</ns2:RequiresCardSpouse>
                }
                {
                    for $SECOND_NAME in $evaluacionSolicitudTarjetaCredito/SECOND_NAME
                    return
                        <ns2:SecondName>{ data($SECOND_NAME) }</ns2:SecondName>
                }
                {
                    for $SECOND_NAME_SPOUSE in $evaluacionSolicitudTarjetaCredito/SECOND_NAME_SPOUSE
                    return
                        <ns2:SecondNameSpouse>{ data($SECOND_NAME_SPOUSE) }</ns2:SecondNameSpouse>
                }
                {
                    for $SECOND_SURNAME in $evaluacionSolicitudTarjetaCredito/SECOND_SURNAME
                    return
                        <ns2:SecondSurname>{ data($SECOND_SURNAME) }</ns2:SecondSurname>
                }
                {
                    for $SECOND_SURNAME_SPOUSE in $evaluacionSolicitudTarjetaCredito/SECOND_SURNAME_SPOUSE
                    return
                        <ns2:SecondSurnameSpouse>{ data($SECOND_SURNAME_SPOUSE) }</ns2:SecondSurnameSpouse>
                }
                {
                    for $SECONDARY_EMAIL in $evaluacionSolicitudTarjetaCredito/SECONDARY_EMAIL
                    return
                        <ns2:SecondaryEmail>{ data($SECONDARY_EMAIL) }</ns2:SecondaryEmail>
                }
                <ns2:SellerCode>{ data($evaluacionSolicitudTarjetaCredito/SELLER_CODE) }</ns2:SellerCode>
                {
                    for $SHIPPING_STATE_ACCOUNT in $evaluacionSolicitudTarjetaCredito/SHIPPING_STATE_ACCOUNT
                    return
                        <ns2:ShippingStateAccount>{ data($SHIPPING_STATE_ACCOUNT) }</ns2:ShippingStateAccount>
                }
                {
                    for $SOURCE_OTHER_INCOME in $evaluacionSolicitudTarjetaCredito/SOURCE_OTHER_INCOME
                    return
                        <ns2:SourceOtherIncome>{ data($SOURCE_OTHER_INCOME) }</ns2:SourceOtherIncome>
                }
                {
                    for $SPOUSE_NAME in $evaluacionSolicitudTarjetaCredito/SPOUSE_NAME
                    return
                        <ns2:SpouseName>{ data($SPOUSE_NAME) }</ns2:SpouseName>
                }                
                {
                    for $SPOUSE_PHONE in $evaluacionSolicitudTarjetaCredito/SPOUSE_PHONE
                    return
                        <ns2:SpousePhone>{ data($SPOUSE_PHONE) }</ns2:SpousePhone>
                }                                                
                <ns2:SupervisorCode>{ data($evaluacionSolicitudTarjetaCredito/SUPERVISOR_CODE) }</ns2:SupervisorCode>
                <ns2:Surname>{ data($evaluacionSolicitudTarjetaCredito/SURNAME) }</ns2:Surname>
                {
                    for $THIRD_NAME in $evaluacionSolicitudTarjetaCredito/THIRD_NAME
                    return
                        <ns2:ThirdName>{ data($THIRD_NAME) }</ns2:ThirdName>
                }
                {
                    for $TYPE_RESIDENCE in $evaluacionSolicitudTarjetaCredito/TYPE_RESIDENCE
                    return
                        <ns2:TypeResidence>{ data($TYPE_RESIDENCE) }</ns2:TypeResidence>
                }
                {
                    for $UNIQUE_NUMBER in $evaluacionSolicitudTarjetaCredito/UNIQUE_NUMBER
                    return
                        <ns2:UniqueNumber>{ data($UNIQUE_NUMBER) }</ns2:UniqueNumber>
                }
                {
                    for $VIP_CUSTOMER in $evaluacionSolicitudTarjetaCredito/VIP_CUSTOMER
                    return
                        <ns2:VIPCustomer>{ data($VIP_CUSTOMER) }</ns2:VIPCustomer>
                }
                {
                    for $WORK_PHONE_EXTENSION in $evaluacionSolicitudTarjetaCredito/WORK_PHONE_EXTENSION
                    return
                        <ns2:WorkPhoneExtension>{ data($WORK_PHONE_EXTENSION) }</ns2:WorkPhoneExtension>
                }                                                
                <ns2:Workplace>{ data($evaluacionSolicitudTarjetaCredito/WORKPLACE) }</ns2:Workplace>
                {
                    for $YEARS_CURRENT_ADDRESS in $evaluacionSolicitudTarjetaCredito/YEARS_CURRENT_ADDRESS
                    return
                        <ns2:YearsCurrentAddress>{ data($YEARS_CURRENT_ADDRESS) }</ns2:YearsCurrentAddress>
                }
                {
                    for $YEARS_CURRENT_JOB in $evaluacionSolicitudTarjetaCredito/YEARS_CURRENT_JOB
                    return
                        <ns2:YearsCurrentJob>{ data($YEARS_CURRENT_JOB) }</ns2:YearsCurrentJob>
                }
            </ns1:creditCardApplication>
        </ns1:CreditCardApplicationReception>
};

declare variable $evaluacionSolicitudTarjetaCredito as element(ns0:evaluacionSolicitudTarjetaCredito) external;
declare variable $login as xs:string external;
declare variable $token as xs:string external;
declare variable $serviceId as xs:string external;
declare variable $idCompany as xs:long external;

xf:creditCardApplicationReceptionIn($evaluacionSolicitudTarjetaCredito,
    $login,
    $token,
    $serviceId,
    $idCompany)