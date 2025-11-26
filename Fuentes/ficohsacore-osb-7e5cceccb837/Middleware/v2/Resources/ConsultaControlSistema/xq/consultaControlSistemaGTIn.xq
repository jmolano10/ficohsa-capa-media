(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataREG/validaMasterData/xsd/consultaValidaMasterData_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaValidaMasterData";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaControlSistema/xq/consultaControlSistemaHNIn/";

declare function xf:consultaControlSistemaHNIn($pais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PAIS>{ $pais }</ns0:PAIS>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;

xf:consultaControlSistemaHNIn($pais)
