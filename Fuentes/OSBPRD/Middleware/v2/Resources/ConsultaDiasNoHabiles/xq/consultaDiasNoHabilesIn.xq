(:: pragma bea:global-element-parameter parameter="$consultaDiasNoHabiles" element="ns1:consultaDiasNoHabiles" location="../xsd/consultaDiasNoHabilesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/consultaDiasNoHabiles/xsd/consultaDiasNoHabiles_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDiasNoHabiles";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDiasNoHabilesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDiasNoHabiles/xq/consultaDiasNoHabiles/";

declare function xf:consultaDiasNoHabilesIn($consultaDiasNoHabiles as element(ns1:consultaDiasNoHabiles))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_ANIO>{ data($consultaDiasNoHabiles/YEAR) }</ns0:PN_ANIO>
            <ns0:PN_MES>{ data($consultaDiasNoHabiles/MONTH) }</ns0:PN_MES>
            <ns0:PN_DIA>{ data($consultaDiasNoHabiles/DAY) }</ns0:PN_DIA>
            <ns0:PV_MODULO>{ data($consultaDiasNoHabiles/MODULE) }</ns0:PV_MODULO>
            <ns0:PV_ESTADO>{ data($consultaDiasNoHabiles/STATUS) }</ns0:PV_ESTADO>
        </ns0:InputParameters>
};

declare variable $consultaDiasNoHabiles as element(ns1:consultaDiasNoHabiles) external;

xf:consultaDiasNoHabilesIn($consultaDiasNoHabiles)