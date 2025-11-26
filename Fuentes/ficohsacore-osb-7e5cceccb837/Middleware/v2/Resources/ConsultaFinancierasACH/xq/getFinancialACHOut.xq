(:: pragma bea:global-element-parameter parameter="$consultaFinancierasACHResponse" element="ns0:consultaFinancierasACHResponse" location="../../../BusinessServices/FPC/getFinancialACH12c/xsd/GetFinancialACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFinancierasACHResponse" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinancierasACH/xq/getFinancialACHOut/";

declare function xf:getFinancialACHOut($consultaFinancierasACHResponse as element(ns0:consultaFinancierasACHResponse))
    as element(ns0:consultaFinancierasACHResponse) {
        <ns0:consultaFinancierasACHResponse>
            <ns0:consultaFinancierasACHResponseType>
			{
			   for $consultaFinancierasACHResponseRecordType in $consultaFinancierasACHResponse/ns0:consultaFinancierasACHResponseType/ns0:consultaFinancierasACHResponseRecordType
			   return
                <ns0:consultaFinancierasACHResponseRecordType>
                        <DESTINATION_CODE>{ data($consultaFinancierasACHResponseRecordType/DESTINATION_CODE) }</DESTINATION_CODE>
                        <DESTINATION_NAME>{ data($consultaFinancierasACHResponseRecordType/DESTINATION_NAME) }</DESTINATION_NAME>                    
                    <ns0:consultaFinancierasACHDetailResponseType>
					{
					  for $consultaFinancierasACHDetailResponseRecordType in $consultaFinancierasACHResponse/ns0:consultaFinancierasACHResponseType/ns0:consultaFinancierasACHResponseRecordType[1]/ns0:consultaFinancierasACHDetailResponseType/ns0:consultaFinancierasACHDetailResponseRecordType
					  return(
                        <ns0:consultaFinancierasACHDetailResponseRecordType>
                             <TYPE_OF_PRODUCT>{ data($consultaFinancierasACHDetailResponseRecordType/TYPE_OF_PRODUCT) }</TYPE_OF_PRODUCT>
							 <MIN_PRODUCT_ID_LENGTH>{ data($consultaFinancierasACHDetailResponseRecordType/MIN_PRODUCT_ID_LENGTH) }</MIN_PRODUCT_ID_LENGTH>
							 <MAX_PRODUCT_ID_LENGTH>{ data($consultaFinancierasACHDetailResponseRecordType/MAX_PRODUCT_ID_LENGTH) }</MAX_PRODUCT_ID_LENGTH>
							 <LEADING_ZEROS_YES_NO>{ data($consultaFinancierasACHDetailResponseRecordType/LEADING_ZEROS_YES_NO) }</LEADING_ZEROS_YES_NO>
							 <PRODUCT_ID_SAMPLE>{ data($consultaFinancierasACHDetailResponseRecordType/PRODUCT_ID_SAMPLE) }</PRODUCT_ID_SAMPLE>
							 <TRANSFER_TYPE>{ data($consultaFinancierasACHDetailResponseRecordType/TRANSFER_TYPE) }</TRANSFER_TYPE>
                        </ns0:consultaFinancierasACHDetailResponseRecordType>
						)
					}	
                    </ns0:consultaFinancierasACHDetailResponseType>
                </ns0:consultaFinancierasACHResponseRecordType>
			}
            </ns0:consultaFinancierasACHResponseType>
        </ns0:consultaFinancierasACHResponse>
};

declare variable $consultaFinancierasACHResponse as element(ns0:consultaFinancierasACHResponse) external;

xf:getFinancialACHOut($consultaFinancierasACHResponse)
