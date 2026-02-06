xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransferenciaACHEnviada" element="ns0:consultaEstadoTransferenciaACHEnviada" location="../xsd/consultaEstadoTransferenciaACHEnviadaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ACH/Enviado/consultaEstado/xsd/consultaEstado_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEstado";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransferenciaACHEnviadaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransferenciaACHEnviada/xq/consultaEstadoIn/";

declare function xf:consultaEstadoIn($consultaEstadoTransferenciaACHEnviada as element(ns0:consultaEstadoTransferenciaACHEnviada))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ACHSECUENCA>{ data($consultaEstadoTransferenciaACHEnviada/SEQUENCE_ID) }</ns1:PV_ACHSECUENCA>
            <ns1:PV_CUENTAORD>{ data($consultaEstadoTransferenciaACHEnviada/DEBIT_ACCOUNT) }</ns1:PV_CUENTAORD>
        </ns1:InputParameters>
};

declare variable $consultaEstadoTransferenciaACHEnviada as element(ns0:consultaEstadoTransferenciaACHEnviada) external;

xf:consultaEstadoIn($consultaEstadoTransferenciaACHEnviada)