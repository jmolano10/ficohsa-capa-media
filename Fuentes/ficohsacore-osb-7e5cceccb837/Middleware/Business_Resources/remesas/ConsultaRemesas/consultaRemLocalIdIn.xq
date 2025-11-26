(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns0:consultaRemesas" location="consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resoruces/ConsultarRemLocalId/consultarRemLocalId_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalIdIn/";

declare function xf:consultaRemLocalIdIn($consultaRemesas1 as element(ns0:consultaRemesas))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $REMITTANCE_ID in $consultaRemesas1/REMITTANCE_ID
                return
                    <ns1:PV_REMESA>{ data($REMITTANCE_ID) }</ns1:PV_REMESA>
            }
        </ns1:InputParameters>
};

declare variable $consultaRemesas1 as element(ns0:consultaRemesas) external;

xf:consultaRemLocalIdIn($consultaRemesas1)