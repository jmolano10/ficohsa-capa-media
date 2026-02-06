xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns1:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultarRemLocalId/xsd/consultarRemLocalId_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemLocalIdIn/";

declare function xf:consultaRemLocalIdIn($consultaRemesas1 as element(ns1:consultaRemesas))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $REMITTANCE_ID in $consultaRemesas1/REMITTANCE_ID
                return
                    <ns0:PV_REMESA>{ data($REMITTANCE_ID) }</ns0:PV_REMESA>
            }
        </ns0:InputParameters>
};

declare variable $consultaRemesas1 as element(ns1:consultaRemesas) external;

xf:consultaRemLocalIdIn($consultaRemesas1)