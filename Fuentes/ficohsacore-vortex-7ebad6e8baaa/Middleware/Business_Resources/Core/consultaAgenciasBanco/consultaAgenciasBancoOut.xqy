xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDAOResponse1" element="ns1:ConsultaDAOResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAgenciasBancoResponse" location="consultaAgenciasBancoTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoOut/";

declare function xf:consultaAgenciasBancoOut($consultaDAOResponse1 as element(ns1:ConsultaDAOResponse))
    as element(ns0:consultaAgenciasBancoResponse) {
        <ns0:consultaAgenciasBancoResponse>
        {
			if($consultaDAOResponse1/Status/successIndicator/text() = "Success" and empty($consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/ZERORECORDS/text())) then(
            	<ns0:consultaAgenciasBancoResponseType>
            	{
					let $ids := $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType/ID
	            	let $names := $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType/NAME
	            	let $areas := $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType/AREA
	            	let $gZone := $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType/GEOGRAPHICZONE
	            	let $ALLOWSCHQBKPRINT := $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType/ALLOWSCHQBKPRINT
	            	let $ALLOWSCASHIERCHQPRINT := $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType/ALLOWSCASHIERCHQPRINT
	            	let $CHQPRINTZONE := $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType/CHQPRINTZONE
	                return
    					for $i in (1 to count($ids))
        				return
        				<ns0:consultaAgenciasBancoResponseRecordType>
                        	<BRANCH_CODE>{ data($ids[$i]) }</BRANCH_CODE>
                        	<BRANCH_NAME>{ data($names[$i]) }</BRANCH_NAME>
                        	<BRANCH_TYPE>{ data($areas[$i]) }</BRANCH_TYPE>
                        	<GEOGRAPHIC_ZONE>{ data($gZone[$i]) }</GEOGRAPHIC_ZONE>
                        	<SERVICES_AVAILABLE>
                        	<SERVICE>
                            	<NAME>ALLOWSCHQBKPRINT</NAME>
                                <VALUE>{	if (empty($ALLOWSCHQBKPRINT[$i]/text())) then ( "NONE" ) 
                                			else data($ALLOWSCHQBKPRINT[$i]) }</VALUE>	
                        	</SERVICE>
                        	<SERVICE>
                            	<NAME>ALLOWSCASHIERCHQPRINT</NAME>
                                <VALUE>{	if (empty($ALLOWSCASHIERCHQPRINT[$i]/text())) then ( "NONE" ) 
                                			else data($ALLOWSCASHIERCHQPRINT[$i]) }</VALUE>	
                        	</SERVICE>
                        	<SERVICE>
                            	<NAME>CHQPRINTZONE</NAME>
                                <VALUE>{	if (empty($CHQPRINTZONE[$i]/text())) then ( "NONE" ) 
                                			else data($CHQPRINTZONE[$i]) }</VALUE>	
                        	</SERVICE>                        	
                    	</SERVICES_AVAILABLE>
                    	</ns0:consultaAgenciasBancoResponseRecordType>
		   		}
            	</ns0:consultaAgenciasBancoResponseType>
             )
			else()
         }
        </ns0:consultaAgenciasBancoResponse>
};

declare variable $consultaDAOResponse1 as element(ns1:ConsultaDAOResponse) external;

xf:consultaAgenciasBancoOut($consultaDAOResponse1)