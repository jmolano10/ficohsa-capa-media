xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PMSV/consultaTransaccionLote/xsd/consultaTransaccionLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTransaccionLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionLote/xq/consultaTransaccionLoteHeaderOut/";

declare function xf:consultaTransaccionLoteHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>
            	{
                    if (data($outputParameters/ns0:ERROR_CODE) = "SUCCESS") then
                        ("Success")
                    else 
                        data($outputParameters/ns0:ERROR_CODE)
                }
			</successIndicator>
            {
                for $ERROR_MESSAGE in $outputParameters/ns0:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaTransaccionLoteHeaderOut($outputParameters)