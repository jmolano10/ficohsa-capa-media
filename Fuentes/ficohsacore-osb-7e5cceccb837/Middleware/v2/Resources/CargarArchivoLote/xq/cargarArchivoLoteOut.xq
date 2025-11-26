(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/cargarArchivoLote/xsd/cargarArchivoLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cargarArchivoLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cargarArchivoLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLoteOut/";

declare function xf:cargarArchivoLoteOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:cargarArchivoLoteResponse) {
        <ns0:cargarArchivoLoteResponse>
            {
                for $PV_CODIGOCLIENTE in $outputParameters1/ns1:PV_CODIGOCLIENTE
                return
                	if (fn:string($PV_CODIGOCLIENTE) != '') then 
                		(<CUSTOMER_ID>{ data($PV_CODIGOCLIENTE) }</CUSTOMER_ID>)
                	else
                    	()
            }
            {
                for $PN_NUMEROLOTE in $outputParameters1/ns1:PN_NUMEROLOTE
                return
                	if (fn:string($PN_NUMEROLOTE) != '') then 
                		(<BANK_BATCH_ID>{ data($PN_NUMEROLOTE) }</BANK_BATCH_ID>)
                	else
                    	()
            }
            {
                for $PD_FECHASISTEMA in $outputParameters1/ns1:PD_FECHASISTEMA
                return
                	if (fn:string($PD_FECHASISTEMA/text()) != '') then 
                		(<UPLOAD_DATE>{ xs:date(substring-before($PD_FECHASISTEMA, 'T')) }</UPLOAD_DATE>)
                	else
             	       ()
            }
            {
                for $PN_MONTOTOTAL in $outputParameters1/ns1:PN_MONTOTOTAL
                return
                	if (fn:string($PN_MONTOTOTAL) != '') then 
                		(<TOTAL_AMOUNT>{ data($PN_MONTOTOTAL) }</TOTAL_AMOUNT>)
                	else
                    	()
            }
            {
                for $PN_TOTALTRANSACCIONES in $outputParameters1/ns1:PN_TOTALTRANSACCIONES
                return
                	if (fn:string($PN_TOTALTRANSACCIONES) != '') then 
                		(<NUMBER_OF_TRANSACTIONS>{ data($PN_TOTALTRANSACCIONES) }</NUMBER_OF_TRANSACTIONS>)
                	else
                    	()
            }
            <STATUS>
            	{ 
            		if (count($outputParameters1/ns1:PT_ERRORES/ns1:ERROR_ROW/ns1:ITEM) = 0) then
            			('Success')
            		else
            			('Error')
            	}
        	</STATUS>
            <TRX_STATUS>
	            {
	            	for $ERROR_ROW at $i in $outputParameters1/ns1:PT_ERRORES/ns1:ERROR_ROW
	                return
	                	if (count($ERROR_ROW/ns1:ITEM) > 0) then
	                        (
		                        <TRX>
		                            <ID>{ $i }</ID>		                            
		                            <ERROR_MESSAGES>
		                                {
		                                    for $ITEM in $ERROR_ROW/ns1:ITEM
		                                    return
		                                        <MESSAGE>{ data($ITEM) }</MESSAGE>
		                                }
		                            </ERROR_MESSAGES>
		                        </TRX>
	                        )
	                	else
	                		()
	            }
            </TRX_STATUS>
        </ns0:cargarArchivoLoteResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:cargarArchivoLoteOut($outputParameters1)