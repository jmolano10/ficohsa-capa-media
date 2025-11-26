(:: pragma bea:global-element-parameter parameter="$t24ChangesGRP1" element="ns1:T24ChangesGRP" location="../xsd/T24FicoTSPServices2-T24ChangesGRP.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ActualizaGRPTSPDB/xsd/T24UpdateGRPDB_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://www.temenos.com/T24/event/T24FicoTSPServices2/T24ChangesGRP";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/T24UpdateGRPDB";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/ActualizaGRP/xq/actualizaGRPIn/";

declare function xf:actualizaGRPIn($t24ChangesGRP1 as element(ns1:T24ChangesGRP))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $id in $t24ChangesGRP1/ns1:id
                return
                    <ns0:PV_ID_CUENTA>{ data($id) }</ns0:PV_ID_CUENTA>
            }
            {
                for $payrollGrp in $t24ChangesGRP1/ns1:payrollGrp
                return
                    <ns0:PV_ID_GRUPO_PLANILLA>{ data($payrollGrp) }</ns0:PV_ID_GRUPO_PLANILLA>
            }
        </ns0:InputParameters>
};

declare variable $t24ChangesGRP1 as element(ns1:T24ChangesGRP) external;

xf:actualizaGRPIn($t24ChangesGRP1)