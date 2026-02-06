xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../xsd/consultarReciboPagoPtmo_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:consultaDetalleCompletoTransaccionResponse/DETAILS" location="../../../consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosT24/consultarReciboPagoPtmo/xq/consultaReciboPagoPtmoOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarReciboPagoPtmo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";

declare function xf:consultaReciboPagoPtmoOut($outputParameters1 as element(ns1:OutputParameters))
    as element() {
            <DETAILS>
                {
                	if (data($outputParameters1/ns1:ERROR_CODE = "SUCCESS") ) then (
						let $LABELS := $outputParameters1/ns1:LABELS/ns1:LABELS_ITEM
						let $VALUES := $outputParameters1/ns1:VALUESS/ns1:LABELS_ITEM
						for $i in (1 to count($LABELS))
			            return
		                    <DETAIL_RECORD>
		                    	<LABEL>{ data($LABELS[$i]) }</LABEL>
		                    	<VALUE>{ data($VALUES[$i]) }</VALUE>
		                    </DETAIL_RECORD>
		            ) else (
		            	""
		            )
				}
            </DETAILS>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaReciboPagoPtmoOut($outputParameters1)