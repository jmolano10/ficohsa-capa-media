xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaderubrocmpvtadivisasResponse1" element="ns1:ConsultaderubrocmpvtadivisasResponse" location="../Resources/XMLSchema_-1176801753.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRubroResponse" location="consultaRubroTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaRubro/ConsultaRubro/consultaRubroOut/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRubroTypes";

declare function xf:consultaRubroOut($consultaderubrocmpvtadivisasResponse1 as element(ns1:ConsultaderubrocmpvtadivisasResponse))
    as element(ns0:consultaRubroResponse) {
        <ns0:consultaRubroResponse>
        {
        	if($consultaderubrocmpvtadivisasResponse1/Status/successIndicator/text() = "Success" and empty($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/ZERORECORDS/text())) then(
        		<ns0:consultaRubroResponseType>
        		{
        			for $i in (1 to max((	count($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType/ID),
                 							count($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType/DESCRIPTION),
                 							count($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType/CURRENTLEVEL),
                 							count($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType/PARENTLEVEL)
                					   )))
                	return
                	<ns0:consultaRubroResponseRecordType>
                		<ITEM_ID>{data($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType[$i]/ID)}</ITEM_ID>
                		<ITEM_DESCRIPTION>{data($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType[$i]/DESCRIPTION)}</ITEM_DESCRIPTION>
                		<PARENT_ITEM_ID>{data($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType[$i]/PARENTLEVEL)}</PARENT_ITEM_ID>
                		<ITEM_LEVEL>{data($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/gWSBUYSELLCATEGORYDetailType/mWSBUYSELLCATEGORYDetailType[$i]/CURRENTLEVEL)}</ITEM_LEVEL>
                	</ns0:consultaRubroResponseRecordType>
        		}
        		</ns0:consultaRubroResponseType>
        	)
        	else()
        }
        </ns0:consultaRubroResponse>
};

declare variable $consultaderubrocmpvtadivisasResponse1 as element(ns1:ConsultaderubrocmpvtadivisasResponse) external;

xf:consultaRubroOut($consultaderubrocmpvtadivisasResponse1)