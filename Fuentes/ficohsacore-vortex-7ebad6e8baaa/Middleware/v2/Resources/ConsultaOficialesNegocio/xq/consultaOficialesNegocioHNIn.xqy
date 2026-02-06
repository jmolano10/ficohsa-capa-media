xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOficialesNegocio" element="ns1:consultaOficialesNegocio" location="../../../../Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOficialesNegocio";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioHNIn/";

declare function xf:consultaOficialesNegocioHNIn($consultaOficialesNegocio as element(ns1:consultaOficialesNegocio))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $OFFICER_CODE in $consultaOficialesNegocio/OFFICER_CODE
                return
                    <ns0:P_OFFICER_CODE>{ data($OFFICER_CODE) }</ns0:P_OFFICER_CODE>
            }
            {
                for $BRANCH_CODE in $consultaOficialesNegocio/BRANCH_CODE
                return
                    <ns0:P_BRANCH_CODE>{ data($BRANCH_CODE) }</ns0:P_BRANCH_CODE>
            }
            {
                for $APPLICATION in $consultaOficialesNegocio/APPLICATION
                return
                    <ns0:P_APPLICATION>{ data($APPLICATION) }</ns0:P_APPLICATION>
            }
        </ns0:InputParameters>
};

declare variable $consultaOficialesNegocio as element(ns1:consultaOficialesNegocio) external;

xf:consultaOficialesNegocioHNIn($consultaOficialesNegocio)