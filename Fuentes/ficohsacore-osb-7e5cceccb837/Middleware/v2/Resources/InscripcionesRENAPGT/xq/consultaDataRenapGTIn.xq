(:: pragma bea:global-element-parameter parameter="$inscripcionesRENAP" element="ns0:inscripcionesRENAP" location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/RENAP/consultaDataRenap/xsd/consultaDataRenap_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRENAPTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDataRenap";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/InscripcionesRENAPGT/xq/consultaDataRenapIn/";

declare function xf:consultaDataRenapIn($inscripcionesRENAP as element(ns0:inscripcionesRENAP))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_USUARIO>{ data($inscripcionesRENAP/USER_CODE) }</ns1:PV_USUARIO>
            <ns1:PV_NOMBRE_USUARIO>{ data($inscripcionesRENAP/USER_NAME) }</ns1:PV_NOMBRE_USUARIO>
            <ns1:PV_CUI>{ data($inscripcionesRENAP/CUI) }</ns1:PV_CUI>
            {
                for $FOOTPRINT in $inscripcionesRENAP/FOOTPRINT
                return
                    <ns1:PCL_HUELLA>{ data($FOOTPRINT) }</ns1:PCL_HUELLA>
            }
            {
                for $FINGER_CODE in $inscripcionesRENAP/FINGER_CODE
                return
                    <ns1:PV_CODIGO_DEDO>{ data($FINGER_CODE) }</ns1:PV_CODIGO_DEDO>
            }
            {
                for $FMD in $inscripcionesRENAP/FMD
                return
                    <ns1:PCL_FMD>{ data($FMD) }</ns1:PCL_FMD>
            }
            <ns1:PV_TIPO_CONSULTA>{ data($inscripcionesRENAP/QUERY_TYPE) }</ns1:PV_TIPO_CONSULTA>
            <ns1:PV_ORIGEN_CONSULTA>{ data($inscripcionesRENAP/ORIGIN_INQUIRY) }</ns1:PV_ORIGEN_CONSULTA>
        </ns1:InputParameters>
};

declare variable $inscripcionesRENAP as element(ns0:inscripcionesRENAP) external;

xf:consultaDataRenapIn($inscripcionesRENAP)