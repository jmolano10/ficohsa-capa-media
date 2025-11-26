(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/generaCatalogos/xsd/generaCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCatalogosRGResponse" location="../../ConsultaCatalogosRegionales/xsd/consultaCatalogosRegionalesTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generaCatalogos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCatalogosRegionalesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCatalogosRG/xq/consultaCatalogosRGOut/";

declare function xf:consultaCatalogosRGOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaCatalogosRGResponse) {
        <ns1:consultaCatalogosRGResponse>
            <CATALOGUES_DETAILS>
                <CATALOGUE>
                    <NAME>{ data($outputParameters1/ns0:PV_NAME) }</NAME>
                    <SOURCE_SYSTEM>{ data($outputParameters1/ns0:PV_SOURCE_SYSTEM) }</SOURCE_SYSTEM>
                    { 
                        for $detail in $outputParameters1/ns0:PR_DETAILS_CAT/ns0:DETAILS_CAT/ns0:DETAILS_CAT_ITEM
                        return(
                    	<DETAILS>
                        	<ITEM_NAME>{ data($detail/ns0:ITEM_NAME) }</ITEM_NAME>
                        	<ITEM_VALUE>{ data($detail/ns0:ITEM_VALUE) }</ITEM_VALUE>
                		</DETAILS>
                		)
                    }
                    <RECORDS_INFO>
                        <INITIAL_RECORD>{ data($outputParameters1/ns0:PN_INITIAL_RECORD) }</INITIAL_RECORD>
                        <RECORDS_RETURNED>{ data($outputParameters1/ns0:PN_RECORDS_RETURNED) }</RECORDS_RETURNED>
                        <RECORDS_TOTAL>{ data($outputParameters1/ns0:PN_RECORDS_TOTAL) }</RECORDS_TOTAL>
                        { 
                        	for $ticket in $outputParameters1/ns0:PR_DETAILS_CAT/ns0:DETAILS_CAT/ns0:DETAILS_CAT_ITEM
                        	return(
                        	 if (empty($ticket) )then (
                        		<TICKET/>
                        		)else(<TICKET>{ data($ticket/ns0:TICKET) }</TICKET>)
                        	)
                        }
                    </RECORDS_INFO>
                    <SUCCESS_INDICATOR>{ data($outputParameters1/ns0:PV_CODIGO_ESTADO) }</SUCCESS_INDICATOR>
                    <MESSAGE>{ data($outputParameters1/ns0:PV_MENSAJE_ESTADO) }</MESSAGE>
                </CATALOGUE>
            </CATALOGUES_DETAILS>
        </ns1:consultaCatalogosRGResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaCatalogosRGOut($outputParameters1)
