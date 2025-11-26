(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalH2HRequest" element="ns0:transferenciaInternacionalH2HRequest" location="../xsd/transferenciaInternacionalH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjTransferenciaInternacionalRequest" location="../../../BusinessServices/SJS/TransferenciaInternacionalH2H/xsd/sjTransferenciaInternacionalH2H.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/sjTransferenciaInternacionalIN";

declare function xf:transferenciaInternacionalH2HIN($transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest),
$userName as xs:string,
$password as xs:string,
$sourceBank as xs:string)
    as element(ns1:sjTransferenciaInternacionalRequest) {
    	<ns1:sjTransferenciaInternacionalRequest>
		<CUSTOMER_ID>{ data($transferenciaInternacionalH2HRequest/CUSTOMER_ID) }</CUSTOMER_ID>
		<USER_NAME>{ data($userName) }</USER_NAME>
		<PASSWORD>{ data($password) }</PASSWORD>
		<SOURCE_BANK>{ data($sourceBank) }</SOURCE_BANK>
		{
		<TRANSFERS_INT>
			{
			for $transferInt in $transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT
			return
			<TRANSFER_INT>
			    <TRACE>{ data($transferInt/TRACE) }</TRACE>
				<DEBIT_ACCOUNT>{ data($transferInt/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
				<DEBIT_CURRENCY>{ data($transferInt/DEBIT_CURRENCY) }</DEBIT_CURRENCY>
				<TRANSFER_AMOUNT>{ data($transferInt/TRANSFER_AMOUNT) }</TRANSFER_AMOUNT>
				<DESTINATION_COUNTRY>{ data($transferInt/DESTINATION_COUNTRY) }</DESTINATION_COUNTRY>
				<DESTINATION_CURRENCY>{ data($transferInt/DESTINATION_CURRENCY) }</DESTINATION_CURRENCY>
				<INTERMEDIARY_BANK_CODE>{ data($transferInt/INTERMEDIARY_BANK_CODE) }</INTERMEDIARY_BANK_CODE>
				<INTERMEDIARY_BANK_CODE_TYPE>{ data($transferInt/INTERMEDIARY_BANK_CODE_TYPE) }</INTERMEDIARY_BANK_CODE_TYPE>
				<INTERMEDIARY_BANK_INSTRUCTIONS>{ data($transferInt/INTERMEDIARY_BANK_INSTRUCTIONS) }</INTERMEDIARY_BANK_INSTRUCTIONS>
				<BENEF_BANK_CODE>{ data($transferInt/BENEF_BANK_CODE) }</BENEF_BANK_CODE>
				<BENEF_BANK_CODE_TYPE>{ data($transferInt/BENEF_BANK_CODE_TYPE) }</BENEF_BANK_CODE_TYPE>
				<BENEF_BANK_INT_ACCOUNT>{ data($transferInt/BENEF_BANK_INT_ACCOUNT) }</BENEF_BANK_INT_ACCOUNT>
				<BENEF_BANK_NAME>{ data($transferInt/BENEF_BANK_NAME) }</BENEF_BANK_NAME>
				<BENEF_BANK_ADDRESS>{ data($transferInt/BENEF_BANK_ADDRESS) }</BENEF_BANK_ADDRESS>
				<BENEF_BANK_CITY>{ data($transferInt/BENEF_BANK_CITY) }</BENEF_BANK_CITY>
				<BENEF_BANK_STATE>{ data($transferInt/BENEF_BANK_STATE) }</BENEF_BANK_STATE>
				<BENEF_BANK_POSTAL_CODE>{ data($transferInt/BENEF_BANK_POSTAL_CODE) }</BENEF_BANK_POSTAL_CODE>
				<BENEF_BANK_COUNTRY>{ data($transferInt/BENEF_BANK_COUNTRY) }</BENEF_BANK_COUNTRY>
				<BENEFICIARY_NAME>{ data($transferInt/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
				<BENEFICIARY_ACCOUNT>{ data($transferInt/BENEFICIARY_ACCOUNT) }</BENEFICIARY_ACCOUNT>
				<BENEFICIARY_ADDRESS>{ data($transferInt/BENEFICIARY_ADDRESS) }</BENEFICIARY_ADDRESS>
				<BENEFICIARY_CITY>{ data($transferInt/BENEFICIARY_CITY) }</BENEFICIARY_CITY>
				<BENEFICIARY_STATE>{ data($transferInt/BENEFICIARY_STATE) }</BENEFICIARY_STATE>
				<BENEFICIARY_POSTAL_CODE>{ data($transferInt/BENEFICIARY_POSTAL_CODE) }</BENEFICIARY_POSTAL_CODE>
				<BENEFICIARY_COUNTRY>{ data($transferInt/BENEFICIARY_COUNTRY) }</BENEFICIARY_COUNTRY>
				<BENEFICIARY_INFO>{ data($transferInt/BENEFICIARY_INFO) }</BENEFICIARY_INFO>
				<INTERFACE_REFERENCE_NO>{ data($transferInt/INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
				<DESCRIPTION>{ data($transferInt/DESCRIPTION) }</DESCRIPTION>
			</TRANSFER_INT>
			}
		</TRANSFERS_INT>
		}
	</ns1:sjTransferenciaInternacionalRequest>
};

declare variable $transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $sourceBank as xs:string external;

xf:transferenciaInternacionalH2HIN($transferenciaInternacionalH2HRequest, $userName, $password, $sourceBank)