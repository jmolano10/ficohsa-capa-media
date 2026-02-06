xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$respuestaAbanks" element="ns1:OutputParameters" location="../Resources/ConsultaMovimientosCuenta/xsd/ORA_BANK_OSB_K_CONSULTAMOVSCUENTA_TOPLEVEL-24OSB_CON_MOVS_CTA.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$respuestaT24" element="ns0:ConsultademovimientosdectaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAMOVSCUENTA/TOPLEVEL-24OSB_CON_MOVS_CTA/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuentaAbanks/consultaMovimientosCuentaMixtoHeaderOut/";

declare function xf:consultaMovimientosCuentaMixtoHeaderOut($respuestaAbanks as element(ns1:OutputParameters),
    $respuestaT24 as element(ns0:ConsultademovimientosdectaResponse))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
	        	if ( fn:string($respuestaT24/Status/successIndicator) = "Success" and 
	        		 fn:empty($respuestaT24/WSSTMTENTBOOKType[1]/ZERORECORDS) and
	        		 fn:string($respuestaAbanks/ns1:ERROR_CODE) = "SUCCESS" and
	        		 count($respuestaAbanks/ns1:REF_NO/ns1:ITEM) > 0 ) then (
	        		 
	        		 <successIndicator>{data($respuestaAbanks/ns1:ERROR_CODE)}</successIndicator>
                
                ) else if (	 fn:string($respuestaT24/Status/successIndicator) = "Success" and 
			        		 fn:string($respuestaT24/WSSTMTENTBOOKType[1]/ZERORECORDS) != "" and
			        		 fn:string($respuestaAbanks/ns1:ERROR_CODE) = "SUCCESS" and
			        		 count($respuestaAbanks/ns1:REF_NO/ns1:ITEM) = 0 ) then (
			        		 
			        		 <successIndicator>NO RECORDS</successIndicator>,
			        		 <messages>{ concat(data($respuestaT24/WSSTMTENTBOOKType[1]/ZERORECORDS), ". ", data($respuestaAbanks/ns1:ERROR_MESSAGE))}</messages>
			        		 
                ) else if (	 fn:string($respuestaT24/Status/successIndicator) = "Success" and
			        		 fn:string($respuestaAbanks/ns1:ERROR_CODE) = "SUCCESS" and
			        		 ( count($respuestaAbanks/ns1:REF_NO/ns1:ITEM) = 0  or fn:string($respuestaT24/WSSTMTENTBOOKType[1]/ZERORECORDS) != "" )) then (
			        		 
			        		 <successIndicator>{data($respuestaAbanks/ns1:ERROR_CODE)}</successIndicator>
			        		 
			     ) else (
			     
			     	<successIndicator>{data($respuestaAbanks/ns1:ERROR_CODE)}</successIndicator>,
			     	<messages>{ concat(data($respuestaT24/Status/messages[1]), ". ", data($respuestaAbanks/ns1:ERROR_MESSAGE))}</messages>
			     )
            }
        </ns2:ResponseHeader>
};

declare variable $respuestaAbanks as element(ns1:OutputParameters) external;
declare variable $respuestaT24 as element(ns0:ConsultademovimientosdectaResponse) external;

xf:consultaMovimientosCuentaMixtoHeaderOut($respuestaAbanks,
    $respuestaT24)