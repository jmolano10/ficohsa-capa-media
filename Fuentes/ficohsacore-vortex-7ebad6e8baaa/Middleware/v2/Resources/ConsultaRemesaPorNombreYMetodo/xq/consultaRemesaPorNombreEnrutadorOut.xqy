xquery version "2004-draft";
(:: pragma  parameter="$parametersOut" type="anyType" ::)
(:: pragma bea:global-element-return element="ns1:consultaRemesaPorNombreYMetodoResponse" location="../xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreEnrutadorOut/";

declare function xf:consultaRemesaPorNombreEnrutadorOut($parametersOut as element(*),
    $remittanceIdentifier as xs:string)
    as element(ns1:consultaRemesaPorNombreYMetodoResponse) {
        <ns1:consultaRemesaPorNombreYMetodoResponse>
            <ns1:consultaRemesaPorNombreYMetodoResponseType>
                {
                if ($remittanceIdentifier = "MONEYGRAM") then (
                
                let $REMITTANCE_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="multi.referenceInfo.referenceNumber"]/text()), "\|")
                let $REMITTER_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="multi.remittanceContractId"]/text()), "\|")
                let $BENEFICIARY_FIRSTNAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="multi.referenceInfo.receiverFirstName"]/text()), "\|")
                let $BENEFICIARY_LASTNAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="multi.referenceInfo.receiverLastName"]/text()), "\|")
                let $REMITTER_LASTNAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="multi.referenceInfo.senderLastName"]/text()), "\|")
                let $EXCHANGE_RATE := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="multi.exchangeRate"]/text()), "\|")
                let $REMITTANCE_STATUS := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="multi.referenceInfo.transactionStatus"]/text()), "\|")
                for $i in (1 to count($REMITTER_ID))
                	return
	                <ns1:consultaRemesaPorNombreYMetodoResponseRecordType>
	                    <REMITTANCE_ID>{ $REMITTANCE_ID[$i] }</REMITTANCE_ID>
	                    <REMITTER_ID>{ $REMITTER_ID[$i] }</REMITTER_ID>
	                    <REMITTER_NAME>{ $REMITTER_LASTNAME[$i] }</REMITTER_NAME>
	                    <BENEFICIARY_NAME>
	                    { 
	                    	concat($BENEFICIARY_FIRSTNAME[$i], " ", $BENEFICIARY_LASTNAME[$i]) 
	                    }
	                    </BENEFICIARY_NAME>
	                    <BRANCH_NAME></BRANCH_NAME>
	                    <PAYMENT_DATE></PAYMENT_DATE>
	                    <CURRENCY></CURRENCY>
	                    <EXCHANGE_RATE>{ $EXCHANGE_RATE[$i] }</EXCHANGE_RATE>
		               	<REMITTANCE_STATUS>{ $REMITTANCE_STATUS[$i] }</REMITTANCE_STATUS>
	                    <REMITTANCE_AMOUNT></REMITTANCE_AMOUNT>
	                </ns1:consultaRemesaPorNombreYMetodoResponseRecordType>
	                
                ) else if ($remittanceIdentifier = "PACIFIC") then (

                let $REMITTANCE_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="remittanceNumber"]/text()), "\|")
                let $REMITTER_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="remittanceContractId"]/text()), "\|")
                let $REMITTER_NAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="senderName"]/text()), "\|")
                let $BENEFICIARY_NAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="beneficiaryName"]/text()), "\|")
                let $EXCHANGE_RATE := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="originExchangeRate"]/text()), "\|")
                let $REMITTANCE_STATUS := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="remittanceStatus"]/text()), "\|")
				let $REMITTANCE_AMOUNT := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="destinationAmount"]/text()), "\|")
                for $i in (1 to count($REMITTER_ID))
                	return
	                <ns1:consultaRemesaPorNombreYMetodoResponseRecordType>
	                    <REMITTANCE_ID>{ $REMITTANCE_ID[$i] }</REMITTANCE_ID>
	                    <REMITTER_ID>{ $REMITTER_ID[$i] }</REMITTER_ID>
	                    <REMITTER_NAME>{ $REMITTER_NAME[$i] }</REMITTER_NAME>
	                    <BENEFICIARY_NAME>{ $BENEFICIARY_NAME[$i] }</BENEFICIARY_NAME>
	                    <BRANCH_NAME></BRANCH_NAME>
	                    <PAYMENT_DATE></PAYMENT_DATE>
	                    <CURRENCY>HNL</CURRENCY>
	                    <EXCHANGE_RATE>{ $EXCHANGE_RATE[$i] }</EXCHANGE_RATE>
			            <REMITTANCE_STATUS>{ $REMITTANCE_STATUS[$i] }</REMITTANCE_STATUS>
	                	<REMITTANCE_AMOUNT>{ $REMITTANCE_AMOUNT[$i] }</REMITTANCE_AMOUNT>
	                </ns1:consultaRemesaPorNombreYMetodoResponseRecordType>
	                
                ) else if ($remittanceIdentifier = "MOREMONEY") then (

                let $REMITTANCE_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="RemittanceNumber"]/text()), "\|")
                let $REMITTER_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="ContractID"]/text()), "\|")
                let $REMITTER_NAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="SenderName"]/text()), "\|")
                let $BENEFICIARY_NAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="BeneficiaryName"]/text()), "\|")
                let $EXCHANGE_RATE := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="ExchangeRate"]/text()), "\|")
                let $REMITTANCE_STATUS := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="Status"]/text()), "\|")
				let $REMITTANCE_AMOUNT := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="OriginAmount"]/text()), "\|")
				let $REMITTANCE_CURRENCY := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="Currency"]/text()), "\|")
                for $i in (1 to count($REMITTER_ID))
                	return
	                <ns1:consultaRemesaPorNombreYMetodoResponseRecordType>
	                    <REMITTANCE_ID>{ $REMITTANCE_ID[$i] }</REMITTANCE_ID>
	                    <REMITTER_ID>{ $REMITTER_ID[$i] }</REMITTER_ID>
	                    <REMITTER_NAME>{ $REMITTER_NAME[$i] }</REMITTER_NAME>
	                    <BENEFICIARY_NAME>{ $BENEFICIARY_NAME[$i] }</BENEFICIARY_NAME>
	                    <BRANCH_NAME></BRANCH_NAME>
	                    <PAYMENT_DATE></PAYMENT_DATE>
	                    <CURRENCY>{ $REMITTANCE_CURRENCY[$i]}</CURRENCY>
	                    <EXCHANGE_RATE>{ $EXCHANGE_RATE[$i] }</EXCHANGE_RATE>
			            <REMITTANCE_STATUS>{ $REMITTANCE_STATUS[$i] }</REMITTANCE_STATUS>
	                	<REMITTANCE_AMOUNT>{ $REMITTANCE_AMOUNT[$i] }</REMITTANCE_AMOUNT>
	                </ns1:consultaRemesaPorNombreYMetodoResponseRecordType>                
                
                ) else if ($remittanceIdentifier = "INTERMEX") then (
                 
                let $REMITTANCE_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="CodeW"]/text()), "\|")
                let $REMITTER_ID := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="agreementContractID"]/text()), "\|")
                let $REMITTER_NAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="SenderName"]/text()), "\|")
                let $REMITTER_LASTNAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="SenderLastName"]/text()), "\|")
                let $BENEFICIARY_NAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="ReceiverName"]/text()), "\|")
                let $BENEFICIARY_LASTNAME := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="ReceiverLastName"]/text()), "\|")
                let $EXCHANGE_RATE := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="ExchangeRate"]/text()), "\|")
                let $REMITTANCE_STATUS := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="MessageW"]/text()), "\|")
				let $REMITTANCE_AMOUNT := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="AmmountToPay"]/text()), "\|")
				let $REMITTANCE_CURRENCY := fn:tokenize(data($parametersOut/moreParameters/data[@fieldName="DestinationCurrency"]/text()), "\|")
                for $i in (1 to count($REMITTER_ID))
                	return
	                <ns1:consultaRemesaPorNombreYMetodoResponseRecordType>
	                    <REMITTANCE_ID>{ $REMITTANCE_ID[$i] }</REMITTANCE_ID>
	                    <REMITTER_ID>{ $REMITTER_ID[$i] }</REMITTER_ID>
	                    <REMITTER_NAME>
	                    { 
	                    	concat($REMITTER_NAME[$i], " ", $REMITTER_LASTNAME[$i])
	                    }
	                    </REMITTER_NAME>
	                    <BENEFICIARY_NAME>
	                    { 
	                    	concat($BENEFICIARY_NAME[$i], " ", $BENEFICIARY_LASTNAME[$i]) 
	                    }
	                    </BENEFICIARY_NAME>
	                    <BRANCH_NAME></BRANCH_NAME>
	                    <PAYMENT_DATE></PAYMENT_DATE>
	                    <CURRENCY>{ $REMITTANCE_CURRENCY[$i]}</CURRENCY>
	                    <EXCHANGE_RATE>{ $EXCHANGE_RATE[$i] }</EXCHANGE_RATE>
			            <REMITTANCE_STATUS>{ $REMITTANCE_STATUS[$i] }</REMITTANCE_STATUS>
	                	<REMITTANCE_AMOUNT>{ $REMITTANCE_AMOUNT[$i] }</REMITTANCE_AMOUNT>
	                </ns1:consultaRemesaPorNombreYMetodoResponseRecordType>
	                  
                )else ()
                
                }
            </ns1:consultaRemesaPorNombreYMetodoResponseType>
        </ns1:consultaRemesaPorNombreYMetodoResponse>
};

declare variable $parametersOut as element(*) external;
declare variable $remittanceIdentifier as xs:string external;

xf:consultaRemesaPorNombreEnrutadorOut($parametersOut,
    $remittanceIdentifier)