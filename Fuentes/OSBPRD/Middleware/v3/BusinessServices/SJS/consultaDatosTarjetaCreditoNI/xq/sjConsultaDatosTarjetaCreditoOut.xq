(:: pragma bea:global-element-parameter parameter="$sjconsultaDatosTarjetaCredito" element="ns0:sjconsultaDatosTarjetaCredito" location="../../consultaDatosTarjetaCredito/xsd/sjconsultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjconsultaDatosTarjetaCreditoResponse" location="../../consultaDatosTarjetaCredito/xsd/sjconsultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/SJS/consultaDatosTarjetaCreditoNI/xq/sjConsultaDatosTarjetaCreditoOut/";
declare namespace ns1 = "http://www.procesa.com/fdcs";

declare function xf:sjConsultaDatosTarjetaCreditoOut($sjconsultaDatosTarjetaCredito as element(ns0:sjconsultaDatosTarjetaCredito),
    $resultGroup as element(*))
    as element(ns0:sjconsultaDatosTarjetaCreditoResponse) {
    	
        <ns0:sjconsultaDatosTarjetaCreditoResponse>
        {
        	let $balanceInquiry := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns1:BalanceInquiryResponse[1]
    		let $embosserInquiry := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns1:EmbosserInquiryResponse[1]
        	return(
                for $dualIndicator in $balanceInquiry/ARXBIO-DUAL-IND
    			return
    			<DUAL_INDICATOR>{ data($dualIndicator) }</DUAL_INDICATOR>,
    			
    			for $accountNumber in $balanceInquiry/ARXBIO-ACCT
    			return
    			<ACCOUNT_NUMBER>{ data($accountNumber) }</ACCOUNT_NUMBER>,
    			for $cardHolderName in $embosserInquiry/ARXCIO-EMBOSSED-NAME-1
    			return
    			<CARD_HOLDER_NAME>{ data($cardHolderName) }</CARD_HOLDER_NAME>,
    			for $cardType in $embosserInquiry/ARXCIO-CARDHOLDER-TYPE
				return
				<CARD_TYPE>{ data($cardType/text()) }</CARD_TYPE>,
				
				for $orgItem in $sjconsultaDatosTarjetaCredito/CARD_INFORMATION
    			let $org := data($orgItem/ORG)
    			let $embosserInquiry := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns1:EmbosserInquiryResponse[ARXCIO-ORG = $org]
    			return(
    				<CARD_CURRENCY_INFORMATION>
    					<ORG>{ $org}</ORG>
	    				{
							for $cardActivationDate in string($embosserInquiry/ARXCIO-CARD-ACTIVATED-DATE/text())
								return
								if(fn-bea:trim($cardActivationDate) != "") then (
									<CARD_ACTIVATION_DATE>{ $cardActivationDate }</CARD_ACTIVATION_DATE>
								)else()
	    				}
	    				{
							for $cardStatus in $embosserInquiry/ARXCIO-CURR-CRD-ACT
				 			return
				 				<CARD_STATUS>{ data($cardStatus/text()) }</CARD_STATUS>
	    				}
	    				{
	    						for $cardExpirationDate in $embosserInquiry/ARXCIO-DATE-EXPIRE
    						return
    						<CARD_EXPIRATION_DATE>{ data($cardExpirationDate) }</CARD_EXPIRATION_DATE>
    					}
    					{
    						for $embossedNumber in $embosserInquiry/ARXCIO-EMB-REPL
    						return
    						<EMBOSSED_NUMBER>{ data($embossedNumber) }</EMBOSSED_NUMBER>
    					}
    					{
    						for $blockCode in $embosserInquiry/ARXCIO-BLK-CODE
    						return
    						<BLOCK_CODE>{ data($blockCode) }</BLOCK_CODE>
    					}
    					{
    						for $blockReason in $embosserInquiry/ARXCIO-USER-4
    						return
    						<BLOCK_REASON>{ data($blockReason) }</BLOCK_REASON>
    					}
    					{
    						for $blockDate in $embosserInquiry/ARXCIO-DATE-BLOCK
    						return
    						<BLOCK_DATE>{ data($blockDate) }</BLOCK_DATE>
    					}
    					<PRODUCT>TCR</PRODUCT>
    				</CARD_CURRENCY_INFORMATION>
    			
    			)
                 
         	)
        }
        </ns0:sjconsultaDatosTarjetaCreditoResponse>
};

declare variable $sjconsultaDatosTarjetaCredito as element(ns0:sjconsultaDatosTarjetaCredito) external;
declare variable $resultGroup as element(*) external;

xf:sjConsultaDatosTarjetaCreditoOut($sjconsultaDatosTarjetaCredito,
    $resultGroup)