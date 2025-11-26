(:: pragma bea:global-element-parameter parameter="$sjTransferenciaInternacionalICBRequest" element="ns0:sjTransferenciaInternacionalICBRequest" location="../xsd/sjTransferenciaInternacionalH2HICB.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../INTFC/consultaCuentasPorClienteH2H/xsd/CuentasPorCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HICBTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CuentasPorCliente";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/TransferenciaInternacionalH2HICB/xq/sjConsultaCuentaINICB/";

declare function xf:sjConsultaCuentaINICB($tranferIndex as xs:integer,
    $sjTransferenciaInternacionalICBRequest as element(ns0:sjTransferenciaInternacionalICBRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUENTA>{ data($sjTransferenciaInternacionalICBRequest/TRANSFERS_INT/TRANSFER_INT[$tranferIndex]/DEBIT_ACCOUNT) }</ns1:PV_CUENTA>
            <ns1:PV_CODIGOPAIS>{ data($sjTransferenciaInternacionalICBRequest/SOURCE_BANK) }</ns1:PV_CODIGOPAIS>
            <ns1:PV_IDPROXY>FICBCO0375</ns1:PV_IDPROXY>
            <ns1:PV_CODIGOCLIENTE>{ data($sjTransferenciaInternacionalICBRequest/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
        </ns1:InputParameters>
};

declare variable $tranferIndex as xs:integer external;
declare variable $sjTransferenciaInternacionalICBRequest as element(ns0:sjTransferenciaInternacionalICBRequest) external;

xf:sjConsultaCuentaINICB($tranferIndex,
    $sjTransferenciaInternacionalICBRequest)