xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDiasNoHabilesIN" element="ns0:consultaDiasNoHabiles" location="../xsd/consultaDiasNoHabilesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDiasNoHabiles/xsd/consultaDiasNoHabiles_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MSG_P_DIAS_NO_HABILES";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDiasNoHabilesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDiasNoHabiles/xq/consultaDiasNoHabilesInGT/";

declare function xf:consultaDiasNoHabilesInGT($consultaDiasNoHabilesIN as element(ns0:consultaDiasNoHabiles))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $YEAR in $consultaDiasNoHabilesIN/YEAR
                return
                    <ns1:PN_ANIO>{ data($YEAR) }</ns1:PN_ANIO>
            }
            {
                for $MONTH in $consultaDiasNoHabilesIN/MONTH
                return
                    <ns1:PN_MES>{ data($MONTH) }</ns1:PN_MES>
            }
             {
                for $DAY in $consultaDiasNoHabilesIN/DAY
                return
                    <ns1:PN_DIA>{ data($DAY) }</ns1:PN_DIA>
            }
        </ns1:InputParameters>
};

declare variable $consultaDiasNoHabilesIN as element(ns0:consultaDiasNoHabiles) external;

xf:consultaDiasNoHabilesInGT($consultaDiasNoHabilesIN)