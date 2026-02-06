xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaDetalleTransaccion/xsd/ORA_BANK_OSB_K_CONSULTARECIBOSERVICIO_TOPLEVEL-24OSB_CON_RECIBO_SERVI.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTransaccionAbanks/xq/consultaReciboServicioPAOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTARECIBOSERVICIO/TOPLEVEL-24OSB_CON_RECIBO_SERVI/";

declare function xf:consultaReciboServicioPAOut($outputParameters1 as element(ns0:OutputParameters))
    as xs:string {
		if (data($outputParameters1/ns0:ERROR_CODE = "SUCCESS") ) then ( 	
        	
        	concat(
	        	
	        	for $i in ( 1 to count($outputParameters1/ns0:LABELS/ns0:ITEM) )
		        	return
		                        concat(	"<DETAIL_RECORD>",
		                        			"<LABEL>", data($outputParameters1/ns0:LABELS/ns0:ITEM[$i]) ,"</LABEL>",
		                        			"<VALUE>", data($outputParameters1/ns0:VALUESS/ns0:ITEM[$i]) ,"</VALUE>",
		                        		"</DETAIL_RECORD>")
			)
	    )
        else 
        (
        	""
        )
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaReciboServicioPAOut($outputParameters1)