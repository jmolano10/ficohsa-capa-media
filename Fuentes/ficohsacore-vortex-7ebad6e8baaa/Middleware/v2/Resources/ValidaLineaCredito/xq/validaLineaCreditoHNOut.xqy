xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ValidaLineaCredito/xsd/validaLineaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaLineaCreditoResponse" location="../xsd/validaLineaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaLineaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaLineaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaLineaCredito/xq/validaLineaCreditoHNOut/";

declare function xf:validaLineaCreditoHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:validaLineaCreditoResponse) {
        <ns1:validaLineaCreditoResponse>
            <DESTINATION_CODE>{ data($outputParameters/PN_CODIGO_DESTINO) }</DESTINATION_CODE>
            <LINE_CREDIT_VALUE>{ data($outputParameters/PN_VALOR_LINEA) }</LINE_CREDIT_VALUE>
            <LINE_CREDIT_USED>{ data($outputParameters/PN_VALOR_UTILIZADO) }</LINE_CREDIT_USED>
            <LINE_CREDIT_PREASSIGNED>{ data($outputParameters/PN_VALOR_PREASIGNADO) }</LINE_CREDIT_PREASSIGNED>
            <LINE_CREDIT_ASSIGNED>{ data($outputParameters/PN_VALOR_ASIGNADO) }</LINE_CREDIT_ASSIGNED>
            <LINE_CREDIT_AVAILABLE>{ data($outputParameters/PN_VALOR_DISP_LINEA) }</LINE_CREDIT_AVAILABLE>
            {
	            if (data($outputParameters/PV_ESTA_VALOR_DISP)='Y')
	            then <LINE_AVAILABILITY>true</LINE_AVAILABILITY>
	            else <LINE_AVAILABILITY>false</LINE_AVAILABILITY>
        	}
        </ns1:validaLineaCreditoResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:validaLineaCreditoHNOut($outputParameters)