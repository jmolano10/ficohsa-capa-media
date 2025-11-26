(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaUsuariosPGAResponse" location="../xsd/consultaUsuariosPGATypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosPGATypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarUsuarioPGA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosPGA/xq/consultarUsuarioPGAOut/";

declare function xf:consultarUsuarioPGAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaUsuariosPGAResponse) {
        <ns1:consultaUsuariosPGAResponse>
            <PROFILE>{ data($outputParameters/ns0:PV_PROFILE) }</PROFILE>
            <ROLLCODE>{ data($outputParameters/ns0:PN_ROLL_CODE) }</ROLLCODE> 
        	<ROLLNAME>{ data($outputParameters/ns0:PV_ROLL_NAME) }</ROLLNAME> 
        	<AUTHENTICATOR>{ data($outputParameters/ns0:PV_AUTHENTICATOR) }</AUTHENTICATOR> 
        </ns1:consultaUsuariosPGAResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultarUsuarioPGAOut($outputParameters)