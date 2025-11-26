(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse" element="ns0:ConsultadetransaccionTTResponse" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/ConsultaTransaccionRTE/RegistrarEquivalenteTrxRTE/FLINK_OSB_REGISTRAR_EQUIV_TRX.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REGISTRAR_EQUIV_TRX/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaTransaccionRTE/RegistrarEquivalenteTrxTTIn/";

declare function xf:RegistrarEquivalenteTrxTTIn($consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $ID in $consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/gWSTTTRANSACTIONDetailType/mWSTTTRANSACTIONDetailType[1]/ID
                return
                    <ns1:ID_TRX>{ data($ID) }</ns1:ID_TRX>
            }
        </ns1:InputParameters>
};

declare variable $consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse) external;

xf:RegistrarEquivalenteTrxTTIn($consultadetransaccionTTResponse)