xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldoTCBatch" element="ns0:sjConsultaSaldoTCBatch" location="../xsd/sjConsultaSaldoTCBatchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaSaldoTCBatch" location="../xsd/sjConsultaSaldoTCBatchTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldoTCBatch";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldoTCBatch/xq/diferenciarPaises/";

declare function xf:diferenciarPaises($sjConsultaSaldoTCBatch as element(ns0:sjConsultaSaldoTCBatch))
    as element(ns0:sjConsultaSaldoTCBatch) {
        <ns0:sjConsultaSaldoTCBatch>
            <CARDS>
                {
                    for $CARD in $sjConsultaSaldoTCBatch/CARDS/CARD
                    return
                        <CARD>
                            <ID>{ data($CARD/ID) }</ID>
                            <PRODUCT_REGION>{ data($CARD/PRODUCT_REGION) }</PRODUCT_REGION>
                            {
                            	
                                	if(data($CARD/PRODUCT_REGION) = 'GT01' or data($CARD/PRODUCT_REGION) = 'PA01' or data($CARD/PRODUCT_REGION) = 'NI01')then(
                                   		<REGION>REG</REGION>
                                   	)else if (data($CARD/PRODUCT_REGION) = 'HN01') then (
                                   		<REGION>HN</REGION>
                                   	)else(
                                   		<REGION>{ data($CARD/PRODUCT_REGION) }</REGION>
                                   	)
                            }
                        </CARD>
                }
            </CARDS>
        </ns0:sjConsultaSaldoTCBatch>
};

declare variable $sjConsultaSaldoTCBatch as element(ns0:sjConsultaSaldoTCBatch) external;

xf:diferenciarPaises($sjConsultaSaldoTCBatch)