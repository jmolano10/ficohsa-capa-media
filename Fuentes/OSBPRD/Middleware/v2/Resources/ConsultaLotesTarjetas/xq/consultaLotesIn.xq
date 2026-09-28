(:: pragma bea:global-element-parameter parameter="$consultaLotesTarjetas" element="ns0:consultaLotesTarjetas" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEBITCARD/consultaLotes/xsd/consultaLotes_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLotes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLotesTarjetas/xq/consultaLotesIn/";

declare function xf:consultaLotesIn($consultaLotesTarjetas as element(ns0:consultaLotesTarjetas))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_BATCH_REFERENCES>
                {
                    for $BATCH_REFERENCE_ITEM in $consultaLotesTarjetas/BATCH_REFERENCES/BATCH_REFERENCE_ITEM
                    return
                        <ns1:PT_BATCH_REFERENCES_ITEM>
                            <ns1:V_BATCH_REFERENCES>{ data($BATCH_REFERENCE_ITEM/BATCH_REFERENCE) }</ns1:V_BATCH_REFERENCES>
                        </ns1:PT_BATCH_REFERENCES_ITEM>
                }
            </ns1:PT_BATCH_REFERENCES>
        </ns1:InputParameters>
};

declare variable $consultaLotesTarjetas as element(ns0:consultaLotesTarjetas) external;

xf:consultaLotesIn($consultaLotesTarjetas)