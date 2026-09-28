(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../Resources/ConsultaDetalleCobroTSP/xsd/consultaDetalleCobroTSP_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:consultaDetalleCompletoTransaccionResponse/DETAILS" location="../ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleCobroTSP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCobroTSP/PruebaOut/";

declare function xf:PruebaOut($outputParameters1 as element(ns1:OutputParameters))
    as element() {
        
        <DETAILS>
            {
            	if(($outputParameters1/ns1:AR_TRX_COBRO/ns1:AR_TRX_COBRO_ITEM[1]/ns1:TRX_ID/text())) then (
            
	                for $AR_TRX_COBRO_ITEM in $outputParameters1/ns1:AR_TRX_COBRO/ns1:AR_TRX_COBRO_ITEM
	                return
	                    <DETAIL_RECORD>
	                        <LABEL>TRX_ID|MONTO_TRANSACCION|FECHA|MONTO_TSP</LABEL>
	                        {
	                            for $TRX_ID in $AR_TRX_COBRO_ITEM/ns1:TRX_ID,
	                                $MONTO in $AR_TRX_COBRO_ITEM/ns1:MONTO,
	                                $FECHA in $AR_TRX_COBRO_ITEM/ns1:FECHA,
	                                $MONTO_TSP in $AR_TRX_COBRO_ITEM/ns1:MONTO_TSP
	                            return
	                                <VALUE>{ concat($TRX_ID ,'|', $MONTO ,'|', $FECHA ,'|', $MONTO_TSP) }</VALUE>
	                        }
	                    </DETAIL_RECORD>
	            )else (
	            	""
	            )
            }
        </DETAILS>
 
};


declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:PruebaOut($outputParameters1)