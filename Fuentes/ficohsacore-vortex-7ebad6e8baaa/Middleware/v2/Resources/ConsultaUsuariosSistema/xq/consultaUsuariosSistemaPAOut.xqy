xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaUsuariosSistema/xsd/consultaUsuariosSistema_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaUsuariosSistemaResponse" location="../xsd/consultaUsuariosSistemaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaUsuariosSistema";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosSistemaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosSistema/xq/consultaUsuariosSistemaPAOut/";

declare function xf:consultaUsuariosSistemaPAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaUsuariosSistemaResponse) {
        <ns1:consultaUsuariosSistemaResponse>
            <ns1:consultaUsuariosSistemaResponseType>
            {
            	
	                let $codUsuario  := ($outputParameters/ns0:CODIGO_USUARIO_OUT/ns0:ITEM)  
		            let $nomUsuario  := ($outputParameters/ns0:NOMBRE_USUARIO_OUT/ns0:ITEM)  
		            let $codDepto  := ($outputParameters/ns0:CODIGO_DEPARTAMENTO_OUT/ns0:ITEM)  
		            let $aplicacion  := ($outputParameters/ns0:APLICACION_OUT/ns0:ITEM)  
		            let $oficialDAO  := ($outputParameters/ns0:OFICIAL_DAO_OUT/ns0:ITEM)  
		            let $codAgencia  := ($outputParameters/ns0:CODIGO_AGENCIA_OUT/ns0:ITEM)  
		            let $nomAgencia  := ($outputParameters/ns0:NOMBRE_AGENCIA_OUT/ns0:ITEM)  
		            let $nomIniSesion  := ($outputParameters/ns0:NOMBRE_INICIO_SESION_OUT/ns0:ITEM)
		            
		            
                	for $i  in (1 to count($codUsuario))
	                return
	                    (<ns1:consultaUsuariosSistemaResponseRecordType>
	                    <USER_ID>{ data($codUsuario[$i]) }</USER_ID>
	                    <USER_NAME>{ data($nomUsuario[$i]) }</USER_NAME>
	                    <DEPT_CODE>{ string(data($codDepto[$i])) }</DEPT_CODE>
	                    <APPLICATION>{ data($aplicacion[$i]) }</APPLICATION>
	                    <OFFICER_DAO>{ data($oficialDAO[$i]) }</OFFICER_DAO>
	                    <BRANCH_CODE>{ string(data($codAgencia[$i])) }</BRANCH_CODE>
	                    <BRANCH_NAME>{ data($nomAgencia[$i]) }</BRANCH_NAME>
	                    <SIGN_ON_NAME>{ data($nomIniSesion[$i]) }</SIGN_ON_NAME>
	                    </ns1:consultaUsuariosSistemaResponseRecordType>)
                }
            
            
            
            </ns1:consultaUsuariosSistemaResponseType>
        </ns1:consultaUsuariosSistemaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaUsuariosSistemaPAOut($outputParameters)