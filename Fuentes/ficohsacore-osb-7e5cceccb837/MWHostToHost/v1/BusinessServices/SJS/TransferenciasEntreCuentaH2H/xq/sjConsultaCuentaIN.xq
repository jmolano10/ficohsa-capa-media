xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$transferenciaEntreCuentaH2H1" element="ns1:transferenciaEntreCuentaH2H" location="../../../../Resources/TranferenciasEntreCuentasH2H/xsd/transferenciaCuentasH2HType.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../INTFC/consultaCuentasPorClienteH2H/xsd/CuentasPorCliente_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/TransferenciasEntreCuentaH2H/xq/sjConsultaCuentaIN/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CuentasPorCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaEntreCuentaH2HType";

declare function xf:sjConsultaCuentaIN($tranferIndex as xs:integer,$transferenciaEntreCuentaH2H1 as element(ns1:transferenciaEntreCuentaH2H))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
          <ns2:PV_CUENTA>{data($transferenciaEntreCuentaH2H1/TRANSFERS_INT/TRANSFER_INT[$tranferIndex]/DEBIT_ACCOUNT)}</ns2:PV_CUENTA>
            <ns2:PV_CODIGOPAIS>{ data($transferenciaEntreCuentaH2H1/SOURCE_BANK) }</ns2:PV_CODIGOPAIS>
            <ns2:PV_IDPROXY>FICBCO0078</ns2:PV_IDPROXY>
            <ns2:PV_CODIGOCLIENTE>{ data($transferenciaEntreCuentaH2H1/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTE>
        </ns2:InputParameters>
};


declare variable $tranferIndex as xs:integer external;
declare variable $transferenciaEntreCuentaH2H1 as element(ns1:transferenciaEntreCuentaH2H) external;

xf:sjConsultaCuentaIN($tranferIndex,$transferenciaEntreCuentaH2H1)

