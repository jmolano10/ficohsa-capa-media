(:: pragma bea:global-element-parameter parameter="$reprocesoACHEnviadasCR" element="ns1:reprocesoACHEnviadasCR" location="../xsd/reprocesoACHEnviadasCRTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SendCreditUSD" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHEnviadasCRTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/sendCreditUSDIn/";

declare function xf:sendCreditUSDIn($reprocesoACHEnviadasCR as element(ns1:reprocesoACHEnviadasCR))
    as element(ns0:SendCreditUSD) {
        <ns0:SendCreditUSD>
            <ns0:vReceivingBankId>{ data($reprocesoACHEnviadasCR/DESTINATION_BANK) }</ns0:vReceivingBankId>
            {
                for $TXN_DETAIL in $reprocesoACHEnviadasCR/TXN_DETAIL
                return
                    <ns0:vRemittanceArray>{ data($TXN_DETAIL) }</ns0:vRemittanceArray>
            }
            {
                for $T24_CONTROL_REF in $reprocesoACHEnviadasCR/T24_CONTROL_REF
                return
                    <ns0:vInstruction>{ data($T24_CONTROL_REF) }</ns0:vInstruction>
            }
            {
                for $ORD_IDENTIFICATION in $reprocesoACHEnviadasCR/ORD_IDENTIFICATION
                return
                    <ns0:vOriginatorId>
                    	{ 
                    		if(data($ORD_IDENTIFICATION) = 'Ahorros') then(
                    			'1'
                    		)else if(data($ORD_IDENTIFICATION) = 'Cheques') then(
                    			'2'
                    		)else(
                    			'0'
                    		)
                    	}
                    </ns0:vOriginatorId>
            }
            {
                for $ORD_ACCOUNT in $reprocesoACHEnviadasCR/ORD_ACCOUNT
                return
                    <ns0:vOriginatorAccount>{ data($ORD_ACCOUNT) }</ns0:vOriginatorAccount>
            }
            <ns0:vOriginatorAccountType>{ data($reprocesoACHEnviadasCR/ORD_ACCOUNT_TYPE) }</ns0:vOriginatorAccountType>
            {
                for $ORD_NAME in $reprocesoACHEnviadasCR/ORD_NAME
                return
                    <ns0:vOriginatorName>{ data($ORD_NAME) }</ns0:vOriginatorName>
            }
            {
                for $BEN_IDENTIFICATION in $reprocesoACHEnviadasCR/BEN_IDENTIFICATION
                return
                    <ns0:vReceivingId>{ data($BEN_IDENTIFICATION) }</ns0:vReceivingId>
            }
            {
                for $BEN_ACCOUNT in $reprocesoACHEnviadasCR/BEN_ACCOUNT
                return
                    <ns0:vDestinationAccount>{ data($BEN_ACCOUNT) }</ns0:vDestinationAccount>
            }
            <ns0:vDestinationAccountType>
            	{ 
            		if(data($reprocesoACHEnviadasCR/ACCOUNT_TYPE) = 'Savings') then(
            			2
            		)else if(data($reprocesoACHEnviadasCR/ACCOUNT_TYPE) = 'Checking') then(
            			1
            		)else if(data($reprocesoACHEnviadasCR/ACCOUNT_TYPE) = 'Loan') then(
            			3
            		)else if(data($reprocesoACHEnviadasCR/ACCOUNT_TYPE) = 'Creditca') then(
            			4
            		)else(
            			99
            		)
            	}
            </ns0:vDestinationAccountType>
            {
                for $BEN_NAME in $reprocesoACHEnviadasCR/BEN_NAME
                return
                    <ns0:vRecipientName>{ data($BEN_NAME) }</ns0:vRecipientName>
            }
            {
                for $BEN_AMOUNT in $reprocesoACHEnviadasCR/BEN_AMOUNT
                return
                    <ns0:vAmount>{ data($BEN_AMOUNT) }</ns0:vAmount>
            }
        </ns0:SendCreditUSD>
};

declare variable $reprocesoACHEnviadasCR as element(ns1:reprocesoACHEnviadasCR) external;

xf:sendCreditUSDIn($reprocesoACHEnviadasCR)
