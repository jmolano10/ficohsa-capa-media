(:: pragma bea:global-element-parameter parameter="$consultadedestinosACHResponse1" element="ns0:ConsultadedestinosACHResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFinancierasACHResponse" location="consultaFinancierasACHTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinanacierasACHOut/";

declare function xf:consultaFinanacierasACHOut($consultadedestinosACHResponse1 as element(ns0:ConsultadedestinosACHResponse))
    as element(ns1:consultaFinancierasACHResponse) {
        <ns1:consultaFinancierasACHResponse>
            <ns1:consultaFinancierasACHResponseType>
                {
                    let $ids := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/ID
                    let $descriptions := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/DESCRIPTION
                    let $productTypes := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODUCTTYPE
                    let $productMinLengths := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDMINLENGTH
                    let $productMaxLengths := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDMAXLENGTH
                    let $productLeadZeros := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDLEADZEROS
                    let $productIdSampless := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDSAMPLE
                    for $i in (1 to count($ids))
                    	return 
                        <ns1:consultaFinancierasACHResponseRecordType>
                            <DESTINATION_CODE>{ data($ids[$i]) }</DESTINATION_CODE>
                            <DESTINATION_NAME>{ data($descriptions[$i]) }</DESTINATION_NAME>
                            <ns1:consultaFinancierasACHDetailResponseType>
                            {
                            	let $productType := fn:tokenize($productTypes[$i], '\|\|')
                            	let $productMinLength := fn:tokenize($productMinLengths[$i], '\|\|')
                            	let $productMaxLength := fn:tokenize($productMaxLengths[$i], '\|\|')
                            	let $productLeadZero := fn:tokenize($productLeadZeros[$i], '\|\|')
                            	let $productIdSample := fn:tokenize($productIdSampless[$i], '\|\|')
                            	for $j in 1 to (max ( (count($productType), count($productMinLength), count($productMaxLength),
                            						  count($productLeadZero), count($productIdSample))))
		                        return
		                        	if (data($productType[$j]) != "" or data($productMinLength[$j]) != "" or data($productMaxLength[$j]) != ""
		                        		or data($productLeadZero[$j]) != "" or data($productIdSample[$j]) != "") then (
		                        	<ns1:consultaFinancierasACHDetailResponseRecordType>
		                        		<TYPE_OF_PRODUCT>{ data($productType[$j]) }</TYPE_OF_PRODUCT>
		                        		<MIN_PRODUCT_ID_LENGTH>{ data($productMinLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
		                        		<MAX_PRODUCT_ID_LENGTH>{ data($productMaxLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
		                        		<LEADING_ZEROS_YES_NO>{ data($productLeadZero[$j]) }</LEADING_ZEROS_YES_NO>
		                        		<PRODUCT_ID_SAMPLE>{ data($productIdSample[$j]) }</PRODUCT_ID_SAMPLE>
		                        	</ns1:consultaFinancierasACHDetailResponseRecordType>
		                        	) else ()
                           	}
                            </ns1:consultaFinancierasACHDetailResponseType>
                        </ns1:consultaFinancierasACHResponseRecordType>
                }
            </ns1:consultaFinancierasACHResponseType>
        </ns1:consultaFinancierasACHResponse>
};

declare variable $consultadedestinosACHResponse1 as element(ns0:ConsultadedestinosACHResponse) external;

xf:consultaFinanacierasACHOut($consultadedestinosACHResponse1)