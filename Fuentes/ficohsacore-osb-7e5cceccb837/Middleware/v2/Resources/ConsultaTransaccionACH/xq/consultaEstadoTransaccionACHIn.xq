(:: pragma bea:global-element-parameter parameter="$consultaTransaccionACH" element="ns1:consultaTransaccionACH" location="../xsd/consultaTransaccionACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ACH/Recibido/ConsultaEstadoTransaccionACH/xsd/consultaEstadoTransaccionACH_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEstadoTransaccionACH";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionACH/xq/consultaEstadoTransaccionACHIn/";

declare function xf:consultaEstadoTransaccionACHIn($consultaTransaccionACH as element(ns1:consultaTransaccionACH))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_PXPIDREF>
            { 	
            	if ($consultaTransaccionACH/SEARCH_CRITERIA = 'TRANSACTIONID') then(
            		data($consultaTransaccionACH/SEARCH_VALUE)
            	)else(
            		''
            	)
            }
            </ns0:PV_PXPIDREF>
            <ns0:PV_PXPLOTEREF>
            { 	
            	if ($consultaTransaccionACH/SEARCH_CRITERIA = 'MESSAGEID') then(
            		data($consultaTransaccionACH/SEARCH_VALUE)
            	)else(
            		''
            	)
            }
            </ns0:PV_PXPLOTEREF>
        </ns0:InputParameters>
};

declare variable $consultaTransaccionACH as element(ns1:consultaTransaccionACH) external;

xf:consultaEstadoTransaccionACHIn($consultaTransaccionACH)
