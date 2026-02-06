xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalRequest1" element="ns0:transferenciaInternacionalRequest" location="../../../../Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/transferenciaInternacional/xsd/TransferenciaInternacional_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransferenciaInternacional";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/transferenciaInternacional/xq/transferenciaInternacionalIn/";

declare function xf:transferenciaInternacionalIn($transferenciaInternacionalRequest1 as element(ns0:transferenciaInternacionalRequest),
    $usuarioInternacionalRequest1 as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:DEBIT_ACCOUNT>{ data($transferenciaInternacionalRequest1/DEBIT_ACCOUNT) }</ns1:DEBIT_ACCOUNT>
            <ns1:DEBIT_CURRENCY>{ data($transferenciaInternacionalRequest1/DEBIT_CURRENCY) }</ns1:DEBIT_CURRENCY>
            <ns1:TRANSFER_AMOUNT>{ data($transferenciaInternacionalRequest1/TRANSFER_AMOUNT) }</ns1:TRANSFER_AMOUNT>
            <ns1:DESTINATION_COUNTRY>{ data($transferenciaInternacionalRequest1/DESTINATION_COUNTRY) }</ns1:DESTINATION_COUNTRY>
            <ns1:INTERMEDIARY_BANK_CODE>{ data($transferenciaInternacionalRequest1/INTERMEDIARY_BANK_CODE) }</ns1:INTERMEDIARY_BANK_CODE>
            <ns1:INTERMEDIARY_BANK_CODE_TYPE>{ data($transferenciaInternacionalRequest1/INTERMEDIARY_BANK_CODE_TYPE) }</ns1:INTERMEDIARY_BANK_CODE_TYPE>
            <ns1:INTERMEDIARY_BANK_INSTRUCTIONS>{ data($transferenciaInternacionalRequest1/INTERMEDIARY_BANK_INSTRUCTIONS) }</ns1:INTERMEDIARY_BANK_INSTRUCTIONS>
            <ns1:BENEF_BANK_CODE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_CODE) }</ns1:BENEF_BANK_CODE>
            <ns1:BENEF_BANK_CODE_TYPE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_CODE_TYPE) }</ns1:BENEF_BANK_CODE_TYPE>
            <ns1:BENEF_BANK_INT_ACCOUNT>{ data($transferenciaInternacionalRequest1/BENEF_BANK_INT_ACCOUNT) }</ns1:BENEF_BANK_INT_ACCOUNT>
            <ns1:BENEF_BANK_NAME>{ data($transferenciaInternacionalRequest1/BENEF_BANK_NAME) }</ns1:BENEF_BANK_NAME>
            <ns1:BENEF_BANK_ADDRESS>{ data($transferenciaInternacionalRequest1/BENEF_BANK_ADDRESS) }</ns1:BENEF_BANK_ADDRESS>
            <ns1:BENEF_BANK_CITY>{ data($transferenciaInternacionalRequest1/BENEF_BANK_CITY) }</ns1:BENEF_BANK_CITY>
            <ns1:BENEF_BANK_STATE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_STATE) }</ns1:BENEF_BANK_STATE>
            <ns1:BENEF_BANK_POSTAL_CODE>{ data($transferenciaInternacionalRequest1/BENEF_BANK_POSTAL_CODE) }</ns1:BENEF_BANK_POSTAL_CODE>
            <ns1:BENEF_BANK_COUNTRY>{ data($transferenciaInternacionalRequest1/BENEF_BANK_COUNTRY) }</ns1:BENEF_BANK_COUNTRY>
            <ns1:BENEFICIARY_NAME>{ data($transferenciaInternacionalRequest1/BENEFICIARY_NAME) }</ns1:BENEFICIARY_NAME>
            <ns1:BENEFICIARY_ACCOUNT>{ data($transferenciaInternacionalRequest1/BENEFICIARY_ACCOUNT) }</ns1:BENEFICIARY_ACCOUNT>
            <ns1:BENEFICIARY_ADDRESS>{ data($transferenciaInternacionalRequest1/BENEFICIARY_ADDRESS) }</ns1:BENEFICIARY_ADDRESS>
            <ns1:BENEFICIARY_CITY>{ data($transferenciaInternacionalRequest1/BENEFICIARY_CITY) }</ns1:BENEFICIARY_CITY>
            <ns1:BENEFICIARY_STATE>{ data($transferenciaInternacionalRequest1/BENEFICIARY_STATE) }</ns1:BENEFICIARY_STATE>
            <ns1:BENEFICIARY_POSTAL_CODE>{ data($transferenciaInternacionalRequest1/BENEFICIARY_POSTAL_CODE) }</ns1:BENEFICIARY_POSTAL_CODE>
            <ns1:BENEFICIARY_INFO>{ data($transferenciaInternacionalRequest1/DESCRIPTION) }</ns1:BENEFICIARY_INFO>
            <ns1:BENEFICIARY_COUNTRY>{ data($transferenciaInternacionalRequest1/BENEFICIARY_COUNTRY) }</ns1:BENEFICIARY_COUNTRY>
            <ns1:INTERFACE_REFERENCE_NO>{ data($transferenciaInternacionalRequest1/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:USERNAME>{ $usuarioInternacionalRequest1 }</ns1:USERNAME>

            <ns0:CHANNEL>{ 
    			let $channel:= data($transferenciaInternacionalRequest1/CHANNEL)
             	return
    			if ($channel != '') then (
    			data($transferenciaInternacionalRequest1/CHANNEL)
    				
    			)
                        else
    			"BBE"    			
    		 
    		}</ns0:CHANNEL>


        </ns1:InputParameters>
};

declare variable $transferenciaInternacionalRequest1 as element(ns0:transferenciaInternacionalRequest) external;
declare variable $usuarioInternacionalRequest1 as xs:string external;

xf:transferenciaInternacionalIn($transferenciaInternacionalRequest1,
    $usuarioInternacionalRequest1)