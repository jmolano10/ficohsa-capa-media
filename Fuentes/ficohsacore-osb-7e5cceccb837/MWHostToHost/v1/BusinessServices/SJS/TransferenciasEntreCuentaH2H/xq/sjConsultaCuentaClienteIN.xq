(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../INTFC/consultaCuentasPorClienteH2H/xsd/CuentasPorCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CuentasPorCliente";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/TransferenciaInternacionalH2H/xq/sjConsultaCuentaClienteIN/";

declare function xf:sjConsultaCuentaClienteIN($Cuenta as xs:string,
    $Cliente as xs:string,
    $Pais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CUENTA>{ $Cuenta }</ns0:PV_CUENTA>
            <ns0:PV_CODIGOPAIS>{ $Pais }</ns0:PV_CODIGOPAIS>
            <ns0:PV_IDPROXY>FICBCO0078</ns0:PV_IDPROXY>
            <ns0:PV_CODIGOCLIENTE>{ $Cliente }</ns0:PV_CODIGOCLIENTE>
        </ns0:InputParameters>
};

declare variable $Cuenta as xs:string external;
declare variable $Cliente as xs:string external;
declare variable $Pais as xs:string external;

xf:sjConsultaCuentaClienteIN($Cuenta,
    $Cliente,
    $Pais)
