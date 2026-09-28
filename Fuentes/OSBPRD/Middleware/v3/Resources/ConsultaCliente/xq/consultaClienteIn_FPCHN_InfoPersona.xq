(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/FPC/consultaInformacionPersona/xsd/consultaInformacionPersonaFPC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteIn_FPCHN_InfoPersona/";

declare function xf:consultaClienteIn_FPCHN_InfoPersona($ID_TYPE as xs:string,
    $ID_VALUE as xs:string)
    as element(ns0:InputParameters) {        
        <ns0:InputParameters>
        {
        if ($ID_TYPE = 'ACCOUNT_NUMBER') then
            <ns0:PC_COD_CTA>{ $ID_VALUE }</ns0:PC_COD_CTA>
        else
        	<ns0:PC_COD_CTA/>
        }	
        </ns0:InputParameters>
};

declare variable $ID_TYPE as xs:string external;
declare variable $ID_VALUE as xs:string external;

xf:consultaClienteIn_FPCHN_InfoPersona($ID_TYPE,
    $ID_VALUE)