xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/CNV/actualizaEstadoRemesaLocal/xsd/actualizaEstadoRemesaLocal_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaEstadoRemesaLocal";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/aerActualizaEstadoRemLocalHeaderOut/";

declare function xf:aerActualizaEstadoRemLocalHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $PN_ERROR := fn:string($outputParameters1/ns0:PN_ERROR/text())
                return
                    if ($PN_ERROR = "0") then (
                    	<successIndicator>SUCCESS</successIndicator>
                    ) else (
                    	<successIndicator>ERROR</successIndicator>,
                    	<messages>{ fn:string($outputParameters1/ns0:PV_ERRORTECNICO/text()) }</messages>
                    )
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:aerActualizaEstadoRemLocalHeaderOut($outputParameters1)