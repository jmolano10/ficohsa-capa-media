(:: pragma bea:global-element-parameter parameter="$consultaComisiones1" element="ns0:consultaComisiones" location="../xsd/consultaComisionesCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisiones" location="../../ConsultaComisiones/xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionesCB/xq/consultaComisionesCBIN/";

declare function xf:consultaComisionesCBIN($consultaComisiones1 as element(ns0:consultaComisiones))
    as element(ns0:consultaComisiones) {
        <ns0:consultaComisiones>
            <TRANSACTION_TYPE>{ data($consultaComisiones1/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
            {
                for $CUSTOMER_ID in $consultaComisiones1/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            <SOURCE_CURRENCY>{ data($consultaComisiones1/SOURCE_CURRENCY) }</SOURCE_CURRENCY>
            <ADDITIONAL_INFO>
            {
            	for $i in (1 to count($consultaComisiones1/ADDITIONAL_INFO/INFO)) 
            	return
            	<INFO>
                            <NAME>{ data($consultaComisiones1/ADDITIONAL_INFO/INFO[$i]/NAME) }</NAME>
                            <VALUE>{ data($consultaComisiones1/ADDITIONAL_INFO/INFO[$i]/VALUE) }</VALUE>
                </INFO>
            }
            </ADDITIONAL_INFO>
        </ns0:consultaComisiones>
};

declare variable $consultaComisiones1 as element(ns0:consultaComisiones) external;

xf:consultaComisionesCBIN($consultaComisiones1)