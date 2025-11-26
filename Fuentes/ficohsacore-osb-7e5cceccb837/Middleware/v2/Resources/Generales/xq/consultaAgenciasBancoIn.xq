(:: pragma bea:global-element-return element="ns0:consultaAgenciasBanco" location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/consultaAgenciasBancoIn/";

declare function xf:consultaAgenciasBancoIn($branchCode as xs:string)
    as element(ns0:consultaAgenciasBanco) {
        <ns0:consultaAgenciasBanco>
            <BRANCH_CODE>{ $branchCode }</BRANCH_CODE>
        </ns0:consultaAgenciasBanco>
};

declare variable $branchCode as xs:string external;

xf:consultaAgenciasBancoIn($branchCode)