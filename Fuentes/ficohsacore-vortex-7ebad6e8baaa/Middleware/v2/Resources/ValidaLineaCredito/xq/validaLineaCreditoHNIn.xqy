xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaLineaCreditoRequest" element="ns1:validaLineaCreditoRequest" location="../xsd/validaLineaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ValidaLineaCredito/xsd/validaLineaCredito_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaLineaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaLineaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaLineaCredito/xq/validaLineaCreditoHNIn/";

declare function xf:validaLineaCreditoHNIn($validaLineaCreditoRequest as element(ns1:validaLineaCreditoRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <PV_COD_APLIC>{ data($validaLineaCreditoRequest/APLICATION_CODE) }</PV_COD_APLIC>
            <PN_COD_AGENCIA>{ data($validaLineaCreditoRequest/AGENCY_CODE) }</PN_COD_AGENCIA>
            <PN_COD_SUBAPLIC>{ data($validaLineaCreditoRequest/SUBAPLICATION_CODE) }</PN_COD_SUBAPLIC>
            <PN_NUM_LINEA>{ data($validaLineaCreditoRequest/LINE_CREDIT_NUMBER) }</PN_NUM_LINEA>
            <PN_VALOR_VERIFICAR>{ data($validaLineaCreditoRequest/VERIFICATE_VALUE) }</PN_VALOR_VERIFICAR>
        </ns0:InputParameters>
};

declare variable $validaLineaCreditoRequest as element(ns1:validaLineaCreditoRequest) external;

xf:validaLineaCreditoHNIn($validaLineaCreditoRequest)