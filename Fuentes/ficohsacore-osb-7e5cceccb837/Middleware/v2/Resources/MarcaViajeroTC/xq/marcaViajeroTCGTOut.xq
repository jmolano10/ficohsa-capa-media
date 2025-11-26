xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjMarcaViajeroTCResponse" element="ns0:sjMarcaViajeroTCResponse" location="../../../BusinessServices/SJS/marcaViajeroTCGT/xsd/sjMarcaViajeroTCGTTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:marcaViajeroTCResponse" location="../xsd/marcaViajeroTCTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MarcaViajeroTC/xq/marcaViajeroTCGTOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjMarcaViajeroTCGTTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/marcaViajeroTCTypes";

declare function xf:marcaViajeroTCGTOut($sjMarcaViajeroTCResponse as element(ns0:sjMarcaViajeroTCResponse))
    as element(ns1:marcaViajeroTCResponse) {
        <ns1:marcaViajeroTCResponse>
            <CREDIT_CARDS>
            {
			for $i in $sjMarcaViajeroTCResponse/ns0:CREDIT_CARDS/CREDIT_CARD_INFORMATION order by $i/INDEX
            return
            (
                <CREDIT_CARD_INFORMATION>
            	{
                        for $CREDIT_CARD_NUMBER in $i/CREDIT_CARD_NUMBER
                        return
                            <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
 				}
 				{
                        for $ACCOUNT_HOLDER_NAME in $i/ACCOUNT_HOLDER_NAME
                        return
                            <ACCOUNT_HOLDER_NAME>{ data($ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>
				}
				{
                        for $CARD_HOLDER_NAME in $i/CARD_HOLDER_NAME
                        return
                            <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>

				}
				{
                        for $CASE_NUMBER in $i/CASE_NUMBER
                        return
                            <CASE_NUMBER>{ data($CASE_NUMBER) }</CASE_NUMBER>

				}
				{
                        for $MESSAGES_ID in $i/MESSAGES_ID
                        return
                            <MESSAGES_ID>{ data($MESSAGES_ID) }</MESSAGES_ID>
				}
				{
                    <SUCCESS_INDICATOR>{ data($i/SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
				}
				{
                        for $MESSAGES in $i/MESSAGES
                        return
                            <MESSAGES>{ data($MESSAGES) }</MESSAGES>
                }   
                    
                </CREDIT_CARD_INFORMATION>
                
                )
               }
            </CREDIT_CARDS>
        </ns1:marcaViajeroTCResponse>
};

declare variable $sjMarcaViajeroTCResponse as element(ns0:sjMarcaViajeroTCResponse) external;

xf:marcaViajeroTCGTOut($sjMarcaViajeroTCResponse)