(:: pragma bea:global-element-parameter parameter="$sjTransferenciaInternacionalRequest1" element="ns0:sjTransferenciaInternacionalRequest" location="../xsd/sjTransferenciaInternacionalH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../INTFC/consultaCuentasPorClienteH2H/xsd/CuentasPorCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CuentasPorCliente";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/TransferenciaInternacionalH2H/xq/sjConsultaCuentaIN/";

declare function xf:sjConsultaCuentaIN($tranferIndex as xs:integer,
    $sjTransferenciaInternacionalRequest1 as element(ns0:sjTransferenciaInternacionalRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUENTA>{ data($sjTransferenciaInternacionalRequest1/TRANSFERS_INT/TRANSFER_INT[$tranferIndex]/DEBIT_ACCOUNT) }</ns1:PV_CUENTA>
            <ns1:PV_CODIGOPAIS>{ data($sjTransferenciaInternacionalRequest1/SOURCE_BANK) }</ns1:PV_CODIGOPAIS>
            <ns1:PV_IDPROXY>FICBCO0375</ns1:PV_IDPROXY>
            <ns1:PV_CODIGOCLIENTE>{ data($sjTransferenciaInternacionalRequest1/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
        </ns1:InputParameters>
};

declare variable $tranferIndex as xs:integer external;
declare variable $sjTransferenciaInternacionalRequest1 as element(ns0:sjTransferenciaInternacionalRequest) external;

xf:sjConsultaCuentaIN($tranferIndex,
    $sjTransferenciaInternacionalRequest1)