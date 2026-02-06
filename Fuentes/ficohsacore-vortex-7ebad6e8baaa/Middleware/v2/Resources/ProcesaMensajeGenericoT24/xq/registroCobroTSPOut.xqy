xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/TSP/registrarCobroTSP/xsd/registroCobroSP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroCobroSP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/registroCobroTSPOut/";

declare function xf:registroCobroTSPOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_COD_RSPTA in $outputParameters1/ns1:PV_COD_RSPTA
                return
                    <successIndicator>{ fn:upper-case(data($PV_COD_RSPTA)) }</successIndicator>
            }
            {
                if (fn:upper-case(fn:string($outputParameters1/ns1:PV_DES_RSPTA/text())) != "SUCCESS") then (

                    <messages>{ fn:string($outputParameters1/ns1:PV_DES_RSPTA/text()) }</messages>
				) else ()                    
            }
            
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:registroCobroTSPOut($outputParameters1)