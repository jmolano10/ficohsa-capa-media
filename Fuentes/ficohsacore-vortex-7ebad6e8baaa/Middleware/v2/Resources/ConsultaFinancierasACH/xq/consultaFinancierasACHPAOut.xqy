xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFinancierasACHResponse" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFinancierasACH";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaFinancierasACH/xq/consultaFinancierasACHOut/";

declare function xf:consultaFinancierasACHOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaFinancierasACHResponse) {
        <ns1:consultaFinancierasACHResponse>
            <ns1:consultaFinancierasACHResponseType>
                {
                	let $destinationCodes := $outputParameters1/ns0:DESTINATION_CODES/ns0:DESTINATION_CODES_ITEM
					let $destinationNames := $outputParameters1/ns0:DESTINATION_NAMES/ns0:DESTINATION_NAMES_ITEM
					let $typeOfProducts := $outputParameters1/ns0:TYPE_OF_PRODUCTS/ns0:TYPE_OF_PRODUCTS_ITEM
					let $minProductIdLength := $outputParameters1/ns0:MIN_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM
					let $maxProductIdLength := $outputParameters1/ns0:MAX_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM
					let $leadingZerosYesNO := $outputParameters1/ns0:LEADING_ZEROS_YES_NO/ns0:DESTINATION_CODES_ITEM
                	let $productIdSampleItem := $outputParameters1/ns0:PRODUCT_ID_SAMPLE/ns0:PRODUCT_ID_SAMPLE_ITEM
                
                	for $i in (1 to count($destinationCodes))
                	where (data($destinationCodes[$i]) != data($destinationCodes[$i+1])) or ($i = count($destinationCodes))
                    return
	                        <ns1:consultaFinancierasACHResponseRecordType>
 	                            <DESTINATION_CODE>{ data($destinationCodes[$i]) }</DESTINATION_CODE>
	                            <DESTINATION_NAME>{ data($destinationNames[$i]) }</DESTINATION_NAME>
	                            <ns1:consultaFinancierasACHDetailResponseType>
	                            {
	                            (: se retroce hasta cuatro posicione para evaluacion :)
		                            if (($i - 4) <= 0 ) then
			                             for $j in (1 to $i)
			                             where  data($destinationCodes[$j]) = data($destinationCodes[$i])
			                             return  
			                             	<ns1:consultaFinancierasACHDetailResponseRecordType>
			                               		<TYPE_OF_PRODUCT>{ data($typeOfProducts[$j]) }</TYPE_OF_PRODUCT>
			                                   	<MIN_PRODUCT_ID_LENGTH>{ data($minProductIdLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
			                                    <MAX_PRODUCT_ID_LENGTH>{ data($maxProductIdLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
			                                    <LEADING_ZEROS_YES_NO>{ data($leadingZerosYesNO[$j]) }</LEADING_ZEROS_YES_NO>
			                                    <PRODUCT_ID_SAMPLE>{ data($productIdSampleItem[$j]) }</PRODUCT_ID_SAMPLE>
			                             	</ns1:consultaFinancierasACHDetailResponseRecordType>
		                            else
										for $j in (($i - 4) to $i)
										where  data($destinationCodes[$j]) = data($destinationCodes[$i])
			                            return  
			                             	<ns1:consultaFinancierasACHDetailResponseRecordType>
			                               		<TYPE_OF_PRODUCT>{ data($typeOfProducts[$j]) }</TYPE_OF_PRODUCT>
			                                   	<MIN_PRODUCT_ID_LENGTH>{ data($minProductIdLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
			                                    <MAX_PRODUCT_ID_LENGTH>{ data($maxProductIdLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
			                                    <LEADING_ZEROS_YES_NO>{ data($leadingZerosYesNO[$j]) }</LEADING_ZEROS_YES_NO>
			                                    <PRODUCT_ID_SAMPLE>{ data($productIdSampleItem[$j]) }</PRODUCT_ID_SAMPLE>
			                             	</ns1:consultaFinancierasACHDetailResponseRecordType>
	                            }
	                            </ns1:consultaFinancierasACHDetailResponseType>
	                        </ns1:consultaFinancierasACHResponseRecordType>		                                                               	
                }
            </ns1:consultaFinancierasACHResponseType>
        </ns1:consultaFinancierasACHResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaFinancierasACHOut($outputParameters1)