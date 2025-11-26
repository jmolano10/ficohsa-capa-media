(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/consultaInformacionPersona/xsd/consultaInformacionPersonaFPC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensiones_FPCHNIn/";

declare function xf:consultaFondoPensiones_FPCHNIn($accountNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PC_COD_CTA>{ $accountNumber }</ns0:PC_COD_CTA>
        </ns0:InputParameters>
};

declare variable $accountNumber as xs:string external;

xf:consultaFondoPensiones_FPCHNIn($accountNumber)