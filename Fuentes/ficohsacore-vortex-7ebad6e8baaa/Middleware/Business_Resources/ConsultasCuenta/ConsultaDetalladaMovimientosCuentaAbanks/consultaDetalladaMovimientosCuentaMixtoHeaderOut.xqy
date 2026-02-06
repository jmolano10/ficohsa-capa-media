xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$respuestaAbanks" element="ns0:OutputParameters" location="../Resources/ConsultaDetalladaMovimientosCuenta/xsd/ORA_BANK_OSB_K__CONSDETMOVSCTA_TOPLEVEL-24OSB_CON_DET_MOVS_CTA.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$respuestaT24" element="ns1:ConsultadetalladademovscuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuentaAbanks/consultaDetalladaMovimientosCuentaMixtoHeaderOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K__CONSDETMOVSCTA/TOPLEVEL-24OSB_CON_DET_MOVS_CTA/";

declare function xf:consultaDetalladaMovimientosCuentaMixtoHeaderOut($respuestaAbanks as element(ns0:OutputParameters),
    $respuestaT24 as element(ns1:ConsultadetalladademovscuentaResponse))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
	        	if ( fn:string($respuestaT24/Status/successIndicator) = "Success" and 
	        		 fn:empty($respuestaT24/WSFICOSTMTBOOKDETAILType[1]/ZERORECORDS) and
	        		 fn:string($respuestaAbanks/ns0:ERROR_CODE) = "SUCCESS" and
	        		 count($respuestaAbanks/ns0:REF_NO/ns0:ITEM) > 0 ) then (
	        		 
	        		 <successIndicator>{data($respuestaAbanks/ns0:ERROR_CODE)}</successIndicator>
                
                ) else if (	 fn:string($respuestaT24/Status/successIndicator) = "Success" and 
			        		 fn:string($respuestaT24/WSFICOSTMTBOOKDETAILType[1]/ZERORECORDS) != "" and
			        		 fn:string($respuestaAbanks/ns0:ERROR_CODE) = "SUCCESS" and
			        		 count($respuestaAbanks/ns0:REF_NO/ns0:ITEM) = 0 ) then (
			        		 
			        		 <successIndicator>NO RECORDS</successIndicator>,
			        		 <messages>{ concat(data($respuestaT24/WSFICOSTMTBOOKDETAILType[1]/ZERORECORDS), ". ", data($respuestaAbanks/ns0:ERROR_MESSAGE))}</messages>
			        		 
                ) else if (	 fn:string($respuestaT24/Status/successIndicator) = "Success" and
			        		 fn:string($respuestaAbanks/ns0:ERROR_CODE) = "SUCCESS" and
			        		 ( count($respuestaAbanks/ns0:REF_NO/ns0:ITEM) = 0  or fn:string($respuestaT24/WSFICOSTMTBOOKDETAILType[1]/ZERORECORDS) != "" )) then (
			        		 
			        		 <successIndicator>{data($respuestaAbanks/ns0:ERROR_CODE)}</successIndicator>
			        		 
			     ) else (
			     
			     	<successIndicator>{data($respuestaAbanks/ns0:ERROR_CODE)}</successIndicator>,
			     	<messages>{ concat(data($respuestaT24/Status/messages), ". ", data($respuestaAbanks/ns0:ERROR_MESSAGE))}</messages>
			     )
            }
        </ns2:ResponseHeader>
};

declare variable $respuestaAbanks as element(ns0:OutputParameters) external;
declare variable $respuestaT24 as element(ns1:ConsultadetalladademovscuentaResponse) external;

xf:consultaDetalladaMovimientosCuentaMixtoHeaderOut($respuestaAbanks,
    $respuestaT24)