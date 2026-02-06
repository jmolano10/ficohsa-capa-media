xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOficialesNegocio" element="ns1:consultaOficialesNegocio" location="../../../../Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOficialesNegocio";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/consultaOficialesNegocioPAIn/";

declare function xf:consultaOficialesNegocioPAIn($consultaOficialesNegocio as element(ns1:consultaOficialesNegocio))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $OFFICER_CODE in $consultaOficialesNegocio/OFFICER_CODE
                return
                    <ns0:PV_CODIGO_EJECUTIVO>{ data($OFFICER_CODE) }</ns0:PV_CODIGO_EJECUTIVO>
            }
            {
                for $BRANCH_CODE in $consultaOficialesNegocio/BRANCH_CODE
                return
                    <ns0:PN_CODIGO_AGENCIA>{ data($BRANCH_CODE) }</ns0:PN_CODIGO_AGENCIA>
            }
        </ns0:InputParameters>
};

declare variable $consultaOficialesNegocio as element(ns1:consultaOficialesNegocio) external;

xf:consultaOficialesNegocioPAIn($consultaOficialesNegocio)