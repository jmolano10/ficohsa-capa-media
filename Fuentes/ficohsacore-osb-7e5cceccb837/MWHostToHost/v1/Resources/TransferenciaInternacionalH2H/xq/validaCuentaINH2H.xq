(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalH2HRequest" element="ns0:transferenciaInternacionalH2HRequest" location="../xsd/transferenciaInternacionalH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/INTFC/consultaCuentasPorClienteH2H/xsd/CuentasPorCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CuentasPorCliente";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/validaCuentaINH2H/";

declare function xf:validaCuentaINH2H($transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest),
    $codigopais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUENTA>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT[1]/DEBIT_ACCOUNT) }</ns1:PV_CUENTA>
            <ns1:PV_CODIGOPAIS>{ $codigopais }</ns1:PV_CODIGOPAIS>
            <ns1:PV_IDPROXY>FICBCO0375</ns1:PV_IDPROXY>
            <ns1:PV_CODIGOCLIENTE>{ data($transferenciaInternacionalH2HRequest/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
        </ns1:InputParameters>
};

declare variable $transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest) external;
declare variable $codigopais as xs:string external;

xf:validaCuentaINH2H($transferenciaInternacionalH2HRequest,
    $codigopais)