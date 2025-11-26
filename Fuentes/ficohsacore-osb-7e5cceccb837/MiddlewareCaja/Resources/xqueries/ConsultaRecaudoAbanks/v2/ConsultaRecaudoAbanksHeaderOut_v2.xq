(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../xsds/ConsultaRecaudoAbanks/consultaRecaudoAbanks/v2/consultaRecaudoAbanks_v2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRecaudoAbanks_v2";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/v2/ConsultaRecaudoAbanksHeaderOut_v2/";

declare function xf:ConsultaRecaudoAbanksHeaderOut_v2($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $codigoError := fn:string($outputParameters1/ns0:PV_CODIGO_ERROR/text())
                let $mensajeError := fn:string($outputParameters1/ns0:PV_MENSAJE_ERROR/text())
                return
                if ($codigoError = "0") then (
                	<successIndicator>Success</successIndicator>,
                    <messages></messages>
                ) else (
					<successIndicator>ERROR</successIndicator>,                
                    <messages>{ $mensajeError }</messages>                
                )
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ConsultaRecaudoAbanksHeaderOut_v2($outputParameters1)