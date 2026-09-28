xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionUsuarioAplicacion/xq/consultarUsuarioPGAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarUsuarioPGA";

declare function xf:consultarUsuarioPGAHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>
            {
           	if (fn:upper-case(fn:string($outputParameters/ns0:PV_ERROR_CODE/text())) = "SUCCESS") then (
           		"Success"
           	)
           	else
            	data($outputParameters/ns0:PV_ERROR_CODE) 
            }
            </successIndicator>
            {
                for $ERROR_MESSAGE in $outputParameters/ns0:PV_ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultarUsuarioPGAHeaderOut($outputParameters)