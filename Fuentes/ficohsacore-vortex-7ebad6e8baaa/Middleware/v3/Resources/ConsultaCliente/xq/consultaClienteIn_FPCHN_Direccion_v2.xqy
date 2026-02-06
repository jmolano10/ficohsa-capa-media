xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/FPC/consultaDireccionPersona/xsd/consultaDireccionPersonaFPC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDireccionPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteIn_FPCHN_Direccion_v2/";

declare function xf:consultaClienteIn_FPCHN_Direccion($ID_TYPE as xs:string,$ID_VALUE as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
        if ($ID_TYPE = ('CODE', 'CUSTOMER_ID')) then
            <ns0:PC_COD_PERSONA>{ $ID_VALUE }</ns0:PC_COD_PERSONA>
        else
        	<ns0:PC_COD_PERSONA/>
        }	
        </ns0:InputParameters>
};

declare variable $ID_TYPE as xs:string external;
declare variable $ID_VALUE as xs:string external;

xf:consultaClienteIn_FPCHN_Direccion($ID_TYPE, $ID_VALUE)