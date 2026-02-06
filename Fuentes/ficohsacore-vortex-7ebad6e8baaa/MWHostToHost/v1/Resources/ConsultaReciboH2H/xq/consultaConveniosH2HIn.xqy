xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/consultaConveniosH2H/xsd/consultaConveniosH2H_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConveniosH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaReciboH2H/xq/consultaConveniosH2HIn/";

declare function xf:consultaConveniosH2HIn($sourceBank as xs:string,
    $serviceId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_IDSERVICIO>
                <ns0:PT_IDSERVICIO_ITEM>{ $serviceId }</ns0:PT_IDSERVICIO_ITEM>
            </ns0:PT_IDSERVICIO>
            <ns0:PV_CODIGOPAIS>{ $sourceBank }</ns0:PV_CODIGOPAIS>
        </ns0:InputParameters>
};

declare variable $sourceBank as xs:string external;
declare variable $serviceId as xs:string external;

xf:consultaConveniosH2HIn($sourceBank,
    $serviceId)