xquery version "1.0" encoding "UTF-8";
(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalH2HRequest" element="ns0:transferenciaInternacionalH2HRequest" location="../xsd/transferenciaInternacionalH2HICBTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2HICB/xq/transferenciaInternacionalH2HICBIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HICBType";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.transfersh2h";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns6 = "urn:infocorp.framework.common";
declare namespace ns7 = "urn:infocorp.framework.businessentities.taskprocessing";
declare namespace ns8 = "urn:infocorp.framework.businessentities.thirdpartyproducts";
declare namespace ns9 = "urn:tailored.icbanking.businessentities.framework.thirdpartyproducts";

declare function xf:transferenciaInternacionalH2HICBIn($transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest),
    $string as xs:string,
    $amount as xs:string,
    $amounttocredit as xs:string,
    $exchangerate as xs:string,
    $currency as xs:string)
    as element(*) {
        <ns3:ProcessExternalTransferMessageIn>
    		<ns3:AuthorizationRequired>{ 
    			let $autorizacion := data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/AUTHORIZATION)
             	return
    			if ($autorizacion = 'NO') then (
    				"false"
    			)else if ($autorizacion = 'YES') then(
    				"true"
    			)
    			else ("false")    			
    		 
    		}</ns3:AuthorizationRequired>
    		<ns3:Batch>
    			<ns7:Description>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/DESCRIPTION) }</ns7:Description>
    			<ns7:Tasks>
    				<ns7:Task>
    					<ns7:TaskFinancialData>
    						<ns7:Amount>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/TRANSFER_AMOUNT) }</ns7:Amount>
    						<ns7:AmountToCredit>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/TRANSFER_AMOUNT) }</ns7:AmountToCredit>
    						<ns7:AmountToDebit>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/AMOUNT_DEBIT) }</ns7:AmountToDebit>
    						<ns7:Currency>
    							<ns4:CurrencyId>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/DEBIT_CURRENCY)}</ns4:CurrencyId>
    						</ns7:Currency>
    						<ns7:DebitProduct>
    							<ns4:ProductNumber>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/DEBIT_ACCOUNT)}</ns4:ProductNumber>
    						</ns7:DebitProduct>
    						<ns7:ExchangeRateTransaction>{data ($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/EXCHANGERATE)}</ns7:ExchangeRateTransaction>
    						<ns7:NotifyTo></ns7:NotifyTo>
    						<ns7:ThirdPartyCreditProduct>
    							<ns8:Alias></ns8:Alias>
    							<ns8:Bank>
    								<ns4:Description>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_NAME)}</ns4:Description>
    								<ns4:HeadquartersAddress>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_ADDRESS)}</ns4:HeadquartersAddress>
    								<ns4:RoutingNumber>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_CODE)}</ns4:RoutingNumber>
    							</ns8:Bank>
    							<ns8:Currency>
	    							<ns4:CurrencyId>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/DEBIT_CURRENCY)}</ns4:CurrencyId>
    							</ns8:Currency>					    		
    							<ns8:OwnerAddress>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_ADDRESS)}</ns8:OwnerAddress>
    							<ns8:OwnerCity>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_CITY)}</ns8:OwnerCity>
    							<ns8:OwnerName>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_NAME)}</ns8:OwnerName>
    							<ns8:ThirdPartyProductNumber>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_ACCOUNT)}</ns8:ThirdPartyProductNumber>    							    							
    						</ns7:ThirdPartyCreditProduct>    						
    					</ns7:TaskFinancialData>
    				</ns7:Task>
    			</ns7:Tasks>
    		</ns3:Batch>
    		<ns3:BeneficiaryDetail></ns3:BeneficiaryDetail>
    		<ns3:BeneficiaryInformation>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_INFO)}</ns3:BeneficiaryInformation>
    		<ns3:BeneficiaryNoneSelection>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_CODE_TYPE)}</ns3:BeneficiaryNoneSelection>
    		<ns3:CountryCode_Beneficiary>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_COUNTRY)}</ns3:CountryCode_Beneficiary>
    		<ns3:CountryCode_CorrespondentBankCountry>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_COUNTRY)}</ns3:CountryCode_CorrespondentBankCountry>
    		<ns3:CountryCode_ThirdPartyCreditProduct>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/DESTINATION_COUNTRY)}</ns3:CountryCode_ThirdPartyCreditProduct>
    		<ns3:CustomerId>{data($transferenciaInternacionalH2HRequest/CUSTOMER_ID)}</ns3:CustomerId>
    		<ns3:IntermediarySwiftSelection>
    		{ 
    			let $swiftSelection := data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/DESTINATION_COUNTRY)
             	return
    			if ($swiftSelection = 'US') then (
    			data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_CODE_TYPE)
    				
    			)
    			else data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/INTERMEDIARY_BANK_CODE_TYPE)    			
    		 
    		}

    		</ns3:IntermediarySwiftSelection>
    		<ns3:ProcessDate>{data ($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/PROCESSDATE)}</ns3:ProcessDate>
    		<ns3:ReferenceCode>{data ($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/REFERENCECODE)}</ns3:ReferenceCode>
    		<ns3:SecondNotifyTo></ns3:SecondNotifyTo>
    		<ns3:ThirdNotifyTo></ns3:ThirdNotifyTo>
    		<ns3:ThirdPartyProductAdditionalInfoExtended>
    			<ns8:CorrespondentBankDescription>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_NAME)})</ns8:CorrespondentBankDescription>
    			<ns8:CorrespondentBankRoutingNumber>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/INTERMEDIARY_BANK_CODE)}</ns8:CorrespondentBankRoutingNumber>
    			<ns9:OwnerState>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_STATE)}</ns9:OwnerState>
    			<ns9:OwnerZip>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEFICIARY_POSTAL_CODE)}</ns9:OwnerZip>
    			<ns9:BankState>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_STATE)}</ns9:BankState>
    			<ns9:BankCity>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_CITY)}</ns9:BankCity>
    			<ns9:BankZip>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_POSTAL_CODE)}</ns9:BankZip>
    			<ns9:CorrespondentBankAccount/>
    			<ns9:BeneficiaryIntermediaryBankAccount>{data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT/BENEF_BANK_INT_ACCOUNT)}</ns9:BeneficiaryIntermediaryBankAccount>
    		</ns3:ThirdPartyProductAdditionalInfoExtended>
        </ns3:ProcessExternalTransferMessageIn>
};

declare variable $transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest) external;
declare variable $string as xs:string external;
declare variable $amount as xs:string external;
declare variable $amounttocredit as xs:string external;
declare variable $exchangerate as xs:string external;
declare variable $currency as xs:string external;
xf:transferenciaInternacionalH2HICBIn($transferenciaInternacionalH2HRequest,
    $string,
    $amount ,
    $amounttocredit,
    $exchangerate,
    $currency)