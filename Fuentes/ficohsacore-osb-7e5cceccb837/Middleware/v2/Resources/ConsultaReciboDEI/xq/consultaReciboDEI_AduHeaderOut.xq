(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultaReciboADU/xsd/ConsultaReciboAdu_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaReciboAdu";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEI_AduHeaderOut/";

declare function xf:consultaReciboDEI_AduHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_CODIGOMENSAJE in string($outputParameters/ns1:PV_CODIGOMENSAJE/text())
                return
                if(upper-case($PV_CODIGOMENSAJE) = "SUCCESS") then(
                	<successIndicator>Success</successIndicator>
                )else(
                	
                    <successIndicator>{ $PV_CODIGOMENSAJE }</successIndicator>,
                    <messages>{ data($outputParameters/ns1:PV_DESCRIPCIONMENSAJE) }</messages>
                 )
            }
            
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaReciboDEI_AduHeaderOut($outputParameters)