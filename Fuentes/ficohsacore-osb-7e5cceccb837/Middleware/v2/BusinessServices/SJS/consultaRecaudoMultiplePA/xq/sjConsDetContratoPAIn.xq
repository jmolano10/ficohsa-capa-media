(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../v3/BusinessServices/OSB/ObtenerInformacionConvenioPA/xsd/ObtenerInformacionConvenioPA_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerInfomacionConvenio";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultiplePA/xq/sjConsDetContratoPAIn/";

declare function xf:sjConsDetContratoPAIn($codContratro as xs:string,
    $codPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_PAIS>{ $codPais }</ns0:PV_PAIS>
            <ns0:PV_CONTRATO>{ $codContratro }</ns0:PV_CONTRATO>
        </ns0:InputParameters>
};

declare variable $codContratro as xs:string external;
declare variable $codPais as xs:string external;

xf:sjConsDetContratoPAIn($codContratro,
    $codPais)